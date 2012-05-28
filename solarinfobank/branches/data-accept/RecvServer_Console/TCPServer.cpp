#include "stdafx.h"
#include "TCPServer.h"
#include "DLLLoader.h"
#include "direct.h"
extern DLLLoader dllLoader;

//检测心跳数据
DWORD WINAPI TCPServer_KeepLiveThread(LPVOID param)
{
	TCPServer * pSvr=(TCPServer *)param;

	for (;;)
	{
		pSvr->m_csOnlineClient.Enter();

		if (pSvr->G_OnlineClient.empty())
		{
			pSvr->m_csOnlineClient.Leave();
			Sleep(200);
			continue;
		}

		int m_count=0;

		time_t tm_current=time(NULL);

		map<SOCKET,CUserSession *>::iterator itMap;
		for (itMap=pSvr->G_OnlineClient.begin();itMap!=pSvr->G_OnlineClient.end();)
		{
			if (itMap->second->bDelete) //标记为已删除的延迟清理
			{
				double tmRet=difftime(tm_current,itMap->second->DeleteTime);
				if (tmRet>=20.0f)
				{
					if (itMap->second->sockAccept!=INVALID_SOCKET)
					{
						closesocket(itMap->second->sockAccept);
						itMap->second->sockAccept=INVALID_SOCKET;
					}

					delete itMap->second; //释放Client对应的资源
					itMap->second=NULL;

					pSvr->G_OnlineClient.erase(itMap++);
				}
				else
				{
 					++itMap;
				}
			}
			else
			{
				m_count++;

				//检测存活时间间隔
				double tmRet=difftime(tm_current,itMap->second->LastKeepLive);
				if (tmRet>=(double)pSvr->dwTimeOut)
				{
					//cout << "*** IP=" << itMap->second->strAddress << ",SOCKET ID=" << itMap->first << " [超时]" << endl;
					
					itMap->second->bDelete=TRUE;
					itMap->second->DeleteTime=time(NULL);

					closesocket(itMap->second->sockAccept);
					itMap->second->sockAccept=INVALID_SOCKET;
				}

				++itMap;
			}
		}

		char strTemp[MAX_PATH];
		sprintf(strTemp,"RecvServer V1.0.1  --- Online:[%d/%d],Recv:[%d],Process:[%d]",m_count,pSvr->G_OnlineClient.size(),pSvr->dwRecvPackets,pSvr->dataManage.dwSeqPackets);
		SetConsoleTitle(strTemp);

		pSvr->m_csOnlineClient.Leave();

		Sleep(1000);
	}

	return 0;
}

//先做删除标记，延迟60秒删除，以避免多个工作线程收到消息造成重复释放内存，
void TCPServer::DoClear(CUserSession * pSession)
{
	//cout << "*** IP=" << pSession->strAddress << ",SOCKET ID=" << pSession->sockAccept << " [掉线]" << endl;

	pSession->bDelete=TRUE;
	pSession->DeleteTime=time(NULL);

	//客户端退出时，删除SOCKET查找表
	m_csmapSocket.Enter();
	map<CString,CUserSession *>::iterator itIndex;
	for (itIndex=mapSocket.begin();itIndex!=mapSocket.end();itIndex++)
	{
		if (pSession->sockAccept==itIndex->second->sockAccept)
		{
			mapSocket.erase(itIndex);
			break;
		}
	}
	m_csmapSocket.Leave();
}

