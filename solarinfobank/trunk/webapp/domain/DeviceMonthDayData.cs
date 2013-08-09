using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：设备各测点月天数据统计
    /// 作者：张月
    /// 时间：2011年2月17日 14:47:45
    /// </summary>
    [Serializable]

    public class DeviceMonthDayData : BaseLocalTime
    {
        /// <summary>
        /// 无参构造函数
        /// </summary>
        public DeviceMonthDayData() { }

        public int id { get; set; }                  //Id
        public int deviceID { get; set; }             //设备ID
        public int month { get; set; }               //月份
        public float? d_1 { get; set; }               //1号发电量             
        public float? d_2 { get; set; }               //2号发电量
        public float? d_3 { get; set; }               //3号发电量
        public float? d_4 { get; set; }               //4号发电量
        public float? d_5 { get; set; }               //5号发电量
        public float? d_6 { get; set; }               //6号发电量
        public float? d_7 { get; set; }               //7号发电量
        public float? d_8 { get; set; }               //8号发电量
        public float? d_9 { get; set; }               //9号发电量
        public float? d_10 { get; set; }              //10号发电量
        public float? d_11 { get; set; }              //11号发电量
        public float? d_12 { get; set; }              //12号发电量
        public float? d_13 { get; set; }              //13号发电量
        public float? d_14 { get; set; }              //14号发电量
        public float? d_15 { get; set; }              //15号发电量
        public float? d_16 { get; set; }              //16号发电量
        public float? d_17 { get; set; }              //17号发电量
        public float? d_18 { get; set; }              //18号发电量
        public float? d_19 { get; set; }              //19号发电量
        public float? d_20 { get; set; }              //20号发电量
        public float? d_21 { get; set; }              //21号发电量
        public float? d_22 { get; set; }              //22号发电量
        public float? d_23 { get; set; }              //23号发电量
        public float? d_24 { get; set; }              //24号发电量
        public float? d_25 { get; set; }              //25号发电量
        public float? d_26 { get; set; }              //26号发电量
        public float? d_27 { get; set; }              //27号发电量
        public float? d_28 { get; set; }              //28号发电量
        public float? d_29 { get; set; }              //29号发电量
        public float? d_30 { get; set; }              //30号发电量
        public float? d_31 { get; set; }              //31号发电量
        public float lastTotalEnergy { get; set; }    //最后总发电量，用于缓存丢失后修正发电量数据

        /// <summary>
        /// 非持久化属性，用于识别保存的天
        /// </summary>
        public int curDay { get; set; }               //当前天

        /// <summary>
        /// 非持久化属性
        /// </summary>
        public int year { get; set; }               //年度
        /// <summary>
        /// 统计本月纵电量
        /// </summary>
        /// <returns></returns>
        public float count()
        {
            float? cvalue = (this.d_1 == null ? 0 : this.d_1) + (this.d_2 == null ? 0 : this.d_2) +
                           (this.d_3 == null ? 0 : this.d_3) + (this.d_4 == null ? 0 : this.d_4) +
                           (this.d_5 == null ? 0 : this.d_5) + (this.d_6 == null ? 0 : this.d_6) +
                           (this.d_7 == null ? 0 : this.d_7) + (this.d_8 == null ? 0 : this.d_8) +
                           (this.d_9 == null ? 0 : this.d_9) + (this.d_10 == null ? 0 : this.d_10) +
                           (this.d_11 == null ? 0 : this.d_11) + (this.d_12 == null ? 0 : this.d_12) +
                           (this.d_13 == null ? 0 : this.d_13) + (this.d_14 == null ? 0 : this.d_14) +
                           (this.d_15 == null ? 0 : this.d_15) + (this.d_16 == null ? 0 : this.d_16) +
                           (this.d_17 == null ? 0 : this.d_17) + (this.d_18 == null ? 0 : this.d_18) +
                           (this.d_19 == null ? 0 : this.d_19) + (this.d_20 == null ? 0 : this.d_20) +
                           (this.d_21 == null ? 0 : this.d_21) + (this.d_22 == null ? 0 : this.d_22) +
                           (this.d_23 == null ? 0 : this.d_23) + (this.d_24 == null ? 0 : this.d_24) +
                           (this.d_25 == null ? 0 : this.d_25) + (this.d_26 == null ? 0 : this.d_26) +
                           (this.d_27 == null ? 0 : this.d_27) + (this.d_28 == null ? 0 : this.d_28) +
                           (this.d_29 == null ? 0 : this.d_29) + (this.d_30 == null ? 0 : this.d_30) +
                           (this.d_31 == null ? 0 : this.d_31);
            return StringUtil.stringtoFloat(cvalue.ToString());
        }


        public float count(int dd, int dd1)
        {

            float returnValue = 0;

            for (int x = dd; x <= dd1; x++)
            {
                float ftemp = 0;
                string valueStr = string.Empty;
                object value = ReflectionUtil.getProperty(this, string.Format("d_{0}", x));
                valueStr = value == null ? "0" : value.ToString();
                float.TryParse(valueStr, out ftemp);
                returnValue += ftemp;
            }
            return returnValue;
        }
        /// <summary>
        /// 取得某个天的数据
        /// </summary>
        /// <param name="month"></param>
        /// <returns></returns>
        public float getDayData(int day)
        {
            object value = ReflectionUtil.getProperty(this, string.Format("d_{0}", day));
            return value == null ? 0 : (float)value;
        }


    }
}
