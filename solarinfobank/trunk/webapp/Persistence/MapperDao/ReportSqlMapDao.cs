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


    public class ReportSqlMapDao : BaseSqlDao<DefineReport>, IReportDao

    {

        #region IReportDao 成员

        public IList<DefineReport> GetRunReportsListByPlantId(Hashtable table)
        {
            if (table.ContainsKey("page"))
                (table["page"] as Pager).RecordCount = (int)ExecuteQueryForObject("loading_report_page_count_by_plantId", table);
            return ExecuteQueryForList<DefineReport>("loading_report_page_list_by_plantId", table);
        }

        #endregion

        #region IReportDao 成员


        public DefineReport GetRunReportById(string id)
        {
          
           
            return ExecuteQueryForObject<DefineReport>("define_report_get",id);
        }

        #endregion

        #region IReportDao 成员


      

        #endregion

        #region IReportDao 成员


        public int DeleteReportById(string id)
        {
            return ExecuteDelete("delete_report_by_Id",id);
        }

        public int EditReportById(DefineReport report)
        {
            return ExecuteUpdate("edit_report_by_id",report);
        }

        public DefineReport ShowReportById(string id)
        {
            return (DefineReport)ExecuteQueryForObject("get_report_by_id",id);
        }

        public  int AddRunReport(DefineReport report)
        {
           return Insert(report);
        }

      

        #endregion

        #region IReportDao 成员


        public IList<DefineReport> GetAllReportsList()
        {
            return ExecuteQueryForList<DefineReport>("get_all_defined_report", null);
        }

        #endregion



        #region IReportDao 成员


        public IList<DefineReport> GetRunReportsListByUserId(Hashtable table)
        {
            if (table.ContainsKey("page"))
                (table["page"] as Pager).RecordCount = (int)ExecuteQueryForObject("loading_report_page_count_by_userId", table);
            return ExecuteQueryForList<DefineReport>("loading_report_page_list_by_userId", table);
        }

        #endregion
    }
}
