#include "stdafx.h"
#include "TCPServer.h"
#include "DLLLoader.h"
#include "direct.h"
extern DLLLoader dllLoader;

//�����������
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
			if (itMap->second->bDelete) //���Ϊ��ɾ�����ӳ�����
			{
				double tmRet=difftime(tm_current,itMap->second->DeleteTime);
				if (tmRet>=20.0f)
				{
					if (itMap->second->sockAccept!=INVALID_SOCKET)
					{
						closesocket(itMap->second->sockAccept);
						itMap->second->sockAccept=INVALID_SOCKET;
					}

					delete itMap->second; //�ͷ�Client��Ӧ����Դ
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

				//�����ʱ����
				double tmRet=difftime(tm_current,itMap->second->LastKeepLive);
				if (tmRet>=(double)pSvr->dwTimeOut)
				{
					//cout << "*** IP=" << itMap->second->strAddress << ",SOCKET ID=" << itMap->first << " [��ʱ]" << endl;
					
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

//����ɾ����ǣ��ӳ�60��ɾ�����Ա����������߳��յ���Ϣ����ظ��ͷ��ڴ棬
void TCPServer::DoClear(CUserSession * pSession)
{
	//cout << "*** IP=" << pSession->strAddress << ",SOCKET ID=" << pSession->sockAccept << " [����]" << endl;

	pSession->bDelete=TRUE;
	pSession->DeleteTime=time(NULL);

	//�ͻ����˳�ʱ��ɾ��SOCKET���ұ�
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

//һ��ֻ�ύһ��WSARecv IO PENDING
void TCPServer::DoRead(PER_IO_DATA * pRecvIO,CUserSession * pSession,DWORD dwIOSize)
{
	pSession->LastKeepLive=time(NULL);//���´��ʱ��
	
	//��¼ÿ���յ�������
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

		CString strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; //Ĭ��1:��������

		//��־0���ر� 1���������� 2����Сʱ����
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
	pSession->dwRecvBytes+=dwIOSize; //���½��յ��������ֽ�

	//�ж��Ƿ������������ݱ���������뻺����еȴ�д��MYSQL
	while (pSession->HasCompletionPacket()) //
	{
		InterlockedIncrement(&dwRecvPackets);

		//������һ�����������ݰ�
		TCP_DATA * pTCPData=new TCP_DATA;

		pSession->ExtractPacket(pTCPData); 

		DoParser(pTCPData,pSession);

		dataManage.AddToBuffer(pTCPData);
		
		//����OK
		if (pSession->bWorkStatus)
		{		
			int dwSend=send(pSession->sockAccept,"OK",2,0);
			if (dwSend<2)
			{
				cout << "Send OK Error!" << endl;
			}
		}
	}

	//����Ͷ��WSARECV
	BOOL bRet=pSession->Recv();
	if (!bRet)
	{
		DoClear(pSession);
	}
}

//�������ɼ���ID���豸ID����SOCKET����������Ա���Ҹ�SOCKET�����ݸ����Ӹ�DLL
void TCPServer::DoParser(TCP_DATA * pTCPData,CUserSession * pSession)
{
	char deviceID[DEVICE_ID_LEN+1];
	memcpy(deviceID,pTCPData->pDataContent+CLIENT_HEAD_LEN,DEVICE_ID_LEN);
	deviceID[DEVICE_ID_LEN]='\0';

	//cout << "�ɼ���ID:" << deviceID << " -> SOCKET ID:" << pSession->sockAccept << endl;

	m_csmapSocket.Enter();
	mapSocket[deviceID]=pSession;
	m_csmapSocket.Leave();
}

//ɨ�����ݿ⣬��ȡ��Ҫ���»��ߵ��Ե��豸
DWORD WINAPI DebugWorkThread(LPVOID param)
{
	DEBUG_PARAM_DATA * pData=(DEBUG_PARAM_DATA *)param;
	TCPServer * pDlg=(TCPServer *)pData->pThis;
	CUserSession * pSession=pData->pSession;

	//����DLL�����ݲ���

	dllLoader.pSend2Dll((int)pSession->sockAccept,pData->strCollector,pData->strDevice);

	cout << "*** Call SendDll.DLL Finished!" << endl;

	//�ָ�IOCP������IO�շ�
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

			//�ָ����ݿ���ı��
			CString strSql;
			strSql.Format("Update device set Status='0' where Status='%s' and deviceAddress='%s'",strDebug,strID);
			
			pDlg->dataManage.m_conn.ExecSQL(strSql.GetBuffer(0));
		}

		token = strtok( NULL, "&" );
	}

	//������Ϻ󣬴Ӹ��»�����ɾ��
	pDlg->m_csmapDebugDevice.Enter();

	pDlg->mapDebugDevice[pData->strCollector].clear();
	map<CString,map<CString,CString> >::iterator itFind=pDlg->mapDebugDevice.find(pData->strCollector);
	if (itFind!=pDlg->mapDebugDevice.end())
	{
		pDlg->mapDebugDevice.erase(itFind);
	}

	pDlg->m_csmapDebugDevice.Leave();

	//�ָ����
	pDlg->mapDebugStatus[pData->strCollector]=FALSE;

	delete pData;
	pData=NULL;

	return 0L;
}

//ѭ������ID�Ƿ��ж�Ӧ��SOCKET,��˵���豸�Ѿ����ߣ�����DEBUG�����߳�
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
			
			//����Ĳɼ����ж�Ӧ��SOCKET�����������������Ĳ�����DLL
			map<CString,CUserSession *>::iterator itSocketFind=pDlg->mapSocket.find(strCollector);
			if (itSocketFind!=pDlg->mapSocket.end())
			{
				CUserSession * pSession=itSocketFind->second;
				SOCKET hSocket=pSession->sockAccept;

				//û��Ҫ�����������
				if (itIndex->second.empty())
				{
					//cout << "��ʾ: �ɼ��� " << strCollector.GetBuffer(0) << " ��û��Ҫ���Ե������ID..." << endl;

					continue;
				}

				//ֹͣ����IO�շ�
				pSession->bWorkStatus=FALSE;

				//���˲ɼ����ĸ���״̬���Ϊ���ڸ��£���ʱIOCP���ڴ����SOCKET�ϵ�����IO
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
					
					//cout << "*** ����DEBUG�߳� -> " << "�ɼ���:" << strCollector.GetBuffer(0) << ",SOCKET:" << hSocket << ",�豸�б�:" << m_temp.GetBuffer(0) << endl;
					
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
				//cout << "*** ��ʾ: �ɼ��� " << strCollector.GetBuffer(0) << " û�лSOCKET��" << endl;
			}
		}

		Sleep(5000);
	}

	return 0L;
}

