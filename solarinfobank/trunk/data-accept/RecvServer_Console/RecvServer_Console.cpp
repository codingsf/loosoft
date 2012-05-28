// RecvServer_Console.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "RecvServer_Console.h"
#include "MySQLUtil.h"
#include "DataManage.h"
#include "TCPServer.h"
#include "DLLLoader.h"
#include "NewProtocol.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// The one and only application object

CWinApp theApp;

using namespace std;

DLLLoader dllLoader;	
Protocol69Dealer protocol69Dealer;
TCPServer tcp_svr;


int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	int nRetCode = 0;
	//modify by qhb for 升级版本号 in 20120330
	SetConsoleTitle("RecvServer V1.1.0");
	cout << "===========================================================" << endl;

	// 初始化 MFC 并在失败时显示错误
	if (!AfxWinInit(::GetModuleHandle(NULL), NULL, ::GetCommandLine(), 0))
	{
		// TODO: 更改错误代码以符合您的需要
		_tprintf(_T("错误: MFC 初始化失败\n"));
		nRetCode = 1;
	}
	else
	{
		InitDB();

		for (;;)
		{
			Sleep(8888);
		}
		
		FreeDB();
	}

	return nRetCode;
}


