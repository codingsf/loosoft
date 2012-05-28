// SendDll.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "stdio.h"

#include "winsock2.h"
#pragma comment(lib,"ws2_32.lib")

#include "MemCacheClient.h"

MemCacheClient * pClient=NULL;


BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	WSADATA wsaData;
    int rc = WSAStartup(MAKEWORD(2,0), &wsaData);
    if (rc != 0) {
        printf("Failed to start winsock\n");
        return FALSE;
    }

    return TRUE;
}

//这个接口用于将SOCKET发给指定的DLL
extern "C" __declspec(dllexport) void Send2Dll(int hSocket,char * strCollector,char * strDeviceID)
{
	char strTemp[MAX_PATH];
	sprintf(strTemp,"SOCKET %d\nCollector %s\nDeviceID %s\r",hSocket,strCollector,strDeviceID);

	//::MessageBox(NULL,strTemp,"这里调用其他DLL，执行升级调试工作。",MB_OK);
}

/////////////////////以下是操作memcached client的API封装//////////////////////////

extern "C" __declspec(dllexport) BOOL MC_Init(char * strServer)
{
	if (pClient==NULL)
	{
		pClient=new MemCacheClient;

		pClient->SetTimeout(5000);

		bool bAdd=pClient->AddServer(strServer);
		if (!bAdd)
		{
			return FALSE;
		}	
	}

	return TRUE;
}
extern "C" __declspec(dllexport) void MC_UnInit()
{
	if (pClient!=NULL)
	{
		delete pClient;
		pClient=NULL;
	}

	WSACleanup();
}

extern "C" __declspec(dllexport) int Send2MC(char * strKey,char * strContent)
{
	MemCacheClient::MemRequest req;
	req.mKey  = strKey;
	req.mData.WriteBytes(strContent, strlen(strContent));

	pClient->Set(req);

	return req.mResult;
}


extern "C" __declspec(dllexport) int GetFromMC(char * strKey,char * strContent)
{
	MemCacheClient::MemRequest req;
	req.mKey  = strKey;

	int iRet = pClient->Gets(req);
	if(iRet <= 0)
		return -1;

	memcpy(strContent, req.mData.GetReadBuffer(), req.mData.GetReadSize());
	return iRet;
}

extern "C" __declspec(dllexport) int Remove(char * strKey)
{
	MemCacheClient::MemRequest req;
	req.mKey  = strKey;

	pClient->Del(req);
	return req.mResult;
}


//追加数据
extern "C" __declspec(dllexport) int Append2MC(char * strKey,char * strContent)
{
	MemCacheClient::MemRequest req;
	req.mKey  = strKey;
	req.mData.WriteBytes(strContent, strlen(strContent));
	pClient->Append(req);
	return req.mResult;
}

