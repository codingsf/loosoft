#include "StdAfx.h"
#include "NewProtocol.h"
#include "DLLLoader.h"
#include "TCPServer.h"

extern DLLLoader dllLoader;
extern TCPServer tcp_svr;

//全局累计的量
static unsigned int addnum = 0;
//16位CRC校验表
const  static unsigned char auchCRCHi[] = {
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x00,0xc1,0x81,0x40,0x01,0xc0,0x80,0x41,
	0x01,0xc0,0x80,0x41,0x00,0xc1,0x81,0x40
};
const  static unsigned char auchCRCLo[] = {
	0x00,0xc0,0xc1,0x01,0xc3,0x03,0x02,0xc2,
	0xc6,0x06,0x07,0xc7,0x05,0xc5,0xc4,0x04,
	0xcc,0x0c,0x0d,0xcd,0x0f,0xcf,0xce,0x0e,
	0x0a,0xca,0xcb,0x0b,0xc9,0x09,0x08,0xc8,
	0xd8,0x18,0x19,0xd9,0x1b,0xdb,0xda,0x1a,
	0x1e,0xde,0xdf,0x1f,0xdd,0x1d,0x1c,0xdc,
	0x14,0xd4,0xd5,0x15,0xd7,0x17,0x16,0xd6,
	0xd2,0x12,0x13,0xd3,0x11,0xd1,0xd0,0x10,
	0xf0,0x30,0x31,0xf1,0x33,0xf3,0xf2,0x32,
	0x36,0xf6,0xf7,0x37,0xf5,0x35,0x34,0xf4,
	0x3c,0xfc,0xfd,0x3d,0xff,0x3f,0x3e,0xfe,
	0xfa,0x3a,0x3b,0xfb,0x39,0xf9,0xf8,0x38,
	0x28,0xe8,0xe9,0x29,0xeb,0x2b,0x2a,0xea,
	0xee,0x2e,0x2f,0xef,0x2d,0xed,0xec,0x2c,
	0xe4,0x24,0x25,0xe5,0x27,0xe7,0xe6,0x26,
	0x22,0xe2,0xe3,0x23,0xe1,0x21,0x20,0xe0,
	0xa0,0x60,0x61,0xa1,0x63,0xa3,0xa2,0x62,
	0x66,0xa6,0xa7,0x67,0xa5,0x65,0x64,0xa4,
	0x6c,0xac,0xad,0x6d,0xaf,0x6f,0x6e,0xae,
	0xaa,0x6a,0x6b,0xab,0x69,0xa9,0xa8,0x68,
	0x78,0xb8,0xb9,0x79,0xbb,0x7b,0x7a,0xba,
	0xbe,0x7e,0x7f,0xbf,0x7d,0xbd,0xbc,0x7c,
	0xb4,0x74,0x75,0xb5,0x77,0xb7,0xb6,0x76,
	0x72,0xb2,0xb3,0x73,0xb1,0x71,0x70,0xb0,
	0x50,0x90,0x91,0x51,0x93,0x53,0x52,0x92,
	0x96,0x56,0x57,0x97,0x55,0x95,0x94,0x54,
	0x9c,0x5c,0x5d,0x9d,0x5f,0x9f,0x9e,0x5e,
	0x5a,0x9a,0x9b,0x5b,0x99,0x59,0x58,0x98,
	0x88,0x48,0x49,0x89,0x4b,0x8b,0x8a,0x4a,
	0x4e,0x8e,0x8f,0x4f,0x8d,0x4d,0x4c,0x8c,
	0x44,0x84,0x85,0x45,0x87,0x47,0x46,0x86,
	0x82,0x42,0x43,0x83,0x41,0x81,0x80,0x40
};

//计算CRC校验值
WORD Protocol69Dealer::ConCRC(BYTE *pInfo, int nLen)
{
	unsigned char uchCRCHi = 0xff;
	unsigned char uchCRCLo = 0xff;
	WORD uIndex;
	while (nLen > 0)
	{
		nLen--;
		uIndex = uchCRCHi^*(pInfo++);
		uchCRCHi = uchCRCLo^auchCRCHi[uIndex];
		uchCRCLo = auchCRCLo[uIndex];
	}
	return(uchCRCLo<<8 | uchCRCHi);
}

