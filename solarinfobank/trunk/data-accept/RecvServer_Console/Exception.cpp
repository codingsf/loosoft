#include "stdafx.h"
#include "Exception.h"

Exception::Exception()
{
	m_pMessage = new char[8];
	strcpy(m_pMessage, "Nothing");
}

Exception::Exception(const Exception &ex)
{
	size_t len = strlen(ex.m_pMessage);
	m_pMessage = new char[len + 1];
	strcpy(m_pMessage, ex.m_pMessage);
}

Exception::Exception(const string &msg)
{
	Exception(msg.c_str());
}

Exception::Exception(const char * const &pMsg)
{
	if (pMsg == NULL)
	{
		Exception();
		return;
	}

	size_t len = strlen(pMsg);
	m_pMessage = new char[len + 1];
	strcpy(m_pMessage, pMsg);
}

Exception::~Exception()
{
	if (m_pMessage != NULL)
	{
		delete[] m_pMessage;
	}
}
