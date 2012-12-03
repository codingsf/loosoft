using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using IBatisNet.Common.Pagination;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 采集器信息服务
    /// Author: 赵文辉
    /// Time: 2011年2月18日 15:32:42   第一次修改
    /// </summary>
    public class CollectorInfoService
    {
        //新创建一个采集器服务
        private static CollectorInfoService _instance = new CollectorInfoService();
        //定义一个内置接口
        private IDaoManager _daoManager = null;
        //定义一个采集器接口
        private ICollectorDao _stationInfoDao = null;

        private static Hashtable collectorInfoCodeIdHash = new Hashtable();

        /// <summary>
        /// 初始化所有采集器
        /// </summary>
        public void init()
        {
            foreach (Collector collector in _stationInfoDao.GetColloectorInfos())
            {
                collectorInfoCodeIdHash[collector.code] = collector.id;
            }
        }
        /// <summary>
        /// 创建一个不带参的构造函数
        /// </summary>
        private CollectorInfoService()
        {
            //获取采集器接口
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _stationInfoDao = _daoManager.GetDao(typeof(ICollectorDao)) as ICollectorDao;
        }

        /// <summary>
        /// 创建一个采集器服务
        /// </summary>
        /// <returns>采集器服务</returns>
        public static CollectorInfoService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new CollectorInfoService();
            }
            return _instance;
        }

        /// <summary>
        /// 采集器验证
        /// </summary>
        /// <param name="guid">采集器编号</param>
        /// <param name="password">密码</param>
        /// <returns>是否通过验证 false失败 true成功</returns>
        public Collector Exists(string guid, string password)
        {
            return _stationInfoDao.Exists(guid, password);
        }

        /// <summary>
        /// 添加采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器实体</param>
        public void Add(Collector collectorInfo)
        {
            _stationInfoDao.Insert(collectorInfo);
        }


        /// <summary>
        /// 根据采集器编号查询采集器信息
        /// </summary>
        /// <param name="code">编号</param>
        /// <returns>采集器对象</returns>
        public Collector GetCollectorById(int id)
        {
            return _stationInfoDao.GetCollectorById(id);
        }

        
        /// <summary>
        /// 根据采集器code取得采集器数据库id
        /// </summary>
        /// <param name="code"></param>
        /// <returns>采集器id</returns>
        public int getCollectorIdbyCode(string code)
        {
            Collector collector = _stationInfoDao.GetCollectorByCode(code);
            if (collector != null)
            {
                return collector.id;
            }
            return 0;
        }

        /// <summary>
        /// 根据采集器code取得采集器数据库id
        /// </summary>
        /// <param name="code"></param>
        /// <returns>采集器id</returns>
        public Collector getCollectorbyCode(string code)
        {
            //先从hash表中取得code对应的id
           // object value = collectorInfoCodeIdHash[code];
            //if (value == null)
            //{ 
                //从数据库中取得采集器id
                //int id = _stationInfoDao.CheckCollectorExists(code);
                //if (id > 0)
                //{
                    //collectorInfoCodeIdHash[code] = id;
                    Collector collector = _stationInfoDao.GetCollectorByCode(code);
                    if (collector!=null && !collector.isUsed)
                    {
                        //collector.isUsed = true;
                        //this.Save(collector);
                    }
                    return collector;
                //}
                //return id;
            //}
            //else
            //{
                //return int.Parse(value.ToString());
            //}
        }

        /// <summary>
        /// 修改采集器信息
        /// </summary>
        /// <param name="collectorInfo">采集器实体</param>
        public void Update(Collector collectorInfo)
        {
            _stationInfoDao.UpdateCollector(collectorInfo);
        }

        /// <summary>
        /// 删除采集器信息
        /// </summary>
        /// <param name="code">采集器编号</param>
        /// <returns>是否删除成功 0失败 1成功</returns>
        public int Collector_Delete(string code)
        {
            return _stationInfoDao.DeleteCollector(code);
        }

        /// 查询所有采集器信息
        /// </summary>
        /// <returns>所有采集器信息</returns>
        public IList<Collector> GetColloectorInfos()
        {
            return _stationInfoDao.GetColloectorInfos();
        }

        public int Save(Collector collector)
        {
            if (collector.id > 0)
            {
                return _stationInfoDao.Update(collector);
            }
            else
                return _stationInfoDao.Insert(collector);

        }

        public Collector Get(int id)
        {
            Collector info = null;
            info = _stationInfoDao.Get(new Collector() { id = id });
            return info;
        }

        public int Delete(int id)
        {
            return _stationInfoDao.Remove(new Collector() { id = id });
        }
        /// <summary>
        /// 功能：根据采集器编号和密码查询
        /// 作者：张月
        /// 时间：2011年3月12日 11:42:04
        /// </summary>
        /// <param name="collector">采集器实体</param>
        /// <returns></returns>
        public Collector GetClollectorByCodePass(string code, string password)
        {
            return _stationInfoDao.GetClollectorByCodePass(new Collector { code = code, password = password });
        }

        public IList<Collector> GetList()
        {
            return _stationInfoDao.Getlist(new Collector());
        }
        public IPaginatedList GetPageCollectors()
        {
            return _stationInfoDao.GetPageCollectors();
        }

        public IList<Collector> GetCollectorsByPage(Hashtable hashPara)
        {
            if (hashPara["sd"] == null)
            {
                hashPara["sd"] = DateTime.Now.AddYears(-5).ToString("yyyy-MM-dd");
            }
            if (hashPara["ed"] == null)
            {
                hashPara["ed"] = DateTime.Now.ToString("yyyy-MM-dd");
            }
            hashPara["ed"] = DateTime.Parse(hashPara["ed"].ToString()).AddDays(1).ToString("yyyy-MM-dd");
            return _stationInfoDao.GetCollectorsByPage(hashPara);
        }

        /// <summary>
        /// 获取当前采集器下指定时间发电量
        /// </summary>
        /// <param name="cid">采集器编号</param>
        /// <param name="startyyyyMMdd">开始时间</param>
        /// <param name="endyyyyMMdd">结束时间</param>
        /// <returns></returns>
        public double GetEnergy(int cid, string startyyyyMMdd, string endyyyyMMdd)
        {
            //20111130    20111130
            double returnValue = 0;
            DateTime startTime = DateTime.Parse(startyyyyMMdd);
            DateTime endTime = DateTime.Parse(endyyyyMMdd);
            IList<CollectorYearMonthData> cymds = new List<CollectorYearMonthData>();
            int yyyy = startTime.Year;
            while (yyyy <= endTime.Year)//计算开始到结束时间的所在年发电量
            {
                cymds.Add(CollectorYearMonthDataService.GetInstance().GetCollectorYearMonthData(cid, yyyy));
                yyyy++;
            }
            //计算开始到结束时间内的所有发电量
            foreach (CollectorYearMonthData cymd in cymds)
            {
                if (cymd.year.Equals(startTime.Year) && startTime.AddMonths(1) < endTime)
                    returnValue += cymd.count(startTime.Month + 1, 12);
                else
                    if (cymd.year.Equals(endTime.Year) && endTime.AddMonths(-1) > startTime)
                        returnValue += cymd.count(1, endTime.Month - 1);
                    else
                        if (startTime.Year.Equals(endTime.Year) == false)
                            returnValue += cymd.count();
            }
            CollectorMonthDayData cmdd = null;
            //计算边缘月的发电量 
            if (!(startTime.Year.Equals(endTime.Year) && startTime.Month.Equals(endTime.Month)))
            {
                cmdd = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(startTime.Year, cid, startTime.Month);
                returnValue += cmdd.count(startTime.Day, 31);

                cmdd = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(startTime.Year, cid, endTime.Month);
                returnValue += cmdd.count(1, endTime.Day);
            }
            else
            {
                cmdd = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(startTime.Year, cid, endTime.Month);
                returnValue += cmdd.count(startTime.Day, endTime.Day);
            }
            return returnValue;
        }

        public int CheckCollectorExists(string code)
        {

            return _stationInfoDao.CheckCollectorExists(code);
        }

        public IList<Collector> GetCollectorsByUid(int uid)
        {
            return _stationInfoDao.GetCollectorsByUid(uid);

        }
    }
}