//获取时间戳
string Protocol69Dealer::GenerateTimeStamp()
{
	char ndate[52];
	memset(ndate, 0 ,sizeof(ndate));
	SYSTEMTIME sysTime;
	GetLocalTime(&sysTime);
    sprintf(ndate, "%04d%02d%02d%02d%02d%02d%03d", 
		sysTime.wYear, 
		sysTime.wMonth, 
		sysTime.wDay, 
		sysTime.wHour, 
		sysTime.wMinute, 
		sysTime.wSecond, 
		sysTime.wMilliseconds); 
	string timestamp = ndate;
	return timestamp;
}
//获取时间戳
string Protocol69Dealer::GenerateTimeStamp1()
{
	char ndate[52];
	memset(ndate, 0 ,sizeof(ndate));
	SYSTEMTIME sysTime;
	GetLocalTime(&sysTime);
    sprintf(ndate, "%04d-%02d-%02d %02d:%02d:%02d:%03d", 
		sysTime.wYear, 
		sysTime.wMonth, 
		sysTime.wDay, 
		sysTime.wHour, 
		sysTime.wMinute, 
		sysTime.wSecond, 
		sysTime.wMilliseconds); 
	string timestamp = ndate;
	return timestamp;
}

//获取随机码
string Protocol69Dealer::GetRand()
{
	char ranstr[5];
	//srand(unsigned(time(NULL)));
	sprintf(ranstr, "%04d", rand() % 1000);
	/*itoa(rand() % 1000, ranstr, 10);
	ranstr[4] = '\0';*/
	string strRand = ranstr;
	return strRand;
}

//获取一个唯一的量 add by qhb
string Protocol69Dealer::GetOnlyone()
{
	//if(addnum>=100000)addnum=0;
    //addnum+=1;
    //char dest[14];
    //_itoa(addnum,dest,100000);

    //return dest;
    char ranstr[7];
	//srand(unsigned(time(NULL)));
	sprintf(ranstr, "%06d", rand() % 100000);
	/*itoa(rand() % 1000, ranstr, 10);
	ranstr[4] = '\0';*/
	string strRand = ranstr;
	return strRand;
}


