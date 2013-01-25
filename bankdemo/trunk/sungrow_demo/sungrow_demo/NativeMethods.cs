// 功能：定义NativeMethods类
// 描述：
// 编码：温伟鹏
// 日期：2009-03-15 10:37:20

using System;
using System.Runtime.InteropServices;
using System.Drawing;
using sungrow_demo;

namespace SharpPlatform.GeDemo
{
    public struct COPYDATASTRUCT
    {
        public IntPtr dwData;
        public int cbData;
        [MarshalAs(UnmanagedType.LPStr)]
        public string lpData;
    } 

    /// <summary>
    /// 定义一个类型为<see cref="NativeMethods"/>的类
    /// </summary>
    public class NativeMethods
    {


        //进程间通信
        public const int WM_COPYDATA = 0x004A;
        /// <summary>
        /// add by
        /// </summary>
        /// <param name="hWnd"></param>
        /// <param name="Msg"></param>
        /// <param name="wParam"></param>
        /// <param name="lParam"></param>
        /// <returns></returns>
        [DllImport("User32.dll ", EntryPoint = "SendMessage")]
        public static extern int SendMessage(
        int hWnd,   //   handle   to   destination   window 
        int Msg,   //   message 
        int wParam,   //   first   message   parameter 
        ref   COPYDATASTRUCT lParam   //   second   message   parameter 
        );

        /// <summary>
        /// add by qianhb 查找窗体
        /// </summary>
        /// <param name="lpClassName"></param>
        /// <param name="lpWindowName"></param>
        /// <returns></returns>
        [DllImport("User32.dll ", EntryPoint = "FindWindow")]
        public static extern int FindWindow(string lpClassName, string
        lpWindowName); 



        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x, int y, int cx, int cy, UInt32 uflags);

        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr PostMessage(IntPtr hWnd, int msg, int wParam, int lParam);
        //[DllImport("user32.dll", CharSet = CharSet.Auto)] 
        //public static extern IntPtr PostMessage(int hWnd, int msg, int wParam, int lParam);
        [DllImport("user32.dll")]
        public static extern int SendMessage(IntPtr hWnd, uint Msg, int wParam, int lParam);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int GetMessage(out MSG msg, IntPtr hWnd, int wMsgFilterMin, int wMsgFilterMax);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int PeekMessage(out MSG msg, IntPtr hWnd, int wMsgFilterMin, int wMsgFilterMax);
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern long DispatchMessage(MSG msg);
        /// <summary>
        /// 查找窗口句柄
        /// </summary>
        /// <param name="className">窗口类名</param>
        /// <param name="windowTitle">窗口标题</param>
        /// <returns></returns>
        //[DllImport("user32.dll")]
        //public static extern IntPtr FindWindow(string className, string windowTitle);
        [DllImport("user32.dll")]
        public static extern bool ShowWindowAsync(int hWnd, int nCmdShow);
        /// <summary>
        /// 获取窗口的矩形
        /// </summary>
        /// <param name="hWnd"></param>
        /// <param name="rect"></param>
        /// <returns></returns>
        [DllImport("user32.dll")]
        public static extern bool GetWindowRect(IntPtr hWnd, out RECT rect);
        /// <summary>
        /// 获取客户端矩形
        /// </summary>
        /// <param name="hWnd"></param>
        /// <param name="rect"></param>
        /// <returns></returns>
        [DllImport("user32.dll")]
        public static extern bool GetClientRect(IntPtr hWnd, out RECT rect);
        /// <summary>
        /// 获取桌面的句柄
        /// </summary>
        /// <returns></returns>
        [DllImport("user32.dll")]
        public static extern IntPtr GetDesktopWindow();
        /// <summary>
        /// 根据句柄获取Window HDC
        /// </summary>
        /// <param name="hwnd">窗口句柄</param>
        /// <returns></returns>
        [DllImport("user32")]
        public static extern IntPtr GetWindowDC(IntPtr hwnd);
        /// <summary>
        /// 根据句柄获取DC
        /// </summary>
        /// <param name="hwnd"></param>
        /// <returns></returns>
        [DllImport("user32")]
        public static extern IntPtr GetDC(IntPtr hwnd);
        /// <summary>
        /// 释放HDC
        /// </summary>
        /// <param name="handle"></param>
        /// <param name="hdc"></param>
        /// <returns></returns>
        [DllImport("user32")]
        public static extern long ReleaseDC(IntPtr handle, IntPtr hdc);
        /// <summary>
        /// 根据鼠标指针所在位置，得到窗口句柄
        /// </summary>
        /// <param name="point"></param>
        /// <returns></returns>
        [DllImport("user32")]
        public static extern IntPtr WindowFromPoint(Point point);
        /// <summary>
        /// 截取窗口图像
        /// </summary>
        /// <param name="hWnd">要进行截图的窗口句柄</param>
        /// <param name="hdcBlt">要将图像写入的HDC</param>
        /// <param name="nFlags">可选参数。定义绘图选项。PW_CLIENTONLY</param>
        /// <returns></returns>
        [DllImport("user32")]
        public static extern bool PrintWindow(IntPtr hWnd, IntPtr hdcBlt, UInt32 nFlags);
        /// <summary>
        /// 关闭句柄
        /// </summary>
        /// <param name="hObject"></param>
        /// <returns></returns>
        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool CloseHandle(IntPtr hObject);

