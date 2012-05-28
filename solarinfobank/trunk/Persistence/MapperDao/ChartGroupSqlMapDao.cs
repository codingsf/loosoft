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
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.MapperDao
{
    public class ChartGroupSqlMapDao : BaseSqlDao<ChartGroup>, IChartGroupDao
    {

       public  IList<ChartGroup> GetReportGroupList(Hashtable has)
        {
            return ExecuteQueryForList<ChartGroup>("chartgroup_page_hashtable_list", has);
   
       
       }

    }
}
