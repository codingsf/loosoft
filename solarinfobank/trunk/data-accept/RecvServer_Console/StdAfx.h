// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__6217AA24_8E6E_43A2_8038_1B9BEF6D8644__INCLUDED_)
#define AFX_STDAFX_H__6217AA24_8E6E_43A2_8038_1B9BEF6D8644__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#include <afx.h>
#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#include <iostream>
#include<vector>
#pragma warning(disable:4018)
#pragma warning(disable:4996)

#include "winsock2.h"
#pragma comment(lib,"ws2_32.lib")

#include "MySQLUtil.h"
#include "map"
#include "queue"
#include <string>
using namespace std;

//声明Send2DLL里的函数原型
typedef  BOOL (*PFUN_INIT)(char *);
typedef  void (*PFUN_UNINIT)();
typedef  int (*PFUN_SEND2MC)(char *,char *);
typedef  void (*PFUN_SEND2Dll)(int,char *,char *);


// TODO: reference additional headers your program requires here

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__6217AA24_8E6E_43A2_8038_1B9BEF6D8644__INCLUDED_)
