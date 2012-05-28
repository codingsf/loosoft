#include "StdAfx.h"
#include "DataManage.h"
#include "DLLLoader.h"
extern DLLLoader dllLoader;

DataManage::DataManage(void)
{
	dwSeqPackets=0;
}

DataManage::~DataManage(void)
{
	dwSeqPackets=0;
}

BOOL DataManage::OpenDB()
{
	//读取MYSQL.INI配置文件，以便连接数据库
	mysqlConnectParam.dwPort=GetPrivateProfileInt("MySQL","Port",3306,"./config.ini");
	GetPrivateProfileString("MySQL","IP","",mysqlConnectParam.strIp,50,"./config.ini");
	GetPrivateProfileString("MySQL","User","",mysqlConnectParam.strUser,50,"./config.ini");
	GetPrivateProfileString("MySQL","Pass","",mysqlConnectParam.strPass,50,"./config.ini");
	GetPrivateProfileString("MySQL","DBName","",mysqlConnectParam.strDB,50,"./config.ini");

	try
	{
		m_conn.SetDBServer(mysqlConnectParam.strIp);
		m_conn.SetDBName(mysqlConnectParam.strDB);
		m_conn.SetDBUser(mysqlConnectParam.strUser);
		m_conn.SetDBPassword(mysqlConnectParam.strPass);
		m_conn.SetDBPort(mysqlConnectParam.dwPort);

		m_conn.Open();
		m_conn.ExecSQL("set names 'gb2312'");

		cout << "*** Connect to MYSQL Success..." << endl;

		CreateThread(NULL,0,SaveToDBThread,this,NULL,NULL);
	}

	catch (MySQLException &e)
	{
		cout << "*** Connect to MYSQL Failed...\n" << e.Message() << endl;

		cout << "*** Press any key to quit..." << endl;

		return FALSE;
	}

	return TRUE;
}

void DataManage::AddToBuffer(TCP_DATA * pTcpData)
{
	m_csBufferQueue.Enter();

	m_BufferQueue.push(pTcpData);

	m_csBufferQueue.Leave();
}

DWORD WINAPI SaveToDBThread(LPVOID param)
{
	DataManage * pDlg=(DataManage *)param;

	for (;;)
	{
		pDlg->m_csBufferQueue.Enter();
		if (pDlg->m_BufferQueue.empty())
		{
			pDlg->m_csBufferQueue.Leave();
			Sleep(50);
			continue;
		}

		TCP_DATA * pTCPData=pDlg->m_BufferQueue.front();
		pDlg->m_BufferQueue.pop();

		//放入MemCached Server 作为缓存
		CString strContent;
		for (int i=0;i<pTCPData->dwDataLen;i++)
		{
			char strTemp[4];
			sprintf(strTemp,"%02X ",(unsigned char)pTCPData->pDataContent[i]);
			strContent+=strTemp;
		}
		strContent.TrimRight();

		CString strID;
		strID.Format("tcp%s%d",CTime::GetCurrentTime().Format("%Y%m%d%H%M%S"),pDlg->dwSeqPackets);

		//cout << "KEY:" << strID.GetBuffer(0) << ",Content:" << strContent.GetBuffer(0) << endl;

		int dwRet=dllLoader.pSend2MC(strID.GetBuffer(0),strContent.GetBuffer(0));
		if (dwRet<0)
		{
			cout << "KEY:[" << strID.GetBuffer(0) << "],Error Code:" << dwRet << ",check Memcached Server!" << endl;
		}

		strID.ReleaseBuffer();
		strContent.ReleaseBuffer();

		delete []pTCPData->pDataContent;
		pTCPData->pDataContent=NULL;
		delete pTCPData;
		pTCPData=NULL;

		pDlg->dwSeqPackets++;

		pDlg->m_csBufferQueue.Leave();
	}

	return 0L;
}