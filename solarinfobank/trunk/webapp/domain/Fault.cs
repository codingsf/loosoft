﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 告警日志类
    /// Author: 赵文辉
    /// Time: 2011年2月17日 11:34:33
    /// </summary>
    [Serializable]

    public class Fault
    {
        #region Model
        //编号  非空
        public int id { get; set; }
        //采集器Id  非空
        public int collectorID { get; set; }
        //地址  非空
        public string address { get; set; }
        /// <summary>
        /// 设备
        /// </summary>
        private Device _device;
        public Device device
        {
            get
            {
                return _device;
            }
            set
            {
                _device = value;
            }
        }
        //告警信息代码  非空
        public int errorCode { get; set; }
        //告警类型  非空
        public int errorTypeCode { get; set; }
        //状态数据1  可空
        public int? data1 { get; set; }
        //状态数据2  可空
        public int? data2 { get; set; }
        //发送时间  非空
        public DateTime sendTime { get; set; }
        public bool confirm { get; set; }
        #endregion Model


        //告警信息代码  非持久化
        public string inforank { get; set; }
        public string collectorString { get; set; }//chenbo added

        //告警类型名称
        public string errorTypeName
        {
            get
            {
                return ErrorType.getErrortypeByCode(this.errorTypeCode).name;
            }
        }
        //告警类型名称
        public string deviceName
        {
            get
            {
                return device.fullName;
            }
        }

        //信息内容  非空
        public string content
        {
            get
            {
                ErrorItem error = ErrorItem.getErrotItemByCode(this.errorCode);
                if (error != null)
                {
                    return error.name;
                }
                return LanguageUtil.getDesc("UNKNOWN");
            }
        }

        //是否确认  非空
        public string confirmed { get; set; }

        public int year
        {
            get
            {
                return sendTime.Year;
            }
        }//表名标示字符


        //数据一描述
        public string data1Desc
        {
            get
            {
                return data1 == null ? "--" : data1.ToString();
            }
        }

        //数据一描述
        public string data2Desc
        {
            get
            {
                return data2 == null ? "--" : data2.ToString();
            }
        }

        public string plantName
        {
            get
            {
                if (device != null && device.plantUnit != null && device.plantUnit.plant != null)
                    return this.device.plantUnit.plant.name;
                return "";
            }
        }

        public string unitName
        {
            get
            {
                if (device != null && device.plantUnit != null)
                return this.device.plantUnit.displayname;
                return string.Empty;
            }
        }

    }
}
