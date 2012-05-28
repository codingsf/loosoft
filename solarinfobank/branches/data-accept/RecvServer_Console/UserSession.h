// UserSession.h: interface for the CUserSession class.
//
//////////////////////////////////////////////////////////////////////

#ifndef USERSESSION_H
#define USERSESSION_H

#include "mydef.h"
#include "CriticalSection.h"

/*
CUserSession:
为了便于管理多个SOCKET，为每个SOCKET连接维护一个链路，每个SOCKET单独处理数据包。
由于网络的不确定因素，客户端发出的数据，服务器可能需要N次才能收完，所以需要做一个缓冲区  
主要用途为收到的数据暂放缓冲区，等待检测是否达到一副完整的包了，
若完整，则解出，剩下的数据移动到最前面
*/

class CUserSession
{
public:
	BOOL bWorkStatus;       //是否处于工作状态

	time_t LastKeepLive; //最后存活的时间
	SOCKET sockAccept;  //关联的SOCKET连接句柄

	BOOL bDelete;       //是否被标记为已删除（已断开）
	time_t DeleteTime; //标记为删除的时间

	char strAddress[50]; //客户端IP地址

	char pRecvBuf[RECV_BUF_LEN * 16]; //最大512 * 16=8K
	int dwRecvBytes;

	PER_IO_DATA pPerIOData;

public:

	CUserSession();
	~CUserSession();

	BOOL Recv(); //投递一个IO PENDING
	BOOL HasCompletionPacket();
	void ExtractPacket(TCP_DATA * pTCPData);

private:
	void CloseSocket();
};

#endif 
