#pragma once

#include "stdafx.h"

#define DEVICE_ID_LEN 15

#define RECV_BUF_LEN 512

//�ͻ��˰���ͷ������
#define CLIENT_HEAD_LEN 4

//������TCP����
typedef struct  
{
	int dwDataLen;
	char * pDataContent;
}TCP_DATA;

//MYSQL���Ӳ���
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

//PER IO�ṹ��
typedef struct 
{
	OVERLAPPED  OverLapped;
	WSABUF		wsaBuffer;
	char		DataBuf[RECV_BUF_LEN * 8]; //WSARecv�������ݵĻ�����
	IOType      m_ioType;      //IO����
	DWORD		dwRecvBytes;   //�Ѿ����ͻ����յ������ݳ���
}PER_IO_DATA,*LPPER_IO_DATA;