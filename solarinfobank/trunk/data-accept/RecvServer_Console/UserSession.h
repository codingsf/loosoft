/*************************************************
Copyright:
Author:bloodhunter
Date:2012-10-21
Description:�û��Ự������
FileName:UserSession.h
**************************************************/
#ifndef USERSESSION_H
#define USERSESSION_H

#include "mydef.h"
#include "CriticalSection.h"
#include "ExpandType.h"

/*
CUserSession:
Ϊ�˱��ڹ�����SOCKET��Ϊÿ��SOCKET����ά��һ����·��ÿ��SOCKET�����������ݰ���
��������Ĳ�ȷ�����أ��ͻ��˷��������ݣ�������������ҪN�β������꣬������Ҫ��һ��������  
��Ҫ��;Ϊ�յ��������ݷŻ��������ȴ�����Ƿ�ﵽһ�������İ��ˣ�
��������������ʣ�µ������ƶ�����ǰ��
*/
class CUserSession
{
//��Ա����
public:
	BOOL bWorkStatus;						//�Ƿ��ڹ���״̬

	time_t LastKeepLive;					//������ʱ��
	SOCKET sockAccept;						//������SOCKET���Ӿ��

	BOOL bDelete;							//�Ƿ񱻱��Ϊ��ɾ�����ѶϿ���
	time_t DeleteTime;						//���Ϊɾ����ʱ��

	char strAddress[50];					//�ͻ���IP��ַ

	char pRecvBuf[RECV_BUF_LEN * 16];		//���512 * 16=8K
	int dwRecvBytes;

	PER_IO_DATA pPerIOData;

	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	int m_iSessionState;					//��ǰ�û�״̬
	NewRegisterInfo* m_pRegisterInfo;		//ע����Ϣ�����а���SN��������֤��
	int m_iHistoryRes;					    //�ϴβ����������ʷ��������,-1 �Ѿ��·����ȴ����ܣ� 1 �ظ��ɹ� 0 �ظ�ʧ��
	int m_iHistoryStopRes;					//�ϴβ����������ʷ������ֹ,-1 �Ѿ��·����ȴ����ܣ� 1 �ظ��ɹ� 0 �ظ�ʧ��
	int m_iParamSetRes;					    //�ϴβ������������,-1 �Ѿ��·����ȴ����ܣ� 1 �ظ��ɹ� 0 �ظ�ʧ��
	char m_strPachetHead[16];

	//�˴�����memecache��key���ɵ�һ�ε�¼ʱ����
	string strInfo_Station;					//��վ��Ϣ
	string strInfo_Device;					//�豸��Ϣ
	string strInfo_RTData;					//ʵʱ������Ϣ			
	string strInfo_HistoryData;				//��ʷ������Ϣ
	string strInfo_HistoryFault;			//��ʷ������Ϣ

	string strCmd_Req_HistoryStart;			//��ʷ���ݿ�ʼ����
	string strCmd_Res_HistoryStart;			//��ʷ���ݿ�ʼ��Ӧ
	string strCmd_Req_HistoryStop;			//��ʷ������ֹ����
	string strCmd_Res_HistoryStop;			//��ʷ������ֹ��Ӧ
	string cmd_Req_ParameterSet;			//������������
	string cmd_Res_ParameterSet;			//����������Ӧ

	string strState_ConnSuccess;			//ע��ɹ�
	string strState_ConnFail;				//ע��ʧ��
	string strState_Auth;			        //��֤���
	//string strState_AuthFail;				//��֤ʧ��
	string strState_Online;					//�Ƿ�����
	string strRT_Last;						//���һ��ʵʱ����
	//END:add by bloodhunter for new protocol at 2012-3-23

//������Ա
public:
	CUserSession();
	~CUserSession();

	BOOL Recv(); //Ͷ��һ��IO PENDING
	BOOL HasCompletionPacket(int& iProtocol);
	void ExtractPacket(TCP_DATA * pTCPData, int iProtocol);

private:
	void CloseSocket();
};

#endif 