//深层解压包 
//此处如果返回值为New_Session_Error_State，则表示该连接为非法连接，上层需要删除该链接
//如果返回值为New_Session_Errror_Data则表示该连接数据出现异常，需要其重发或者重新认证。错误码的发送由本函数内部实现，不需要上层调用
int Protocol69Dealer::AnalysisPacket(TCP_DATA* pTCPData, CUserSession* pSession, DataInfoStructor& dataInfo)
{
	if (pSession->bDelete)//如果已经标记为删除，则直接返回false，不作其他处理
		return New_Session_Error_State;

	if (pTCPData->dwDataLen < 18)
	{
		return New_Session_Errror_Data;
	}
	int datatype =  pTCPData->pDataContent[14] + pTCPData->pDataContent[15] * 256;

	//CRC16校验码验证
	unsigned short crc = ConCRC((byte*)(pTCPData->pDataContent), pTCPData->dwDataLen - 2);
	int res = (byte)(pTCPData->pDataContent[pTCPData->dwDataLen - 2]) + ((byte)(pTCPData->pDataContent[pTCPData->dwDataLen - 1])) * 256;
	if(crc != res)
	{
		SendErrorCode(pSession, datatype);
		return New_Session_Errror_Data;
	}

	char dataBody[1024];
	memset(dataBody, 0, sizeof(dataBody));

	dataInfo.iProtocolType = (int)(pTCPData->pDataContent[14]) +  (int)(pTCPData->pDataContent[15]) * 256;		//数据类型
	dataInfo.iProtocolSubType = (int)(pTCPData->pDataContent[16]) + (int)(pTCPData->pDataContent[17]) * 256;	//类别标识
	
	dataInfo.iProtocolvarH =  (int)(pTCPData->pDataContent[10]);//zhouh 2012-8-7 
	dataInfo.iProtocolvarL =  (int)(pTCPData->pDataContent[11]);//zhouh 2012-8-7

	//以保证可重复登录 ||判断符改为&& by qhb 源代码使得验证会话始终停留在第一步了
	if((dataInfo.iProtocolType == New_Protocol_Type_Register) &&
		(dataInfo.iProtocolSubType == New_Procotol_Type_Register_Recv_Login_Req))//必须为注册请求
	{
		if (pTCPData->dwDataLen != 68)//数据长度非法
		{
			SendErrorCode(pSession, datatype);
			return New_Session_Errror_Data;
		}
		//获取SN与密码
		memcpy(dataBody, pTCPData->pDataContent + 18, 16);
		dataInfo.m_pRegisterInfo->m_strSerialNum = dataBody;
        dataInfo.m_pRegisterInfo->m_strSerialNum = Ltrim(dataInfo.m_pRegisterInfo->m_strSerialNum);
		memcpy(dataBody, pTCPData->pDataContent + 34, 32);
		dataInfo.m_pRegisterInfo->m_strPwd = dataBody;
        dataInfo.m_pRegisterInfo->m_strPwd = Ltrim(dataInfo.m_pRegisterInfo->m_strPwd);

		if(dataInfo.iProtocolvarH==1 && dataInfo.iProtocolvarL==1)//zhouh 2012-8-7 
		{
			dataInfo.m_pRegisterInfo->m_strKey="*_Sungrow 1997_*";
		}

		return New_Session_Errror_Success;
	}

	switch(pSession->m_iSessionState)
	{
	//未登录，必须携带账户密码进行登录请求
	case New_Session_State_FirstFrame:

		if((dataInfo.iProtocolType != New_Protocol_Type_Register) || (dataInfo.iProtocolSubType != New_Procotol_Type_Register_Recv_Login_Req))//必须为注册请求
			return New_Session_Error_State;

		if (pTCPData->dwDataLen != 68)//数据长度非法
		{
			SendErrorCode(pSession, New_Protocol_Type_Register);
			return New_Session_Errror_Data;
		}

		//获取SN与密码
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 18, 16);
		dataInfo.m_pRegisterInfo->m_strSerialNum = dataBody;
        dataInfo.m_pRegisterInfo->m_strSerialNum = Ltrim(dataInfo.m_pRegisterInfo->m_strSerialNum);
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 34, 32);
		dataInfo.m_pRegisterInfo->m_strPwd = dataBody;
        dataInfo.m_pRegisterInfo->m_strPwd = Ltrim(dataInfo.m_pRegisterInfo->m_strPwd);
		return New_Session_Errror_Success;
	
	//已登录，必须为验证码验证AES128
	case New_Session_State_Register_Login: 
		if((dataInfo.iProtocolType != New_Protocol_Type_Register) ||
			(dataInfo.iProtocolSubType != New_Procotol_Type_Register_Recv_AuthCode))//必须为接收验证码
			return New_Session_Error_State;

		if (pTCPData->dwDataLen != 52)//数据长度非法
		{
			SendErrorCode(pSession, datatype);
			return New_Session_Errror_Data;
		}
		//获取密文
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 18, 32);
		dataInfo.m_pRegisterInfo->m_strCipherText = dataBody;
		return New_Session_Errror_Success;
	
	//已鉴权结束，可进行任意符合规约的通信
	case New_Session_State_Register_AuthCode://后续所有信息均在此处理
		if((dataInfo.iProtocolType == New_Procotol_Type_PowerStation) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_PowerStation))//电厂描述信息
		{
			if (pTCPData->dwDataLen != 205)//数据长度非法
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_RT) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_RT))//实时信息
		{
			if (pTCPData->dwDataLen < 24)//数据长度非法
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_Device) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_Device))//设备信息
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_RT) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_RT))//实时信息
		{
			if (pTCPData->dwDataLen < 24)//数据长度非法
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//历史数据
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_HD))//历史数据信息
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//历史故障信息
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_Fault_HD))//历史故障信息
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//此处更改为复制全部包结构
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//历史请求响应
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_HD_Req))//历史请求响应
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//历史终止响应
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_HD_Stop_Req))//历史终止响应
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//参数设置响应
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_Param_Req))//参数设置响应
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//以上均不是，则通信非法
		return New_Session_Error_State;
	}
	//本质上来说，程序不会运行到此处
	return New_Session_Errror_Data;
}

