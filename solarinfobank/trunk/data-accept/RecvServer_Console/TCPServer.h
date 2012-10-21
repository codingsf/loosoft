/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:TCPSRV连接类
FileName:TCPServer.h
**************************************************/
#pragma once

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
	map<CString, CUserSession *> mapSocket;  //采集器和SOCKET对照表，需要实时更新

	CriticalSection m_csmapDebugDevice;
	map<CString,map<CString,CString> > mapDebugDevice; //需要升级的设备以及调试方式，从数据库读取

	void DoParser(TCP_DATA * pTCPData,CUserSession * pSession);
	//BEGIN:add by bloodhunter at 2012-4-6
	CriticalSection m_csMap;
	map<string, CUserSession*> m_mapSession;								//存储SN与Session的键值对
	HANDLE		m_hCmdThread;												//处理命令的线程，从memcache中读取命令，下发
	UINT		m_iCmdThreadID;
	friend DWORD WINAPI CMDThreadProc (LPVOID pParam);					//CMD线程工作函数
	//END:add by bloodhunter at 2012-4-6
	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	void DealNewProtocol(TCP_DATA * pTCPData, CUserSession * pSession);		//处理新协议的数据
public:	
	static int iSendConn;	//是否在接收请求时发送握手响应。以兼容老版本协议
	//END:add by bloodhunter for new protocol at 2012-3-23

	// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
	// [修改说明]:防止程序未处理到的异常导致程序假死或memcached客户端出现问题导致无法正确插入数据
	friend DWORD WINAPI RestartThread (LPVOID pParam);				//定时重启自身
	static int m_iRestartInterval;									//重启时间间隔，默认0
	static bool m_bIsExit;											//线程退出标志位
	// END:Add by bloodhunter at 2012/10/21 for 代码整改

	
//private:
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


	//将ASCII码转化为16进制数
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
		   cmd[i] = ConvertHexChar(tmpByte)<<4;//左移4位
		   if (str[++j] == ' ')
			   ++j;
		   tmpByte = str[j];        
		   cmd[i] = cmd[i] + (ConvertHexChar(tmpByte) & 0xF);//取低4位然后相加。    
		} 
		return i + 1;
	}
};
