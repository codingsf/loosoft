/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月16日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Service;
using System.Threading;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Configuration;
namespace DataAnalyze
{
    /// <summary>
    /// 数据持久化处理器
    /// </summary>
    public class PersistentProcesser
    {
        //持久化间隔分钟
        static int persistent_interval = ConfigurationSettings.AppSettings["persistent_interval"] == null ? 60 : int.Parse(ConfigurationSettings.AppSettings["persistent_interval"]);
        /// <summary>
        /// 定时从缓存中取得要持久化的数据进行定时持久化
        /// </summary>
        public void Processing()
        {
            Console.WriteLine("启动持久化线程");
            while (1 == 1)
            {
                persistent_interval = ConfigurationSettings.AppSettings["persistent_interval"] == null ? 60 : int.Parse(ConfigurationSettings.AppSettings["persistent_interval"]);
                Thread.Sleep(persistent_interval * 60 * 1000);
                //持久化数据
                peristentData();
            }
        }
  
        public void peristentData(){
            Console.WriteLine("开始持久化");
            //持久化设备天数据
            try
            {
                DeviceDayDataService.GetInstance().batchSave(BaseMessage.devicedayDataMapList);
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化设备天数据异常：" + ee.Message);

            }
            //持久化采集器天数据
            try
            {
                CollectorDayDataService.GetInstance().batchSave(BaseMessage.collectordayDataMap);
            }
            catch (Exception ee) {
                LogUtil.error("持久化采集器天数据异常：" + ee.Message);
            }

            //持久化设备实时数据
            try{
                DeviceRunDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化设备实时数据数据异常：" + ee.Message);
            }
            //持久化采集器实时数据
            try
            {
                LogUtil.writeline("start 持久化采集器实时数据");
                CollectorRunDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化采集器实时数据异常：" + ee.Message);
            }

            //持久化最大值统计
            try{
                DeviceDataCountService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化最大值统计异常：" + ee.Message);
            }

            //持久化设备月天数据
            try{
                DeviceMonthDayDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化设备月天数据异常：" + ee.Message);
            }
            //持久化采集器月天数据
            try{
                CollectorMonthDayDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化采集器月天数据异常：" + ee.Message);
            }
            //持久化设备年月数据
            try{
                DeviceYearMonthDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化设备年月数据异常：" + ee.Message);
                DeviceYearMonthDataService.GetInstance().batchSave();
            }
            //持久化采集器年月数据
            try{
                CollectorYearMonthDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化采集器年月数据异常：" + ee.Message);
            }
            //持久化设备总体数据
            try{
                DeviceYearDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化采集器年月数据异常：" + ee.Message);
            }
            //持久化采集器总体数据
            try
            {
                CollectorYearDataService.GetInstance().batchSave();
            }
            catch (Exception ee)
            {
                LogUtil.error("持久化采集器总体数据异常：" + ee.Message);
            }
        }
    }
}
