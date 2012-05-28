using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
   public interface IReportDao
    {
       IList<DefineReport> GetRunReportsListByPlantId(Hashtable table);
       DefineReport GetRunReportById(string id);
      
       int DeleteReportById(string id);
       int EditReportById(DefineReport report);
       DefineReport ShowReportById(string id);
       int AddRunReport(DefineReport report);
       IList<DefineReport> GetAllReportsList();
       IList<DefineReport> GetRunReportsListByUserId(Hashtable table);
    }
}