//一次只提交一个WSARecv IO PENDING
void TCPServer::DoRead(PER_IO_DATA * pRecvIO,CUserSession * pSession,DWORD dwIOSize)
{
	pSession->LastKeepLive=time(NULL);//更新存活时间
	
	//记录每次收到的数据
	if (dwLogLevel!=0)
	{
		CString strLog;
		strLog.Format("[%s] - [%s] - [%d] - [",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),pSession->strAddress,dwIOSize);

		char strTemp[6];
		for (int i=0;i<dwIOSize;i++)
		{
			sprintf_s(strTemp,"%02X ",(unsigned char)pRecvIO->DataBuf[i]);
			strTemp[5]='\0';
			
			strLog+=strTemp;
		}

		strLog.TrimRight();
		strLog+="]";

		CString strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; //默认1:按天生成

		//日志0：关闭 1：按天生成 2：按小时生成
		if (dwLogLevel==2)
		{
			strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d_%H")+".txt";
		}

		FILE * fp=fopen(strFile,"a");
		if (fp!=NULL)
		{
			fputs(strLog,fp);
			fputs("\n\n",fp);
			fclose(fp);
		}
	}

	memcpy(pSession->pRecvBuf+pSession->dwRecvBytes,pRecvIO->DataBuf,dwIOSize);
	pSession->dwRecvBytes+=dwIOSize; //更新接收到的数据字节

	//判断是否有完整的数据报，有则放入缓冲队列等待写入MYSQL
	while (pSession->HasCompletionPacket()) //
	{
		InterlockedIncrement(&dwRecvPackets);

		//解析出一副完整的数据包
		TCP_DATA * pTCPData=new TCP_DATA;

		pSession->ExtractPacket(pTCPData); 

		DoParser(pTCPData,pSession);

		dataManage.AddToBuffer(pTCPData);
		
		//返回OK
		if (pSession->bWorkStatus)
		{		
			int dwSend=send(pSession->sockAccept,"OK",2,0);
			if (dwSend<2)
			{
				cout << "Send OK Error!" << endl;
			}
		}
	}

	//继续投递WSARECV
	BOOL bRet=pSession->Recv();
	if (!bRet)
	{
		DoClear(pSession);
	}
}

//解析出采集器ID和设备ID，跟SOCKET句柄关联，以便查找该SOCKET，传递改链接给DLL
void TCPServer::DoParser(TCP_DATA * pTCPData,CUserSession * pSession)
{
	char deviceID[DEVICE_ID_LEN+1];
	memcpy(deviceID,pTCPData->pDataContent+CLIENT_HEAD_LEN,DEVICE_ID_LEN);
	deviceID[DEVICE_ID_LEN]='\0';

	//cout << "采集器ID:" << deviceID << " -> SOCKET ID:" << pSession->sockAccept << endl;

	m_csmapSocket.Enter();
	mapSocket[deviceID]=pSession;
	m_csmapSocket.Leave();
}

//扫描数据库，获取需要更新或者调试的设备
DWORD WINAPI DebugWorkThread(LPVOID param)
{
	DEBUG_PARAM_DATA * pData=(DEBUG_PARAM_DATA *)param;
	TCPServer * pDlg=(TCPServer *)pData->pThis;
	CUserSession * pSession=pData->pSession;

	//调用DLL并传递参数

	dllLoader.pSend2Dll((int)pSession->sockAccept,pData->strCollector,pData->strDevice);

	cout << "*** Call SendDll.DLL Finished!" << endl;

	//恢复IOCP的网络IO收发
	pSession->bWorkStatus=TRUE;
	pSession->Recv();

	char * token= strtok(pData->strDevice, "&");
	while( token != NULL )
	{
		CString strTemp=token;
		int nPos=strTemp.Find(":");
		if (nPos!=-1)
		{
			CString strID=strTemp.Left(nPos);
			CString strDebug=strTemp.Right(strTemp.GetLength()-nPos-1);

			//恢复数据库里的标记
			CString strSql;
			strSql.Format("Update device set Status='0' where Status='%s' and deviceAddress='%s'",strDebug,strID);
			
			pDlg->dataManage.m_conn.ExecSQL(strSql.GetBuffer(0));
		}

		token = strtok( NULL, "&" );
	}

	//处理完毕后，从更新缓存里删除
	pDlg->m_csmapDebugDevice.Enter();

	pDlg->mapDebugDevice[pData->strCollector].clear();
	map<CString,map<CString,CString> >::iterator itFind=pDlg->mapDebugDevice.find(pData->strCollector);
	if (itFind!=pDlg->mapDebugDevice.end())
	{
		pDlg->mapDebugDevice.erase(itFind);
	}

	pDlg->m_csmapDebugDevice.Leave();

	//恢复标记
	pDlg->mapDebugStatus[pData->strCollector]=FALSE;

	delete pData;
	pData=NULL;

	return 0L;
}