        #region 预定义

        public static readonly IntPtr HWND_BOTTOM = new IntPtr(1);
        public static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);
        public static readonly IntPtr HWND_TOP = new IntPtr(0);
        public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
        public static readonly UInt32 SWP_NOSIZE = 1;
        public static readonly UInt32 SWP_NOMOVE = 2;
        public static readonly UInt32 SWP_NOZORDER = 4;
        public static readonly UInt32 SWP_NOREDRAW = 8;
        public static readonly UInt32 SWP_NOACTIVATE = 16;
        public static readonly UInt32 SWP_FRAMECHANGED = 32;
        public static readonly UInt32 SWP_SHOWWINDOW = 64;
        public static readonly UInt32 SWP_HIDEWINDOW = 128;
        public static readonly UInt32 SWP_NOCOPYBITS = 256;
        public static readonly UInt32 SWP_NOOWNERZORDER = 512;
        public static readonly UInt32 SWP_NOSENDCHANGING = 1024;
        public static readonly int WM_COMMAND = 0x0112;
        public static readonly int WM_QT_PAINT = 0xC2DC;
        public static readonly int WM_PAINT = 0x000F;
        public static readonly int WM_SIZE = 0x0005;

        #endregion

        public delegate int EnumWindowsProc(IntPtr hwnd, int lParam);

        [DllImport("user32", CharSet = CharSet.Auto)]
        public extern static IntPtr GetParent(IntPtr hWnd);

        [DllImport("user32", CharSet = CharSet.Auto)]
        public extern static bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

        [DllImport("user32", CharSet = CharSet.Auto)]
        public extern static IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);

        [DllImport("user32.dll", ExactSpelling = true, CharSet = CharSet.Auto)]
        public static extern IntPtr GetWindow(IntPtr hWnd, int uCmd);

        public static int GW_CHILD = 5;
        public static int GW_HWNDNEXT = 2;

        #region GDI绘图函数
        /// <summary>
        /// 根据句柄创建内存DC
        /// </summary>
        /// <param name="hwnd"></param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateCompatibleDC(IntPtr hwnd);
        /// <summary>
        /// 创建内存图像句柄
        /// </summary>
        /// <param name="hdc">DC句柄</param>
        /// <param name="nWidht">图像宽度</param>
        /// <param name="nHeight">图像高度</param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateCompatibleBitmap(IntPtr hdc, int nWidht, int nHeight);
        /// <summary>
        /// 
        /// </summary>
        /// <param name="hdc"></param>
        /// <param name="hgdiobj"></param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern IntPtr SelectObject(IntPtr hdc, IntPtr hgdiobj);
        /// <summary>
        /// 删除DC。释放资源
        /// </summary>
        /// <param name="hdc">DC句柄</param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern int DeleteDC(IntPtr hdc);
        /// <summary>
        /// 创建DC
        /// </summary>
        /// <param name="lpszDriver">驱动名</param>
        /// <param name="lpszDevice">设备名</param>
        /// <param name="lpszOutput">未用到。NULL</param>
        /// <param name="lpInitData">可选的打印数据</param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern IntPtr CreateDC(string lpszDriver, string lpszDevice, string lpszOutput, IntPtr lpInitData);
        /// <summary>
        /// API函数BitBlt
        /// </summary>
        /// <param name="hdcDest">DC目标设备句柄</param>
        /// <param name="nXDest">目标对象的左上角X坐标</param>
        /// <param name="nYDest">目标对象的左上角Y坐标</param>
        /// <param name="nWidth">目标对象的矩形宽度</param>
        /// <param name="nHeight">目标对象的矩形高度</param>
        /// <param name="hdcSrc">DC源设备句柄</param>
        /// <param name="nXSrc">源对象的左上角X坐标</param>
        /// <param name="nYSrc">源对象的左上角Y坐标</param>
        /// <param name="dwRop">光栅操作值</param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern int BitBlt(IntPtr hdcDest, int nXDest, int nYDest, int nWidth, int nHeight, IntPtr hdcSrc, int nXSrc, int nYSrc, int dwRop);
        /// <summary>
        /// 使用当前选定的画笔和画刷进行矩形的绘制
        /// </summary>
        /// <param name="hdc">DC句柄</param>
        /// <param name="nLeftRect">左上角x坐标</param>
        /// <param name="nTopRect">左上角y坐标</param>
        /// <param name="nRightRect">右下角x坐标</param>
        /// <param name="nBottomRect">右下角y坐标</param>
        /// <returns></returns>
        [DllImport("gdi32.dll")]
        public static extern bool Rectangle(IntPtr hdc, int nLeftRect, int nTopRect, int nRightRect, int nBottomRect);


        #region Raster operation（BitBlt函数最后一个参数）
        /// <summary>
        /// 以黑色填充目标矩形区域。
        /// </summary>
        public static int RP_BLACKNESS = 0x42;
        /// <summary>
        /// 先将源矩形图像与目标矩形图像进行布尔“或”运算，然后再将图像进行反相。
        /// </summary>
        public static int RP_NOTSRCERASE = 0x001100A6;
        /// <summary>
        /// 将源矩形图像进行反相，复制到目标矩形上。
        /// </summary>
        public static int RP_NOTSRCCOPY = 0x330008;
        /// <summary>
        /// 将目标矩形图像进行反相.
        /// </summary>
        public static int RP_DSTINVERT = 0x550009;
        /// <summary>
        /// 将源矩形图像进行反相，与目标矩形图像进行布尔“或”运算。
        /// </summary>
        public static int RP_MERGEPAINT = 0x0BB0226;
        /// <summary>
        /// 将源矩形图像与指定的图案刷（Pattern）进行布尔“与”运算
        /// </summary>
        public static int RP_MERGECOPY = 0x00C000CA;
        /// <summary>
        /// 将源矩形图像与目标矩形图像进行布尔“与”运算。
        /// </summary>
        public static int RP_SRCAND = 0x008800C6;
        /// <summary>
        /// 将目标矩形图像直接复制到目标矩形。
        /// </summary>
        public static int RP_SRCCOPY = 0x00CC0020;
        /// <summary>
        /// 将目标矩形图像进行反相，再与源矩形图像进行布尔“与”运算。
        /// </summary>
        public static int RP_SRCERASE = 0x440328;
        /// <summary>
        /// 将源矩形图像与目标矩形图像进行布尔“或”运算。
        /// </summary>
        public static int RP_SRCPAINT = 0x00EE0086;
        /// <summary>
        /// 将源矩形图像与目标矩形图像进行布尔“异或”运算。
        /// </summary>
        public static int RP_SRCINVERT = 0x660046;
        /// <summary>
        /// 将指定的图案刷复制到目标矩形上。
        /// </summary>
        public static int RP_PATCOPY = 0x00F00021;
        /// <summary>
        /// 将指定的图案刷与目标矩形图像进行布尔“异或”运算。
        /// </summary>
        public static int RP_PATINVERT = 0x005A0049;
        /// <summary>
        /// 先将源矩形图像进行反相，与指定的图案刷进行布尔“或”运算，再与目标矩形图像进行布尔“或”运算
        /// </summary>
        public static int RP_PATPAINT = 0x00FB0A09;
        /// <summary>
        /// 用白色填充矩形区域。
        /// </summary>
        public static int RP_WHITENESS = 0x00FF0062;
        #endregion

        #endregion
    }
}
