/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:数据操作相关声明
FileName:CriticalSection.h
**************************************************/
#pragma once

#include "MyDef.h"
#include "CriticalSection.h"

/// <summary>
/// 数据操作类
/// </summary>
class DataManage
{
//方法成员
public:
    /// <summary>
    /// 构造函数
    /// </summary>
	DataManage(void);

	/// <summary>
    /// 析构函数
    /// </summary>
	~DataManage(void);

	/// <summary>
	/// 打开数据库连接
	/// </summary>
	/// <returns>操作结果</returns>
	/// <notice>此方法中为直接读取配置文件，根据文件配置进行数据库打开操作。若日后程序继续扩展，则建议将配置文件单独提取成类，以满足单一职责的原则</notice>
	BOOL OpenDB();
	
	/// <summary>
	/// 供外部调用，将需要存入memcached的数据存入内存缓冲区，等待专职线程进行对应处理。老协议使用
	/// </summary>
	/// <param name="param">DataManage *对象指针</param>
	void AddToBuffer(TCP_DATA * pTcpData);

	/// <summary>
	/// 专职方法，用于老版本协议中的数据存入memcached
	/// </summary>
	/// <param name="param">DataManage *对象指针</param>
	friend DWORD WINAPI SaveToDBThread(LPVOID param);

	//BEGIN:add by bloodhunter at 2012-4-16
	/// <summary>
	/// 供外部调用，将需要存入memcached的数据存入内存缓冲区，等待专职线程进行对应处理。新协议使用
	/// </summary>
	/// <param name="pTcpData">需要处理的数据</param>
	void AddToMemBuf(TCP_DATA * pTcpData);
	/// <summary>
	/// 专职将内存缓存中的新版本协议的数据写入memcached
	/// </summary>
	/// <param name="param">DataManage对象</param>
	friend DWORD WINAPI SaveToMemThread(LPVOID param);//写memecache线程

//变量成员
private:
	queue <TCP_DATA *> m_bufMem;		//数据缓存
	CriticalSection m_csMap;						//线程锁
	//END:add by bloodhunter at 2012-4-16
	CriticalSection m_csBufferQueue;
	queue <TCP_DATA *> m_BufferQueue; //数据缓存队列
	
	MYSQL_CONNECT_PARAM mysqlConnectParam; //MYSQL连接的配置信息
public:
	MyConnection m_conn;	//数据库连接
	long dwSeqPackets;		//老协议中使用，用于标记当前处理数据包的个数。[此如果非客户需求，个人建议应将其移除，毕竟long存在其取值范围]
};
