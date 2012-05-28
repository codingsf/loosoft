#include "StdAfx.h"
#include "ExpandType.h"
#include "DataManage.h"
#include "DLLLoader.h"
extern DLLLoader dllLoader;

DataManage::DataManage(void)
{
	dwSeqPackets=0;
	CreateThread(NULL,0,SaveToMemThread,this,NULL,NULL);
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



//存buf，等待写入memcache
void DataManage::AddToMemBuf(TCP_DATA * pTcpData)
{
	m_csMap.Enter();
	m_bufMem.push(pTcpData);
	m_csMap.Leave();
}



//写memcache线程
DWORD WINAPI SaveToMemThread(LPVOID param)
{
	DataManage * pDlg=(DataManage *)param;

	CString lastKey("");
	for (;;)
	{
#if 0//测试用，测试append方法是否有效
			int dwtestRet;
			CString test("DEBUG");
			CString testID("test1234test");
			if(test.Compare(lastKey) != 0)
			{	
				//尝试第一次写入
				dwtestRet=dllLoader.pSend2MC(test.GetBuffer(0),testID.GetBuffer(0));
				if(dwtestRet < 0)//表明此key已经存在，则使用append方法
				{
					dwtestRet = dllLoader.pAppend2MC(test.GetBuffer(0),testID.GetBuffer(0));
				}
			}
			else
			{
				dwtestRet = dllLoader.pAppend2MC(test.GetBuffer(0),testID.GetBuffer(0));
			}
			lastKey = test;

			testID.ReleaseBuffer();
			test.ReleaseBuffer();

			char read[4096];
			memset(read, 0 , sizeof(read));
            dllLoader.pReadFromMC("DEBUG",read);
			dllLoader.pRemoveFromMC("DEBUG");
			memset(read, 0 , sizeof(read));
            dllLoader.pReadFromMC("DEBUG",read);

			Sleep(1000);
			continue;
#endif
		pDlg->m_csMap.Enter();
		if (pDlg->m_bufMem.empty())
		{
			pDlg->m_csMap.Leave();
			Sleep(200);
			continue;
		}

		TCP_DATA * pTCPData=pDlg->m_bufMem.front();
		pDlg->m_bufMem.pop();

		if(pTCPData->key == NULL || pTCPData->pDataContent == NULL)
		{
			//Sleep(50);
			continue;
		}
		//放入MemCached Server 作为缓存
		CString strContent;
		if(pTCPData->isHex)
		{
			for (int i=0;i<pTCPData->dwDataLen;i++)
			{
				char strTemp[4];
				sprintf(strTemp,"%02X ",(unsigned char)pTCPData->pDataContent[i]);
				strContent+=strTemp;
			}
			strContent.TrimRight();
		}
		else
		{
			strContent.Format("%s", pTCPData->pDataContent);
		}

		CString strID;
		strID.Format("%s", pTCPData->key);

		//int dwRet=dllLoader.pSend2MC(strID.GetBuffer(0),strContent.GetBuffer(0));
		//strID.ReleaseBuffer();
		//strContent.ReleaseBuffer();
		int dwRet=dllLoader.pSend2MC((LPTSTR)(LPCTSTR)strID, (LPTSTR)(LPCTSTR)strContent);
		if (dwRet<0)
		{
			cout << "KEY:[" << (LPTSTR)(LPCTSTR)strID<< "],Error Code:" << dwRet << ",check Memcached Server!" << endl;
		}
		else
		{
			//此处记载日志，写入memcache的内容
			SENDMEMLOG(strID, strContent, true);
#if 0//此处不再需要，保留
			CString memkeyList_key;
			//此处更改为每秒一个key，以保证不会出现value过大的问题
			//memkeyList_key.Format("%s", "keylist_2.0_" + CTime::GetCurrentTime().Format("%Y-%m-%d"));
			//此处暂时使用到秒级别的作为key的寄存标识。但如果面对千以上级别的并发数，即使这样依然会崩溃
			memkeyList_key.Format("%s", "keylist_2.0_" + CTime::GetCurrentTime().Format("%Y%m%d%H%M%S"));
			char tmp[10240];//此处定义为10K，无法定义更大，因为此处为栈区，栈区的大小有限

			//尝试读取，如果读取成功，则表明存在，使用append。如果读取失败，则表明不存在，使用send
			memset(tmp, 0, sizeof(tmp));
			dwRet = dllLoader.pReadFromMC((LPTSTR)(LPCTSTR)memkeyList_key, tmp);
			if(dwRet == -1)
			{
				dwRet=dllLoader.pSend2MC((LPTSTR)(LPCTSTR)memkeyList_key, (LPTSTR)(LPCTSTR)strID);
			}
			else
			{
				strID = ":" + strID;
				if(strID.GetAllocLength()> 10200)
				{
					int mm =0;
				}
				dllLoader.pAppend2MC((LPTSTR)(LPCTSTR)memkeyList_key, (LPTSTR)(LPCTSTR)strID);
			}
#endif
		}

		//释放资源
        if(pTCPData != NULL)
        {
            if(pTCPData->pDataContent != NULL)
            {
		        delete []pTCPData->pDataContent;
                pTCPData->pDataContent = NULL;
            }
            if(pTCPData->key != NULL)
            {
		        delete[]pTCPData->key;
                pTCPData->key = NULL;
            }
		    delete pTCPData;
		    pTCPData=NULL;
        }
		pDlg->m_csMap.Leave();
		//Sleep(50);
	}
	return 0L;
}