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
    /// <summary>
    /// 告警日志实现类
    /// Author: 赵文辉
    /// Time: 2011年2月17日 13:36:30
    /// </summary>
    public class FaultSqlMapDao : BaseSqlDao<Fault>, IFaultDao
    {
        public void LoadingPageCount(Hashtable page)
        {
            if (page.ContainsKey("page"))
                (page["page"] as Pager).RecordCount = (int)base.ExecuteQueryForObject("loading_hashtable_page_count", page);

        }
        public void LoadingPageCount(Pager page)
        {
            if (page != null)
                page.RecordCount = (int)base.ExecuteQueryForObject("loading_pager_page_count", page);

        }

        public void ConfirmRecord(string year,string collectors)
        {
            Hashtable table = new Hashtable();
            table.Add("year", year);
            table.Add("ids", collectors);
            ExecuteUpdate("Plant_fault_confirmed_all",table);
        }
        
        
        public void ConfirmSelect(Hashtable table)
        {
            ExecuteUpdate<Hashtable>("FAULT_HASHTABLE_UPDATE",table);
        }
        
        public void ConfirmSelect(string year,string id )
        {
            Hashtable param = new Hashtable();
            param.Add("year", year);
            param.Add("ids", id);
            ExecuteUpdate("Plant_fault_confirm", param); ;
        }

        /// <summary>
        /// 
        /// 取得多个单元的未确认log数量
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        public int GetNewLogNums(IList<PlantUnit> units) {
            return GetNewLogNums(units, DateTime.Now.Year);
        }


        /// <summary>
        /// 
        /// 取得多个单元的未确认log数量
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        public int GetNewLogNums(IList<PlantUnit> units ,int year)
        {
            string ids = string.Empty;
            StringBuilder sb = new StringBuilder();
            foreach (PlantUnit unit in units)
            {
                sb.Append(",").Append(unit.collector.id);
            }
            if (sb.Length > 0)
            {
                ids = sb.ToString().Substring(1);
            }
            else
            {
                ids = "-1";
            }

            Hashtable whereHash = new Hashtable();
            whereHash.Add("year", year);
            whereHash.Add("ids", ids);
            return (int)ExecuteQueryForObject("log_noconfirmed_num", whereHash);
        }


        #region IFaultDao 成员


        public IList<Fault> GetDeviceLogsPage(Hashtable table)
        {
            if(table.ContainsKey("page"))
                (table["page"] as Pager).RecordCount =(int) ExecuteQueryForObject("device_fault_list_count", table);
            return ExecuteQueryForList<Fault>("device_fault_list", table);
        }

        #endregion

        #region IFaultDao 成员


        public int ConfirmDeviveLogSelected(Hashtable table)
        {
            return ExecuteUpdate("device_fault_confirm_selected", table);
        }

        public int ConfirmDeviveLogAll(Hashtable table)
        {
            return ExecuteUpdate("device_fault_confirm_all", table);
        }

        #endregion

        #region IFaultDao 成员

        public int GetPlantNoConfirmLogsCount(string year, string ids)
        {
            Hashtable para = new Hashtable();
            para.Add("year", year);
            para.Add("ids", ids);
            return (int)ExecuteQueryForObject("get_user_not_confirm_logs_count", para);
            
        }

        #endregion

        #region IFaultDao 成员


        public IList<Fault> GetEventReportLogs(Hashtable table)
        {
            return ExecuteQueryForList<Fault>("interval_sender_load_logs", table);
        }


        /// <summary>
        /// 根据设备id，告警代码和是否确认来取得最新一条告警记录
        /// </summary>
        /// <param name="year">年份</param>/// 
        /// <param name="deviceId">设备id</param>
        /// <param name="errorCode">告警代码</param>
        /// <param name="confirm">是否确认</param>
        /// <returns></returns>
        public Fault GetFaultbyDeviceIdTypeStatus(int year, long deviceId, int errorCode, bool confirm)
        {
            Hashtable para = new Hashtable();
            para.Add("year", year);
            para.Add("deviceID", deviceId);
            para.Add("errorCode", errorCode);
            para.Add("confirm",  confirm?1:0);
            return ExecuteQueryForObject<Fault>("GetFaultbyDeviceIdTypeStatus", para);
        }

        /// <summary>
        /// 更新告警的发生时间
        /// </summary>
        /// <param name="year"></param>
        /// <param name="id"></param>
        /// <param name="sendTime"></param>
        /// <returns></returns>
        public void updateSendtime(int year, long id, string sendTime)
        {
            Hashtable para = new Hashtable();
            para.Add("year", year);
            para.Add("id", id);
            para.Add("sendTime", sendTime);
            ExecuteUpdate("updateFaultTime", para);
        }
        #endregion
    }
}
