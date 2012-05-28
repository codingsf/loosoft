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

void CriticalSection::Enter()
{
	EnterCriticalSection((LPCRITICAL_SECTION) m_handle);
}

void CriticalSection::Leave()
{
	LeaveCriticalSection((LPCRITICAL_SECTION) m_handle);
}
