// 功能：定义RECT类
// 描述：
// 编码：温伟鹏
// 日期：2009-03-15 10:45:11

using System;
using System.Runtime.InteropServices;

namespace sungrow_demo
{
    /// <summary>
    /// 定义一个类型为<see cref="RECT"/>的类
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT
    {
        public int X;
        public int Y;
        public int Width;
        public int Height;
    }
}
