// 功能：定义POINT类
// 描述：
// 编码：温伟鹏
// 日期：2009-03-15 10:38:17

using System;
using System.Runtime.InteropServices;

namespace sungrow_demo
{
    /// <summary>
    /// 定义一个类型为<see cref="POINT"/>的类
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public class POINT
    {
        public int x;
        public int y;

        public POINT()
        {
        }

        public POINT(int x, int y)
        {
            this.x = x;
            this.y = y;
        }
    }
}
