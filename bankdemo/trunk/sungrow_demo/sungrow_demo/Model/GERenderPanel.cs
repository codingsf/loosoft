// 功能：定义GERenderPanel对象
// 描述：用来呈现GE地图的控件
// 编码：温伟鹏
// 日期：2009-03-15 10:37:20

using System;
using System.Windows.Forms;
using sungrow_demo;

namespace SharpPlatform.GeDemo
{
    /// <summary>
    /// 用来呈现GE地图的控件
    /// </summary>
    public class GERenderPanel:Panel
    {
        #region 构造函数
        public GERenderPanel() { }
        #endregion

        #region 函数
        /// <summary>
        /// 根据鼠标指针坐标获取GoogleEarth的坐标
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <returns></returns>
        public DoublePoint DetermineScreenCoordinates(double x, double y)
        {
            DoublePoint dptScreen = new DoublePoint(-2, -2);
            try
            {
                double screenX = x - this.Location.X;
                double screenY = y - this.Location.Y;
                double midX = this.Width / 2;
                double midY = this.Height / 2;
                double outX = 0.0;
                double outY = 0.0;


                if (screenX < midX)
                {
                    dptScreen.X = ((screenX / midX) - 1);
                    outX = (screenX / midX) - 1;
                }
                else if (screenX > midX)
                {
                    dptScreen.X = ((screenX - midX) / midX);
                    outX = (screenX - midX) / midX;
                }
                else if (screenX == midX)
                    dptScreen.X = (0.0);


                if (screenY < midY)
                {
                    dptScreen.Y = (1 - (screenY / midY));
                    outY = 1 - (screenY / midY);
                }
                else if (screenY > midY)
                {
                    dptScreen.Y = (((this.Height - screenY) / midY) - 1);
                    outY = ((this.Height - screenY) / midY) - 1;
                }
                else if (screenY == midY)
                {
                    dptScreen.Y = (0.0);
                }

                return dptScreen;
            }
            catch
            {
                return dptScreen;
            }
        }
        #endregion
    }
}
