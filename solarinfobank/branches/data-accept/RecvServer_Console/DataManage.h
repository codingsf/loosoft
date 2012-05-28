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

	friend DWORD WINAPI SaveToDBThread(LPVOID param); //д���߳�

private:
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //���ݻ������
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL���ӵ�������Ϣ
};
