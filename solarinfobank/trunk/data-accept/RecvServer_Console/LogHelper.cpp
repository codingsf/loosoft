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
////���������߳�
//void LogHelper::CreateWorkThread()
//{
//	m_hThreadEventExit = CreateEvent(NULL, TRUE, FALSE, NULL);
//	m_hThread = (HANDLE)_beginthreadex(NULL, 0, WriteThreadProc, this, 0, &m_hThreadID);
//}
//
//// �����߳�
//UINT WINAPI LogHelper::WriteThreadProc(LPVOID pParam)
//{
//	LogHelper* pThis = reinterpret_cast<LogHelper*>( pParam );
//	pThis->RunWritting();
//	return 1L;
//}
//
//// ������ִ����
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
//			// �߳��˳���β����������ͷ����ȫ��д��
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
//// ��������
//void LogHelper::GetReady()
//{
//	FolderCheck();
//	m_streamWriter.open((LPCTSTR)m_fileFullName.c_str(), fstream::out | fstream::app);
//	CreateWorkThread();
//}
//
//// ���Ŀ¼������������򴴽�
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
//// �ⲿ�ӿڣ�д������
//void LogHelper::Write(string strMessage)
//{
//	EnterCriticalSection(&m_csLock);
//	m_strText.push(strMessage);
//	LeaveCriticalSection(&m_csLock);
//}
//
//// �ر�д�������ͷ������Դ
//void LogHelper::Close()
// {
//	 SetEvent(m_hThreadEventExit);                // �����̷߳����˳��ź�
//	 WaitForSingleObject(m_hThread, INFINITE);    // �ȴ����̹߳ر�
//	 m_streamWriter.flush();
//	 m_streamWriter.close();
//}
//
//// �����ļ�ȫ·����
//void LogHelper::SetFullName(string pstrName)
//{
//	m_fileFullName =  pstrName;
//}
//
//// ��ȡ�ļ�ȫ·����
//string LogHelper::GetFullName()
// {
//	 return m_fileFullName;
//}
// 
// // ��ȡ�ļ�·��
//string LogHelper::GetFilePath()
//{
//	int idx = m_fileFullName.find_last_of("\\");
//	return m_fileFullName.substr(0, idx);
//}
//
//// �����ļ�����
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
