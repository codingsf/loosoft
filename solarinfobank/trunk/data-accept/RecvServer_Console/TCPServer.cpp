/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:用户会话类实现
FileName:TCPServer.cpp
**************************************************/

#include "stdafx.h"
#include "TCPServer.h"
#include "DLLLoader.h"
#include "direct.h"
#include "NewProtocol.h"
#include "ExpandType.h"

extern DLLLoader dllLoader;
extern Protocol69Dealer protocol69Dealer;

using namespace std;
int TCPServer::iSendConn=GetPrivateProfileInt("Server","SendConn",1,"./config.ini");
int TCPServer::m_iRestartInterval=GetPrivateProfileInt("Server","RestartInterval",0,"./config.ini");
bool TCPServer::m_bIsExit = true;
/// <summary>
/// 检测心跳数据
/// </summary>
/// <param name="param">TCPServer *</param>
DWORD WINAPI TCPServer_KeepLiveThread(LPVOID param)
{
	TCPServer * pSvr=(TCPServer *)param;

	while (TCPServer::m_bIsExit)
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
		sprintf(strTemp,"RecvServer V2.1.0  --- Online:[%d/%d],Recv:[%d],Process:[%d]",m_count,pSvr->G_OnlineClient.size(),pSvr->dwRecvPackets,pSvr->dataManage.dwSeqPackets);
		SetConsoleTitle(strTemp);

		pSvr->m_csOnlineClient.Leave();

		Sleep(1000);
	}

	return 0;
}

/// <summary>
/// 先做删除标记，延迟60秒删除，以避免多个工作线程收到消息造成重复释放内存，
/// </summary>
/// <param name="pSession">CUserSession *用户会话</param>
void TCPServer::DoClear(CUserSession * pSession)
{
	cout << "*** IP=" << pSession->strAddress << ",SOCKET ID=" << pSession->sockAccept << " [离线]" << endl;

	pSession->bDelete=TRUE;
	pSession->DeleteTime=time(NULL);
	//BEGIN:add by bloodhunter 2012-4-6
	m_csMap.Enter();
	map<string, CUserSession*>::iterator sessionIte;
	for (sessionIte=m_mapSession.begin();sessionIte!=m_mapSession.end();sessionIte++)
	{
		if( sessionIte->second->m_pRegisterInfo->m_strSerialNum == "")
			continue;
		if (pSession->m_pRegisterInfo->m_strSerialNum ==  sessionIte->second->m_pRegisterInfo->m_strSerialNum)
		{
			m_mapSession.erase(sessionIte);
			protocol69Dealer.DealOffLine(pSession);
			break;
		}
	}
	//m_mapSession.erase(pSession->m_pRegisterInfo->m_strSerialNum);
	//protocol69Dealer.DealOffLine(pSession);
	m_csMap.Leave();
	//END:add by bloodhunter 2012-4-6
	//客户端退出时，删除SOCKET查找表
	m_csmapSocket.Enter();
	map<CString,CUserSession *>::iterator itIndex;
	for (itIndex=mapSocket.begin();itIndex!=mapSocket.end();itIndex++)
	{
		if (pSession->sockAccept == itIndex->second->sockAccept)
		{
			mapSocket.erase(itIndex);
			break;
		}
	}
	m_csmapSocket.Leave();
}

