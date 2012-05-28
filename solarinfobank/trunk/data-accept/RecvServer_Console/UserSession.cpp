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

	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	m_iSessionState = New_Session_State_FirstFrame;
	m_pRegisterInfo = new NewRegisterInfo;
	//Э��ͷ
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

//BEGIN:modify by bloodhunter for new protocol at 2012-3-23
//����Ƿ��յ�һ��������������Ϣͷ��
BOOL CUserSession::HasCompletionPacket(int& iProtocol)
{
	if ( dwRecvBytes < CLIENT_HEAD_LEN ) //����ͷ��4���ֽڣ���С��4����˵��ͷ�����ݲ�����������
		return FALSE;

	////���ݰ���ǰ2λ����0x68Ϊ�쳣��
	//if ((unsigned char)pRecvBuf[0]!=0x68 || (unsigned char)pRecvBuf[1]!=0x68) //��Э������������������0x69��ͷ�İ�   
	//{
	//	cout << "*** IP=" << strAddress << "��SOCKET ID=" << sockAccept << "�����Ĳ�ƥ��..." << endl;
	//	dwRecvBytes=0;
	//	CloseSocket();
	//	return FALSE;
	//}
	//int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2]+2;
	////���ݳ��Ȳ�����δ�������
	//if (dwRecvBytes<packetCount)
	//	return FALSE;
	//return TRUE;

	//0x68�İ�ͷ����Э��
	if(0x68 == (unsigned char)pRecvBuf[0] && 0x68 == (unsigned char)pRecvBuf[1])
	{
		int packetCount = (unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		iProtocol = Protocol68;
		//���ݳ��Ȳ�����δ�������
		if (dwRecvBytes < packetCount)
			return FALSE;

		return TRUE;
	}

	//0x68�İ�ͷ����Э�飬���а�ͷ�������������汾����˰汾�ţ��ֱ�Ϊ�����ֽڣ�����0x69 0x69֮��
	if(0x69 == (unsigned char)pRecvBuf[0] && 0x69 == (unsigned char)pRecvBuf[1])
	{
		if(dwRecvBytes < 18)//�˴��ݴ���ֹ����̫�̵����ݵ��³������
			return false;

		int packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
			+ (unsigned char)pRecvBuf[6] * 256 * 256 
			+ (unsigned char)pRecvBuf[5] * 256 
			+ (unsigned char)pRecvBuf[4] + 10;

		//int packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
		//	+ (unsigned char)pRecvBuf[6] * 256 * 256 
		//	+ (unsigned char)pRecvBuf[5] * 256 
		//	+ (unsigned char)pRecvBuf[4] + 10;
		iProtocol = Protocol69;
		//���ݳ��Ȳ�����δ�������
		if (dwRecvBytes < packetCount)
			return FALSE;

		return TRUE;
	}

    //��ƥ�䲻��������Ϊ���ݷǷ�
	cout << "*** IP=" << strAddress << "��SOCKET ID=" << sockAccept << "�����Ĳ�ƥ��..." << endl;
	dwRecvBytes=0;
	CloseSocket();
	return FALSE;
}
//END:modify by bloodhunter for new protocol at 2012-3-23

//�ӻ���������һ�����������ݰ�����������ͷ�������ݶ�
void CUserSession::ExtractPacket(TCP_DATA * pTCPData, int iProtocol)
{
	//BEGIN:modify by bloodhunter for new protocol at 2012-3-23
	//int packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
	int packetCount;
	switch(iProtocol)
	{
	case Protocol68:
		packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		break;;
	case Protocol69:
		packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
			+ (unsigned char)pRecvBuf[6] * 256 * 256 
			+ (unsigned char)pRecvBuf[5] * 256 
			+ (unsigned char)pRecvBuf[4] + 10;
		//packetCount = (unsigned char)pRecvBuf[7] * 256 * 256 * 256
		//	+ (unsigned char)pRecvBuf[6] * 256 * 256 
		//	+ (unsigned char)pRecvBuf[5] * 256 
		//	+ (unsigned char)pRecvBuf[4] + 10;
		break;
	default:
		packetCount=(unsigned char)pRecvBuf[3] * 256 + (unsigned char)pRecvBuf[2] + 2;
		break;
	}
	pTCPData->iProtocol = iProtocol;
	//END:modify by bloodhunter for new protocol at 2012-3-23
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