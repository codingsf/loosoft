#ifndef _TCPSERVER_H_
#define _TCPSERVER_H_

#include "StdAfx.h"
#include "CriticalSection.h"
#include "UserSession.h"
#include "DataManage.h"

/*
TCPServer
采用了WINDOWS下的IOCP作为服务器模型，具体工作机制请参考微软MSDN文档，
或者 http://baike.baidu.com/view/972785.htm

服务器流程：

接收到的数据暂放如PER IO缓冲区，每收到数据都要检测缓冲区内的数据是否跟协议符合、
若完整，则调用CuserSession内的ExtractPacket方法，取出一幅完整的数据，
然后放入缓冲队列内，等待写入MYSQL数据库
若不完整，或者不符合协议规定，则关闭此SOCKET。
*/

class CUserSession;

//调用DLL的参数
typedef struct  
{
	char strCollector[DEVICE_ID_LEN+1]; //采集器ID
	char strDevice[1024];               //设备以及操作方法字符串列表
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

	map<CString,BOOL> mapDebugStatus; //设备是否正在调试

	CriticalSection m_csmapSocket;
	map<CString,CUserSession *> mapSocket;  //采集器和SOCKET对照表，需要实时更新

	CriticalSection m_csmapDebugDevice;
	map<CString,map<CString,CString> > mapDebugDevice; //需要升级的设备以及调试方式，从数据库读取

	void DoParser(TCP_DATA * pTCPData,CUserSession * pSession);
	
private:
	int dwServerPort;
	int dwTimeOut;
	int dwLogLevel;
	long dwRecvPackets;

	DataManage dataManage;	

	CriticalSection m_csOnlineClient;
	map<SOCKET,CUserSession * > G_OnlineClient; //在线客户端MAP

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

	friend DWORD WINAPI TCPServer_KeepLiveThread(LPVOID param); //维护SOCKET的链路，1800秒没收到数据认为超时
	friend DWORD WINAPI TCPServer_SocketThread(LPVOID param);
	friend DWORD WINAPI TCPServer_WorkThread(LPVOID param); //IOCP的工作线程

	void DoRead(PER_IO_DATA * pRecvIO,CUserSession * pSession,DWORD dwIOSize); //收到数据了（异步模式）
	void DoClear(CUserSession * pSession);               //预释放SOCKET
};


#endif





















