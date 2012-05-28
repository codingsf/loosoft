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

	//BEGIN:add by bloodhunter at 2012-4-16
	void AddToMemBuf(TCP_DATA * pTcpData);
	friend DWORD WINAPI SaveToMemThread(LPVOID param);//дmemecache�߳�
private:
	queue <TCP_DATA *> m_bufMem;		//���ݻ���
	CriticalSection m_csMap;						//�߳���
	//END:add by bloodhunter at 2012-4-16
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //���ݻ������
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL���ӵ�������Ϣ
};
