/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:用户会话类声明
FileName:UserSession.h
**************************************************/
#ifndef USERSESSION_H
#define USERSESSION_H

#include "mydef.h"
#include "CriticalSection.h"
#include "ExpandType.h"

/*
CUserSession:
为了便于管理多个SOCKET，为每个SOCKET连接维护一个链路，每个SOCKET单独处理数据包。
由于网络的不确定因素，客户端发出的数据，服务器可能需要N次才能收完，所以需要做一个缓冲区  
主要用途为收到的数据暂放缓冲区，等待检测是否达到一副完整的包了，
若完整，则解出，剩下的数据移动到最前面
*/
class CUserSession
{
//成员变量
public:
	BOOL bWorkStatus;						//是否处于工作状态

	time_t LastKeepLive;					//最后存活的时间
	SOCKET sockAccept;						//关联的SOCKET连接句柄

	BOOL bDelete;							//是否被标记为已删除（已断开）
	time_t DeleteTime;						//标记为删除的时间

	char strAddress[50];					//客户端IP地址

	char pRecvBuf[RECV_BUF_LEN * 16];		//最大512 * 16=8K
	int dwRecvBytes;

	PER_IO_DATA pPerIOData;

	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	int m_iSessionState;					//当前用户状态
	NewRegisterInfo* m_pRegisterInfo;		//注册信息，其中包含SN与明文验证码
	int m_iHistoryRes;					    //上次操作结果，历史数据请求,-1 已经下发，等待接受， 1 回复成功 0 回复失败
	int m_iHistoryStopRes;					//上次操作结果，历史数据终止,-1 已经下发，等待接受， 1 回复成功 0 回复失败
	int m_iParamSetRes;					    //上次操作结果，设置,-1 已经下发，等待接受， 1 回复成功 0 回复失败
	char m_strPachetHead[16];

	//此处所有memecache的key均由第一次登录时生成
	string strInfo_Station;					//电站信息
	string strInfo_Device;					//设备信息
	string strInfo_RTData;					//实时数据信息			
	string strInfo_HistoryData;				//历史数据信息
	string strInfo_HistoryFault;			//历史故障信息

	string strCmd_Req_HistoryStart;			//历史数据开始请求
	string strCmd_Res_HistoryStart;			//历史数据开始响应
	string strCmd_Req_HistoryStop;			//历史数据终止请求
	string strCmd_Res_HistoryStop;			//历史数据终止响应
	string cmd_Req_ParameterSet;			//参数设置请求
	string cmd_Res_ParameterSet;			//参数设置响应

	string strState_ConnSuccess;			//注册成功
	string strState_ConnFail;				//注册失败
	string strState_Auth;			        //认证结果
	//string strState_AuthFail;				//认证失败
	string strState_Online;					//是否在线
	string strRT_Last;						//最后一次实时数据
	//END:add by bloodhunter for new protocol at 2012-3-23

//方法成员
public:
	CUserSession();
	~CUserSession();

	BOOL Recv(); //投递一个IO PENDING
	BOOL HasCompletionPacket(int& iProtocol);
	void ExtractPacket(TCP_DATA * pTCPData, int iProtocol);

private:
	void CloseSocket();
};

#endif 
