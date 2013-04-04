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
	//先这是进程所在目录为工作目录，以便有其它程序启动时工作路径不对
	char pBuf[MAX_PATH];
	GetCurrentDirectory(MAX_PATH,pBuf);
	cout << "*** The original current directory is:" << pBuf << endl;

	CString	strAppPath;  // 保存结果
	TCHAR szModuleFileName[MAX_PATH]; // 全路径名
	TCHAR drive[_MAX_DRIVE];  // 盘符名称，比如说C盘啊，D盘啊
	TCHAR dir[_MAX_DIR]; // 目录
	TCHAR fname[_MAX_FNAME];  // 进程名字
	TCHAR ext[_MAX_EXT]; //后缀，一般为exe或者是dll
	if (NULL == GetModuleFileName(NULL, szModuleFileName, MAX_PATH)) //获得当前进程的文件路径
		strAppPath="";
	else{
		_tsplitpath_s( szModuleFileName, drive, dir, fname, ext );  //分割该路径，得到盘符，目录，文件名，后缀名
		strAppPath = drive;
		strAppPath += dir;
	}

	SetCurrentDirectory(strAppPath);
	
	GetCurrentDirectory(MAX_PATH,pBuf);
	cout << "*** The now current directory is:" << pBuf << endl;

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
	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	pReadFromMC = (PFUN_SEND2MC)::GetProcAddress(hDll,"GetFromMC");
	pRemoveFromMC = (PFUN_INIT)::GetProcAddress(hDll,"Remove");
	pAppend2MC =  (PFUN_SEND2MC)::GetProcAddress(hDll,"Append2MC");//追加数据
	pIsExistKey = (PFUN_INIT)::GetProcAddress(hDll,"IsExist");
	//END:add by bloodhunter for new protocol at 2012-3-23

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
	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	FreeLibrary(hAesDll);
	//END:add by bloodhunter for new protocol at 2012-3-23
}
