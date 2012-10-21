/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:用户会话类实现
FileName:UserSession.cpp
**************************************************/

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

	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	m_iSessionState = New_Session_State_FirstFrame;
	m_pRegisterInfo = new NewRegisterInfo;
	//协议头
	m_strPachetHead[0] = 0x69;
	m_strPachetHead[1] = 0x69;
	m_strPachetHead[2] = 0x01;
	m_strPachetHead[3] = 0x00;
	m_strPachetHead[4] = 0x2a;
	m_strPachetHead[5] = 0x00;
	m_strPachetHead[6] = 0x00;
	m_strPachetHead[7] = 0x00;
	m_strPachetHead[8] = 0x01;
	m_strPachetHead[9] = 0x00;
	m_strPachetHead[10] = 0x01;
	m_strPachetHead[11] = 0x00;
	m_strPachetHead[12] = 0x00;
	m_strPachetHead[13] = 0x00;
	//END:add by bloodhunter for new protocol at 2012-3-23
}

CUserSession::~CUserSession()
{
	CloseSocket();
	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
    if(m_pRegisterInfo != NULL)
    {
	    delete m_pRegisterInfo;
        m_pRegisterInfo = NULL;
    }
	//END:add by bloodhunter for new protocol at 2012-3-23
}

/// <summary>
/// 投递WSARECV请求
/// </summary>
/// <returns>操作结果</returns>
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

//BEGIN:modify by bloodhunter for new protocol at 2012-3-23
/// <summary>
/// 检测是否收到一个完整的数据消息
/// </summary>
/// <param name="iProtocol">int& 协议类型，输出参数</param>
/// <return>检测结果 false 表示未收到完整的数据消息，true表示已收到一个完整的数据消息</return>
BOOL CUserSession::HasCompletionPacket(int& iProtocol)
{
	if ( dwRecvBytes < CLIENT_HEAD_LEN ) //数据头部4个字节，若小于4，则说明头部数据不够，不处理
		return FALSE;

	////数据包文前2位不是0x68为异常包
	//if ((unsigned char)pRecvBuf[0]!=0x68 || (unsigned char)pRecvBuf[1]!=0x68) //新协议中增加了连续两个0x69开头的包   
	//{
	//	cout << "*** IP=" << strAddress << "，SOCKET ID=" << sockAccept << "，报文不匹配..." << endl;
	//	dwRecvBytes=0;
	//	CloseSocket();
	//	return FALSE;
	//}
	//int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2]+2;
	////数据长度不够，未接收完毕
	//if (dwRecvBytes<packetCount)
	//	return FALSE;
	//return TRUE;

	//0x68的包头，旧协议
	if(0x68 == (unsigned char)pRecvBuf[0] && 0x68 == (unsigned char)pRecvBuf[1])
	{
		int packetCount = (unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		iProtocol = Protocol68;
		//数据长度不够，未接收完毕
		if (dwRecvBytes < packetCount)
			return FALSE;

		// BEGIN:Add by bloodhunter at 2012/10/21 for 代码整改
		// [修改说明]:此处需要对包的长度作基本保证，即是一个合法的数据包
		if (packetCount < CLIENT_HEAD_LEN + DEVICE_ID_LEN)
			return FALSE; 
		// END:Add by bloodhunter at 2012/10/21 for 代码整改

		return TRUE;
	}

	//0x68的包头，新协议，其中包头部分增加了主版本号与此版本号，分别为两个字节，紧随0x69 0x69之后
	if(0x69 == (unsigned char)pRecvBuf[0] && 0x69 == (unsigned char)pRecvBuf[1])
	{
		if(dwRecvBytes < 18)//此处容错，防止出现太短的数据导致程序崩溃
			return false;

		int packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
			+ (unsigned char)pRecvBuf[6] * 256 * 256 
			+ (unsigned char)pRecvBuf[5] * 256 
			+ (unsigned char)pRecvBuf[4] + 10;
		iProtocol = Protocol69;
		//数据长度不够，未接收完毕
		if (dwRecvBytes < packetCount)
			return FALSE;

		return TRUE;
	}

    //均匹配不到，则认为数据非法
	cout << "*** IP=" << strAddress << "，SOCKET ID=" << sockAccept << "，报文不匹配..." << endl;
	dwRecvBytes=0;
	CloseSocket();
	return FALSE;
}
//END:modify by bloodhunter for new protocol at 2012-3-23

/// <summary>
/// 从缓冲区里解出一副完整的数据包，包含数据头部和数据段
/// </summary>
/// <param name="param">TCP_DATA * 输出参数，完整的数据包寄存器</param>
/// <param name="iProtocol">协议类型</param>
void CUserSession::ExtractPacket(TCP_DATA * pTCPData, int iProtocol)
{
	//BEGIN:modify by bloodhunter for new protocol at 2012-3-23
	//int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
	int packetCount;//包长
	switch(iProtocol)
	{
	//老版本协议
	case Protocol68:
		packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		break;

	//新版本协议
	case Protocol69:
		packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
			+ (unsigned char)pRecvBuf[6] * 256 * 256 
			+ (unsigned char)pRecvBuf[5] * 256 
			+ (unsigned char)pRecvBuf[4] + 10;
		break;
	
	//默认做老版本协议
	default:
		packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		break;
	}

	pTCPData->iProtocol = iProtocol;
	//END:modify by bloodhunter for new protocol at 2012-3-23

	pTCPData->dwDataLen = packetCount;
	pTCPData->pDataContent = new char[packetCount]; //申请长度，拷贝数据
	memcpy(pTCPData->pDataContent, pRecvBuf, packetCount); //此处无需进行异常容错处理，因此方法之前的HasCompletionPacket已经保证了其安全性
	
	dwRecvBytes = dwRecvBytes - packetCount; //计算剩下的数据长度
	if (dwRecvBytes > 0)
	{
		//把剩余的数据移到前面 
		memmove(pRecvBuf, pRecvBuf + packetCount, dwRecvBytes); //此处无需进行异常容错处理
	}
}

/// <summary>
/// 关闭连接
/// </summary>
void CUserSession::CloseSocket()
{
	bDelete=TRUE;
	DeleteTime=time(NULL);

	shutdown(sockAccept,SD_RECEIVE);

	closesocket(sockAccept);
}