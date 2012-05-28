// DLLLoader.cpp: implementation of the DLLLoader class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "RecvServer_Console.h"
#include "DLLLoader.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

DLLLoader::DLLLoader()
{
	hDll=::LoadLibrary(".\\SendDll.dll");
	if (hDll==NULL)
	{
		cout << "*** WARNING:Can't Find Library SendDll.dll ***" << endl;
		
		return;
	}

	pInit = (PFUN_INIT)::GetProcAddress(hDll,"MC_Init");
	pUnInit = (PFUN_UNINIT)::GetProcAddress(hDll,"MC_UnInit");
	pSend2MC = (PFUN_SEND2MC)::GetProcAddress(hDll,"Send2MC");
	pSend2Dll = (PFUN_SEND2Dll)::GetProcAddress(hDll,"Send2Dll");

	GetPrivateProfileString("Memcached","Host","127.0.0.1:11211",strMCServer,50,"./config.ini");
	BOOL bInit=pInit(strMCServer);
	if (!bInit)
	{
		cout << "*** Init MemCachedClient Failed!" << endl;
	}
	else
	{
		cout << "*** Init MemCachedClient Success..." << endl;
	}
}

DLLLoader::~DLLLoader()
{
	pUnInit();

	FreeLibrary(hDll);
}
