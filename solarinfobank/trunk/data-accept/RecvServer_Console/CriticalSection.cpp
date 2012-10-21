/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:�ٽ������ƣ����ڶ��̻߳��⡢��
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
Description: ����
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
Description: ����
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