//ɨ�����ݿ⣬��ȡ��Ҫ���»��ߵ��Ե��豸
DWORD WINAPI ScanDataBaseThread(LPVOID param)
{
	TCPServer * pDlg=(TCPServer *)param;

	for (;;)
	{
		try
		{
			//ÿ�ζ�ȡ״̬��Ϊ0�����ݣ�Ȼ�������ڵ�SOCKETת�Ƹ�DLL
			MyResult res;
			char **row = NULL;
			pDlg->dataManage.m_conn.ExecSQL("select b.code,a.deviceAddress,a.Status from device as a,collector_info as b where a.collectorID=b.id and a.Status!='0'",&res);

			while (res.GetRow(row))
			{
				CString strCollector=row[0];
				CString strDevice=row[1];
				CString strDebug=row[2];

				//map�ﲻ���ڵļ�¼��˵������Ҫ���µ�
				map<CString,CString>::iterator mapIndex=pDlg->mapDebugDevice[strCollector].find(strDevice);
				if (mapIndex==pDlg->mapDebugDevice[strCollector].end())
				{
					//cout << "��Ҫ���� -> �ɼ���ID:[" << strCollector.GetBuffer(0) << "],�����ID:[" << strDevice.GetBuffer(0) << "],����:[" <<strDebug.GetBuffer(0) << "]" << endl;

					pDlg->m_csmapDebugDevice.Enter();
					pDlg->mapDebugDevice[strCollector][strDevice]=strDebug;
					pDlg->m_csmapDebugDevice.Leave();
				}
			}
		}
		catch (...)
		{
			cout << "��ȡ���device��collector_info�����쳣..." << endl;
		}

		Sleep(60000);
	}

	return -1L;
}

