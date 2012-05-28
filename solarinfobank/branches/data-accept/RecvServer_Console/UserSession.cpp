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

//投递WSARECV请求
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

//检测是否收到一个完整的数据消息头部
BOOL CUserSession::HasCompletionPacket()
{
	if ( dwRecvBytes < CLIENT_HEAD_LEN ) //数据头部4个字节，若小于4，则说明头部数据不够，不处理
		return FALSE;

	//数据包文前2位不是0x68为异常包
	if ((unsigned char)pRecvBuf[0]!=0x68 || (unsigned char)pRecvBuf[1]!=0x68)
	{
		cout << "*** IP=" << strAddress << "，SOCKET ID=" << sockAccept << "，报文不匹配..." << endl;

		dwRecvBytes=0;

		CloseSocket();

		return FALSE;
	}

	int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2]+2;

	//数据长度不够，未接收完毕
	if (dwRecvBytes<packetCount)
		return FALSE;

	return TRUE;
}

//从缓冲区里解出一副完整的数据包，包含数据头部和数据段
void CUserSession::ExtractPacket(TCP_DATA * pTCPData)
{
	int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;

	pTCPData->dwDataLen=packetCount;
	pTCPData->pDataContent=new char[packetCount]; //申请长度，拷贝数据
	memcpy( pTCPData->pDataContent, pRecvBuf, packetCount); 
	
	dwRecvBytes = dwRecvBytes-packetCount; //计算剩下的数据长度

	if (dwRecvBytes>0)
	{
		memmove( pRecvBuf, pRecvBuf + packetCount, dwRecvBytes); //把剩余的数据移到前面
	}
}

void CUserSession::CloseSocket()
{
	bDelete=TRUE;
	DeleteTime=time(NULL);

	shutdown(sockAccept,SD_RECEIVE);

	closesocket(sockAccept);
}