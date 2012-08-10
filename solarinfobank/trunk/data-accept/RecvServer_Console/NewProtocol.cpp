#include "StdAfx.h"
#include "NewProtocol.h"
#include "DLLLoader.h"
#include "TCPServer.h"

extern DLLLoader dllLoader;
extern TCPServer tcp_svr;

//ȫ���ۼƵ���
static unsigned int addnum = 0;
//16λCRCУ���
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

//����CRCУ��ֵ
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

//��ȡʱ���
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
//��ȡʱ���
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

//��ȡ�����
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

//��ȡһ��Ψһ���� add by qhb
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


//����ѹ�� 
//�˴��������ֵΪNew_Session_Error_State�����ʾ������Ϊ�Ƿ����ӣ��ϲ���Ҫɾ��������
//�������ֵΪNew_Session_Errror_Data���ʾ���������ݳ����쳣����Ҫ���ط�����������֤��������ķ����ɱ������ڲ�ʵ�֣�����Ҫ�ϲ����
int Protocol69Dealer::AnalysisPacket(TCP_DATA* pTCPData, CUserSession* pSession, DataInfoStructor& dataInfo)
{
	if (pSession->bDelete)//����Ѿ����Ϊɾ������ֱ�ӷ���false��������������
		return New_Session_Error_State;

	if (pTCPData->dwDataLen < 18)
	{
		return New_Session_Errror_Data;
	}
	int datatype =  pTCPData->pDataContent[14] + pTCPData->pDataContent[15] * 256;

	//CRC16У������֤
	unsigned short crc = ConCRC((byte*)(pTCPData->pDataContent), pTCPData->dwDataLen - 2);
	int res = (byte)(pTCPData->pDataContent[pTCPData->dwDataLen - 2]) + ((byte)(pTCPData->pDataContent[pTCPData->dwDataLen - 1])) * 256;
	if(crc != res)
	{
		SendErrorCode(pSession, datatype);
		return New_Session_Errror_Data;
	}

	char dataBody[1024];
	memset(dataBody, 0, sizeof(dataBody));

	dataInfo.iProtocolType = (int)(pTCPData->pDataContent[14]) +  (int)(pTCPData->pDataContent[15]) * 256;		//��������
	dataInfo.iProtocolSubType = (int)(pTCPData->pDataContent[16]) + (int)(pTCPData->pDataContent[17]) * 256;	//����ʶ
	
	dataInfo.iProtocolvarH =  (int)(pTCPData->pDataContent[10]);//zhouh 2012-8-7 
	dataInfo.iProtocolvarL =  (int)(pTCPData->pDataContent[11]);//zhouh 2012-8-7

	//�Ա�֤���ظ���¼ ||�жϷ���Ϊ&& by qhb Դ����ʹ����֤�Ựʼ��ͣ���ڵ�һ����
	if((dataInfo.iProtocolType == New_Protocol_Type_Register) &&
		(dataInfo.iProtocolSubType == New_Procotol_Type_Register_Recv_Login_Req))//����Ϊע������
	{
		if (pTCPData->dwDataLen != 68)//���ݳ��ȷǷ�
		{
			SendErrorCode(pSession, datatype);
			return New_Session_Errror_Data;
		}
		//��ȡSN������
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
	//δ��¼������Я���˻�������е�¼����
	case New_Session_State_FirstFrame:

		if((dataInfo.iProtocolType != New_Protocol_Type_Register) || (dataInfo.iProtocolSubType != New_Procotol_Type_Register_Recv_Login_Req))//����Ϊע������
			return New_Session_Error_State;

		if (pTCPData->dwDataLen != 68)//���ݳ��ȷǷ�
		{
			SendErrorCode(pSession, New_Protocol_Type_Register);
			return New_Session_Errror_Data;
		}

		//��ȡSN������
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 18, 16);
		dataInfo.m_pRegisterInfo->m_strSerialNum = dataBody;
        dataInfo.m_pRegisterInfo->m_strSerialNum = Ltrim(dataInfo.m_pRegisterInfo->m_strSerialNum);
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 34, 32);
		dataInfo.m_pRegisterInfo->m_strPwd = dataBody;
        dataInfo.m_pRegisterInfo->m_strPwd = Ltrim(dataInfo.m_pRegisterInfo->m_strPwd);
		return New_Session_Errror_Success;
	
	//�ѵ�¼������Ϊ��֤����֤AES128
	case New_Session_State_Register_Login: 
		if((dataInfo.iProtocolType != New_Protocol_Type_Register) ||
			(dataInfo.iProtocolSubType != New_Procotol_Type_Register_Recv_AuthCode))//����Ϊ������֤��
			return New_Session_Error_State;

		if (pTCPData->dwDataLen != 52)//���ݳ��ȷǷ�
		{
			SendErrorCode(pSession, datatype);
			return New_Session_Errror_Data;
		}
		//��ȡ����
		memset(dataBody, 0, sizeof(dataBody));
		memcpy(dataBody, pTCPData->pDataContent + 18, 32);
		dataInfo.m_pRegisterInfo->m_strCipherText = dataBody;
		return New_Session_Errror_Success;
	
	//�Ѽ�Ȩ�������ɽ���������Ϲ�Լ��ͨ��
	case New_Session_State_Register_AuthCode://����������Ϣ���ڴ˴���
		if((dataInfo.iProtocolType == New_Procotol_Type_PowerStation) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_PowerStation))//�糧������Ϣ
		{
			if (pTCPData->dwDataLen != 205)//���ݳ��ȷǷ�
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_RT) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_RT))//ʵʱ��Ϣ
		{
			if (pTCPData->dwDataLen < 24)//���ݳ��ȷǷ�
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_Device) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_Device))//�豸��Ϣ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		if((dataInfo.iProtocolType == New_Procotol_Type_RT) &&
			(dataInfo.iProtocolSubType == New_Procotol_Type_Recv_Info_RT))//ʵʱ��Ϣ
		{
			if (pTCPData->dwDataLen < 24)//���ݳ��ȷǷ�
			{
				SendErrorCode(pSession, datatype);
				return New_Session_Errror_Data;
			}
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//��ʷ����
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_HD))//��ʷ������Ϣ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//��ʷ������Ϣ
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Recv_Info_Fault_HD))//��ʷ������Ϣ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);//�˴�����Ϊ����ȫ�����ṹ
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//��ʷ������Ӧ
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_HD_Req))//��ʷ������Ӧ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//��ʷ��ֹ��Ӧ
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_HD_Stop_Req))//��ʷ��ֹ��Ӧ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//����������Ӧ
		if((dataInfo.iProtocolType == New_Protocol_Type_History) &&
			(dataInfo.iProtocolSubType == New_Protocol_Type_Send_Cmd_Param_Req))//����������Ӧ
		{
			//dataInfo.data = new char[pTCPData->dwDataLen];
			memcpy(dataInfo.data, pTCPData->pDataContent, pTCPData->dwDataLen);
			dataInfo.iLen = pTCPData->dwDataLen;
			return New_Session_Errror_Success;
		}

		//���Ͼ����ǣ���ͨ�ŷǷ�
		return New_Session_Error_State;
	}
	//��������˵�����򲻻����е��˴�
	return New_Session_Errror_Data;
}

