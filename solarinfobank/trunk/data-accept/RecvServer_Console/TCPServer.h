/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:TCPSRV������
FileName:TCPServer.h
**************************************************/
#pragma once

#include "StdAfx.h"
#include "CriticalSection.h"
#include "UserSession.h"
#include "DataManage.h"

/*
TCPServer
������WINDOWS�µ�IOCP��Ϊ������ģ�ͣ����幤��������ο�΢��MSDN�ĵ���
���� http://baike.baidu.com/view/972785.htm

���������̣�

���յ��������ݷ���PER IO��������ÿ�յ����ݶ�Ҫ��⻺�����ڵ������Ƿ��Э����ϡ�
�������������CuserSession�ڵ�ExtractPacket������ȡ��һ�����������ݣ�
Ȼ����뻺������ڣ��ȴ�д��MYSQL���ݿ�
�������������߲�����Э��涨����رմ�SOCKET��
*/

class CUserSession;

//����DLL�Ĳ���
typedef struct  
{
	char strCollector[DEVICE_ID_LEN+1]; //�ɼ���ID
	char strDevice[1024];               //�豸�Լ����������ַ����б�
	CUserSession * pSession;
	void * pThis;
}DEBUG_PARAM_DATA;

class TCPServer
{
public:
	TCPServer();
	~TCPServer();

	void StartTCPServer();
	void StopTCPServer();

	map<CString,BOOL> mapDebugStatus; //�豸�Ƿ����ڵ���

	CriticalSection m_csmapSocket;
	map<CString, CUserSession *> mapSocket;  //�ɼ�����SOCKET���ձ���Ҫʵʱ����

	CriticalSection m_csmapDebugDevice;
	map<CString,map<CString,CString> > mapDebugDevice; //��Ҫ�������豸�Լ����Է�ʽ�������ݿ��ȡ

	void DoParser(TCP_DATA * pTCPData,CUserSession * pSession);
	//BEGIN:add by bloodhunter at 2012-4-6
	CriticalSection m_csMap;
	map<string, CUserSession*> m_mapSession;								//�洢SN��Session�ļ�ֵ��
	HANDLE		m_hCmdThread;												//����������̣߳���memcache�ж�ȡ����·�
	UINT		m_iCmdThreadID;
	friend DWORD WINAPI CMDThreadProc (LPVOID pParam);					//CMD�̹߳�������
	//END:add by bloodhunter at 2012-4-6
	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	void DealNewProtocol(TCP_DATA * pTCPData, CUserSession * pSession);		//������Э�������
public:	
	static int iSendConn;	//�Ƿ��ڽ�������ʱ����������Ӧ���Լ����ϰ汾Э��
	//END:add by bloodhunter for new protocol at 2012-3-23

	// BEGIN:Add by bloodhunter at 2012/10/21 for ��������
	// [�޸�˵��]:��ֹ����δ�������쳣���³��������memcached�ͻ��˳������⵼���޷���ȷ��������
	friend DWORD WINAPI RestartThread (LPVOID pParam);				//��ʱ��������
	static int m_iRestartInterval;									//����ʱ������Ĭ��0
	static bool m_bIsExit;											//�߳��˳���־λ
	// END:Add by bloodhunter at 2012/10/21 for ��������

	
//private:
	int dwServerPort;
	int dwTimeOut;
	int dwLogLevel;
	long dwRecvPackets;

	DataManage dataManage;	
	CriticalSection m_csOnlineClient;
	map<SOCKET,CUserSession * > G_OnlineClient; //���߿ͻ���MAP

	CString GetAddressBySocket(SOCKET hSocket);
	BOOL AssociateWithIocompletionPort(HANDLE hcomport, HANDLE hDevice ,DWORD dwCompkey);
	CUserSession * CreateCompletionKey(SOCKET socketAccept,HANDLE hiocp);
	HANDLE CreateNewIoCompletionPort(DWORD dwNumberOfConcurrentThread );
	CString ErrorCode2Text(DWORD ret);

	SOCKET  m_Socket;
	HANDLE m_hiocp;
	int nThreadCount;

	friend DWORD WINAPI CheckDebugThread(LPVOID param);
	friend DWORD WINAPI ScanDataBaseThread(LPVOID param);
	friend DWORD WINAPI DebugWorkThread(LPVOID param);

	friend DWORD WINAPI TCPServer_KeepLiveThread(LPVOID param); //ά��SOCKET����·��1800��û�յ�������Ϊ��ʱ
	friend DWORD WINAPI TCPServer_SocketThread(LPVOID param);
	friend DWORD WINAPI TCPServer_WorkThread(LPVOID param); //IOCP�Ĺ����߳�

	void DoRead(PER_IO_DATA * pRecvIO,CUserSession * pSession,DWORD dwIOSize); //�յ������ˣ��첽ģʽ��
	void DoClear(CUserSession * pSession);               //Ԥ�ͷ�SOCKET


	//��ASCII��ת��Ϊ16������
	static BYTE ConvertHexChar(BYTE ch)
	{
		if((ch>='0')&&(ch<='9'))
		   return ch-0x30;
		else if((ch>='A')&&(ch<='F'))
		   return ch-'A'+10;
		else if((ch>='a')&&(ch<='f'))
		   return ch-'a'+10;        
		else
		   return -1;
	}

	int static CString2Hex(char* cmd, CString& str)
	{
		BYTE tmpByte = 0x00;
		int strLen = str.GetLength();
		int i =0;
		int j = 0;
		for (i=0, j=0; i<1024,j<strLen; i++,j++)
		{
		   if (str[j] == ' ')
			++j;
		    tmpByte = str[j]; 
		   cmd[i] = ConvertHexChar(tmpByte)<<4;//����4λ
		   if (str[++j] == ' ')
			   ++j;
		   tmpByte = str[j];        
		   cmd[i] = cmd[i] + (ConvertHexChar(tmpByte) & 0xF);//ȡ��4λȻ����ӡ�    
		} 
		return i + 1;
	}
};
