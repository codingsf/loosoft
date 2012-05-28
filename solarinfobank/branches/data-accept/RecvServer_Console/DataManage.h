#pragma once

#include "MyDef.h"
#include "CriticalSection.h"

class DataManage
{
public:
	DataManage(void);
	~DataManage(void);
	BOOL OpenDB();
	MyConnection m_conn;

	long dwSeqPackets;
	void AddToBuffer(TCP_DATA * pTcpData);

	friend DWORD WINAPI SaveToDBThread(LPVOID param); //写库线程

private:
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //数据缓存队列
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL连接的配置信息
};
