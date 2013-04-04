/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:���ݲ�����ص�ʵ��
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
/// �����ݿ�����
/// </summary>
/// <returns>�������</returns>
/// <notice>�˷�����Ϊֱ�Ӷ�ȡ�����ļ��������ļ����ý������ݿ�򿪲��������պ���������չ�����齫�����ļ�������ȡ���࣬�����㵥һְ���ԭ��</notice>
BOOL DataManage::OpenDB()
{
	//��ȡMYSQL.INI�����ļ����Ա��������ݿ�
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
/// ���ⲿ���ã�����Ҫ����memcached�����ݴ����ڴ滺�������ȴ�רְ�߳̽��ж�Ӧ������Э��ʹ��
/// </summary>
/// <param name="param">DataManage *����ָ��</param>
void DataManage::AddToBuffer(TCP_DATA * pTcpData)
{
	m_csBufferQueue.Enter();
	m_BufferQueue.push(pTcpData);
	m_csBufferQueue.Leave();
}

/// <summary>
/// רְ�����������ϰ汾Э���е����ݴ���memcached
/// </summary>
/// <param name="param">DataManage *����ָ��</param>
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
		// BEGIN:Add by bloodhunter at 2012/10/21 for ��������
		// [�޸�˵��]:�����Ľ���Ӻ���β�����˴������ڼ�������ͻ�ĸ��ʣ����ṩ���������
		pDlg->m_csBufferQueue.Leave();
		// BEGIN:Add by bloodhunter at 2012/10/21 for ��������

		//����MemCached Server ��Ϊ����
		CString strContent;
		for (int i=0;i<pTCPData->dwDataLen;i++)
		{
			// BEGIN:Modify by bloodhunter at 2012/10/21 for ��������
			// [�޸�˵��]:��ʱ������Ҫ��ʼ��
			//char strTemp[4];
			char strTemp[4] = {0};
			// END:Modify by bloodhunter at 2012/10/21 for ��������
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
		}else{//add by hbqian for �������һ�γɹ��������ݵ�ʱ�䵽memached���Ա���������жϽ��ճ��������״̬
			CString strID1="accept_run_lasttime"; //�����ȷ�������ݵ�ʱ��
			CString strContent1=CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S");
			int dwRet=dllLoader.pSend2MC(strID1.GetBuffer(0),strContent1.GetBuffer(0));
			strID1.ReleaseBuffer();
			strContent1.ReleaseBuffer();
		}


		strID.ReleaseBuffer();
		strContent.ReleaseBuffer();

		// BEGIN:Modify by bloodhunter at 2012/10/21 for ��������
		// [�޸�˵��]:�˴��ڴ��ͷ�ʱ����Ҫ���Ӷ����ж��Ա�֤������ȫ
		//delete []pTCPData->pDataContent;
		//pTCPData->pDataContent=NULL;
		//delete pTCPData;
		//pTCPData=NULL;
		//�ͷ���Դ
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
		// BEGIN:Modify by bloodhunter at 2012/10/21 for ��������

		pDlg->dwSeqPackets++;	
	}

	// BEGIN:Delete by bloodhunter at 2012/10/21 for ��������
	// [�޸�˵��]:�����Ľ���Ӵ˴�����ǰ�������ڼ�������ͻ�ĸ��ʣ����ṩ���������
	//pDlg->m_csBufferQueue.Leave();
	// BEGIN:Delete by bloodhunter at 2012/10/21 for ��������

	return 0L;
}


/// <summary>
/// ���ⲿ���ã�����Ҫ����memcached�����ݴ����ڴ滺�������ȴ�רְ�߳̽��ж�Ӧ������Э��ʹ��
/// </summary>
/// <param name="pTcpData">��Ҫ���������</param>
void DataManage::AddToMemBuf(TCP_DATA * pTcpData)
{
	m_csMap.Enter();
	m_bufMem.push(pTcpData);
	m_csMap.Leave();
}

/// <summary>
/// רְ���ڴ滺���е��°汾Э�������д��memcached
/// </summary>
/// <param name="param">DataManage����</param>
DWORD WINAPI SaveToMemThread(LPVOID param)
{
	DataManage * pDlg=(DataManage *)param;

	CString lastKey("");
	while (TCPServer::m_bIsExit)
	{
#if 0//�����ã�����append�����Ƿ���Ч
			int dwtestRet;
			CString test("DEBUG");
			CString testID("test1234test");
			if(test.Compare(lastKey) != 0)
			{	
				//���Ե�һ��д��
				dwtestRet=dllLoader.pSend2MC(test.GetBuffer(0),testID.GetBuffer(0));
				if(dwtestRet < 0)//������key�Ѿ����ڣ���ʹ��append����
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
		/// �Ӷ����л�ȡ�˴���Ҫ�����Ķ���
		pDlg->m_csMap.Enter();
		if (pDlg->m_bufMem.empty())
		{
			pDlg->m_csMap.Leave();
			Sleep(200);
			continue;
		}

		TCP_DATA * pTCPData=pDlg->m_bufMem.front();
		pDlg->m_bufMem.pop();
		// BEGIN:Add by bloodhunter at 2012/10/21 for ��������
		// [�޸�˵��]:�Ӵ����β��ת�Ƶ��˴����Լ�������ͻ�ĸ��ʣ��Ӷ���߳��������
		pDlg->m_csMap.Leave();
		// END:Add by bloodhunter at 2012/10/21

		if(pTCPData->key == NULL || pTCPData->pDataContent == NULL)
		{
			// BEGIN:Add by bloodhunter at 2012/10/21 for ��������
			// [�޸�˵��]:�˴�������ͷ���Դ�п��ܵ����ڴ�й¶
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
		//����MemCached Server ��Ϊ����
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
			//д�������ݵ�log
			SENDMEMFAILEDLOG(strID, strContent, true);
		}
		else
		{
			//�˴�������־��д��memcache������
			SENDMEMLOG(strID, strContent, true);
			cout << "KEY:[" << (LPTSTR)(LPCTSTR)strID<< "]:" << dwRet << ",input to Memcached Server success!" << endl;
#if 0//�˴�������Ҫ������
			CString memkeyList_key;
			//�˴�����Ϊÿ��һ��key���Ա�֤�������value���������
			//memkeyList_key.Format("%s", "keylist_2.0_" + CTime::GetCurrentTime().Format("%Y-%m-%d"));
			//�˴���ʱʹ�õ��뼶�����Ϊkey�ļĴ��ʶ����������ǧ���ϼ���Ĳ���������ʹ������Ȼ�����
			memkeyList_key.Format("%s", "keylist_2.0_" + CTime::GetCurrentTime().Format("%Y%m%d%H%M%S"));
			char tmp[10240];//�˴�����Ϊ10K���޷����������Ϊ�˴�Ϊջ����ջ���Ĵ�С����

			//���Զ�ȡ�������ȡ�ɹ�����������ڣ�ʹ��append�������ȡʧ�ܣ�����������ڣ�ʹ��send
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

		//�ͷ���Դ
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
		// BEGIN:Delete by bloodhunter at 2012/10/21 for ��������
		// [�޸�˵��]:�Ӵ����β��ת�ƣ��Լ�������ͻ�ĸ��ʣ��Ӷ���߳��������
		//pDlg->m_csMap.Leave();
		// END:Delete by bloodhunter at 2012/10/21 for ��������
		//Sleep(50);
		pDlg->dwSeqPackets++;
	}
	return 0L;
}