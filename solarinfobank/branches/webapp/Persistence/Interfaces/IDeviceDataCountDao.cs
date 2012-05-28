/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月11日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface IDeviceDataCountDao : IBaseDao<DeviceDataCount>
    {
        DeviceDataCount Get(DeviceDataCount deviceDataCount);

        /// <summary>
        /// 取得月度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        DeviceDataCount GetMonthMax(DeviceDataCount deviceDataCount);

        /// <summary>
        /// 取得年度的最大值发生时间
        /// </summary>
        /// <param name="deviceDataCount"></param>
        /// <returns></returns>
        DeviceDataCount GetYearMax(DeviceDataCount deviceDataCount);
    }
}