//发送内容
void Protocol69Dealer::SendNewProtocol(CUserSession* pSession, char* pstrContent, int iLen, int iType, int iParentType)
{
	iLen = iLen + 8 + 2;//此处的2为类别标识
	char* content = new char[iLen + 2 + 8];
	memset(content, 0, sizeof(content));

	memcpy(content, pSession->m_strPachetHead, 16);//拷贝头
	memcpy(content + 18, pstrContent, iLen - 10);//拷贝内容
	memset(content + 4, 0, 4);

	//设置长度
	content[7] =  iLen / 256 / 256 / 256;
	content[6] =  iLen / 256 / 256 % 256;
	content[5] =  iLen / 256 % 256;
	content[4] =  iLen % 256;

	//设置数据类型
	content[15] = iParentType / 256;
	content[14] = iParentType % 256;
	//设置类别标识
	content[17] = iType / 256;
	content[16] = iType % 256;

	unsigned short crc = ConCRC((byte*)(content), iLen + 8);
	content[iLen + 8] = crc % 256;
	content[iLen + 9] = crc / 256;
	send(pSession->sockAccept, content, iLen + 10, 0);

	SENDLOG(content, iLen + 10, true, pSession->strAddress);

	//if (dwLogLevel!=0)
	//{
	//	CString strLog;
	//	strLog.Format("[DateTime：%s] [Client：%s] [length：%d] [Send Data：",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),pSession->strAddress,iLen + 10);

	//	char strTemp[6];
	//	for (int i=0;i<iLen + 10;i++)
	//	{
	//		sprintf_s(strTemp,"%02X ",(unsigned char)content[i]);
	//		strTemp[5]='\0';

	//		strLog+=strTemp;
	//	}

	//	strLog.TrimRight();
	//	strLog+="]";

	//	CString strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; //默认1:按天生成

	//	//日志0：关闭 1：按天生成 2：按小时生成
	//	if (dwLogLevel==2)
	//	{
	//		strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d_%H")+".txt";
	//	}

	//	FILE * fp=fopen(strFile,"a");
	//	if (fp!=NULL)
	//	{
	//		fputs(strLog,fp);
	//		fputs("\n\n",fp);
	//		fclose(fp);
	//	}
	//}
	delete[] content;
}

//发送错误码
void Protocol69Dealer::SendErrorCode(CUserSession* pSession, int dataType)
{
	SendNewProtocol(pSession, 0, 0, New_Procotol_Type_Send_Error, dataType);
}

