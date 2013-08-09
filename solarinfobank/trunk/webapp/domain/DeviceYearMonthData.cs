/*******************************
/* 项目：逆变器年度发电量数据
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月01日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{

    /// <summary>
    /// 设备各测点年月数据统计
    /// </summary>
    [Serializable]
    public class DeviceYearMonthData : BaseLocalTime
    {
        public DeviceYearMonthData()
        {
            this.localAcceptTime = DateTime.MinValue;
        }
        #region Model
        /// <summary>
        /// auto_increment
        /// </summary>
        public int id { get; set; }
        public int deviceID { get; set; }
        public int year { get; set; }
        /// <summary>
        /// 2月发电量        
        /// </summary>
        public float? m_1 { get; set; }
        /// <summary>
        /// 3月发电量        
        /// </summary>
        public float? m_2 { get; set; }
        /// <summary>
        /// 4月发电量        
        /// </summary>
        public float? m_3 { get; set; }
        /// <summary>
        /// 5月发电量        
        /// </summary>
        public float? m_4 { get; set; }
        /// <summary>800901781106q
        /// 1月发电量        
        /// </summary>
        public float? m_5 { get; set; }
        /// <summary>
        /// 6月发电量        
        /// </summary>
        public float? m_6 { get; set; }
        /// <summary>
        /// 7月发电量        
        /// </summary>
        public float? m_7 { get; set; }
        /// <summary>
        /// 8月发电量        
        /// </summary>
        public float? m_8 { get; set; }
        /// <summary>
        /// 9月发电量        
        /// </summary>
        public float? m_9 { get; set; }
        /// <summary>
        /// 10月发电量        
        /// </summary>
        public float? m_10 { get; set; }
        /// <summary>
        /// 11月发电量        
        /// </summary>
        public float? m_11 { get; set; }
        /// <summary>
        /// 12月发电量        
        /// </summary>
        public float? m_12 { get; set; }
        /// <summary>
        /// 最后总发电量，用于缓存丢失后修正发电量数据
        /// </summary>
        public float lastTotalEnergy { get; set; }

        /// <summary>
        /// 非持久化属性
        /// </summary>
        public int curMonth { get; set; }               //当前月
        #endregion Model

        /// <summary>
        /// 统计所有月份
        /// </summary>
        /// <returns></returns>
        public float count()
        {
            float? cvalue = (this.m_1 == null ? 0 : this.m_1) + (this.m_2 == null ? 0 : this.m_2) +
                          (this.m_3 == null ? 0 : this.m_3) + (this.m_4 == null ? 0 : this.m_4) +
                          (this.m_5 == null ? 0 : this.m_5) + (this.m_6 == null ? 0 : this.m_6) +
                          (this.m_7 == null ? 0 : this.m_7) + (this.m_8 == null ? 0 : this.m_8) +
                          (this.m_9 == null ? 0 : this.m_9) + (this.m_10 == null ? 0 : this.m_10) +
                          (this.m_11 == null ? 0 : this.m_11) + (this.m_12 == null ? 0:this.m_12);
            return StringUtil.stringtoFloat(cvalue.ToString());
        }    
        
        public float count(int m ,int m1)
        {
            float returnValue = 0;

            for (int x = m; x <= m1; x++)
            {
                float ftemp = 0;
                string valueStr = string.Empty;
                object value = ReflectionUtil.getProperty(this, string.Format("m_{0}", x));
                valueStr = value == null ? "0" : value.ToString();
                float.TryParse(valueStr, out ftemp);
                returnValue += ftemp;
            }
            return returnValue;
        }
        /// <summary>
        /// 取得某个月份的数据
        /// </summary>
        /// <param name="month"></param>
        /// <returns></returns>
        public float getMonthData(int month) {
            object value = ReflectionUtil.getProperty(this, string.Format("m_{0}", month));
            return value==null?0:(float)value;
        }
    }
}
