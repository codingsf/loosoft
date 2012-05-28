#ifndef _TCPSERVER_H_
#define _TCPSERVER_H_

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
	map<CString,CUserSession *> mapSocket;  //�ɼ�����SOCKET���ձ���Ҫʵʱ����

	CriticalSection m_csmapDebugDevice;
	map<CString,map<CString,CString> > mapDebugDevice; //��Ҫ�������豸�Լ����Է�ʽ�������ݿ��ȡ

	void DoParser(TCP_DATA * pTCPData,CUserSession * pSession);
	
private:
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
};


#endif





