//处理注册请求
int Protocol69Dealer::DealRegisterReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
    //生成所有用户会话的key
    pSession->strInfo_Station = "tcp_20_plant_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//电站信息
	pSession->strInfo_Device = "tcp_20_device_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//设备信息
	pSession->strInfo_RTData = "tcp_20_run_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";								//实时数据信息			
	pSession->strInfo_HistoryData = "tcp_20_historydata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//历史数据信息
	pSession->strInfo_HistoryFault =  "tcp_20_faultdata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//历史故障信息

	pSession->strCmd_Req_HistoryStart = "tcp_20_historydata_req_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据请求结果
	pSession->strCmd_Res_HistoryStart = "tcp_20_historydata_req_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据请求
	pSession->strCmd_Req_HistoryStop = "tcp_20_historydata_stop_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据终止
	pSession->strCmd_Res_HistoryStop = "tcp_20_historydata_sotp_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据终止结果
	pSession->cmd_Req_ParameterSet = "tcp_20_deviceparamset_" + pSession->m_pRegisterInfo->m_strSerialNum;			//参数设置
	pSession->cmd_Res_ParameterSet = "tcp_20_deviceparamset_re_" + pSession->m_pRegisterInfo->m_strSerialNum;			//参数设置结果

	pSession->strState_ConnSuccess = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;					//注册成功
	pSession->strState_ConnSuccess += "_success";
	pSession->strState_ConnFail = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//注册失败
	pSession->strState_ConnFail += "_fail";
	pSession->strState_Auth = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;						//认证成功
	//pSession->strState_AuthSuccess += "_success";
	//pSession->strState_AuthFail = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;							//认证失败
	//pSession->strState_AuthFail += "_fail";
	pSession->strState_Online = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//是否在线
	pSession->strState_Online += "_status";
	pSession->strRT_Last = "tcp_20_real_" + pSession->m_pRegisterInfo->m_strSerialNum;								//实时数据

	//此处允许重复登陆
	if(pSession->m_pRegisterInfo->CheckPwd())
	{
		pSession->m_iSessionState = New_Session_State_Register_Login;
		//生成明文验证码
		pSession->m_pRegisterInfo->GenerateAuthText();
		//发送明文验证码
		SendNewProtocol(pSession, const_cast<char*>(pSession->m_pRegisterInfo->m_strAutonClearText.c_str()), 
			pSession->m_pRegisterInfo->m_strAutonClearText.length(), New_Procotol_Type_Register_Send_AuthCode, New_Protocol_Type_Register);

        //此处放于方法开始部位，以解决登录密码失败报错的问题
		////如果密码正确，则此处生成其在后续对话中可能使用到的所有用于memcache会话的key
        //pSession->strInfo_Station = "tcp_20_plant_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//电站信息
		//pSession->strInfo_Device = "tcp_20_device_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//设备信息
		//pSession->strInfo_RTData = "tcp_20_run_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";								//实时数据信息			
		//pSession->strInfo_HistoryData = "tcp_20_historydata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//历史数据信息
		//pSession->strInfo_HistoryFault =  "tcp_20_faultdata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//历史故障信息

		//pSession->strCmd_Req_HistoryStart = "tcp_20_historydata_req_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据请求结果
		//pSession->strCmd_Res_HistoryStart = "tcp_20_historydata_req_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据请求
		//pSession->strCmd_Req_HistoryStop = "tcp_20_historydata_stop_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据终止
		//pSession->strCmd_Res_HistoryStop = "tcp_20_historydata_sotp_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//历史数据终止结果
		//pSession->cmd_Req_ParameterSet = "tcp_20_deviceparamset_" + pSession->m_pRegisterInfo->m_strSerialNum;			//参数设置
		//pSession->cmd_Res_ParameterSet = "tcp_20_deviceparamset_re_" + pSession->m_pRegisterInfo->m_strSerialNum;			//参数设置结果

		//pSession->strState_ConnSuccess = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;					//注册成功
		//pSession->strState_ConnSuccess += "_success";
		//pSession->strState_ConnFail = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//注册失败
		//pSession->strState_ConnFail += "_fail";
		//pSession->strState_Auth = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;						//认证成功
		////pSession->strState_AuthSuccess += "_success";
		////pSession->strState_AuthFail = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;							//认证失败
		////pSession->strState_AuthFail += "_fail";
		//pSession->strState_Online = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//是否在线
		//pSession->strState_Online += "_status";
		//pSession->strRT_Last = "tcp_20_real_" + pSession->m_pRegisterInfo->m_strSerialNum;								//实时数据

		//注册成功状态记录存memcache
		string key  = pSession->strState_ConnSuccess;
		string strVal = GenerateTimeStamp1();
		TCP_DATA* pTCPData = new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		
		return New_Session_State_Register_Login;
	}
	else
	{
		//发送验证失败标识
		char content[8];
		memset(content, 0, sizeof(content));
		//设置失败标识
		content[0] = 0;
		content[1] = 0;
		//设置时间戳
		time_t time1;
		time1 = time(NULL);
		struct tm tm1;
		tm1 = *localtime(&time1);

		if(dataInfo.iProtocolvarH ==1 && dataInfo.iProtocolvarL==1)//zhouh 2012-8-7 
		{
			content[2] = 0xff;
			content[3] = 0xff;
			content[4] = 0xff;
			content[5] = 0xff;
			content[6] = 0xff;
			content[7] = 0xff;
		}
		else
		{
			content[2] = tm1.tm_sec;
			content[3] = tm1.tm_min;
			content[4] = tm1.tm_hour;
			content[5] = tm1.tm_mday;
			content[6] = tm1.tm_mon + 1;
			content[7] = tm1.tm_year + 1900 -2000;
		}
		//发送
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_FirstFrame;//账户密码错误，则更改状态为未登陆

		//注册失败状态记录存memcache
		string key  = pSession->strState_ConnFail;
		string strVal = GenerateTimeStamp1();
		TCP_DATA* pTCPData = new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return New_Session_State_FirstFrame;
	}
}

