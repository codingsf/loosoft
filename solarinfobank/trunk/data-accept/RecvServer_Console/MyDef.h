#pragma once

#include "stdafx.h"
#include <string>
using namespace std;

#define DEVICE_ID_LEN 15

#define RECV_BUF_LEN 10240

//客户端包的头部长度
#define CLIENT_HEAD_LEN 4

//完整的TCP数据
typedef struct  _tcp_data
{
	int dwDataLen;
	char * pDataContent;
	//BEGIN:add by bloodhunter at 2012-4-16
	int iProtocol;
	char* key;
	bool isHex;
	//END:add by bloodhunter at 2012-4-16

public:
    _tcp_data()
    {
        dwDataLen = 0;
        pDataContent = NULL;  
        iProtocol = 0;
        key = NULL;
        isHex = false; 
    }
}TCP_DATA;

//MYSQL连接参数
typedef struct 
{
	char strUser[50];
	char strPass[50];
	char strIp[50];
	int dwPort;
	char strDB[50];
}MYSQL_CONNECT_PARAM;

enum IOType 
{
	IORead,
	IOWrite
};

//PER IO结构体
typedef struct 
{
	OVERLAPPED  OverLapped;
	WSABUF		wsaBuffer;
	char		DataBuf[RECV_BUF_LEN * 8]; //WSARecv接收数据的缓冲区
	IOType      m_ioType;      //IO类型
	DWORD		dwRecvBytes;   //已经发送或者收到的数据长度
}PER_IO_DATA,*LPPER_IO_DATA;