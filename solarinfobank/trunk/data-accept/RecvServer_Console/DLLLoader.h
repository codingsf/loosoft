// DLLLoader.h: interface for the DLLLoader class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DLLLOADER_H__824288FD_1C35_4CA2_A78A_B25AA6138DD3__INCLUDED_)
#define AFX_DLLLOADER_H__824288FD_1C35_4CA2_A78A_B25AA6138DD3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class DLLLoader  
{
public:
	PFUN_INIT pInit;
	PFUN_UNINIT pUnInit;
	PFUN_SEND2MC pSend2MC;
	PFUN_SEND2Dll pSend2Dll;

	//BEGIN:add by bloodhunter for new protocol at 2012-3-23
	PFUN_SEND2MC pReadFromMC;
	PFUN_INIT     pRemoveFromMC;
	PFUN_SEND2MC pAppend2MC;
	PFUN_INIT pIsExistKey; 
	//END:add by bloodhunter for new protocol at 2012-3-23


	DLLLoader();
	virtual ~DLLLoader();

	

private:
	HMODULE hDll;
	HMODULE hAesDll;
	char strMCServer[50];
};

#endif // !defined(AFX_DLLLOADER_H__824288FD_1C35_4CA2_A78A_B25AA6138DD3__INCLUDED_)