//处理验证码
int Protocol69Dealer::DealRegisterVerify(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_Login)
	{
		SendErrorCode(pSession, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}
	if(pSession->m_pRegisterInfo->CheckAuth())
	{
		char content[8];
		memset(content, 0, sizeof(content));
		//设置成功标识
		content[0] = 1;
		content[1] = 0;
		//设置时间戳
		time_t time1;
		time1 = time(NULL);
		struct tm tm1;
		tm1 = *localtime(&time1);

		if(dataInfo.iProtocolvarH ==1 && dataInfo.iProtocolvarL==1)//zhouh 2012-8-7 
		{
			content[2] = 0xff;
			content[3] = 0xff;
			content[4] = 0xff;
			content[5] = 0xff;
			content[6] = 0xff;
			content[7] = 0xff;
		}
		else
		{
		content[2] = tm1.tm_sec;
		content[3] = tm1.tm_min;
		content[4] = tm1.tm_hour;
		content[5] = tm1.tm_mday;
		content[6] = tm1.tm_mon + 1;
		content[7] = tm1.tm_year + 1900 -2000;
		}
		//发送
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_Register_AuthCode;

		//验证成功状态存memcache
		string key  = pSession->strState_Auth;
        string strVal = "true:"+GenerateTimeStamp1();
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		//在线状态存memcache
		key  = pSession->strState_Online;
		strVal ="online";
		pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return New_Session_State_Register_AuthCode;
	}
	else
	{
		char content[8];
		memset(content, 0, sizeof(content));
		//设置失败标识
		content[0] = 0;
		content[1] = 0;
		//设置时间戳
		time_t time1;
		time1 = time(NULL);
		struct tm tm1;
		tm1 = *localtime(&time1);
		if(dataInfo.iProtocolvarH ==1 && dataInfo.iProtocolvarL==1)//zhouh 2012-8-7 
		{
			content[2] = 0xff;
			content[3] = 0xff;
			content[4] = 0xff;
			content[5] = 0xff;
			content[6] = 0xff;
			content[7] = 0xff;
		}
		else
		{
			content[2] = tm1.tm_sec;
			content[3] = tm1.tm_min;
			content[4] = tm1.tm_hour;
			content[5] = tm1.tm_mday;
			content[6] = tm1.tm_mon + 1;
			content[7] = tm1.tm_year + 1900 -2000;
		}
		//发送
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_FirstFrame;

		//验证失败状态存memcache
		string key  = pSession->strState_Auth;
        string strVal = "false:"+GenerateTimeStamp1();
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return New_Session_State_FirstFrame;
	}
}

//处理描述电站信息结构
int Protocol69Dealer::DealStationInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Procotol_Type_PowerStation);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//发送确认响应
	char content[2] = {New_Procotol_Type_Recv_Info_PowerStation, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_PowerStation);

	//电站信息头
	string key  = pSession->strInfo_Station;
	//时间戳
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//随机码
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//电站数据信息存memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//处理设备数据
int Protocol69Dealer::DealDeviceInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Procotol_Type_Device);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//发送确认响应
	char content[2] = {New_Procotol_Type_Recv_Info_Device, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_Device);

	//设备头
	string key  = pSession->strInfo_Device;
	//时间戳
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//随机码
	string randstr = GetOnlyone();//GetRand();	
	key += randstr;
	//设备数据存储memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//处理实时数据
int Protocol69Dealer::DealRunInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Procotol_Type_RT);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//发送确认响应
	char content[2] = {New_Procotol_Type_Recv_Info_RT, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_RT);

	//实时头
	string key  = pSession->strInfo_RTData;
	////获取公共地址
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//时间戳
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//随机码
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//实时数据信息存memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	//实时数据状态存memcache
	key  = pSession->strRT_Last;
	pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, timestamp.c_str(), timestamp.length(), false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//处理历史数据
