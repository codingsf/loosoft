#ifndef _MYSQLUTIL_H_
#define _MYSQLUTIL_H_

/*
针对MYSQL的API库进行了简单封装，详细帮助请参考MYSQL API的官方文档
*/

#include <Windows.h>
#include "mysql.h"
#pragma comment(lib, "libmysql.lib")

#include "Exception.h"
#include <string>
using namespace std;

bool InitDB();
void FreeDB();

class MySQLException : public Exception
{
public:
	MySQLException() : Exception() {}
	MySQLException(const MySQLException &ex) : Exception(ex) {}
	MySQLException(const string &msg) : Exception(msg) {}
	MySQLException(const char * const &pMsg) : Exception(pMsg) {}
};

class MyResult
{
protected:
	MYSQL_RES *m_pRes;

public:
	MyResult() : m_pRes(NULL) {}
	MyResult(MYSQL_RES * const &res) : m_pRes(res) {}
	~MyResult();

	void SetResult( MYSQL_RES *pRes);
	unsigned long GetFieldCount() { mysql_num_fields(m_pRes); }
	unsigned long GetRowCount() { return unsigned long (mysql_num_rows(m_pRes)); }
	bool GetRow(char ** &row);
};

class MyConnection
{
protected:
	MYSQL m_mysql;
	string m_dbServer;
	string m_dbName;
	string m_dbUser;
	string m_dbPwd;
	int m_db_port;

public:
	MyConnection();
	~MyConnection();

	void Open(); //打开数据库
	void ExecSQL(const string &sql, MyResult *result = NULL); //执行SQL语句

	const string &GetDBServer() const
	{
		return m_dbServer;
	}
	const string &GetDBName() const
	{
		return m_dbName;
	}
	const string &GetDBUser() const
	{
		return m_dbUser;
	}
	const string &DBPassword() const
	{
		return m_dbPwd;
	}

	void SetDBPort(const int & dbPort)
	{
		m_db_port=dbPort;
	}

	void SetDBServer(const string &server)
	{
		m_dbServer = server;
	}
	void SetDBName(const string &name)
	{
		m_dbName = name;
	}
	void SetDBUser(const string &user)
	{
		m_dbUser = user;
	}
	void SetDBPassword(const string &pwd)
	{
		m_dbPwd = pwd;
	}
};

#endif