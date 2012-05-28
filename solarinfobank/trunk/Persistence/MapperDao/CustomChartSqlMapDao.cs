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
    public class CustomChartSqlMapDao : BaseSqlDao<CustomChart>, ICustomChartDao
    {

        public void Delete(int GroupId)
        {
            ExecuteDelete("DELETE_CUSTOMREPORT_BY_GROUPID", GroupId);
        }

        public IList<CustomChart> GetListOutGroup(int userId)
        {
          return  ExecuteQueryForList<CustomChart>("GetListOutGroup", userId);  
        
        }

        public IList<CustomChart> GetListByGroup(int userId, int groupId)
        {
            Hashtable has = new Hashtable();
            has.Add("userId", userId);
            has.Add("groupId", groupId);
            return ExecuteQueryForList<CustomChart>("GetListByGroupId", has);

        }

        public IList<CustomChart> GetListByPlant(int plantId)
        {
            return ExecuteQueryForList<CustomChart>("GetListByPlantId", plantId);
        }
    }
}