//循环查找ID是否有对应的SOCKET,有说明设备已经上线，则开启DEBUG工作线程
DWORD WINAPI CheckDebugThread(LPVOID param)
{
	TCPServer * pDlg=(TCPServer *)param;

	for (;;)
	{
		map<CString,map<CString,CString> >::iterator itIndex;
		for (itIndex=pDlg->mapDebugDevice.begin();itIndex!=pDlg->mapDebugDevice.end();itIndex++)
		{
			CString strCollector=itIndex->first;
			map<CString,CString> mapDevice=itIndex->second;
			
			//如果改采集器有对应的SOCKET，则输出所有逆变器的参数给DLL
			map<CString,CUserSession *>::iterator itSocketFind=pDlg->mapSocket.find(strCollector);
			if (itSocketFind!=pDlg->mapSocket.end())
			{
				CUserSession * pSession=itSocketFind->second;
				SOCKET hSocket=pSession->sockAccept;

				//没有要升级的逆变器
				if (itIndex->second.empty())
				{
					//cout << "提示: 采集器 " << strCollector.GetBuffer(0) << " 下没有要调试的逆变器ID..." << endl;

					continue;
				}

				//停止网络IO收发
				pSession->bWorkStatus=FALSE;

				//将此采集器的更新状态标记为正在更新，此时IOCP不在处理该SOCKET上的网络IO
				if (pDlg->mapDebugStatus[strCollector]!=TRUE)
				{
					pDlg->mapDebugStatus[strCollector]=TRUE;

					CString m_temp;
					map<CString,CString>::iterator itDeviceIndex;
					for (itDeviceIndex=mapDevice.begin();itDeviceIndex!=mapDevice.end();itDeviceIndex++)
					{
						CString strDeviceID=itDeviceIndex->first;
						CString strDebug=itDeviceIndex->second;
						
						m_temp+=strDeviceID+":"+strDebug+"&";
					}
					
					m_temp=m_temp.Left(m_temp.GetLength()-1);
					
					//cout << "*** 启动DEBUG线程 -> " << "采集器:" << strCollector.GetBuffer(0) << ",SOCKET:" << hSocket << ",设备列表:" << m_temp.GetBuffer(0) << endl;
					
					DEBUG_PARAM_DATA * pData=new DEBUG_PARAM_DATA;
					pData->pSession=pSession;
					strcpy(pData->strCollector,strCollector);
					strcpy(pData->strDevice,m_temp);
					pData->pThis=param;
					
					CreateThread(NULL,0,DebugWorkThread,(LPVOID)pData,NULL,NULL);
				}
			}
			else
			{
				//cout << "*** 提示: 采集器 " << strCollector.GetBuffer(0) << " 没有活动SOCKET。" << endl;
			}
		}

		Sleep(5000);
	}

	return 0L;
}

//扫描数据库，获取需要更新或者调试的设备
DWORD WINAPI ScanDataBaseThread(LPVOID param)
{
	TCPServer * pDlg=(TCPServer *)param;

	for (;;)
	{
		try
		{
			//每次读取状态不为0的数据，然后将其所在的SOCKET转移给DLL
			MyResult res;
			char **row = NULL;
			pDlg->dataManage.m_conn.ExecSQL("select b.code,a.deviceAddress,a.Status from device as a,collector_info as b where a.collectorID=b.id and a.Status!='0'",&res);

			while (res.GetRow(row))
			{
				CString strCollector=row[0];
				CString strDevice=row[1];
				CString strDebug=row[2];

				//map里不存在的记录，说明是需要更新的
				map<CString,CString>::iterator mapIndex=pDlg->mapDebugDevice[strCollector].find(strDevice);
				if (mapIndex==pDlg->mapDebugDevice[strCollector].end())
				{
					//cout << "需要更新 -> 采集器ID:[" << strCollector.GetBuffer(0) << "],逆变器ID:[" << strDevice.GetBuffer(0) << "],操作:[" <<strDebug.GetBuffer(0) << "]" << endl;

					pDlg->m_csmapDebugDevice.Enter();
					pDlg->mapDebugDevice[strCollector][strDevice]=strDebug;
					pDlg->m_csmapDebugDevice.Leave();
				}
			}
		}
		catch (...)
		{
			cout << "读取表格device、collector_info发生异常..." << endl;
		}

		Sleep(60000);
	}

	return -1L;
}

