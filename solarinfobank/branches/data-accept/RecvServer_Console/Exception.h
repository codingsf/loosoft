#ifndef _EXCEPTION_H_
#define _EXCEPTION_H_

#include "windows.h"
#include <string>
using namespace std;

class Exception
{
protected:
	char *m_pMessage;
public:
	Exception();
	Exception(const Exception &ex);
	Exception(const string &msg);
	Exception(const char * const &pMsg);
	~Exception();

	const char * Message() const { return m_pMessage; }
};

#endif