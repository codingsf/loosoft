// UserSession.cpp: implementation of the CUserSession class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "UserSession.h"

CUserSession::CUserSession()
{
	LastKeepLive=time(NULL);
	DeleteTime=time(NULL);
	bDelete=FALSE;
	bWorkStatus=TRUE;

	dwRecvBytes=0;

	ZeroMemory(&pPerIOData.OverLapped,sizeof(OVERLAPPED));
	
	sockAccept=INVALID_SOCKET;
}

CUserSession::~CUserSession()
{
	CloseSocket();
}

//Ͷ��WSARECV����
BOOL CUserSession::Recv()
{
	if (!bWorkStatus || bDelete)
		return TRUE;

	DWORD nRecvBytes = 0, nFlags = 0;

	pPerIOData.m_ioType			= IORead;
	pPerIOData.wsaBuffer.buf	= pPerIOData.DataBuf;
	pPerIOData.wsaBuffer.len	= RECV_BUF_LEN * 8;

	int dwRet=WSARecv( sockAccept, &pPerIOData.wsaBuffer, 1, &nRecvBytes, &nFlags, &pPerIOData.OverLapped, 0 );
	if (dwRet==SOCKET_ERROR && WSAGetLastError() != WSA_IO_PENDING)
		return FALSE;
	
	return TRUE;
}

//����Ƿ��յ�һ��������������Ϣͷ��
BOOL CUserSession::HasCompletionPacket()
{
	if ( dwRecvBytes < CLIENT_HEAD_LEN ) //����ͷ��4���ֽڣ���С��4����˵��ͷ�����ݲ�����������
		return FALSE;

	//���ݰ���ǰ2λ����0x68Ϊ�쳣��
	if ((unsigned char)pRecvBuf[0]!=0x68 || (unsigned char)pRecvBuf[1]!=0x68)
	{
		cout << "*** IP=" << strAddress << "��SOCKET ID=" << sockAccept << "�����Ĳ�ƥ��..." << endl;

		dwRecvBytes=0;

		CloseSocket();

		return FALSE;
	}

	int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2]+2;

	//���ݳ��Ȳ�����δ�������
	if (dwRecvBytes<packetCount)
		return FALSE;

	return TRUE;
}

//�ӻ���������һ�����������ݰ�����������ͷ�������ݶ�
void CUserSession::ExtractPacket(TCP_DATA * pTCPData)
{
	int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;

	pTCPData->dwDataLen=packetCount;
	pTCPData->pDataContent=new char[packetCount]; //���볤�ȣ���������
	memcpy( pTCPData->pDataContent, pRecvBuf, packetCount); 
	
	dwRecvBytes = dwRecvBytes-packetCount; //����ʣ�µ����ݳ���

	if (dwRecvBytes>0)
	{
		memmove( pRecvBuf, pRecvBuf + packetCount, dwRecvBytes); //��ʣ��������Ƶ�ǰ��
	}
}

void CUserSession::CloseSocket()
{
	bDelete=TRUE;
	DeleteTime=time(NULL);

	shutdown(sockAccept,SD_RECEIVE);

	closesocket(sockAccept);
}