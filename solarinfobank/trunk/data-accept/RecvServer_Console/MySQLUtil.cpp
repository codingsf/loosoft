#include "stdafx.h"
#include "MySQLUtil.h"

bool InitDB()
{
	return mysql_library_init(0, NULL, NULL) == 0;
}

void FreeDB()
{
	mysql_library_end();
}

MyConnection::MyConnection()
{
	mysql_init(&m_mysql);
}

MyConnection::~MyConnection()
{
	mysql_close(&m_mysql);
}

void MyConnection::Open()
{
	if (mysql_real_connect(&m_mysql, 
		m_dbServer.c_str(), 
		m_dbUser.c_str(), 
		m_dbPwd.c_str(), 
		m_dbName.c_str(), 
		m_db_port, NULL, 0) == NULL)
	{
		throw MySQLException(mysql_error(&m_mysql));
	}
}

void MyConnection::ExecSQL(const string & sql, MyResult *result)
{
	if (mysql_real_query(&m_mysql, sql.c_str(), (unsigned long) sql.size()) != 0)
	{
		throw MySQLException(mysql_error(&m_mysql));
	}

	if (result == NULL)
	{
		MYSQL_RES *p = mysql_use_result(&m_mysql);
		mysql_free_result(p);
	}
	else
	{
		result->SetResult(mysql_store_result(&m_mysql));
	}
}

MyResult::~MyResult()
{
	mysql_free_result(m_pRes);
}

bool MyResult::GetRow(char ** &row)
{
	row = mysql_fetch_row(m_pRes);
	return row != NULL;
}

void MyResult::SetResult(MYSQL_RES *pRes)
{
	if (m_pRes != NULL)
	{
		mysql_free_result(m_pRes);
	}

	m_pRes = pRes;
}
