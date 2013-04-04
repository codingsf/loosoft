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
	//modify by qhb for �����汾�� in 20120330
	SetConsoleTitle("RecvServer V2.1.0");
	cout << "===========================================================" << endl;

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
		//�������б�ʶ
		//add by hbqian for �������һ�γɹ��������ݵ�ʱ�䵽memached���Ա���������жϽ��ճ��������״̬
		CString strID1="accept_run_lasttime"; //�����ȷ�������ݵ�ʱ��
		CString strContent1=CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S");
		int dwRet=dllLoader.pSend2MC(strID1.GetBuffer(0),strContent1.GetBuffer(0));
		strID1.ReleaseBuffer();
		strContent1.ReleaseBuffer();
		
		for (;;)
		{
			Sleep(8888);
		}
		
		FreeDB();
	}

	return nRetCode;
}