//IOCP�����߳�
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

		//�ͻ��˵���
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
	pSvr->nThreadCount=sysinfo.dwNumberOfProcessors*2+2; //���� CPU* 2+2�������߳�

	//IOCP�����߳�
	for (int i=0;i<pSvr->nThreadCount;i++) 
		CreateThread(NULL,0,TCPServer_WorkThread,param,NULL,NULL);

	//��������
	CreateThread(NULL,0,TCPServer_KeepLiveThread,param,NULL,NULL);

	//SOCKET
	pSvr->m_Socket=WSASocket(AF_INET,SOCK_STREAM,IPPROTO_TCP,NULL,0,WSA_FLAG_OVERLAPPED);

	//��SOCKET
	sockaddr_in localAdd;
	memset(&localAdd,0,sizeof(localAdd));
	localAdd.sin_family=AF_INET;
	localAdd.sin_port=htons(pSvr->dwServerPort);
	localAdd.sin_addr.S_un.S_addr=INADDR_ANY;
	int nRet =bind(pSvr->m_Socket,(sockaddr*)&localAdd,sizeof(localAdd));
	if(nRet == SOCKET_ERROR)
	{
		cout << "���׽���ʧ�ܣ�" << endl;
		closesocket(pSvr->m_Socket);
		return -1;
	}

	//����SOCKET
	nRet=listen(pSvr->m_Socket,5);
	if(nRet == SOCKET_ERROR)
	{
		cout << "�����˿�ʧ�ܣ�" << endl;
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

			//������������SOCKET������IOCP�����
			CUserSession * pSession=pSvr->CreateCompletionKey(hAcceptSocket,pSvr->m_hiocp);
			if (pSession != NULL)
			{
				//Ͷ�ݵ�һ��WSARECV
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

//�õ�SOCKET�Զ˵�IP�Ͷ˿�
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

//�������ת��Ϊ�ı�����
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

//��SOCKET���ڴ����õ�IOCP�����
CUserSession * TCPServer::CreateCompletionKey( SOCKET socketAccept,HANDLE hiocp)
{
	CUserSession * pSession=new CUserSession;

	pSession->sockAccept=socketAccept;
	
	if (!AssociateWithIocompletionPort(hiocp,(HANDLE)socketAccept,(DWORD)pSession))
	{
		cout << "����IOCPʧ��..." << endl;

		delete pSession;
		pSession=NULL;

		return NULL;
	}

	CString strAddress=GetAddressBySocket(socketAccept);
	strcpy(pSession->strAddress,strAddress); //��Ӧ��IP��ַ

	//cout << "*** IP=" << pSession->strAddress << ",SOCKET ID=" << socketAccept << " [����]" << endl;

	m_csOnlineClient.Enter();
	G_OnlineClient[socketAccept]=pSession;
	m_csOnlineClient.Leave();

	return pSession;
}

//����������
TCPServer::TCPServer()
{
	//�������ݿ�ʧ�ܣ��˳�
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

	//ɨ�����ݿ��߳�
	CreateThread(NULL,0,ScanDataBaseThread,this,NULL,NULL);

	//��⹤���߳�
	CreateThread(NULL,0,CheckDebugThread,this,NULL,NULL);
}

//�رշ�����
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