//��������
void Protocol69Dealer::SendNewProtocol(CUserSession* pSession, char* pstrContent, int iLen, int iType, int iParentType)
{
	iLen = iLen + 8 + 2;//�˴���2Ϊ����ʶ
	char* content = new char[iLen + 2 + 8];
	memset(content, 0, sizeof(content));

	memcpy(content, pSession->m_strPachetHead, 16);//����ͷ
	memcpy(content + 18, pstrContent, iLen - 10);//��������
	memset(content + 4, 0, 4);

	//���ó���
	content[7] =  iLen / 256 / 256 / 256;
	content[6] =  iLen / 256 / 256 % 256;
	content[5] =  iLen / 256 % 256;
	content[4] =  iLen % 256;

	//������������
	content[15] = iParentType / 256;
	content[14] = iParentType % 256;
	//��������ʶ
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
	//	strLog.Format("[DateTime��%s] [Client��%s] [length��%d] [Send Data��",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),pSession->strAddress,iLen + 10);

	//	char strTemp[6];
	//	for (int i=0;i<iLen + 10;i++)
	//	{
	//		sprintf_s(strTemp,"%02X ",(unsigned char)content[i]);
	//		strTemp[5]='\0';

	//		strLog+=strTemp;
	//	}

	//	strLog.TrimRight();
	//	strLog+="]";

	//	CString strFile="logs\\"+CTime::GetCurrentTime().Format("%Y%m%d")+".txt"; //Ĭ��1:��������

	//	//��־0���ر� 1���������� 2����Сʱ����
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

//���ʹ�����
void Protocol69Dealer::SendErrorCode(CUserSession* pSession, int dataType)
{
	SendNewProtocol(pSession, 0, 0, New_Procotol_Type_Send_Error, dataType);
}

//����ע������
int Protocol69Dealer::DealRegisterReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
    //���������û��Ự��key
    pSession->strInfo_Station = "tcp_20_plant_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//��վ��Ϣ
	pSession->strInfo_Device = "tcp_20_device_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//�豸��Ϣ
	pSession->strInfo_RTData = "tcp_20_run_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";								//ʵʱ������Ϣ			
	pSession->strInfo_HistoryData = "tcp_20_historydata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//��ʷ������Ϣ
	pSession->strInfo_HistoryFault =  "tcp_20_faultdata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//��ʷ������Ϣ

	pSession->strCmd_Req_HistoryStart = "tcp_20_historydata_req_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ����������
	pSession->strCmd_Res_HistoryStart = "tcp_20_historydata_req_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ��������
	pSession->strCmd_Req_HistoryStop = "tcp_20_historydata_stop_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ������ֹ
	pSession->strCmd_Res_HistoryStop = "tcp_20_historydata_sotp_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ������ֹ���
	pSession->cmd_Req_ParameterSet = "tcp_20_deviceparamset_" + pSession->m_pRegisterInfo->m_strSerialNum;			//��������
	pSession->cmd_Res_ParameterSet = "tcp_20_deviceparamset_re_" + pSession->m_pRegisterInfo->m_strSerialNum;			//�������ý��

	pSession->strState_ConnSuccess = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;					//ע��ɹ�
	pSession->strState_ConnSuccess += "_success";
	pSession->strState_ConnFail = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//ע��ʧ��
	pSession->strState_ConnFail += "_fail";
	pSession->strState_Auth = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;						//��֤�ɹ�
	//pSession->strState_AuthSuccess += "_success";
	//pSession->strState_AuthFail = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;							//��֤ʧ��
	//pSession->strState_AuthFail += "_fail";
	pSession->strState_Online = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//�Ƿ�����
	pSession->strState_Online += "_status";
	pSession->strRT_Last = "tcp_20_real_" + pSession->m_pRegisterInfo->m_strSerialNum;								//ʵʱ����

	//�˴������ظ���½
	if(pSession->m_pRegisterInfo->CheckPwd())
	{
		pSession->m_iSessionState = New_Session_State_Register_Login;
		//����������֤��
		pSession->m_pRegisterInfo->GenerateAuthText();
		//����������֤��
		SendNewProtocol(pSession, const_cast<char*>(pSession->m_pRegisterInfo->m_strAutonClearText.c_str()), 
			pSession->m_pRegisterInfo->m_strAutonClearText.length(), New_Procotol_Type_Register_Send_AuthCode, New_Protocol_Type_Register);

        //�˴����ڷ�����ʼ��λ���Խ����¼����ʧ�ܱ��������
		////���������ȷ����˴��������ں����Ի��п���ʹ�õ�����������memcache�Ự��key
        //pSession->strInfo_Station = "tcp_20_plant_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//��վ��Ϣ
		//pSession->strInfo_Device = "tcp_20_device_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";							//�豸��Ϣ
		//pSession->strInfo_RTData = "tcp_20_run_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";								//ʵʱ������Ϣ			
		//pSession->strInfo_HistoryData = "tcp_20_historydata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//��ʷ������Ϣ
		//pSession->strInfo_HistoryFault =  "tcp_20_faultdata_" + pSession->m_pRegisterInfo->m_strSerialNum+"_";				//��ʷ������Ϣ

		//pSession->strCmd_Req_HistoryStart = "tcp_20_historydata_req_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ����������
		//pSession->strCmd_Res_HistoryStart = "tcp_20_historydata_req_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ��������
		//pSession->strCmd_Req_HistoryStop = "tcp_20_historydata_stop_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ������ֹ
		//pSession->strCmd_Res_HistoryStop = "tcp_20_historydata_sotp_re_" + pSession->m_pRegisterInfo->m_strSerialNum;		//��ʷ������ֹ���
		//pSession->cmd_Req_ParameterSet = "tcp_20_deviceparamset_" + pSession->m_pRegisterInfo->m_strSerialNum;			//��������
		//pSession->cmd_Res_ParameterSet = "tcp_20_deviceparamset_re_" + pSession->m_pRegisterInfo->m_strSerialNum;			//�������ý��

		//pSession->strState_ConnSuccess = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;					//ע��ɹ�
		//pSession->strState_ConnSuccess += "_success";
		//pSession->strState_ConnFail = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//ע��ʧ��
		//pSession->strState_ConnFail += "_fail";
		//pSession->strState_Auth = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;						//��֤�ɹ�
		////pSession->strState_AuthSuccess += "_success";
		////pSession->strState_AuthFail = "tcp_20_auth_" + pSession->m_pRegisterInfo->m_strSerialNum;							//��֤ʧ��
		////pSession->strState_AuthFail += "_fail";
		//pSession->strState_Online = "tcp_20_connect_" + pSession->m_pRegisterInfo->m_strSerialNum;						//�Ƿ�����
		//pSession->strState_Online += "_status";
		//pSession->strRT_Last = "tcp_20_real_" + pSession->m_pRegisterInfo->m_strSerialNum;								//ʵʱ����

		//ע��ɹ�״̬��¼��memcache
		string key  = pSession->strState_ConnSuccess;
		string strVal = GenerateTimeStamp1();
		TCP_DATA* pTCPData = new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		
		return New_Session_State_Register_Login;
	}
	else
	{
		//������֤ʧ�ܱ�ʶ
		char content[8];
		memset(content, 0, sizeof(content));
		//����ʧ�ܱ�ʶ
		content[0] = 0;
		content[1] = 0;
		//����ʱ���
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
		//����
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_FirstFrame;//�˻�������������״̬Ϊδ��½

		//ע��ʧ��״̬��¼��memcache
		string key  = pSession->strState_ConnFail;
		string strVal = GenerateTimeStamp1();
		TCP_DATA* pTCPData = new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return New_Session_State_FirstFrame;
	}
}

