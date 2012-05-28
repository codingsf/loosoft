#include "StdAfx.h"
//#include <time.h>
//#include <direct.h>
//#include <shlobj.h> 
//#include "LogHelper.h"
//
//LogHelper* LogHelper::m_instance;
//
//LogHelper* LogHelper::GetInstance()
//{  
//	if (m_instance == NULL)
//	m_instance = new LogHelper;
//	return m_instance;
//}
//
////创建工作线程
//void LogHelper::CreateWorkThread()
//{
//	m_hThreadEventExit = CreateEvent(NULL, TRUE, FALSE, NULL);
//	m_hThread = (HANDLE)_beginthreadex(NULL, 0, WriteThreadProc, this, 0, &m_hThreadID);
//}
//
//// 工作线程
//UINT WINAPI LogHelper::WriteThreadProc(LPVOID pParam)
//{
//	LogHelper* pThis = reinterpret_cast<LogHelper*>( pParam );
//	pThis->RunWritting();
//	return 1L;
//}
//
//// 工作线执行体
//void LogHelper::RunWritting()
//{
//	while(true)
//	{
//		if (m_strText.size() == 0)
//			Sleep(5000);
//		else
//		{
//			//time_t t = time(0);
//			//char tmp[64];
//			//ZeroMemory(tmp, 0);
//			//strftime( tmp, sizeof(tmp), "%Y/%m/%d %X",localtime(&t));
//
//			//m_streamWriter<<tmp<<"  "<<m_strText.back()<<"\n";
//			m_streamWriter<<m_strText.back()<<"\n";
//			m_strText.pop();
//		}
//
//		UINT eventIdx = WaitForSingleObject(m_hThreadEventExit,200);
//		if (eventIdx -WAIT_OBJECT_0 == 0)
//		{
//			// 线程退出收尾工作，将手头任务全部写完
//			while (m_strText.size() > 0)
//			{
//				//time_t t = time(0);
//				//char tmp[64];
//				//ZeroMemory(tmp, 0);
//				//strftime( tmp, sizeof(tmp), "%Y/%m/%d %X",localtime(&t));
//
//				//m_streamWriter<<tmp<<"  "<<m_strText.back()<<"\n";
//				m_streamWriter<<m_strText.back()<<"\n";
//				m_strText.pop();
//			}
//			m_streamWriter.flush();
//			return;
//		}
//	}
//}
//
//// 就绪工作
//void LogHelper::GetReady()
//{
//	FolderCheck();
//	m_streamWriter.open((LPCTSTR)m_fileFullName.c_str(), fstream::out | fstream::app);
//	CreateWorkThread();
//}
//
//// 检查目录，如果不存在则创建
//void LogHelper::FolderCheck()
//{
//	string dir = GetFilePath();
//	if(_access(dir.c_str(), 0) != -1)
//		return;
//	dir = dir + "\\";
//	UINT ilen = MultiByteToWideChar (CP_ACP, 0, dir.c_str(), -1, NULL, 0);
//	wstring wdir(dir.begin(), dir.end()); 
//	int re = SHCreateDirectoryEx(NULL,(LPCTSTR)wdir.c_str(),NULL);
//}
//
//// 外部接口，写入数据
//void LogHelper::Write(string strMessage)
//{
//	EnterCriticalSection(&m_csLock);
//	m_strText.push(strMessage);
//	LeaveCriticalSection(&m_csLock);
//}
//
//// 关闭写入流，释放相关资源
//void LogHelper::Close()
// {
//	 SetEvent(m_hThreadEventExit);                // 向子线程发出退出信号
//	 WaitForSingleObject(m_hThread, INFINITE);    // 等待子线程关闭
//	 m_streamWriter.flush();
//	 m_streamWriter.close();
//}
//
//// 设置文件全路径名
//void LogHelper::SetFullName(string pstrName)
//{
//	m_fileFullName =  pstrName;
//}
//
//// 获取文件全路径名
//string LogHelper::GetFullName()
// {
//	 return m_fileFullName;
//}
// 
// // 获取文件路径
//string LogHelper::GetFilePath()
//{
//	int idx = m_fileFullName.find_last_of("\\");
//	return m_fileFullName.substr(0, idx);
//}
//
//// 设置文件名称
//string LogHelper::GetFileName()
//{
//	int idx = m_fileFullName.find_last_of("\\");
//	return m_fileFullName.substr(idx+1, m_fileFullName.length());
//}
//
//
//
//
//
//
//
