/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:�ٽ������ƣ����ڶ��̻߳��⡢��
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
