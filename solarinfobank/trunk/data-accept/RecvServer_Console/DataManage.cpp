/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:数据操作相关的实现
FileName:CriticalSection.h
**************************************************/
#include "StdAfx.h"
#include "ExpandType.h"
#include "DataManage.h"
#include "DLLLoader.h"
#include "TCPServer.h"
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

/// <summary>
/// 打开数据库连接
/// </summary>
/// <returns>操作结果</returns>
/// <notice>此方法中为直接读取配置文件，根据文件配置进行数据库打开操作。若日后程序继续扩展，则建议将配置文件单独提取成类，以满足单一职责的原则</notice>
BOOL DataManage::OpenDB()
{
	//读取MYSQL.INI配置文件，以便连接数据库
	mysqlConnectParam.dwPort=GetPrivateProfileInt("MySQL","Port",3306,"./config.ini");
	GetPrivateProfileString("MySQL","IP","",mysqlConnectParam.strIp,50,"./config.ini");
	GetPrivateProfileString("MySQL","User","",mysqlConnectParam.strUser,50,"./config.ini");
	GetPrivateProfileString("MySQL","Pass","",mysqlConnectParam.strPass,50,"./config.ini");
	GetPrivateProfileString("MySQL","DBName","",mysqlConnectParam.strDB,50,"./config.ini");
	cout << "*** dbname...\n" << mysqlConnectParam.strDB << endl;
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

/// <summary>
/// 供外部调用，将需要存入memcached的数据存入内存缓冲区，等待专职线程进行对应处理。老协议使用
/// </summary>
/// <param name="param">DataManage *对象指针</param>
void DataManage::AddToBuffer(TCP_DATA * pTcpData)
{
	m_csBufferQueue.Enter();
	m_BufferQueue.push(pTcpData);
	m_csBufferQueue.Leave();
}

/// <summary>
/// 专职方法，用于老版本协议中的数据存入memcached
/// </summary>
/// <param name="param">DataManage *对象指针</param>
DWORD WINAPI SaveToDBThread(LPVOID param)
{
	DataManage * pDlg=(DataManage *)param;

	while (TCPServer::m_bIsExit)
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
		// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
		// [修改说明]:将锁的解除从函数尾移至此处，用于减少锁冲突的概率，以提供程序的性能
		pDlg->m_csBufferQueue.Leave();
		// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改

		//放入MemCached Server 作为缓存
		CString strContent;
		for (int i=0;i<pTCPData->dwDataLen;i++)
		{
			// BEGIN:Modify by bloodhunter at 2012/10/21 for 代码整改
			// [修改说明]:临时变量需要初始化
			//char strTemp[4];
			char strTemp[4] = {0};
			// END:Modify by bloodhunter at 2012/10/21 for 代码整改
			sprintf(strTemp,"%02X ",(unsigned char)pTCPData->pDataContent[i]);
			strContent += strTemp;
		}
		strContent.TrimRight();

		CString strID;
		strID.Format("tcp%s%d",CTime::GetCurrentTime().Format("%Y%m%d%H%M%S"),pDlg->dwSeqPackets);

		//cout << "KEY:" << strID.GetBuffer(0) << ",Content:" << strContent.GetBuffer(0) << endl;

		int dwRet=dllLoader.pSend2MC(strID.GetBuffer(0),strContent.GetBuffer(0));
		if (dwRet<0)
		{
			cout << "KEY:[" << strID.GetBuffer(0) << "],Error Code:" << dwRet << ",check Memcached Server!" << endl;
		}else{//add by hbqian for 设置最后一次成功处理数据的时间到memached，以便检测程序能判断接收程序的运行状态
			CString strID1="accept_run_lasttime"; //最后正确接收数据的时间
			CString strContent1=CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S");
			int dwRet=dllLoader.pSend2MC(strID1.GetBuffer(0),strContent1.GetBuffer(0));
			strID1.ReleaseBuffer();
			strContent1.ReleaseBuffer();
		}


		strID.ReleaseBuffer();
		strContent.ReleaseBuffer();

		// BEGIN:Modify by bloodhunter at 2012/10/21 for 代码整改
		// [修改说明]:此处内存释放时，需要增加额外判断以保证操作安全
		//delete []pTCPData->pDataContent;
		//pTCPData->pDataContent=NULL;
		//delete pTCPData;
		//pTCPData=NULL;
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
		// BEGIN:Modify by bloodhunter at 2012/10/21 for 代码整改

		pDlg->dwSeqPackets++;	
	}

	// BEGIN:Delete by bloodhunter at 2012/10/21 for 代码整改
	// [修改说明]:将锁的解除从此处移至前处，用于减少锁冲突的概率，以提供程序的性能
	//pDlg->m_csBufferQueue.Leave();
	// BEGIN:Delete by bloodhunter at 2012/10/21 for 代码整改

	return 0L;
}


