﻿/*******************************
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
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    public interface ICustomChartDao : IBaseDao<CustomChart>
    {
        void Delete(int GroupId);

        IList<CustomChart> GetListOutGroup(int userId);

        IList<CustomChart> GetListByGroup(int userId,int Groupid);
        /// <summary>
        /// 根据电站id取得
        /// </summary>
        /// <param name="plantID"></param>
        /// <returns></returns>
        IList<CustomChart> GetListByPlant(int plantID);
    }
}