//������֤��
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
		//���óɹ���ʶ
		content[0] = 1;
		content[1] = 0;
		//����ʱ���
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
		//����
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_Register_AuthCode;

		//��֤�ɹ�״̬��memcache
		string key  = pSession->strState_Auth;
        string strVal = "true:"+GenerateTimeStamp1();
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		//����״̬��memcache
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
		//����ʧ�ܱ�ʶ
		content[0] = 0;
		content[1] = 0;
		//����ʱ���
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
		//����
		SendNewProtocol(pSession, content, 8, New_Procotol_Type_Register_Send_Login_Res, New_Protocol_Type_Register);
		pSession->m_iSessionState = New_Session_State_FirstFrame;

		//��֤ʧ��״̬��memcache
		string key  = pSession->strState_Auth;
        string strVal = "false:"+GenerateTimeStamp1();
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, strVal.c_str(), strVal.length(), false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return New_Session_State_FirstFrame;
	}
}

//����������վ��Ϣ�ṹ
int Protocol69Dealer::DealStationInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Procotol_Type_PowerStation);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//����ȷ����Ӧ
	char content[2] = {New_Procotol_Type_Recv_Info_PowerStation, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_PowerStation);

	//��վ��Ϣͷ
	string key  = pSession->strInfo_Station;
	//ʱ���
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//�����
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//��վ������Ϣ��memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//�����豸����
int Protocol69Dealer::DealDeviceInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Procotol_Type_Device);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//����ȷ����Ӧ
	char content[2] = {New_Procotol_Type_Recv_Info_Device, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_Device);

	//�豸ͷ
	string key  = pSession->strInfo_Device;
	//ʱ���
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//�����
	string randstr = GetOnlyone();//GetRand();	
	key += randstr;
	//�豸���ݴ洢memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//����ʵʱ����
