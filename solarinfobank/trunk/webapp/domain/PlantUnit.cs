using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：电站单元
    /// 作者：张月
    /// 时间：2011年3月7日 11:02:31
    /// </summary>
    /// 
    [Serializable]
    public class PlantUnit
    {
        /// <summary>
        /// 无参数构造函数
        /// </summary>
        public PlantUnit() { }
        public int id { get; set; }

        public int plantID { get; set; }//电站
        public int collectorID { get; set; }//电站
        private Collector _collector;
        /// <summary>
        /// 采集器
        /// </summary>
        public Collector collector
        {
            get
            {
                return _collector;
            }
            set
            {
                _collector = value;
            }
        }

        /// <summary>
        /// 单元名称
        /// </summary>
        public string displayname { get; set; }

        /// <summary>
        /// modify by qhb in 20130323 for
        /// 单元关联的物理设备，和单元对应的采集器的数据设备区别
        /// 业务上以该物理设备为依据
        /// 实际业务情况为：
        /// 有的物理设备是属于一个单元，但是借用其他单元采集器发送数据，系统默认是将从某个采集器发送数据的设备认为就是绑定这个采集器
        /// 的单元的设备，这是用户需要从单元设备关系设定功能中将物理关系纠正过来。
        /// 业务处理：
        /// 1.有设备新增时要将没有plantunitid关系的设备的plantunitid赋值
        /// 2.在进行单元绑定将所绑定采集器没有plantunitid关系的设备赋值
        /// 3.解除绑定时要将设备的plantunitid清空置null
        /// 因为devices和device有取得plantunit有循环引用关系，所有现在devices里面取得是resultClass即通过plantunit.devices取得的device是不能在里面取得plantuint的避免循环引用
        /// </summary>
        public IList<Device> devices { get; set; }

        /// <summary>
        /// 未隐藏的物理设备列表
        /// </summary>
        public IList<Device> displayDevices {
            get {
                IList<Device> devicesList = new List<Device>();
                if (_collector == null) return devicesList;
                foreach (Device device in devices) {
                    if (!device.isHidden) devicesList.Add(device);
                }
                return devicesList;
            }
        }

        /// <summary>
        /// 所有数据关系设备列表，包括隐藏和未隐藏
        /// </summary>
        public IList<Device> dataDevices
        {
            get
            {
                return this.collector == null ? new List<Device>() : this.collector.devices;
            }
        }

        /// <summary>
        /// 未隐藏的数据关系设备列表
        /// </summary>
        public IList<Device> displayDataDevices
        {
            get
            {
                IList<Device> devicesList = new List<Device>();
                if (_collector == null) return devicesList;
                foreach (Device device in _collector.devices)
                {
                    if (!device.isHidden) devicesList.Add(device);
                }
                return devicesList;
            }
        }

        /// <summary>
        /// 单元是否工作， 只有所有设备超过一小时没有数据才为不工作
        /// 1219根据周辉要求
        /// “BANK的数据源的状态不能以是否有设备来决定，只要收到数据源的正确数据包，即使没有设备，数据源也应该显示在线状态”
        /// 改为按照采集器的工作时间来判断
        /// </summary>
        /// <param name="timezone"></param>
        /// <returns></returns>
        public bool isWork(int timezone)
        {
            bool isWork = !over1Hour(timezone);
            //foreach (Device device in displayDevices)
            //{
            //    if (!device.Over1Hour(timezone))
            //    {
            //        isWork = true;
            //        break;
            //    }
            //}
            return isWork;
        }

        /// <summary>
        /// 取得单元的日增量光照强度
        /// </summary>
        /// <returns></returns>
        public double rendersunlight() {
            foreach (Device device in this.devices)
            {
                //十分环境检测仪
                if (device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE)
                {
                    if (device.RenderSunlight() > 0)
                        return device.RenderSunlight();
                }
            }
            return 0;
        }

        /// <summary>
        /// 是否超过一天
        /// </summary>
        /// <param name="timezone"></param>
        /// <returns></returns>
        public bool over1Day(int timezone)
        {
            if (this.collector == null || this.collector.runData == null)
                return true;
            else
                return (CalenderUtil.curDateWithTimeZone(timezone) - this.collector.runData.sendTime).TotalDays > 1;
        }

        /// <summary>
        /// 超过一小时或者未到点
        /// </summary>
        /// <param name="timezone"></param>
        /// <returns></returns>
        public bool over1Hour(int timezone)
        {
            if (this.collector == null || this.collector.runData == null)
                return true;
            else{
                double cha = (CalenderUtil.curDateWithTimeZone(timezone) - this.collector.runData.sendTime).TotalHours;
                //by zhouhui at 20130904 将原来的cha<0改成cha<-1，因为现场有部分设备的时间比实际时间稍微快点是正常的，也是允许的
                //return  cha>1 || cha<0;
                return cha > 1 || cha < -1;
            }
        }

        /// <summary>
        /// 包括超过一天或又设备警告,918增加了状态警告
        /// </summary>
        /// <param name="timezone"></param>
        /// <returns></returns>
        public bool isDeviceFault(int timezone)
        {
           foreach (Device device in displayDevices)
           {
               if (device.Over1Day(timezone) || device.isFault())
                   return true;
           }
           return false;
        }

        /// <summary>
        /// 只取逆变器的设计功率
        /// </summary>
        public float chartPower
        {
            get
            {
                float chartPower = 0f;

                if(devices!=null)
                    foreach (Device device in devices)
                    {
                        if (device.deviceTypeCode != DeviceData.INVERTER_CODE) continue;
                        chartPower += device.chartPower;
                    }
                return chartPower;
            }
        }

        /// <summary>
        /// 今日当前功率
        /// </summary>
        public float TodayPower(int timezone)
        {
            float total = 0;

            if (this.collector != null && this.collector.runData != null && this.collector.runData.sendTime.AddHours(1) >= CalenderUtil.curDateWithTimeZone(timezone))
                total = collector.runData.power;

            return total;
        }

        /// <summary>
        /// 今日发电量
        /// 现为设备的累加起来
        /// 原来是直接去采集器的实时数据中得今日发电量，那样不准确，因为那个实时数据中的发电量本来就不准确
        /// modify by qhb in 20120629 for 当设备没有今日发电量时，则取得对应采集器的相关数据，需求变更来自周辉
        /// </summary>
        public float TodayEnergy(int timezone)
        {
            float total = 0;
            if (devices == null) return total;
            //if (this.collector.runData != null && CalenderUtil.formatDate(collector.runData.sendTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(timezone, "yyyyMMdd")))
            //    total = collector.runData.dayEnergy;
            foreach (Device device in devices)
            {
                total += device.TodayEnergy(timezone);
            }

            //如果设备没有今日发电量则取下采集的实时数据中的今日发电量
            if (total == 0)
            {
                if (this.collector != null && this.collector.runData != null && CalenderUtil.formatDate(collector.runData.sendTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(timezone, "yyyyMMdd")))
                    total = collector.runData.dayEnergy;
            }

            return StringUtil.stringtoFloat(Math.Round(total, 2).ToString());
        }

        /// <summary>
        /// 总发电量，有设备总发电量累加
        /// </summary>
        public float totalEnergy
        {
            get
            {
                float? total = null;

                //先累计实时数据则去设备累计
                if (devices != null && devices.Count>0)
                {
                    total = 0;
                    foreach (Device device in devices)
                    {
                        total += device.TotalEnergy;
                    }
                }

                if (total == null)
                {
                    //先取得采集的实时数据中总发电量
                    if (this.collector != null && this.collector.runData != null)
                        total = collector.runData.totalEnergy;
                }

                //如果设备没有今日发电量则取下采集的实时数据中的今日发电量
                return total==null || float.IsNaN(total.Value) ? 0 : total.Value;
                //float totalEnergy = 0;
                //if (devices == null) return totalEnergy;
                //foreach (Device device in devices) {
                    //totalEnergy += device.TotalEnergy;
                //}
                //return totalEnergy;
            }
        }

        /// <summary>
        /// 显示用总发电量，四舍五入
        /// </summary>
        public double displayTotalEnergy {
            get {
                return Math.Round(this.totalEnergy, 2);
            }
        }


        public string displayTotalEnergyDigtal
        {
            get
            {
                return Util.upDigtal(displayTotalEnergy).ToString();
            }
        }

        public string displayTotalEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(displayTotalEnergy).ToString();
            }
        }
        /// <summary>
        /// 根据传入的设备类型代码取得相应的设备
        /// </summary>
        /// <param name="deviceType">设备类型代码，参见DeviceData.INVERTER_CODE DeviceData.HUILIUXIANG_CODE等</param>
        /// <returns></returns>
        public IList<Device> typeDevices(int deviceType, bool isHidden)
        {
            IList<Device> typeDevices = new List<Device>();
            if (devices == null) return typeDevices;
            foreach (Device device in devices)
            {
                if (device.deviceTypeCode == deviceType && device.isHidden == isHidden) 
                {
                    typeDevices.Add(device);
                }
            }
            return typeDevices;
        }

        public Plant plant { get; set; }
    }
}
