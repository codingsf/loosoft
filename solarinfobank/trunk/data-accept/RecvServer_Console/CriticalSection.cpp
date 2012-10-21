/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:临界区控制，用于多线程互斥、锁
**************************************************/
#include "StdAfx.h"
#include "CriticalSection.h"
#include <Windows.h>

CriticalSection::CriticalSection()
{
	m_handle = new CRITICAL_SECTION;
	InitializeCriticalSection((LPCRITICAL_SECTION) m_handle);
}

CriticalSection::~CriticalSection()
{
	DeleteCriticalSection((LPCRITICAL_SECTION) m_handle);
	delete (LPCRITICAL_SECTION) m_handle;
}

/*************************************************
Function: CriticalSection::Enter()
Description: 锁定
Calls:
Input:
Output:
Return:
Others:
*************************************************/
void CriticalSection::Enter()
{
	EnterCriticalSection((LPCRITICAL_SECTION) m_handle);
}

/*************************************************
Function: CriticalSection::Enter()
Description: 解锁
Calls:
Input:
Output:
Return:
Others:
*************************************************/
void CriticalSection::Leave()
{
	LeaveCriticalSection((LPCRITICAL_SECTION) m_handle);
}
