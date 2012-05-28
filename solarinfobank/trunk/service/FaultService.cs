using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using System.Collections;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 告警日志服务
    /// Author: 陈波
    /// Time: 2011年2月17日 15:48:19
    /// </summary>
    public class FaultService : BaseService
    {
        private static FaultService _faultService = new FaultService();
        private IDaoManager _daoManager = null;
        private IFaultDao _faultDao = null;
        private IDeviceDao _deviceDao = null;
        private FaultService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _faultDao = _daoManager.GetDao(typeof(IFaultDao)) as IFaultDao;
            _deviceDao = _daoManager.GetDao(typeof(IDeviceDao)) as IDeviceDao;
        }

        public static FaultService GetInstance()
        {
            return _faultService;
        }

        public IList<Fault> Getlist(Fault fault)
        {
            return _faultDao.Getlist(fault);
        }

        public IList<Fault> Getlist(Pager page)
        {
            LoadingPageCount(page);
            return _faultDao.Getlist(page);
        }
        public void LoadingPageCount(Pager page)
        {
            _faultDao.LoadingPageCount(page);
        }

        public IList<Fault> GetPlantLoglist(Hashtable page)
        {
            LoadingPageCount(page);
            return _faultDao.Getlist(page);
        }

        /// <summary>
        /// hashtable 索引
        /// user.用户对象 可空
        /// plants.电站对象集合 可空
        /// startTime.开始时间
        /// endTime.结束时间
        /// items.查询项目  告警  错误  信息 。。。逗号分隔
        /// state.状态 已确认  未确认 逗号分隔
        /// page.分页对象 page 类型
        /// 注意  0 1 只能一项为空 两项都不为空时以电站对象为准
        /// 返回数据取 hashtable["source"]
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        public void GetAllLogs(Hashtable table)
        {
            if (table["user"] == null && table["plants"] == null)
                return;

            IList<Fault> faults = new List<Fault>();

            Hashtable htable = new Hashtable();

            #region  查询项目
            string inforank = table["items"] as string;

            inforank = inforank.EndsWith(",") ? inforank.Substring(0, inforank.Length - 1) : inforank;
            if (inforank.IndexOf("-1") > -1)
            {
                inforank = ErrorType.ERROR_TYPE_INFORMATRION + "," + ErrorType.ERROR_TYPE_FAULT + "," + ErrorType.ERROR_TYPE_ERROR + "," + ErrorType.ERROR_TYPE_WARN;
            }

            #endregion

            #region 采集器Ids
            string collectorString = string.Empty;//采集器id组合

            //电站信息参数
            if (table["plants"] != null)
            {
                collectorString = string.Empty;
                IList<Plant> plants = table["plants"] as IList<Plant>;
                foreach (Plant plant in plants)
                {
                    foreach (PlantUnit unit in plant.allFactUnits)
                    {
                        collectorString += string.Format("{0},", unit.collector.id);
                    }
                }
            }
            else
            {
                User user = table["user"] as User;
                foreach (Plant plant in user.displayPlants)
                {
                    foreach (PlantUnit unit in plant.allFactUnits)
                    {
                        collectorString += string.Format("{0},", unit.collector.id);
                    }
                }
            }

            collectorString = collectorString.EndsWith(",") ? collectorString.Substring(0, collectorString.Length - 1) : collectorString;
            #endregion

            #region 开始时间

            DateTime startTime = DateTime.Parse(table["startTime"].ToString());

            #endregion

            #region 结束时间
            DateTime endTime = DateTime.Parse(table["endTime"].ToString()).AddDays(1);

            #endregion

            #region 状态
            string stateStr = table["state"] as string;
            stateStr = stateStr.Equals("-1") ? "1,0" : stateStr;
            #endregion

            #region 分页对象

            Pager page = table["page"] as Pager;
            int startIndex = page.PageSize * (page.PageIndex - 1);
            int pageIndex = page.PageIndex;


            #endregion

            Fault fault = new Fault() { sendTime = startTime, confirmed = stateStr, inforank = inforank, collectorString = collectorString };
            htable.Add("page", page);
            htable.Add("fault", fault);
            htable.Add("endTime", endTime);
            int totalRecord = 0;
            //跨年
            if (endTime.Year > startTime.Year)
            {
                int yyyy = endTime.Year;
                while (yyyy-- > startTime.Year)
                {
                    //改成开始时间
                    fault.sendTime = new DateTime(yyyy + 1, 1, 1, 0, 0, 0);

                    //htable["endTime"] = new DateTime(yyyy - 1, 12, 31);
                    IList<Fault> faultsList = GetPlantLoglist(htable);
                    int skip = 0;
                    if (Math.Abs(totalRecord - startIndex) < page.PageSize)
                        skip = totalRecord - startIndex;

                    totalRecord += (htable["page"] as Pager).RecordCount;
                    if (totalRecord > startIndex)
                    {
                        foreach (Fault item in faultsList)
                        {
                            if (faults.Count < page.PageSize && skip++ >= 0)
                                faults.Add(item);
                            else
                                break;
                        }
                    }
                    page.PageIndex = Math.Abs(startIndex + page.PageSize - totalRecord) / page.PageSize;
                    //fault.sendTime = new DateTime(yyyy, 01, 01);
                    htable["endTime"] = new DateTime(yyyy, 12, 31, 23, 59, 59);

                }
                //htable["endTime"] = endTime;
                fault.sendTime = new DateTime(yyyy + 1, 01, 01, 0, 0, 0);
                if (fault.sendTime < startTime)
                    fault.sendTime = startTime;
                IList<Fault> lastfaultsList = GetPlantLoglist(htable);
                int lastskip = 0;
                if (Math.Abs(totalRecord - startIndex) < page.PageSize)
                    lastskip = totalRecord - startIndex;
                totalRecord += (htable["page"] as Pager).RecordCount;
                if (totalRecord > startIndex)
                {
                    foreach (Fault item in lastfaultsList)
                    {
                        if (faults.Count < page.PageSize && lastskip++ >= 0)
                            faults.Add(item);
                        if (faults.Count > page.PageSize)
                            break;
                    }

                    if (faults.Count < page.PageSize)//如果不够获取下一页的数据
                    {
                        page.PageIndex = page.PageIndex + 1;
                        IList<Fault> nextPageList = GetPlantLoglist(htable);
                        foreach (Fault fau in nextPageList)
                            if (faults.Count < page.PageSize)
                                faults.Add(fau);
                            else
                                break;

                    }
                }
            }
            else
            {
                IList<Fault> faultsList = GetPlantLoglist(htable);
                totalRecord = (htable["page"] as Pager).RecordCount;
                faults = faultsList;
            }
            page.RecordCount = totalRecord;//返回查询的所有年数的所有记录
            page.PageIndex = pageIndex;
            faults = faults.OrderByDescending(m => m.sendTime).ToList<Fault>();
            table.Add("source", faults);

        }

        public void LoadingPageCount(Hashtable page)
        {
            _faultDao.LoadingPageCount(page);
        }

        public void ConfirmRecord(string year, string collectors)
        {
            _faultDao.ConfirmRecord(year, collectors);
        }

        public void ConfirmSelectedRecord(Hashtable table)
        {
            _faultDao.ConfirmSelect(table);
        }

        public void ConfirmSelectedRecord(string year, string id)
        {
            _faultDao.ConfirmSelect(year, id);
        }

        public int getNewLogNums(IList<Plant> plants)
        {
            IList<PlantUnit> units = base.getUnitsByPlantList(plants);
            return _faultDao.GetNewLogNums(units);
        }

        /// <summary>
        /// 取得所有工作年份的未确认告警数量
        /// </summary>
        /// <param name="plants"></param>
        /// <param name="workYears"></param>
        /// <returns></returns>
        public int getNewLogNums(IList<Plant> plants, IList<int> workYears)
        {
            int nums = 0;
            IList<PlantUnit> units = base.getUnitsByPlantList(plants);
            foreach (int year in workYears)
            {
                nums += _faultDao.GetNewLogNums(units, year);
            }
            return nums;
        }

        /// <summary>
        /// 批量保持单元日数据对象
        /// </summary>
        /// <param name="unitDayDatas"></param>
        public void batchSave(ICollection<Fault> logs)
        {
            LogUtil.writeline("save log,logs count:" + logs.Count);
            //_daoManager.BeginTransaction();
            foreach (Fault log in logs)
            {
                //Console.WriteLine("error log is: "+log.sendTime.ToString("yyyy-MM-dd HH:mm:ss"));
                ////add by qianhb for 防止前面取得告警是不能取得设备，这里重新去一次，取不到则不保存log
                //if (log.device.id == 0) {
                //    Console.WriteLine("log.device.id: " + log.device.id);
                //    Device tmp = _deviceDao.GetDeviceByCollector2Address(log.collectorID, log.address);
                //    Console.WriteLine("tmp: " + tmp);
                //    if (tmp == null) continue;
                //    log.device.id = tmp.id;
                //}

                //无对应设备则不处理
                if (log.device.id == 0)continue;
                //取得同类型的某个设备的未确认的告警，如果有就更新其最新发送时间，以便保证同一个设备同一类型在用户未确认之前是有一条记录
                Fault fault = this.GetFaultbyDeviceIdTypeStatus(log.year, log.device.id, log.errorCode, false);
                if (fault == null)
                {
                    LogUtil.writeline("log is:" + log.sendTime.ToString("yyyy-MM-dd HH:mm:ss"));
                    try
                    {
                        _faultDao.Insert(log);
                    }
                    catch (Exception eee)
                    {
                        LogUtil.error("save log error:" + eee.Message);
                    }
                }
                else
                    _faultDao.updateSendtime(log.year, fault.id, log.sendTime.ToString("yyyy-MM-dd HH:mm:ss"));
            }
            //_daoManager.CommitTransaction();
        }

        public IList<Fault> GetDeviceLogsPage(Hashtable table)
        {
            return _faultDao.GetDeviceLogsPage(table);
        }


        public int CofirmDeviceLog(string unitId, string type, string logList)
        {
            Hashtable table = new Hashtable();
            table.Add("year", DateTime.Now.Year);
            table.Add("logIds", logList);
            table.Add("unitId", unitId);
            int i = -1;
            switch (type)
            {
                case "1":
                    i = _faultDao.ConfirmDeviveLogSelected(table);
                    break;
                case "2":
                    i = _faultDao.ConfirmDeviveLogAll(table);
                    break;
                default:
                    break;
            }
            return i;
        }

        public int GetUserNoConfirmLogsCount(User user)
        {
            string ids = string.Empty;
            int userTotalLogsCount = 0;
            foreach (Plant plant in user.displayPlants)
            {
                userTotalLogsCount += GetPlantNoConfirmLogsCount(plant);
            }
            return userTotalLogsCount;
        }

        public int GetPlantNoConfirmLogsCount(Plant plant)
        {
            string ids = string.Empty;
            foreach (PlantUnit unit in plant.allFactUnits)
            {
                ids += string.Format("{0},", unit.collectorID);
            }
            ids = ids.Length > 0 ? ids.Substring(0, ids.Length - 1) : "-1";

            IList<int> yearList = CollectorYearDataService.GetInstance().GetWorkYears(plant);
            int totalLogsCount = 0;
            foreach (int year in yearList)
            {
                totalLogsCount += _faultDao.GetPlantNoConfirmLogsCount(year.ToString(), ids);
            }
            return totalLogsCount;
        }



        public IList<Fault> GetEventReportLogs(string cids, DateTime lastModified)
        {
            Hashtable table = new Hashtable();
            table.Add("year", DateTime.Now.Year);
            table.Add("cids", cids);
            table.Add("lastModified", lastModified);
            return _faultDao.GetEventReportLogs(table);
        }
        /// <summary>
        /// 根据设备id，告警代码和是否确认来取得最新一条告警记录
        /// </summary>
        /// <param name="year">年份</param>/// 
        /// <param name="deviceId">设备id</param>
        /// <param name="errorCode">告警代码</param>
        /// <param name="confirm">是否确认</param>
        /// <returns></returns>
        public Fault GetFaultbyDeviceIdTypeStatus(int year, long deviceId, int errorCode, bool confirm) {
            return _faultDao.GetFaultbyDeviceIdTypeStatus(year,deviceId,errorCode,confirm);
        }

    }
}
