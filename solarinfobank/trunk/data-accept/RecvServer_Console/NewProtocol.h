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

//��Э��
class Protocol69Dealer
{
	int dwLogLevel;
public:
	Protocol69Dealer()
	{
		dwLogLevel=GetPrivateProfileInt("Server","LogLevel",0,"./config.ini");
	}

public:
	//����������а����������ݵĳ�����֤
	int AnalysisPacket(TCP_DATA* pTCPData, CUserSession* pSession, DataInfoStructor& dataInfo);
	//����ע������
	//��ȡSN������
	//����SN��⣬�˶�����
	//������ȷ������������֤��
	//������󣬷��ʹ����룬�ر�����
	int DealRegisterReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//ע���ʵ
	//��ȡ������֤��
	//�˶�������֤�룬��ȷ����ȷ����Ϣ
	//���Ĵ��󣬷��ʹ���ȷ����Ϣ���ر�����
	//���Ĵ��󣬷��ʹ����룬�ر�����
	int DealRegisterVerify(DataInfoStructor& dataInfo, CUserSession * pSession);
	//�����վ��Ϣ
	int DealStationInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//�����豸��Ϣ
	int DealDeviceInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//����ʵʱ��Ϣ
	int DealRunInfo(DataInfoStructor& dataInfo, CUserSession * pSession);
	//������ʷ����
	int DealHistoryData(DataInfoStructor& dataInfo, CUserSession * pSession);
	//������ʷ������Ϣ
	int DealHistoryFault(DataInfoStructor& dataInfo, CUserSession * pSession);

	//������ʷ�������󣬴˴������·�����ͬ���ȴ���Ӧ����һ���̵߳�������
	int DealHistoryDataReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//������ʷ����������Ӧ
	int DealHistoryDataRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//������ʷ������ֹ���󣬴˴������·�����ͬ���ȵ���Ӧ����һ���̵߳�������
	int DealHistoryDataStopReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//������ʷ������ֹ������Ӧ
	int DealHistoryDataStopRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//��������������󣬴˴�����ϴ������ͬ���ȴ���Ӧ����һ���̵߳�������
	int DealParameterSetReq(DataInfoStructor& dataInfo, CUserSession * pSession);
	//�������������Ӧ
	int DealParameterSetRes(DataInfoStructor& dataInfo, CUserSession * pSession);
	//�������������Ӧ
	int DealErrorDataRes(DataInfoStructor& dataInfo, CUserSession * pSession);

	//����������Ϣ
	void DealOffLine(CUserSession * pSession);
private:
	//��ȡʱ���
	string GenerateTimeStamp();
    	//��ȡʱ���
	string GenerateTimeStamp1();
	//��ȡ�����
	string GetRand();
	//��������
	void SendNewProtocol(CUserSession* pSession, char* pstrContent, int iLen, int iType, int iParentType);
	//���ʹ�����
	void SendErrorCode(CUserSession* pSession, int dataType);
	//��ȡУ����
	unsigned short ConCRC(byte* bufin, int n);

	//��mem�ķ������˴���key��value����pTCPData
	void Add2Mem(TCP_DATA* pTCPData, string strkey, const char* strval, int iLen, bool isHex)
	{
		//key
		pTCPData->key = new char[strkey.length() + 1];
		memset(pTCPData->key, 0, sizeof(pTCPData->key) );
		memcpy(pTCPData->key, strkey.c_str(), strkey.length() + 1);
		//value���˴�Ҫ��HEX��ASCALL���ֱ���
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