/// <summary>
/// 供外部调用，将需要存入memcached的数据存入内存缓冲区，等待专职线程进行对应处理。新协议使用
/// </summary>
/// <param name="pTcpData">需要处理的数据</param>
void DataManage::AddToMemBuf(TCP_DATA * pTcpData)
{
	m_csMap.Enter();
	m_bufMem.push(pTcpData);
	m_csMap.Leave();
}

/// <summary>
/// 专职将内存缓存中的新版本协议的数据写入memcached
/// </summary>
/// <param name="param">DataManage对象</param>
DWORD WINAPI SaveToMemThread(LPVOID param)
{
	DataManage * pDlg=(DataManage *)param;

	CString lastKey("");
	while (TCPServer::m_bIsExit)
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
		/// 从队列中获取此次需要操作的对象
		pDlg->m_csMap.Enter();
		if (pDlg->m_bufMem.empty())
		{
			pDlg->m_csMap.Leave();
			Sleep(200);
			continue;
		}

		TCP_DATA * pTCPData=pDlg->m_bufMem.front();
		pDlg->m_bufMem.pop();
		// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
		// [修改说明]:从代码结尾处转移到此处，以减少锁冲突的概率，从而提高程序的性能
		pDlg->m_csMap.Leave();
		// END:Add by bloodhunter at 2012/10/21

		if(pTCPData->key == NULL || pTCPData->pDataContent == NULL)
		{
			// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
			// [修改说明]:此处如果不释放资源有可能导致内存泄露
			if(pTCPData != NULL)
			{
				if(pTCPData->pDataContent != NULL)
				{
					delete [] pTCPData->pDataContent;
					pTCPData->pDataContent = NULL;
				}
				if(pTCPData->key != NULL)
				{
					delete [] pTCPData->key;
					pTCPData->key = NULL;
				}
				delete pTCPData;
				pTCPData = NULL;
			}
			// END:Add by bloodhunter at 2012/10/21
			continue;
		}
		//放入MemCached Server 作为缓存
		CString strContent("");
		if(pTCPData->isHex)
		{
			for (int i=0; i < pTCPData->dwDataLen; i++)
			{
				char strTemp[4] = {0};
				sprintf(strTemp,"%02X ",(unsigned char)pTCPData->pDataContent[i]);
				strContent += strTemp;
			}
			strContent.TrimRight();
		}
		else
		{
			strContent.Format("%s", pTCPData->pDataContent);
		}

		CString strID("");
		strID.Format("%s", pTCPData->key);

		//int dwRet=dllLoader.pSend2MC(strID.GetBuffer(0),strContent.GetBuffer(0));
		//strID.ReleaseBuffer();
		//strContent.ReleaseBuffer();
		int dwRet=dllLoader.pSend2MC((LPTSTR)(LPCTSTR)strID, (LPTSTR)(LPCTSTR)strContent);
		if (dwRet < 0)
		{
			cout << "KEY:[" << (LPTSTR)(LPCTSTR)strID<< "],Error Code:" << dwRet << ",conent:" << (LPTSTR)(LPCTSTR)strContent << ",check Memcached Server!" << endl;
			//写错误数据的log
			SENDMEMFAILEDLOG(strID, strContent, true);
		}
		else
		{
			//此处记载日志，写入memcache的内容
			SENDMEMLOG(strID, strContent, true);
			cout << "KEY:[" << (LPTSTR)(LPCTSTR)strID<< "]:" << dwRet << ",input to Memcached Server success!" << endl;
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
		    pTCPData = NULL;
        }
		// BEGIN:Delete by bloodhunter at 2012/10/21 for 代码整改
		// [修改说明]:从代码结尾处转移，以减少锁冲突的概率，从而提高程序的性能
		//pDlg->m_csMap.Leave();
		// END:Delete by bloodhunter at 2012/10/21 for 代码整改
		//Sleep(50);
		pDlg->dwSeqPackets++;
	}
	return 0L;
}