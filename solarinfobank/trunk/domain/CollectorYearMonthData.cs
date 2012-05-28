using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：采集器年月发电量
    /// 创建时间：2011-02-25
    /// </summary>
    /// 
    [Serializable]
    public class CollectorYearMonthData : BaseLocalTime
    {
        public CollectorYearMonthData() { this.localAcceptTime = DateTime.MinValue; }

        public int id { get; set; }  //电站Id 主键 非空
        public int collectorID { get; set; } //电站Id 非空
        public int year { get; set; } //年份 非空
        public float? m_1 { get; set; }//一月 可空
        public float? m_2 { get; set; }//二月 可空
        public float? m_3 { get; set; }//三月 可空
        public float? m_4 { get; set; }//四月 可空
        public float? m_5 { get; set; }//五月 可空
        public float? m_6 { get; set; }//六月 可空
        public float? m_7 { get; set; }//七月 可空
        public float? m_8 { get; set; }//八月 可空
        public float? m_9 { get; set; }//九月 可空
        public float? m_10 { get; set; }//十月 可空
        public float? m_11 { get; set; }//十一月 可空
        public float? m_12 { get; set; }//十二月 可空

        /// <summary>
        /// 非持久化属性
        /// </summary>
        public int curMonth { get; set; }               //当前月

        /// <summary>
        /// 最后总发电量，用于缓存丢失后修正发电量数据
        /// </summary>
        public float lastTotalEnergy { get; set; }
        /// <summary>
        /// 统计所有月份
        /// </summary>
        /// <returns></returns>
        public float count()
        {
            float? cvalue = (this.m_1 == null ? 0 : this.m_1) +
                (this.m_2 == null ? 0 : this.m_2) +
                (this.m_3 == null ? 0 : this.m_3) +
                (this.m_4 == null ? 0 : this.m_4) +
                (this.m_5 == null ? 0 : this.m_5) +
                (this.m_6 == null ? 0 : this.m_6) +
                (this.m_7 == null ? 0 : this.m_7) +
                (this.m_8 == null ? 0 : this.m_8) +
                (this.m_9 == null ? 0 : this.m_9) +
                (this.m_10 == null ? 0 : this.m_10) +
                (this.m_11 == null ? 0 : this.m_11) +
                (this.m_12 == null ? 0 : this.m_12);
            return float.Parse(cvalue.ToString());
        }


        /// <summary>
        /// 统计指定月份
        /// </summary>
        /// <returns></returns>
        public float count(int m, int m1)
        {
            float returnValue=0;

            for (int x = m; x <= m1; x++)
            {
                float ftemp=0;
                string valueStr=string.Empty;
                object value = ReflectionUtil.getProperty(this, string.Format("m_{0}", x));
                valueStr=value==null?"0":value.ToString();
                float.TryParse(valueStr, out ftemp);
                returnValue += ftemp;
            }
            return returnValue;
        }

    }
}