//IOCP工作线程
DWORD WINAPI TCPServer_WorkThread(LPVOID param)
{
	TCPServer * pSvr=(TCPServer *)param;

	while (TRUE)
	{
		DWORD dwIOSize=0;
		PER_IO_DATA * lpPerIOData=NULL;
		CUserSession * pSession=NULL;

		BOOL bSuccess = GetQueuedCompletionStatus(pSvr->m_hiocp,&dwIOSize,(LPDWORD)&pSession,(LPOVERLAPPED *)&lpPerIOData,INFINITE);
		if (dwIOSize==0xFFFFFFFF)
			return 0;

		//客户端掉线
		if (bSuccess==FALSE || (bSuccess==TRUE && dwIOSize==0) )
		{
			pSvr->DoClear(pSession);
			continue;
		}
		
		if (lpPerIOData==NULL || pSession==NULL)
		{
			return -1;
		}
		
		switch (lpPerIOData->m_ioType)
		{
		case IORead:
			pSvr->DoRead(lpPerIOData,pSession,dwIOSize);
			break;
			
		case IOWrite:
			break;
		}
	}

	return 0;
}

DWORD WINAPI TCPServer_SocketThread(LPVOID param)
{
	TCPServer * pSvr=(TCPServer *)param;

	pSvr->m_hiocp=pSvr->CreateNewIoCompletionPort(0);
	if (pSvr->m_hiocp==NULL) 
	{
		cout << "CreateNewIoCompletionPort Error..." << endl;
		return 0;
	}

	SYSTEM_INFO sysinfo;
	GetSystemInfo(&sysinfo);
	pSvr->nThreadCount=sysinfo.dwNumberOfProcessors*2+2; //创建 CPU* 2+2个工作线程

	//IOCP工作线程
	for (int i=0;i<pSvr->nThreadCount;i++) 
		CreateThread(NULL,0,TCPServer_WorkThread,param,NULL,NULL);

	//创建心跳
	CreateThread(NULL,0,TCPServer_KeepLiveThread,param,NULL,NULL);

	//SOCKET
	pSvr->m_Socket=WSASocket(AF_INET,SOCK_STREAM,IPPROTO_TCP,NULL,0,WSA_FLAG_OVERLAPPED);

	//绑定SOCKET
	sockaddr_in localAdd;
	memset(&localAdd,0,sizeof(localAdd));
	localAdd.sin_family=AF_INET;
	localAdd.sin_port=htons(pSvr->dwServerPort);
	localAdd.sin_addr.S_un.S_addr=INADDR_ANY;
	int nRet =bind(pSvr->m_Socket,(sockaddr*)&localAdd,sizeof(localAdd));
	if(nRet == SOCKET_ERROR)
	{
		cout << "绑定套接字失败！" << endl;
		closesocket(pSvr->m_Socket);
		return -1;
	}

	//监听SOCKET
	nRet=listen(pSvr->m_Socket,5);
	if(nRet == SOCKET_ERROR)
	{
		cout << "监听端口失败！" << endl;
		return -1;
	}
	
	while (TRUE)
	{
		sockaddr_in remoteAdd;
		int nLen=sizeof(sockaddr_in);
		SOCKET hAcceptSocket=accept(pSvr->m_Socket,(sockaddr *)&remoteAdd,&nLen);
		if (hAcceptSocket!=INVALID_SOCKET)
		{
			int dwSend=send(hAcceptSocket,"CON",3,0);
			if (dwSend<3)
			{
				cout << "Send CON Error,SOCKET=" << hAcceptSocket << endl;
			}

			//把连接上来的SOCKET关联到IOCP句柄上
			CUserSession * pSession=pSvr->CreateCompletionKey(hAcceptSocket,pSvr->m_hiocp);
			if (pSession != NULL)
			{
				//投递第一个WSARECV
				BOOL bRecv=pSession->Recv();
				if (!bRecv) 
				{
					pSvr->DoClear(pSession);
				}
			}
		}
	}

	return 0;
}

