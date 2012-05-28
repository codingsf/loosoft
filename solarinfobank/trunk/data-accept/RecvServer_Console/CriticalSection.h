#ifndef _CRITICALSECTION_H_
#define _CRITICALSECTION_H_

/*
CriticalSection:
�ٽ������ƣ����ڶ��̻߳��⡢��
*/

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

#endif
