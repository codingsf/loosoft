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
//	HANDLE						m_hThread;							// 写线程
//	HANDLE						m_hThreadEventExit;			// 线程退出事件，用于主线程通知子线程退出
//	UINT							m_hThreadID;							// 写线程ID
//	CRITICAL_SECTION		m_csLock;						// 互斥锁，用于多线程写入冲突解决
//	queue<string>            m_strText;							// 写入缓冲区
//	ofstream						m_streamWriter;						// 写入流
//	string							m_fileFullName;						// 文件全路径名
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
		dwLogLevel=GetPrivateProfileInt("Server","LogLevel",0,strAppPath+"./config.ini");
	}
public:
	void WriteLog(CString content, int iComm)
	{
		//无需记日志
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