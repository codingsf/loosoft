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

	//BEGIN:add by bloodhunter at 2012-4-16
	void AddToMemBuf(TCP_DATA * pTcpData);
	friend DWORD WINAPI SaveToMemThread(LPVOID param);//写memecache线程
private:
	queue <TCP_DATA *> m_bufMem;		//数据缓存
	CriticalSection m_csMap;						//线程锁
	//END:add by bloodhunter at 2012-4-16
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //数据缓存队列
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL连接的配置信息
};
