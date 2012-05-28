// RecvServer_Console.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "RecvServer_Console.h"
#include "MySQLUtil.h"
#include "DataManage.h"
#include "TCPServer.h"
#include "DLLLoader.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// The one and only application object

CWinApp theApp;

using namespace std;

TCPServer tcp_svr;
DLLLoader dllLoader;	

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	int nRetCode = 0;
	
	SetConsoleTitle("RecvServer V1.0.1");
	cout << "===========================================================" << endl;

        CString strID;
	strID.Format("tcp%s",CTime::GetCurrentTime().Format("%Y%m%d%H%M%S"));
    CString strContent = "dsf";
	cout << "KEY:" << strID.GetBuffer(0) << ",Content:" << strContent.GetBuffer(0) << endl;

	int dwRet=dllLoader.pSend2MC(strID.GetBuffer(0),strContent.GetBuffer(0));
	// ��ʼ�� MFC ����ʧ��ʱ��ʾ����
	if (!AfxWinInit(::GetModuleHandle(NULL), NULL, ::GetCommandLine(), 0))
	{
		// TODO: ���Ĵ�������Է���������Ҫ
		_tprintf(_T("����: MFC ��ʼ��ʧ��\n"));
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