int Protocol69Dealer::DealRunInfo(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Procotol_Type_RT);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//����ȷ����Ӧ
	char content[2] = {New_Procotol_Type_Recv_Info_RT, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Procotol_Type_RT);

	//ʵʱͷ
	string key  = pSession->strInfo_RTData;
	////��ȡ������ַ
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//ʱ���
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//�����
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//ʵʱ������Ϣ��memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	//ʵʱ����״̬��memcache
	key  = pSession->strRT_Last;
	pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, timestamp.c_str(), timestamp.length(), false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//������ʷ����
int Protocol69Dealer::DealHistoryData(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//����ȷ����Ӧ
	char content[2] = {New_Protocol_Type_Recv_Info_HD, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Protocol_Type_History);

	//��ʷͷ
	string key  = pSession->strInfo_HistoryData;
	////��ȡ������ַ
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//ʱ���
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//�����
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//��ʷ���ݴ�memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}

//������ʷ������Ϣ
int Protocol69Dealer::DealHistoryFault(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	//����ȷ����Ӧ
	char content[2] = {New_Protocol_Type_Recv_Info_Fault_HD, 0};
	SendNewProtocol(pSession, content, 2, New_Procotol_Type_Send_Info_Res, New_Protocol_Type_History);

	//��ʷͷ
	string key  = pSession->strInfo_HistoryFault;
	////��ȡ������ַ
	//char addr[5];
	//memcpy(addr + 1, dataInfo.data, 2);
	//addr[0] = '_';
	//addr[3] = '_';
	//addr[4] = '\0';
	//key += addr;
	//ʱ���
	string timestamp = GenerateTimeStamp();
	key += timestamp;
	//�����
	string randstr = GetOnlyone();//GetRand();
	key += randstr;
	//��ʷ������Ϣ��memcache
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, dataInfo.data, dataInfo.iLen, true);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return New_Session_State_Register_AuthCode;
}


