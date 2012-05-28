/************************************************************************/
/* introduction	:define all const used in new protocol                  */
/* author		:BLoodHunter											*/
/* date			:2012-3-23												*/
/* vision		:1.0													*/
/************************************************************************/
#pragma once;
#include "stdafx.h"
#include "MySQLUtil.h"
#include <bitset>
#include <utility>
#include "LogHelper.h"
#include "MyDef.h"
using namespace std;


#define SENDLOG(content, iLen, isSend, socket) \
{\
	LogHelper lohHelper;\
	CString strLog;\
	if(isSend)\
	{\
		strLog.Format("[DateTime��%s] [Client��%s] [length��%d] [Recv Data��",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"), socket,iLen);\
	}\
	else\
	{\
		strLog.Format("[DateTime��%s] [Client��%s] [length��%d] [Send Data��",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"), socket,iLen);\
	}\
	char strTemp[6];\
	for (int i=0;i<iLen;i++)\
	{\
		sprintf_s(strTemp,"%02X ",(unsigned char)content[i]);\
		strTemp[5]='\0';\
		strLog+=strTemp;\
	}\
	strLog.TrimRight();\
	strLog+="]";\
	lohHelper.WriteLog(strLog, 0);\
}

//дmemcache�Ľ�����־
#define SENDMEMLOG(strkey, strcontent, isSend)\
{\
	LogHelper lohHelper;\
	CString content;\
	if(isSend)\
	{\
	content.Format("[DateTime: %s] [KEY: %s] [length: %d] [Send Value: %s]",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),strID, strContent.GetLength(), strContent);\
	}\
	else\
	{\
	content.Format("[DateTime: %s] [KEY: %s] [length: %d] [Recv Value: %s]",CTime::GetCurrentTime().Format("%Y-%m-%d %H:%M:%S"),strID, strContent.GetLength(), strContent);\
	}\
	lohHelper.WriteLog(content, 1);\
}

//�Ự״̬
enum New_SessionState
{
	
	New_Session_State_FirstFrame = -1,				//��һ֡

	New_Session_State_Register_Login,				//��¼
	New_Session_State_Register_AuthCode,			//��֤����֤

	New_Session_State_Last							//���ڻ�ȡ״̬�ܸ���
};

enum New_SessionError
{
	New_Session_Error_State = -2,					//����״̬����Ҫɾ��
	New_Session_Errror_Data = -1,				    //���ݸ�ʽ����
	New_Session_Errror_Success = 0					//��ȷ
};
//Э��������
enum New_SessionSubType
{
	//��¼��֤
	New_Procotol_Type_Register_Recv_Login_Req = 0x01,		//�����û���¼����<���ݰ���ΪSN�����룬�����ַ���ΪUTF-8>
	New_Procotol_Type_Register_Send_AuthCode = 0x02,		//������֤��<���ݰ���Ϊ�����ַ����������ַ���ΪUTF-8>
	New_Procotol_Type_Register_Recv_AuthCode = 0x03,		//������֤��<���ݰ���Ϊ�����ַ����������ַ���ΪUTF-8>
	New_Procotol_Type_Register_Send_Login_Res = 0x04,		//���ص�¼��Ӧ<���ݰ�����Ӧ�����ʱ���>
	
	New_Procotol_Type_Recv_Info_PowerStation = 11,		    //���յ�վ������Ϣ�ṹ<���ݰ���Ϊ��վ������Ϣ>

	New_Procotol_Type_Recv_Info_Device	= 31,				//�����豸������Ϣ�ṹ<���ݰ���Ϊ�豸������Ϣ>

	New_Procotol_Type_Recv_Info_RT = 41,					//����ʵʱ����<���ݰ���Ϊʵʱ����>
	New_Procotol_Type_Recv_Info_Fault_RT = 43,					//����ʵʱ������Ϣ<���ݰ���Ϊʵʱ������Ϣ>

	New_Protocol_Type_Recv_Info_HD = 51,					//��ʷ����
	New_Protocol_Type_Recv_Info_Fault_HD = 52,				//��ʷ����
    New_Protocol_Type_Send_Cmd_HD_Req = 53,
	New_Protocol_Type_Send_Cmd_HD_Stop_Req = 54,
	New_Protocol_Type_Send_Cmd_Param_Req = 61,				//������Ϣ

