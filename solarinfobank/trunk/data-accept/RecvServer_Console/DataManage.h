/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:���ݲ����������
FileName:CriticalSection.h
**************************************************/
#pragma once

#include "MyDef.h"
#include "CriticalSection.h"

/// <summary>
/// ���ݲ�����
/// </summary>
class DataManage
{
//������Ա
public:
    /// <summary>
    /// ���캯��
    /// </summary>
	DataManage(void);

	/// <summary>
    /// ��������
    /// </summary>
	~DataManage(void);

	/// <summary>
	/// �����ݿ�����
	/// </summary>
	/// <returns>�������</returns>
	/// <notice>�˷�����Ϊֱ�Ӷ�ȡ�����ļ��������ļ����ý������ݿ�򿪲��������պ���������չ�����齫�����ļ�������ȡ���࣬�����㵥һְ���ԭ��</notice>
	BOOL OpenDB();
	
	/// <summary>
	/// ���ⲿ���ã�����Ҫ����memcached�����ݴ����ڴ滺�������ȴ�רְ�߳̽��ж�Ӧ������Э��ʹ��
	/// </summary>
	/// <param name="param">DataManage *����ָ��</param>
	void AddToBuffer(TCP_DATA * pTcpData);

	/// <summary>
	/// רְ�����������ϰ汾Э���е����ݴ���memcached
	/// </summary>
	/// <param name="param">DataManage *����ָ��</param>
	friend DWORD WINAPI SaveToDBThread(LPVOID param);

	//BEGIN:add by bloodhunter at 2012-4-16
	/// <summary>
	/// ���ⲿ���ã�����Ҫ����memcached�����ݴ����ڴ滺�������ȴ�רְ�߳̽��ж�Ӧ������Э��ʹ��
	/// </summary>
	/// <param name="pTcpData">��Ҫ���������</param>
	void AddToMemBuf(TCP_DATA * pTcpData);
	/// <summary>
	/// רְ���ڴ滺���е��°汾Э�������д��memcached
	/// </summary>
	/// <param name="param">DataManage����</param>
	friend DWORD WINAPI SaveToMemThread(LPVOID param);//дmemecache�߳�

//������Ա
private:
	queue <TCP_DATA *> m_bufMem;		//���ݻ���
	CriticalSection m_csMap;						//�߳���
	//END:add by bloodhunter at 2012-4-16
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //���ݻ������
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL���ӵ�������Ϣ
public:
	MyConnection m_conn;	//���ݿ�����
	long dwSeqPackets;		//��Э����ʹ�ã����ڱ�ǵ�ǰ�������ݰ��ĸ�����[������ǿͻ����󣬸��˽���Ӧ�����Ƴ����Ͼ�long������ȡֵ��Χ]
};
