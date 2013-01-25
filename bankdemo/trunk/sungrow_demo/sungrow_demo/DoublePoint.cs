// 功能：定义DoublePoint类
// 描述：
// 编码：温伟鹏
// 日期：2009-03-01 1:09:32

using System;

namespace sungrow_demo
{
    /// <summary>
    /// 定义一个类型为<see cref="DoublePoint"/>的类
    /// <remarks>
    /// 坐标为Double类型的点.用来定义Google Earth的坐标系
    /// Google Earth坐标系，地图中心为(0,0)，左上角为(-1,1),右上角为(1,1),左下角(-1,-1),右下角(1,-1)
    /// </remarks>
    /// </summary>
    public class DoublePoint
    {
        #region 私有变量
        private double x;
        private double y;
        #endregion

        #region 公共属性
        /// <summary>
        /// 获取或设置点的X坐标
        /// </summary>
        public double X
        {
            get { return this.x; }
            set { this.x = value; }
        }
        /// <summary>
        /// 获取或设置点的Y坐标
        /// </summary>
        public double Y
        {
            get { return this.y; }
            set { this.y = value; }
        }
        #endregion

        #region 构造函数

        public DoublePoint()
        {
            x = -1;
            y = -1;
        }

        public DoublePoint(double dx, double dy)
        {
            x = dx;
            y = dy;
        }
        #endregion
    }
}
