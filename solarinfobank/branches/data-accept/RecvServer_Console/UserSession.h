// UserSession.h: interface for the CUserSession class.
//
//////////////////////////////////////////////////////////////////////

#ifndef USERSESSION_H
#define USERSESSION_H

#include "mydef.h"
#include "CriticalSection.h"

/*
CUserSession:
Ϊ�˱��ڹ�����SOCKET��Ϊÿ��SOCKET����ά��һ����·��ÿ��SOCKET�����������ݰ���
��������Ĳ�ȷ�����أ��ͻ��˷��������ݣ�������������ҪN�β������꣬������Ҫ��һ��������  
��Ҫ��;Ϊ�յ��������ݷŻ��������ȴ�����Ƿ�ﵽһ�������İ��ˣ�
��������������ʣ�µ������ƶ�����ǰ��
*/

class CUserSession
{
public:
	BOOL bWorkStatus;       //�Ƿ��ڹ���״̬

	time_t LastKeepLive; //������ʱ��
	SOCKET sockAccept;  //������SOCKET���Ӿ��

	BOOL bDelete;       //�Ƿ񱻱��Ϊ��ɾ�����ѶϿ���
	time_t DeleteTime; //���Ϊɾ����ʱ��

	char strAddress[50]; //�ͻ���IP��ַ

	char pRecvBuf[RECV_BUF_LEN * 16]; //���512 * 16=8K
	int dwRecvBytes;

	PER_IO_DATA pPerIOData;

public:

	CUserSession();
	~CUserSession();

	BOOL Recv(); //Ͷ��һ��IO PENDING
	BOOL HasCompletionPacket();
	void ExtractPacket(TCP_DATA * pTCPData);

private:
	void CloseSocket();
};

#endif 
