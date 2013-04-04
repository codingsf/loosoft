#pragma once

#include "stdafx.h"

#include <queue>
#include <process.h>
#include <stdio.h>
#include "fstream"
#include "iostream"
#include <tchar.h>
#include <io.h>
#include <atlconv.h>

using namespace std;
 

class LogHelper
{
//private:
//	static LogHelper* m_instance;
//	LogHelper()
//	{
//		InitializeCriticalSection(&this->m_csLock);
//		this->m_hThread = INVALID_HANDLE_VALUE;
//		this->m_hThreadEventExit = INVALID_HANDLE_VALUE;
//	}
//
//public:
//	~LogHelper()
//	{
//		DeleteCriticalSection(&m_csLock);
//	}
// 
//public:
//	LogHelper(string filepath)
//	{
//
//	}
// public:
//	  static LogHelper* GetInstance();
//
// private:
//	HANDLE						m_hThread;							// д�߳�
//	HANDLE						m_hThreadEventExit;			// �߳��˳��¼����������߳�֪ͨ���߳��˳�
//	UINT							m_hThreadID;							// д�߳�ID
//	CRITICAL_SECTION		m_csLock;						// �����������ڶ��߳�д���ͻ���
//	queue<string>            m_strText;							// д�뻺����
//	ofstream						m_streamWriter;						// д����
//	string							m_fileFullName;						// �ļ�ȫ·����
// 
//protected:
//	void CreateWorkThread();
//	static UINT    WINAPI WriteThreadProc (LPVOID pParam);
//	void RunWritting();
//	void FolderCheck();
// 
//public: 
//	void GetReady();
//	void Write(string strMessage);
//	void Close();
//	static void Dispose()
//	{
//		delete m_instance;
//	}
//	void SetFullName(string pstrName);
//	string GetFullName();
//	string GetFilePath();
//	string GetFileName();

private:
	int dwLogLevel;

public:
	LogHelper()
	{
		CString	strAppPath;  // ������
		TCHAR szModuleFileName[MAX_PATH]; // ȫ·����
		TCHAR drive[_MAX_DRIVE];  // �̷����ƣ�����˵C�̰���D�̰�
		TCHAR dir[_MAX_DIR]; // Ŀ¼
		TCHAR fname[_MAX_FNAME];  // ��������
		TCHAR ext[_MAX_EXT]; //��׺��һ��Ϊexe������dll
		if (NULL == GetModuleFileName(NULL, szModuleFileName, MAX_PATH)) //��õ�ǰ���̵��ļ�·��
			strAppPath="";
		else{
			_tsplitpath_s( szModuleFileName, drive, dir, fname, ext );  //�ָ��·�����õ��̷���Ŀ¼���ļ�������׺��
			strAppPath = drive;
			strAppPath += dir;
		}	
		dwLogLevel=GetPrivateProfileInt("Server","LogLevel",0,strAppPath+"./config.ini");
	}
public:
	void WriteLog(CString content, int iComm)
	{
		//�������־
		if (dwLogLevel == 0)
			return;

		CString strFile;
		if(iComm == 0 &&  dwLogLevel==1)
		{
			strFile="logs\\SOCKET_"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; 
		}
		else if(iComm == 0 &&  dwLogLevel==2)
		{
			strFile="logs\\SOCKET_"+CTime::GetCurrentTime().Format("%Y%m%d_%H")+".txt";
		}
		else if(iComm == 1 &&  dwLogLevel==1)
		{
			strFile="logs\\MEMCACHE_"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; 
		}
		else if(iComm == 1 &&  dwLogLevel==2)
		{
			strFile="logs\\MEMCACHE_"+CTime::GetCurrentTime().Format("%Y%m%d_%H")+".txt";
		}
		else
			return;

		FILE * fp=fopen(strFile,"a");
		if (fp!=NULL)
		{
			fputs(content,fp);
			fputs("\n\n",fp);
			fclose(fp);
		}
	}
};