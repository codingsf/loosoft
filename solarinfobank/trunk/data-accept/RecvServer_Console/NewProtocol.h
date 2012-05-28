/************************************************************************/
/* introduction	:deal with new protocol starting with 0x69 0x69         */
/* author		:BLoodHunter											*/
/* date			:2012-3-23												*/
/* vision		:1.0													*/
/************************************************************************/
#pragma once;

#include "stdafx.h"
#include "MyDef.h"
#include "UserSession.h"
#include "ExpandType.h"
#include <map>

//新协议
class Protocol69Dealer
{
	int dwLogLevel;
public:
	Protocol69Dealer()
	{
		dwLogLevel=GetPrivateProfileInt("Server","LogLevel",0,"./config.ini");
	}

public:
	//深层解包，其中包含对于数据的初步验证
	int AnalysisPacket(TCP_DATA* pTCPData, CUserSession* pSession, DataInfoStructor& dataInfo);
	//处理注册请求
	//获取SN与密码
	//根据SN查库，核对密码
	//密码正确，则发送明文验证码
	//密码错误，发送错误码，关闭连接
	int DealRegisterReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//注册核实
	//获取密文验证码
	//核对密文验证码，正确发送确认信息
	//密文错误，发送错误确认信息，关闭连接
	//报文错误，发送错误码，关闭连接
	int DealRegisterVerify(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理电站信息
	int DealStationInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理设备信息
	int DealDeviceInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理实时信息
	int DealRunInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理历史数据
	int DealHistoryData(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理历史故障信息
	int DealHistoryFault(DataInfoStructor& dataInfo, CUserSession * pSession);

	//处理历史数据请求，此处负责下发，并同步等待回应，由一个线程单独调用
	int DealHistoryDataReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理历史数据请求响应
	int DealHistoryDataRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理历史数据终止请求，此处负责下发，并同步等到响应，由一个线程单独调用
	int DealHistoryDataStopReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理历史数据终止请求响应
	int DealHistoryDataStopRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理参数设置请求，此处负责洗发，并同步等待响应，由一个线程单独调用
	int DealParameterSetReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理参数设置响应
	int DealParameterSetRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//处理错误数据响应
	int DealErrorDataRes(DataInfoStructor& dataInfo, CUserSession * pSession);

	//处理离线信息
	void DealOffLine(CUserSession * pSession);
private:
	//获取时间戳
	string GenerateTimeStamp();
    	//获取时间戳
	string GenerateTimeStamp1();
	//获取随机码
	string GetRand();
	//发送内容
	void SendNewProtocol(CUserSession* pSession, char* pstrContent, int iLen, int iType, int iParentType);
	//发送错误码
	void SendErrorCode(CUserSession* pSession, int dataType);
	//获取校验码
	unsigned short ConCRC(byte* bufin, int n);

	//存mem的方法，此处将key与value存入pTCPData
	void Add2Mem(TCP_DATA* pTCPData, string strkey, const char* strval, int iLen, bool isHex)
	{
		//key
		pTCPData->key = new char[strkey.length() + 1];
		memset(pTCPData->key, 0, sizeof(pTCPData->key) );
		memcpy(pTCPData->key, strkey.c_str(), strkey.length() + 1);
		//value，此处要分HEX与ASCALL两种编码
		if(isHex)
		{
			pTCPData->pDataContent = new char[iLen];
			memcpy(pTCPData->pDataContent, strval, iLen);
		}
		else
		{
			pTCPData->pDataContent = new char[iLen+1];
			memcpy(pTCPData->pDataContent, strval, iLen);
			pTCPData->pDataContent[iLen] = '\0';
		}
		//iLen
		pTCPData->dwDataLen = iLen;
		//isHex
		pTCPData->isHex = isHex;
	}
};