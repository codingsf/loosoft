// 功能：定义MSG结构
// 描述：
// 编码：温伟鹏
// 日期：2009-03-15 10:37:55

using System;
using System.Runtime.InteropServices;

namespace sungrow_demo
{
    /// <summary>
    /// 定义一个类型为<see cref="MSG"/>的结构
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct MSG
    {
        public IntPtr HWND;

        public uint MESSAGE;

        public IntPtr WPARAM;

        public IntPtr LPARAM;

        public long Time;

        public POINT PT;
    }
}