	New_Protocol_Type_Recv_OP = 0xFF,                       //������Ӧ

	New_Procotol_Type_Send_Info_Res = 0xFF,					//������Ϣ��Ӧ<���ݰ���Ϊ��Ӧ����Ӧ����Ϣ>
	New_Procotol_Type_Send_Error = 0xFFFF					//���ʹ�����<���ݰ�Ϊ��>
};

enum New_SessionType
{
	New_Protocol_Type_Register = 1,							//ע��
	New_Procotol_Type_PowerStation = 2,						//�糧
	New_Procotol_Type_Device = 3,							//�豸
	New_Procotol_Type_RT = 4,								//ʵʱ��Ϣ
	New_Protocol_Type_History =5,							//��ʷ��Ϣ
	New_Protocol_Type_SetParam = 6							//�����趨								
};

//Э��汾
enum ProtocolType
{
	Protocol68 = 0,
	Protocol69 = 1
};

struct UserIfo
{
	string s_strSerialNum;										//SN
	string s_strKey;											//key
	string s_strPwd;											//����
};

//�û���¼��Ϣ�ṹ
class NewRegisterInfo
{
public:
	string	m_strSerialNum;										//SN
	string m_strKey;											//key
	string m_strPwd;											//����
	string  m_strAutonClearText;								//������֤��
	string  m_strCipherText;									//������֤��

private:
	//static MyConnection m_conn;
	string m_strOriginCipherText;								//ԭʼ���ģ��ڻ�ȡ�������ʱ����
public:
	bool CheckAuth();											//��֤�����Ƿ�Ϊ��ȷ����
	bool CheckPwd();											//��֤����

	void GenerateAuthText();									//�����������
private:
	wstring Utf82Unicode(const string& utf8string);
	string WideByte2Acsi(const wstring& wstrcode);
	wstring Acsi2WideByte(const string& strascii);
	string Unicode2Utf8(const wstring& widestring);
	string ASCII2UTF8(const string& strAsciiCode);
	string UTF8ToAscall(const string& strUtf8Code);

public: 
	NewRegisterInfo()
	{
		m_strKey = "";
		m_strSerialNum = "";
		m_strAutonClearText = "";
		m_strCipherText = "";
	}

private:

};

//������Ϣ�ṹ
class DataInfoStructor
{
public:
	int iProtocolType;
	int iProtocolSubType;
	NewRegisterInfo* m_pRegisterInfo;
	//char* data;//�˴�Ϊ��Ҫֱ�Ӵ���memcache�����ݰ�������Ҫ��ѹ
	char data[RECV_BUF_LEN * 8];
	int iLen;

public:
	DataInfoStructor()
	{
		memset(data, 0, sizeof(data));
	}
	~DataInfoStructor()
	{
		//if(data != NULL)
		//{
		//	delete [] data;
		//}
	}
};

class ConvertCode
{
public:
	static void unicodeToUTF8(const wstring &src, string& result)
	{
		int n = WideCharToMultiByte( CP_UTF8, 0, src.c_str(), -1, 0, 0, 0, 0 );
		result.resize(n);
		::WideCharToMultiByte( CP_UTF8, 0, src.c_str(), -1, (char*)result.c_str(), result.length(), 0, 0 );
	}

	static void unicodeToGB2312(const wstring& wstr , string& result)
	{
		int n = WideCharToMultiByte( CP_ACP, 0, wstr.c_str(), -1, 0, 0, 0, 0 );
		result.resize(n);
		::WideCharToMultiByte(CP_ACP, 0, wstr.c_str(), -1, (char*)result.c_str(), n, 0, 0 );
	}

	static void utf8ToUnicode(const string& src, wstring& result)
	{
		int n = MultiByteToWideChar( CP_UTF8, 0, src.c_str(), -1, NULL, 0 );
		result.resize(n);
		::MultiByteToWideChar( CP_UTF8, 0, src.c_str(), -1, (LPWSTR)result.c_str(), result.length());
	}

	static void gb2312ToUnicode(const string& src, wstring& result)
	{
		int n = MultiByteToWideChar( CP_ACP, 0, src.c_str(), -1, NULL, 0 );
		result.resize(n);
		::MultiByteToWideChar( CP_ACP, 0, src.c_str(), -1, (LPWSTR)result.c_str(), result.length());
	}

