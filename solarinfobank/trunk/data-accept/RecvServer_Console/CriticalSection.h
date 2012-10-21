/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:临界区控制，用于多线程互斥、锁
FileName:CriticalSection.h
**************************************************/
#pragma once

class CriticalSection
{
protected:
	void *m_handle;

public:
	CriticalSection();
	~CriticalSection();

	void Enter();
	void Leave();
};