int Protocol69Dealer::DealHistoryData(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//发送确认响应
	char content[2] = {New_Protocol_Type_Recv_Info_HD, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Protocol_Type_History);

	//历史头
	string key  = pSession->strInfo_HistoryData;
	////获取公共地址
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//时间戳
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//随机码
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//历史数据存memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//处理历史故障信息
int Protocol69Dealer::DealHistoryFault(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//发送确认响应
	char content[2] = {New_Protocol_Type_Recv_Info_Fault_HD, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Protocol_Type_History);

	//历史头
	string key  = pSession->strInfo_HistoryFault;
	////获取公共地址
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//时间戳
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//随机码
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//历史故障信息存memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}


//处理历史数据请求，此处负责下发，并同步等待回应，由一个线程单独调用
int Protocol69Dealer::DealHistoryDataReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
		return -1;

	pSession->m_iHistoryRes = -1;//初始化历史数据请求响应状态为等待
	SendNewProtocol(pSession, dataInfo.data, dataInfo.iLen, New_Protocol_Type_Send_Cmd_HD_Req, New_Protocol_Type_History);
	string key  = pSession->strCmd_Res_HistoryStart;
	char res = '0';
	for (int i = 0; i < WAITTIMEOUT * 1000 / 200; i++)
	{
		if(pSession->m_iHistoryRes == -1)
		{
			Sleep(200);
			continue;
		}
		//存入memecache	
		itoa(pSession->m_iHistoryRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return res;
	}
	//存入memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return 0;
}

//处理历史数据请求响应
int Protocol69Dealer::DealHistoryDataRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iHistoryRes = (res == New_Protocol_Type_Send_Cmd_HD_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//处理历史数据终止请求，此处负责下发，并同步等到响应，由一个线程单独调用
int Protocol69Dealer::DealHistoryDataStopReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
		return -1;

	pSession->m_iHistoryStopRes = -1;//初始化历史数据请求响应状态为等待
	SendNewProtocol(pSession, dataInfo.data, dataInfo.iLen, New_Protocol_Type_Send_Cmd_HD_Stop_Req, New_Protocol_Type_History);
	string key  = pSession->strCmd_Res_HistoryStop;
	char res = '0';
	for (int i = 0; i < WAITTIMEOUT * 1000 / 200; i++)
	{
		if(pSession->m_iHistoryStopRes == -1)
		{
			Sleep(200);
			continue;
		}
		//存入memecache	
		itoa(pSession->m_iHistoryStopRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		return res;
	}
	//存入memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
	return 0;
}

//处理历史数据终止请求响应
int Protocol69Dealer::DealHistoryDataStopRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iHistoryStopRes = (res == New_Protocol_Type_Send_Cmd_HD_Stop_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//处理参数设置请求，此处负责下发，并同步等待响应，由一个线程单独调用
int Protocol69Dealer::DealParameterSetReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
		return -1;

	pSession->m_iParamSetRes = -1;//初始化参数设置响应状态为等待
	SendNewProtocol(pSession, dataInfo.data, dataInfo.iLen, New_Protocol_Type_Send_Cmd_Param_Req, New_Protocol_Type_SetParam);
	string key  = pSession->strCmd_Res_HistoryStart;
	char res = '0';
	for (int i = 0; i < WAITTIMEOUT * 1000 / 200; i++)
	{
		if(pSession->m_iParamSetRes == -1)
		{
			Sleep(200);
			continue;
		}
		//存入memecache	
		itoa(pSession->m_iParamSetRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		return res;
	}
	//存入memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
	return 0;
}

//处理参数设置响应
int Protocol69Dealer::DealParameterSetRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_SetParam);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iParamSetRes = (res == New_Protocol_Type_Send_Cmd_Param_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//处理错误数据响应
int Protocol69Dealer::DealErrorDataRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//必须是已经验证过的状态
	{
		SendErrorCode(pSession, New_Protocol_Type_SetParam);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;

	int re1, re2;
	switch(dataInfo.data[14] + dataInfo.data[15] * 255)
	{
	case New_Protocol_Type_History:
		re1 = DealHistoryDataStopRes(dataInfo, pSession);
		re2 = DealHistoryDataRes(dataInfo, pSession);
		if(re1 == -1 && re2 == -1)
			return -1;
		return New_Session_State_Register_AuthCode;
	case New_Protocol_Type_SetParam:
		return DealParameterSetRes(dataInfo, pSession);
	}
	return New_Session_State_FirstFrame;
}

void Protocol69Dealer::DealOffLine(CUserSession * pSession)
{
	//离线
	string key  = pSession->strState_Online;
	string strval ="offline";
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, strval.c_str(), strval.length(), false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
}

//自定义trim函数
//add by qhb in 20120626 for 解决sn有空格的问题，又空格导致生产的memcached key有空格不能 put
string Protocol69Dealer::Ltrim(string& str)
{
    string::size_type pos = str.find_last_not_of(' ');
    if(pos != string::npos)
    {
        str.erase(pos + 1);
        pos = str.find_first_not_of(' ');
        if(pos != string::npos) str.erase(0, pos);
    }
    else 
        str.erase(str.begin(), str.end());
    return str;
}