//得到SOCKET对端的IP和端口
CString TCPServer::GetAddressBySocket(SOCKET hSocket)
{
	CString szReturn="ERROR";

	sockaddr_in sockAddr;
	memset(&sockAddr, 0, sizeof(sockAddr));
	int nSockAddrLen = sizeof(sockAddr);

	BOOL bResult = getpeername(hSocket,(SOCKADDR*)&sockAddr, &nSockAddrLen);
	if (bResult != INVALID_SOCKET)
		szReturn.Format("%s:%05d",inet_ntoa(sockAddr.sin_addr),sockAddr.sin_port);

	return szReturn;
}

//错误代码转换为文本描述
CString TCPServer::ErrorCode2Text(DWORD ret)
{
	CString retStr;

	LPVOID lpMsgBuf;
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,0, GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&lpMsgBuf, 0, NULL );

	retStr=(LPCTSTR)lpMsgBuf;

	::LocalFree( lpMsgBuf );

	return retStr;
}

BOOL TCPServer::AssociateWithIocompletionPort(HANDLE hcomport, HANDLE hDevice ,DWORD dwCompkey)
{
	return(CreateIoCompletionPort(hDevice,hcomport,dwCompkey,0)==hcomport);
}

HANDLE TCPServer::CreateNewIoCompletionPort(DWORD dwNumberOfConcurrentThread )
{
	return(CreateIoCompletionPort(INVALID_HANDLE_VALUE,NULL,0,dwNumberOfConcurrentThread));
}

//将SOCKET绑定在创建好的IOCP句柄上
CUserSession * TCPServer::CreateCompletionKey( SOCKET socketAccept,HANDLE hiocp)
{
	CUserSession * pSession=new CUserSession;

	pSession->sockAccept=socketAccept;
	
	if (!AssociateWithIocompletionPort(hiocp,(HANDLE)socketAccept,(DWORD)pSession))
	{
		cout << "创建IOCP失败..." << endl;

		delete pSession;
		pSession=NULL;

		return NULL;
	}

	CString strAddress=GetAddressBySocket(socketAccept);
	strcpy(pSession->strAddress,strAddress); //对应的IP地址

	//cout << "*** IP=" << pSession->strAddress << ",SOCKET ID=" << socketAccept << " [上线]" << endl;

	m_csOnlineClient.Enter();
	G_OnlineClient[socketAccept]=pSession;
	m_csOnlineClient.Leave();

	return pSession;
}

//启动服务器
TCPServer::TCPServer()
{
	//连接数据库失败，退出
	if (!dataManage.OpenDB())
	{
		getchar();

		exit(-1);
	}

	dwRecvPackets=0;

	dwServerPort=GetPrivateProfileInt("Server","TCPPort",9000,"./config.ini");
	dwTimeOut=GetPrivateProfileInt("Server","TimeOut",120,"./config.ini");
	dwLogLevel=GetPrivateProfileInt("Server","LogLevel",0,"./config.ini");

	_mkdir("logs");

	cout << "*** Listen TCP Port:" << dwServerPort << ",TimeOut:" << dwTimeOut << endl;

	CreateThread(NULL,0,TCPServer_SocketThread,this,NULL,NULL);	

	//扫描数据库线程
	CreateThread(NULL,0,ScanDataBaseThread,this,NULL,NULL);

	//检测工作线程
	CreateThread(NULL,0,CheckDebugThread,this,NULL,NULL);
}

//关闭服务器
TCPServer::~TCPServer()
{
// 	for (int i=0;i<nThreadCount;i++)
// 	{
// 		PostQueuedCompletionStatus(m_hiocp,0xFFFFFFFF,0,NULL);
// 	}
// 		
// 	//shutdown(m_Socket,SD_BOTH);
// 	closesocket(m_Socket);
// 	CloseHandle(m_hiocp);	

	exit(-1);
}

void TCPServer::StartTCPServer()
{
	
}

void TCPServer::StopTCPServer()
{
	
}