//������ʷ�������󣬴˴������·�����ͬ���ȴ���Ӧ����һ���̵߳�������
int Protocol69Dealer::DealHistoryDataReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
		return -1;

	pSession->m_iHistoryRes = -1;//��ʼ����ʷ����������Ӧ״̬Ϊ�ȴ�
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
		//����memecache	
		itoa(pSession->m_iHistoryRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);

		return res;
	}
	//����memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);

	return 0;
}

//������ʷ����������Ӧ
int Protocol69Dealer::DealHistoryDataRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iHistoryRes = (res == New_Protocol_Type_Send_Cmd_HD_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//������ʷ������ֹ���󣬴˴������·�����ͬ���ȵ���Ӧ����һ���̵߳�������
int Protocol69Dealer::DealHistoryDataStopReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
		return -1;

	pSession->m_iHistoryStopRes = -1;//��ʼ����ʷ����������Ӧ״̬Ϊ�ȴ�
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
		//����memecache	
		itoa(pSession->m_iHistoryStopRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		return res;
	}
	//����memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
	return 0;
}

//������ʷ������ֹ������Ӧ
int Protocol69Dealer::DealHistoryDataStopRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Protocol_Type_History);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iHistoryStopRes = (res == New_Protocol_Type_Send_Cmd_HD_Stop_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//��������������󣬴˴������·�����ͬ���ȴ���Ӧ����һ���̵߳�������
int Protocol69Dealer::DealParameterSetReq(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
		return -1;

	pSession->m_iParamSetRes = -1;//��ʼ������������Ӧ״̬Ϊ�ȴ�
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
		//����memecache	
		itoa(pSession->m_iParamSetRes, &res, 10);
		TCP_DATA * pTCPData=new TCP_DATA;
		Add2Mem(pTCPData, key, &res, 1, false);
		tcp_svr.dataManage.AddToMemBuf(pTCPData);
		return res;
	}
	//����memecache	
	res = '0';
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, &res, 1, false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
	return 0;
}

//�������������Ӧ
int Protocol69Dealer::DealParameterSetRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
	{
		SendErrorCode(pSession, New_Protocol_Type_SetParam);
		pSession->m_iSessionState = New_Session_State_FirstFrame;
		return -1;
	}

	int res =  dataInfo.data[18] + dataInfo.data[19] * 255;
	pSession->m_iParamSetRes = (res == New_Protocol_Type_Send_Cmd_Param_Req) ? 1 : 0;
	return New_Session_State_Register_AuthCode;
}

//�������������Ӧ
int Protocol69Dealer::DealErrorDataRes(DataInfoStructor& dataInfo, CUserSession * pSession)
{
	if (pSession->m_iSessionState != New_Session_State_Register_AuthCode)//�������Ѿ���֤����״̬
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
	//����
	string key  = pSession->strState_Online;
	string strval ="offline";
	TCP_DATA * pTCPData=new TCP_DATA;
	Add2Mem(pTCPData, key, strval.c_str(), strval.length(), false);
	tcp_svr.dataManage.AddToMemBuf(pTCPData);
}

//�Զ���trim����
//add by qhb in 20120626 for ���sn�пո�����⣬�ֿո���������memcached key�пո��� put
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