	static void printByte(string str)
	{
		int i=0;
		for (i=0; i<str.length(); i++)
		{
			printf("%X ",(unsigned char)str.at(i));
		}
		printf("\n");
	}

	//UTF-8��GB2312��ת��
	static char* U2G(const char* utf8)
	{
		int len = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
		wchar_t* wstr = new wchar_t[len+1];
		memset(wstr, 0, len+1);
		MultiByteToWideChar(CP_UTF8, 0, utf8, -1, wstr, len);
		len = WideCharToMultiByte(CP_ACP, 0, wstr, -1, NULL, 0, NULL, NULL);
		char* str = new char[len+1];
		memset(str, 0, len+1);
		WideCharToMultiByte(CP_ACP, 0, wstr, -1, str, len, NULL, NULL);
		if(wstr) delete[] wstr;
		return str;
	}

	//GB2312��UTF-8��ת��
	static char* G2U(const char* gb2312)
	{
		int len = MultiByteToWideChar(CP_ACP, 0, gb2312, -1, NULL, 0);
		wchar_t* wstr = new wchar_t[len+1];
		memset(wstr, 0, len+1);
		MultiByteToWideChar(CP_ACP, 0, gb2312, -1, wstr, len);
		len = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL, NULL);
		char* str = new char[len+1];
		memset(str, 0, len+1);
		WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, len, NULL, NULL);
		if(wstr) delete[] wstr;
		return str;
	}

};

class AES
{
public:
	typedef enum ENUM_KeySize_
	{
		BIT128 = 0,
		BIT192,
		BIT256
	}ENUM_KEYSIZE;
public:
	AES( ENUM_KEYSIZE keysize, BYTE *key );
	~AES(void);
	void Cipher( BYTE *input, BYTE *output );
	void InvCipher( BYTE *input, BYTE *output );
protected:
	BYTE *RotWord( BYTE *word );
	BYTE *SubWord( BYTE *word );
	void AddRoundKey(int round);
	void SubBytes();
	void InvSubBytes();
	void ShiftRows();
	void InvShiftRows();
	void MixColumns();
	void InvMixColumns();
	 static BYTE gfmultby01(BYTE b)
    {
      return b;
    }

    static BYTE gfmultby02(BYTE b)
    {
      if (b < 0x80)
        return (BYTE)(int)(b <<1);
      else
        return (BYTE)( (int)(b << 1) ^ (int)(0x1b) );
    }

    static BYTE gfmultby03(BYTE b)
    {
      return (BYTE) ( (int)gfmultby02(b) ^ (int)b );
    }

    static BYTE gfmultby09(BYTE b)
    {
      return (BYTE)( (int)gfmultby02(gfmultby02(gfmultby02(b))) ^
                     (int)b );
    }

    static BYTE gfmultby0b(BYTE b)
    {
      return (BYTE)( (int)gfmultby02(gfmultby02(gfmultby02(b))) ^
                     (int)gfmultby02(b) ^
                     (int)b );
    }

    static BYTE gfmultby0d(BYTE b)
    {
      return (BYTE)( (int)gfmultby02(gfmultby02(gfmultby02(b))) ^
                     (int)gfmultby02(gfmultby02(b)) ^
                     (int)(b) );
    }

    static BYTE gfmultby0e(BYTE b)
    {
      return (BYTE)( (int)gfmultby02(gfmultby02(gfmultby02(b))) ^
                     (int)gfmultby02(gfmultby02(b)) ^
                     (int)gfmultby02(b) );
    }
	int Nb;
	int Nk;
	int Nr;
	BYTE *key;// the seed key. size will be 4 * keySize from ctor.
	typedef struct BYTE4_
	{
		BYTE w[4];
	}BYTE4;
	BYTE4 *w;
	LPBYTE State[4];
	/*
    private byte[,] iSbox;  // inverse Substitution box 
    private byte[,] w;      // key schedule array. 
    private byte[,] Rcon;   // Round constants.
    private byte[,] State;  // State matrix
	*/

};

const int WAITTIMEOUT = 5;	//��ʱʱ�䣬����Ϊ��λ��ָ�·�����ȴ������أ���ʱδ������ʧ�ܴ���