/// <summary>
/// 提交异步阻塞接请求WSARecv IO PENDING
/// </summary>
/// <param name="pRecvIO"></param>
/// <param name="pSession"</param>
/// <param name="dwIOSize"></param>
void TCPServer::DoRead(PER_IO_DATA * pRecvIO,CUserSession * pSession,DWORD dwIOSize)
{
	pSession->LastKeepLive=time(NULL);//更新存活时间
	
	SENDLOG(pRecvIO->DataBuf, (int)dwIOSize, false, pSession->strAddress);

	////记录每次收到的数据
	//if (dwLogLevel != 0)
	//{
	//	CString strLog;
	//	//strLog.Format("[%s] - [%s] - [%d] - [",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),pSession->strAddress,dwIOSize);
	//	strLog.Format("[DateTime：%s] [Client：%s] [length：%d] [Recv Data：",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),pSession->strAddress,dwIOSize);
	//	char strTemp[6];
	//	for (int i=0;i<dwIOSize;i++)
	//	{
	//		sprintf_s(strTemp,"%02X ",(unsigned char)pRecvIO->DataBuf[i]);
	//		strTemp[5]='\0';
	//		strLog+=strTemp;
	//	}

	//	strLog.TrimRight();
	//	strLog+="]";

	//	CString strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; //默认1:按天生成

	//	//日志0：关闭 1：按天生成 2：按小时生成
	//	if (dwLogLevel==2)
	//	{
	//		strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d_%H")+".txt";
	//	}

	//	FILE * fp=fopen(strFile,"a");
	//	if (fp!=NULL)
	//	{
	//		fputs(strLog,fp);
	//		fputs("\n\n",fp);
	//		fclose(fp);
	//	}
	//}

	memcpy(pSession->pRecvBuf+pSession->dwRecvBytes,pRecvIO->DataBuf,dwIOSize);
	pSession->dwRecvBytes+=dwIOSize; //更新接收到的数据字节
	//BEGIN:add by bloodhunter for new protocol at 2012-2-23
	int iProtocol = Protocol68;
	//判断是否有完整的数据报，有则放入缓冲队列等待写入MYSQL
	while (pSession->HasCompletionPacket(iProtocol)) //
	{
		InterlockedIncrement(&dwRecvPackets);

		//解析出一副完整的数据包
		TCP_DATA * pTCPData=new TCP_DATA;

		pSession->ExtractPacket(pTCPData, iProtocol);
		switch(iProtocol)
		{
		//此处增加新协议处理部分
		case Protocol69:
			DealNewProtocol(pTCPData, pSession);
			if( pTCPData != NULL)
            {
                delete pTCPData;
                pTCPData = NULL;
            }
			break;
		case Protocol68:
		default:
			DoParser(pTCPData, pSession);
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
			break;
		}
	}
	//END:add by bloodhunter for new protocol at 2012-2-23
	//继续投递WSARECV
	BOOL bRet=pSession->Recv();
	if (!bRet)
	{
		DoClear(pSession);
	}
}

/// <summary>
/// 解析出采集器ID和设备ID，跟SOCKET句柄关联，以便查找该SOCKET，传递改链接给DLL
/// </summary>
/// <param name="pTCPData">TCP_DATA* ，输出参数</param>
/// <param name="pSession">CUserSession *，输出参数</param>
void TCPServer::DoParser(TCP_DATA * pTCPData,CUserSession * pSession)
{
	// BEGIN:Modify by bloodhunter at 2012/10/21 for 代码整改
	// [修改说明]:临时变量数组需初始化内存
	//char deviceID[DEVICE_ID_LEN+1];
	char deviceID[DEVICE_ID_LEN + 1] = {0};
	// END:Modify by bloodhunter at 2012/10/21 for 代码整改
	memcpy(deviceID, pTCPData->pDataContent + CLIENT_HEAD_LEN, DEVICE_ID_LEN);//此处容错在之前的函数，检查完整包处保证，并非此处保证
	deviceID[DEVICE_ID_LEN]='\0';

	//cout << "采集器ID:" << deviceID << " -> SOCKET ID:" << pSession->sockAccept << endl;

	m_csmapSocket.Enter();
	mapSocket[deviceID] = pSession;
	m_csmapSocket.Leave();
}

/// <summary>
/// 扫描数据库，获取需要更新或者调试的设备
/// </summary>
/// <param name="param">DEBUG_PARAM_DATA *</param>
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
	pDlg->mapDebugStatus[pData->strCollector] = FALSE;

	delete pData;
	pData=NULL;

	return 0L;
}

