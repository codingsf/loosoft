#ifndef _CRITICALSECTION_H_
#define _CRITICALSECTION_H_

/*
CriticalSection:
临界区控制，用于多线程互斥、锁
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
