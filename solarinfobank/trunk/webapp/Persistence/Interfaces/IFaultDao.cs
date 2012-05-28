using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces
{
    /// <summary>
    /// 告警日志接口
    /// Author: 赵文辉
    /// Time: 2011年2月17日 12:57:42
    /// </summary>
    public interface IFaultDao : IBaseDao<Fault>
    {
        /// <summary>
        /// 获取查询记录的所有记录数
        /// </summary>
        /// <param name="page"></param>
        void LoadingPageCount(Hashtable page);

        void LoadingPageCount(Pager page);

        void ConfirmRecord(string year,string collectors);

        void ConfirmSelect(Hashtable table);

        void ConfirmSelect(string year,string id);

        /// <summary>
        /// 
        /// 取得多个单元的未确认log数量
        /// </summary>
        /// <param name="units"></param>
        /// <returns></returns>
        int GetNewLogNums(IList<PlantUnit> units);

        int GetNewLogNums(IList<PlantUnit> units, int year);

        IList<Fault> GetDeviceLogsPage(Hashtable table);

        int ConfirmDeviveLogSelected(Hashtable table);

        int ConfirmDeviveLogAll(Hashtable table);

        int GetPlantNoConfirmLogsCount(string year, string pid);

        IList<Fault> GetEventReportLogs(Hashtable table);
        /// <summary>
        /// 根据设备id，告警代码和是否确认来取得最新一条告警记录
        /// </summary>
        /// <param name="year">年份</param>/// 
        /// <param name="deviceId">设备id</param>
        /// <param name="errorCode">告警代码</param>
        /// <param name="confirm">是否确认</param>
        /// <returns></returns>
        Fault GetFaultbyDeviceIdTypeStatus(int year, long deviceId, int errorCode, bool confirm);
                /// <summary>
        /// 更新告警的发生时间
        /// </summary>
        /// <param name="year"></param>
        /// <param name="id"></param>
        /// <param name="sendTime"></param>
        /// <returns></returns>
        void updateSendtime(int year, long id, string sendTime);
    }
}
