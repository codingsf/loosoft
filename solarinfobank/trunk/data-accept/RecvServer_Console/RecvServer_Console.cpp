// RecvServer_Console.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "RecvServer_Console.h"
#include "MySQLUtil.h"
#include "DataManage.h"
#include "TCPServer.h"
#include "DLLLoader.h"
#include "NewProtocol.h"
#using "MemcachedClient.dll"
using namespace CSLib;
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// The one and only application object

CWinApp theApp;

using namespace std;
char memcachedStr[50];

DLLLoader dllLoader;	
Protocol69Dealer protocol69Dealer;
TCPServer tcp_svr;
int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{	
	int nRetCode = 0;
	//����c sharp dll call
	//MemcachedCSClient ^c = gcnew MemcachedCSClient("127.0.0.1:11211");
	//bool issuccess = c->Set("tcp_20_run_shanghaisuori01_20130404222133195005447","111111");
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
	
		GetPrivateProfileString("Memcached","Host","127.0.0.1:11211",memcachedStr,50,"./config.ini");
		System::String ^memcached = gcnew System::String(memcachedStr);
		MemcachedCSClient ^c = gcnew MemcachedCSClient(memcached);
		System::String ^csstrID = gcnew System::String(strID1);
		System::String ^csstrContent = gcnew System::String(strContent1);
		//int dwRet=dllLoader.pSend2MC(strID1.GetBuffer(0),strContent1.GetBuffer(0));
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


