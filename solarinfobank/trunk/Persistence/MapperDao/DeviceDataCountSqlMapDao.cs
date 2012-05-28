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
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class DeviceDataCountSqlMapDao : BaseSqlDao<DeviceDataCount>, IDeviceDataCountDao
    {

        public DeviceDataCount Get(DeviceDataCount deviceDataCount)
        {
            return ExecuteQueryForObject<DeviceDataCount>("devicedatacount_get", deviceDataCount);
       }

       /// <summary>
       /// 取得月度的最大值发生时间
       /// </summary>
       /// <param name="year"></param>
       /// <param name="month"></param>
       /// <returns></returns>
       public DeviceDataCount GetMonthMax(DeviceDataCount deviceDataCount) {
           return ExecuteQueryForObject<DeviceDataCount>("GetMonthMax", deviceDataCount);
       }
       /// <summary>
       /// 取得年度的最大值发生时间
       /// </summary>
       /// <param name="year"></param>
       /// <returns></returns>
       public DeviceDataCount GetYearMax(DeviceDataCount deviceDataCount)
       {
           return ExecuteQueryForObject<DeviceDataCount>("GetYearMax", deviceDataCount);
       }

    }
}