/// <summary>
/// 循环查找ID是否有对应的SOCKET,有说明设备已经上线，则开启DEBUG工作线程
/// </summary>
/// <param name="param">TCPServer *</param>
DWORD WINAPI CheckDebugThread(LPVOID param)
{
	TCPServer * pDlg=(TCPServer *)param;

	while (TCPServer::m_bIsExit)
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

/// <summary>
/// 扫描数据库，获取需要更新或者调试的设备
/// </summary>
/// <param name="param">TCPServer *</param>
DWORD WINAPI ScanDataBaseThread(LPVOID param)
{
	TCPServer * pDlg=(TCPServer *)param;

	while (TCPServer::m_bIsExit)
	{
		try
		{
			MyConnection conn;
			MYSQL_CONNECT_PARAM mysqlConnectParam;
			mysqlConnectParam.dwPort = GetPrivateProfileInt("MySQL","Port",3306,"./config.ini");
			GetPrivateProfileString("MySQL","IP","",mysqlConnectParam.strIp,50,"./config.ini");
			GetPrivateProfileString("MySQL","User","",mysqlConnectParam.strUser,50,"./config.ini");
			GetPrivateProfileString("MySQL","Pass","",mysqlConnectParam.strPass,50,"./config.ini");
			GetPrivateProfileString("MySQL","DBName","",mysqlConnectParam.strDB,50,"./config.ini");
			//cout << "*** dbname...\n" << mysqlConnectParam.strDB << endl;
			conn.SetDBServer(mysqlConnectParam.strIp);
			conn.SetDBName(mysqlConnectParam.strDB);
			conn.SetDBUser(mysqlConnectParam.strUser);
			conn.SetDBPassword(mysqlConnectParam.strPass);
			conn.SetDBPort(mysqlConnectParam.dwPort);
			conn.Open();
			conn.ExecSQL("set names 'gb2312'");//此处设置编码结构为2312，也就意味着后面要在代码中实现gb2312与UTF8之间的转换
			//每次读取状态不为0的数据，然后将其所在的SOCKET转移给DLL
			MyResult res;
			char **row = NULL;
			conn.ExecSQL("select b.code,a.deviceAddress,a.Status from device as a,collector_info as b where a.collectorID=b.id and a.Status!='0'",&res);

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
			//cout << "***关闭记录集和连接...\n" << mysqlConnectParam.strDB << endl;
			//关闭记录集和连接
			conn.~MyConnection();
		}
		//catch (...)
		//{
		//	cout << "读取表格device、collector_info发生异常..." << endl;
		catch (Exception &e)
		{
			cout << "*** 读取表格device、collector_info发生异常...\n" << e.Message() << endl;

			//return FALSE;
		}
		Sleep(60000);
	}

	return -1L;
}

/// <summary>
/// //IOCP工作线程
/// </summary>
/// <param name="param">TCPServer *</param>
DWORD WINAPI TCPServer_WorkThread(LPVOID param)
{
	TCPServer * pSvr=(TCPServer *)param;

	while (TCPServer::m_bIsExit)
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

/// <summary>
/// //IOCP工作线程
/// </summary>
/// <param name="param">TCPServer *</param>
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
	
	while (TCPServer::m_bIsExit)
	{
		sockaddr_in remoteAdd;
		int nLen=sizeof(sockaddr_in);
		SOCKET hAcceptSocket=accept(pSvr->m_Socket,(sockaddr *)&remoteAdd,&nLen);
		if (hAcceptSocket!=INVALID_SOCKET)
		{
			//BEGIN:modify by bloodhunter 2012-3-29 for new protocol
			//int dwSend=send(hAcceptSocket,"CON",3,0);
			//if (dwSend<3)
			//{
			//	cout << "Send CON Error,SOCKET=" << hAcceptSocket << endl;
			//}
			if(TCPServer::iSendConn == 1)
			{
				int dwSend=send(hAcceptSocket,"CON",3,0);
				if (dwSend<3)
				{
					cout << "Send CON Error,SOCKET=" << hAcceptSocket << endl;
				}
			}
			//END:modify by bloodhunter 2012-3-29 for new procotol

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

/// <summary>
/// 得到SOCKET对端的IP和端口
/// </summary>
/// <param name="hSocket">套接字</param>
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

/// <summary>
/// //错误代码转换为文本描述
/// </summary>
/// <param name="ret">错误码</param>
CString TCPServer::ErrorCode2Text(DWORD ret)
{
	CString retStr;

	LPVOID lpMsgBuf;
	FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER|FORMAT_MESSAGE_FROM_SYSTEM,0, GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&lpMsgBuf, 0, NULL );

	retStr=(LPCTSTR)lpMsgBuf;

	::LocalFree( lpMsgBuf );

	return retStr;
}

/// <summary>
/// 完成端口与硬件绑定
/// </summary>
/// <param name="hcomport">完成端口句柄</param>
/// <param name="hDevice">硬件设备句柄，此app中使用的为socket套接字</param>
/// <param name="dwCompkey">尾随参数，用于完成端口回调时使用</param>
/// <return>绑定结果 TRUE成功，FALSE 失败</return>
BOOL TCPServer::AssociateWithIocompletionPort(HANDLE hcomport, HANDLE hDevice ,DWORD dwCompkey)
{
	return(CreateIoCompletionPort(hDevice,hcomport,dwCompkey,0)==hcomport);
}

/// <summary>
/// 创建完成端口
/// </summary>
/// <param name="dwNumberOfConcurrentThread">完成端口工作线程数</param>
HANDLE TCPServer::CreateNewIoCompletionPort(DWORD dwNumberOfConcurrentThread )
{
	return(CreateIoCompletionPort(INVALID_HANDLE_VALUE,NULL,0,dwNumberOfConcurrentThread));
}

/// <summary>
/// 将SOCKET绑定在创建好的IOCP句柄上
/// </summary>
/// <param name="socketAccept">SOCKET套接字</param>
/// <param name="hiocp">完成端口句柄</param>
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
	CreateThread(NULL,0,CMDThreadProc,this,NULL,NULL);
	//m_hCmdThread = (HANDLE)_beginthreadex(NULL, 0, CMDThreadProc, this, 0, &m_iCmdThreadID);
	if (m_hCmdThread == NULL)
	{	
		m_iCmdThreadID = 0;
	}
	// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
	// [修改说明]:防止程序未处理到的异常导致程序假死或memcached客户端出现问题导致无法正确插入数据
	// modify by hbqian at 2013/02/21 for 注释代码，不在重启自己，可能有重启时端口复用问题，导致无法正常重启，改为从外网解决
	// CreateThread(NULL, 0, RestartThread, this, NULL, NULL);
	// END:Add by bloodhunter at 2012/10/21 for 代码整改
}

//关闭服务器
TCPServer::~TCPServer()
{
	exit(-1);
}

void TCPServer::StartTCPServer()
{
}

void TCPServer::StopTCPServer()
{
	
}

//BEGIN:add by bloodhunter for new protocol at 2012-3-23
/// <summary>
/// 处理数据包，新版本协议
/// </summary>
/// <param name="pTCPData">TCP_DATA *数据包</param>
/// <param name="pSession">CUserSession * 用户会话</param>
void TCPServer::DealNewProtocol(TCP_DATA * pTCPData, CUserSession * pSession)
{
	//如果标记为删除，则不再处理
	if(pSession->bDelete)
		return;

	DataInfoStructor dataInfo;
	dataInfo.m_pRegisterInfo = pSession->m_pRegisterInfo;
	int res;
	if(0 != (res = protocol69Dealer.AnalysisPacket(pTCPData, pSession, dataInfo)))//解压失败，返回的错误中，如果是状态错误，即客户端尝试非法通信，则直接标记为删除
	{
		if(res == New_Session_Error_State)//错误状态
		{
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，非法通信..." << endl;
			DoClear(pSession);			
			return;
		}
		
        if(res == New_Session_Errror_Data)//错误数据格式
		{
			//数据格式错误，此时应该清空缓存区。而不是释放链接
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，通信数据格式错误..." << endl;
			memset(pSession->pRecvBuf, 0, sizeof(pSession->pRecvBuf));
			pSession->dwRecvBytes = 0; //更新接收到的数据字节			
		    return;
		}	
	}

	//处理登录请求
	if(dataInfo.iProtocolSubType == New_Procotol_Type_Register_Recv_Login_Req)
	{
		if(protocol69Dealer.DealRegisterReq(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，用户登录失败..." << endl;
        }else{
		    //存储session与sn的对照关系
		    m_mapSession.insert(pair<string, CUserSession*>(pSession->m_pRegisterInfo->m_strSerialNum, pSession));
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，用户登录成功..." << endl;
        }
		return;
	}
	//处理验证码验证
	if(dataInfo.iProtocolSubType == New_Procotol_Type_Register_Recv_AuthCode)
	{
		if(protocol69Dealer.DealRegisterVerify(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，密钥验证失败..." << endl;
        }else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，密钥验证成功..." << endl;
        }
		return;
	}

	//处理电站信息
	if(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_PowerStation)
	{
		if(protocol69Dealer.DealStationInfo(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，电站描述信息上传失败..." << endl;
        }else{
		    cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，电站描述信息上传成功..." << endl;
        }
		return;
	}

	//处理设备信息
	if(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_Device)
	{
		if(protocol69Dealer.DealDeviceInfo(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，设备信息上传失败..." << endl;
        }else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，设备信息上传成功..." << endl;
        }
		return;
	}

	//处理实时信息
	if(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_RT)
	{
		if(protocol69Dealer.DealRunInfo(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，实时信息上传失败..." << endl;
        }else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，实时信息上传成功..." << endl;
        }
		return;
	}

	//处理历史数据
	if(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_HD)
	{
		if(protocol69Dealer.DealHistoryData(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，历史数据上传失败..." << endl;
        }else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，历史数据上传成功..." << endl;
        }
		return;
	}

	//处理历史故障
	if(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_Fault_HD)
	{
		if(protocol69Dealer.DealHistoryData(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，历史故障上传失败..." << endl;
		}else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，历史故障上传成功..." << endl;
        }
		return;
	}

	//处理操作响应
	if(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_OP)
	{
		if(protocol69Dealer.DealHistoryData(dataInfo, pSession) == New_Session_State_FirstFrame)
		{	
			cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，操作响应失败..." << endl;
        }else{
            cout << "*** IP=" << pSession->strAddress << "，SOCKET ID=" << pSession->sockAccept << "，操作响应成功..." << endl;
        }
		return;
	}
}

//END:add by bloodhunter for new protocol at 2012-3-23

/// <summary>
/// 处理来自memcache的命令，新协议使用。
/// </summary>
/// <param name="pParam">TCPServer*</param>
/// <notice>主要用于历史数据请求、历史数据终止、设备参数设置，以后若增加其他对于设备的主动操作，均在此处添加扩展</notice>
DWORD WINAPI CMDThreadProc(LPVOID pParam)
{
	TCPServer* pThis = reinterpret_cast<TCPServer*>(pParam );
	while(TCPServer::m_bIsExit)//add by bloodhunter at 2012-07-11 for  isExistKey  如果存在问题，则先将此处的true更改为false
	{	
		try
		{
			pThis->m_csMap.Enter();
			map<string, CUserSession*>::iterator itIndex;
			for (itIndex = pThis->m_mapSession.begin(); itIndex !=  pThis->m_mapSession.end(); itIndex++)
			{


				DataInfoStructor data;

				char content[10240];
				memset(content, 0, sizeof(content));

				char* contentkey;
				int res;
				
#if 0
				//测试
				contentkey = const_cast<char*>(itIndex->second->strState_Online.c_str());
				res = dllLoader.pIsExistKey(contentkey);//判断是否存在
				if(res != -1)
				{
					res = dllLoader.pReadFromMC(contentkey, content);
					if(res != -1)
					{
						CString strID = itIndex->second->strCmd_Req_HistoryStart.c_str();
						CString strContent = content;
					}
				}
#endif

				//历史数据请求
				contentkey = const_cast<char*>(itIndex->second->strCmd_Req_HistoryStart.c_str());
				res = dllLoader.pIsExistKey(contentkey);//判断是否存在
				if(res != -1)
				{
					res = dllLoader.pReadFromMC(contentkey, content);
					if(res != -1)
					{
						CString strID = itIndex->second->strCmd_Req_HistoryStart.c_str();
						CString strContent = content;
						SENDMEMLOG(strID, strContent, false);
						data.iLen = TCPServer::CString2Hex(data.data, strContent);
						if(protocol69Dealer.DealHistoryDataReq(data, itIndex->second) == 1)//如果命令成功，则memcache中擦除该项
						{
							dllLoader.pRemoveFromMC(const_cast<char*>(itIndex->second->strCmd_Req_HistoryStart.c_str()));
						}
					}
				}

				//历史数据终止
				contentkey = const_cast<char*>(itIndex->second->strCmd_Req_HistoryStop.c_str());
				res = dllLoader.pIsExistKey(contentkey);//判断是否存在
				if(res != -1)
				{
					res = dllLoader.pReadFromMC(contentkey, content);
					if(res != -1)
					{
						CString strID = itIndex->second->strCmd_Req_HistoryStart.c_str();
						CString strContent = content;
						SENDMEMLOG(strID, strContent, false);
						data.iLen = TCPServer::CString2Hex(data.data, strContent);
						if(protocol69Dealer.DealHistoryDataStopReq(data, itIndex->second) == 1)//如果命令成功，则memcache中擦除该项
						{
							dllLoader.pRemoveFromMC(const_cast<char*>(itIndex->second->strCmd_Req_HistoryStop.c_str()));
						}
					}
				}

				//参数设置
				contentkey = const_cast<char*>(itIndex->second->cmd_Req_ParameterSet.c_str());
				res = dllLoader.pIsExistKey(contentkey);//判断是否存在
				if(res != -1)
				{
					res = dllLoader.pReadFromMC(contentkey, content);
					if(res != -1)
					{
						CString strID = itIndex->second->strCmd_Req_HistoryStart.c_str();
						CString strContent = content;
						SENDMEMLOG(strID, strContent, false);
						data.iLen = TCPServer::CString2Hex(data.data, strContent);
						if(protocol69Dealer.DealParameterSetReq(data, itIndex->second) == 1)//如果命令成功，则memcache中擦除该项
						{
							dllLoader.pRemoveFromMC(const_cast<char*>(itIndex->second->cmd_Req_ParameterSet.c_str()));
						}
					}
				}
			}
			pThis->m_csMap.Leave();
		}
		catch(...)
		{
			Sleep(1000);
			continue;
		}
		Sleep(3000);
	}
	
	return 1L;
}

// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
// [修改说明]:防止程序未处理到的异常导致程序假死或memcached客户端出现问题导致无法正确插入数据
 DWORD WINAPI RestartThread (LPVOID pParam)
 {
	TCPServer* pThis = reinterpret_cast<TCPServer*>(pParam );
	int iHasRun = 0;//已运行时间，分钟为单位

	//如果配置文件为0，则表示不定时重启
	if (TCPServer::m_iRestartInterval == 0)
		return 1L;

	while(true)
	{
		/// 到达时间定时重启
		if (iHasRun == TCPServer::m_iRestartInterval)
		{
			//关闭所有处理线程
			TCPServer::m_bIsExit = true;
			Sleep(10000);//等待10秒以保证所有线程退出
			//释放网络资源
			closesocket(pThis->m_Socket);
			Sleep(1000);
			//启动镜像进程
			PROCESS_INFORMATION piProcInfo; 
			STARTUPINFO siStartInfo;

			// Set up members of STARTUPINFO structure.
			siStartInfo.cb = sizeof(STARTUPINFO); 
			siStartInfo.lpReserved = NULL;
			siStartInfo.lpReserved2 = NULL; 
			siStartInfo.cbReserved2 = 0;
			siStartInfo.lpDesktop = NULL; 
			siStartInfo.dwFlags = 0;
			CreateProcess(
				"RecvServer_Console.exe",
				NULL,
				NULL, // process security attributes
				NULL, // primary thread security attributes
				false, // handles are inherited
				CREATE_NEW_CONSOLE, // creation flags
				NULL, // use parent's environment
				NULL, // use parent's current directory
				&siStartInfo, // STARTUPINFO pointer
				&piProcInfo); // receives PROCESS_INFORMATION

			//退出当前进程
			exit(-1);
		}
		Sleep(60 * 1000);//间隔分钟
		iHasRun++;
	}
 }
// END:Add by bloodhunter at 2012/10/21 for 代码整改
