using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;


namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// plant_info:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public class Plant
    {
        public Plant() { }
        private static string plantdefaultpic = "nopic/nopico02.gif";

        #region Model
        private int _id;
        private string _name;
        private string _postcode;
        private string _location;
        private string _country;
        private string _city;
        private int _timezone;
        private string _street;
        private DateTime _installdate;
        private string _operater;
        private string _email;
        private string _phone;
        private string _direction;
        private string _angle;
        private string _manufacturer;
        private string _module_type;
        private string _pic;
        private double _longitude;
        private long _userid;
        private double _latitude;
        private string _description;
        private float _design_power;
        private double _revenueRate;
        private string _currencies;
        private bool _example_plant;
        private bool _videoMonitorEnable;
        private bool _isNewPlant;


        /// <summary>
        /// auto_increment
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }

        private IList<PlantUnit> _plantUnits;


        /// <summary>
        /// 实际电站的设计功率
        /// </summary>
        public float design_power
        {
            get { return _design_power; }
            set { _design_power = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string postcode
        {
            set { _postcode = value; }
            get { return _postcode; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string location
        {
            set { _location = value; }
            get { return _location; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string country
        {
            set { _country = value; }
            get { return _country; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string city
        {
            set { _city = value; }
            get { return _city; }
        }

        /// <summary>
        /// 
        /// </summary>
        public int timezone
        {
            set { _timezone = value; }
            get { return _timezone; }
        }

        /// <summary>
        /// 
        /// </summary>
        public string street
        {
            set { _street = value; }
            get { return _street; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime installdate
        {
            set { _installdate = value; }
            get { return _installdate; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string operater
        {
            set { _operater = value; }
            get { return _operater; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string email
        {
            set { _email = value; }
            get { return _email; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string phone
        {
            set { _phone = value; }
            get { return _phone; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string direction
        {
            set { _direction = value; }
            get { return _direction; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string angle
        {
            set { _angle = value; }
            get { return _angle; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string manufacturer
        {
            set { _manufacturer = value; }
            get { return _manufacturer; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string module_type
        {
            set { _module_type = value; }
            get { return _module_type; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string pic
        {
            set { _pic = value; }
            get { return _pic; }
        }

        /// <summary>
        /// 基础电价
        /// </summary>
        public float basePrice { get; set; }

        /// <summary>
        /// 随机从小图片中取得一个图
        /// </summary>
        public string onePic
        {
            get
            {
                string[] picArray = null;
                if (_pic != null && _pic.Length > 0)
                    picArray = _pic.Split(',');
                if (picArray != null)
                    foreach (string pic in picArray)
                    {
                        if (string.IsNullOrEmpty(pic) == false)
                            return pic;
                    }
                return plantdefaultpic;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public double longitude
        {
            set { _longitude = value; }
            get { return _longitude; }
        }
        /// <summary>
        /// 
        /// </summary>
        public long userID
        {
            set { _userid = value; }
            get { return _userid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public double latitude
        {
            set { _latitude = value; }
            get { return _latitude; }
        }
        public string description
        {
            get { return _description; }
            set { _description = value; }
        }
        public string currencies
        {
            get { return _currencies; }
            set { _currencies = value; }
        }
        public bool example_plant
        {
            get { return _example_plant; }
            set { _example_plant = value; }
        }

        public bool VideoMonitorEnable
        {
            get { return _videoMonitorEnable; }
            set { _videoMonitorEnable = value; }
        }

        public bool isNewPlant
        {
            get
            {
                return _isNewPlant;
            }
            set
            {
                _isNewPlant = value;
            }
        }

        public string structPic { get; set; }

        public IList<PlantUnit> plantUnits
        {
            get
            {

                return _plantUnits;
            }
            set
            {
                _plantUnits = value;
            }
        }

        public double aveKw_Kwp
        {
            get
            {
                int count = 0;
                if (allFactUnits != null)
                    foreach (PlantUnit unit in allFactUnits)
                    {
                        if (unit != null)
                            count += unit.devices.Count;
                    }
                return chartPower / count;
            }
        }

        /// <summary>
        /// 电站下的所有设备
        /// </summary>
        /// <returns></returns>
        public IList<Device> deviceList()
        {
            IList<Device> deviceList = new List<Device>();
            if (allFactUnits == null) return deviceList;
            foreach (PlantUnit unit in this.allFactUnits)
            {
                foreach (Device d in unit.devices)
                {
                    deviceList.Add(d);
                }
            }
            return deviceList;
        }

        /// <summary>
        /// 电站下的所有隐藏设备
        /// </summary>
        /// <returns></returns>
        public IList<Device> displayDevices()
        {
            IList<Device> deviceList = new List<Device>();
            if (allFactUnits == null) return deviceList;
            foreach (PlantUnit unit in this.allFactUnits)
            {
                foreach (Device d in unit.displayDevices)
                {
                    deviceList.Add(d);
                }
            }
            return deviceList;
        }

        /// <summary>
        /// 显示的 类型设备
        /// </summary>
        /// <param name="deviceType"></param>
        /// <returns></returns>
        public IList<Device> typeDevices(int deviceType)
        {
            return typeDevices(deviceType, false);
        }
        /// <summary>
        /// 根据传入的设备类型代码取得相应的设备
        /// </summary>
        /// <param name="deviceType">设备类型代码，参见DeviceData.INVERTER_CODE DeviceData.HUILIUXIANG_CODE等</param>
        /// <returns></returns>
        public IList<Device> typeDevices(int deviceType, bool? isHidden)
        {
            IList<Device> typeDevices = new List<Device>();
            if (allFactUnits == null) return typeDevices;
            foreach (Device device in this.deviceList())
            {
                if (device.deviceTypeCode == deviceType)
                {
                    if (isHidden == null)
                    {
                        typeDevices.Add(device);
                    }
                    else
                    {
                        if (isHidden.Value == device.isHidden)
                            typeDevices.Add(device);
                    }
                }
            }
            return typeDevices;
        }


        private IList<VideoMonitor> _monitores;
        public IList<VideoMonitor> monitores
        {
            get
            {
                return _monitores;
            }
            set
            {
                _monitores = value;
            }
        }

        /// <summary>
        /// 总今日发电量
        /// </summary>
        public float TotalDayEnergy
        {
            get
            {
                float total = 0;
                //有下级电站，那么递归调用下级电站累加
                if (this.childs != null && this.childs.Count > 0)
                {
                    foreach (Plant cplant in this.childs)
                    {
                        total += cplant.TotalDayEnergy;
                    }

                }
                else//没子电站则累加单元发电量
                {
                    string curDate = CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd");
                    if (allFactUnits != null)
                        foreach (PlantUnit unit in allFactUnits)
                        {
                            total += unit.TodayEnergy(this.timezone);
                            //    if (unit.collector.runData != null)
                            //    {

                            //        float daye = !CalenderUtil.formatDate(unit.collector.runData.sendTime, "yyyyMMdd").Equals(curDate) ? 0 : unit.collector.runData.dayEnergy;
                            //        total += daye;
                            //    }
                        }
                }
                return total;
            }
        }
        /// <summary>
        /// 日发电量单位，做了单位进制处理
        /// </summary>
        public string TotalDayEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalDayEnergy);
            }

        }

        /// <summary>
        /// 显示今日总发电量，做了单位进制处理，格式化为2位小数，返回字符串
        /// </summary>
        public string DisplayTotalDayEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalDayEnergy), "0.00");
            }
        }
        /// <summary>
        /// 进制日发电量，返回两位小数数值
        /// </summary>
        public double upTotalDayEnergy
        {
            get
            {
                return Util.upDigtal(TotalDayEnergy);
            }
        }

        //----- business method ------
        /// <summary>
        /// 取得电站的总发电量
        /// </summary>
        public float TotalEnergy
        {
            get
            {
                float total = 0;
                //有下级电站，那么递归调用下级电站累加
                if (this.childs != null && this.childs.Count > 0)
                {
                    foreach (Plant cplant in this.childs)
                    {
                        total += cplant.TotalEnergy;
                    }

                }
                else//没子电站则累加单元发电量
                {

                    if (this.allFactUnits == null) return total;
                    foreach (PlantUnit unit in allFactUnits)
                    {
                        total += unit.totalEnergy;
                    }
                }
                return total;
            }
        }

        public string TotalEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalEnergy);
            }
        }

        /// <summary>
        /// 电站总发电量，做了单位进制处理，格式化为两位小数,返回字符串
        /// </summary>
        public string DisplayTotalEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalEnergy), "0.00");
            }
        }

        /// <summary>
        /// 电站总发电量，做了单位进制处理，格式化为两位小数,返回数值
        /// </summary>
        public double upTotalEnergy
        {
            get
            {
                return Util.upDigtal(TotalEnergy);
            }
        }

        public string TodayTotalPowerUnit
        {
            get
            {
                return Util.upPowerUnit(TodayTotalPower);
            }
        }

        /// <summary>
        /// 用户页面显示的总功率，做了单位进制,返回两位小数的字符串
        /// </summary>
        public string DisplayTodayTotalPower
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TodayTotalPower), "0.00");
            }
        }

        /// <summary>
        /// 今日实时功率
        /// </summary>
        public float TodayTotalPower
        {
            get
            {
                float total = 0;
                //有下级电站，那么递归调用下级电站累加
                if (this.childs != null && this.childs.Count > 0)
                {
                    foreach (Plant cplant in this.childs)
                    {
                        total += cplant.TodayTotalPower;
                    }

                }
                else//没子电站则累加单元发电量
                {
                    if (allFactUnits == null) return total;
                    foreach (PlantUnit unit in allFactUnits)
                    {
                        total += unit.TodayPower(this.timezone);
                    }
                }
                return total;
            }
        }

        /// <summary>
        /// 总安装功率功率
        /// </summary>
        public float TotalDegignPower
        {
            get
            {
                float total = 0;
                //有下级电站，那么递归调用下级电站累加
                if (this.childs != null && this.childs.Count > 0)
                {
                    foreach (Plant cplant in this.childs)
                    {
                        total += cplant.TotalDegignPower;
                    }

                }
                else//没子电站则累加单元发电量
                {
                    total = this.design_power;
                }
                return total;
            }
        }

        /// <summary>
        /// 环境温度
        /// </summary>
        public double Temperature
        {
            get
            {
                double? _temperature = 0;
                if (allFactUnits == null) return _temperature.Value;
                //先取得电站数据
                foreach (PlantUnit unit in allFactUnits)
                {
                    if (unit.collector.runData != null && unit.collector.runData.temperature != null && unit.collector.runData.sendTime.AddHours(1) >= CalenderUtil.curDateWithTimeZone(this.timezone))
                    {
                        _temperature = unit.collector.runData.temperature;
                        break;
                    }
                }

                //如果没有电站数据才取设备数据
                if (_temperature == null || double.IsNaN(_temperature.Value))
                {
                    Device detector = getFirstDetector();
                    //如果环境监测仪的最后更新时间和电站时间相差1小时范围，那么就用环境监测仪的数据
                    if (detector != null && detector.runData != null && detector.runData.updateTime.AddHours(1) >= CalenderUtil.curDateWithTimeZone(this.timezone))
                    {
                        _temperature = detector.getMonitorValue(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE);

                    }

                }
                return _temperature == null || double.IsNaN(_temperature.Value) ? double.NaN : Math.Round(_temperature.Value, 2);
            }
        }

        /// <summary>
        /// 日照强度
        /// 逻辑变更：
        /// 周辉 17:42:53 
        /// 你搞错啦 ,都应该以电站的数据为准,电站的数据没有才用设备的累计 
        /// 周辉 17:43:07 
        /// 这个跟环境温度,日照等都一样 
        /// 周辉 17:43:16 
        /// 先以电站数据为准
        /// </summary>
        public double? Sunstrength
        {
            get
            {
                if (allFactUnits == null) return null;
                float? tmp = null;
                foreach (PlantUnit unit in allFactUnits)
                {
                    if (unit.collector.runData != null && unit.collector.runData.sunStrength != null && unit.collector.runData.sendTime.AddHours(1) >= CalenderUtil.curDateWithTimeZone(this.timezone))
                    {
                        tmp = unit.collector.runData.sunStrength;
                        break;
                    }
                }
                //如果没有电站数据才取设备数据
                if (tmp == null || float.IsNaN(tmp.Value))
                {
                    //先取得环境监测仪日照强度
                    Device detector = getFirstDetector();
                    //如果环境监测仪的最后更新时间和电站时间相差1小时范围，那么就用环境监测仪的数据
                    if (detector != null && detector.runData != null && detector.runData.updateTime.AddHours(1) >= CalenderUtil.curDateWithTimeZone(this.timezone))
                    {
                        tmp = detector.getMonitorValue(MonitorType.MIC_DETECTOR_SUNLINGHT);
                    }
                }
                return tmp == null || float.IsNaN(tmp.Value) ? 0 : tmp; ;
            }
        }

        /// <summary>
        /// 今日co2减排
        /// </summary>
        public double TodayReductiong
        {
            get
            {
                return computeCO2Reduce(ItemConfig.reductionRate, this.TotalDayEnergy);
            }
        }

        /// <summary>
        /// 累计co2减排
        /// </summary>
        public double Reductiong
        {
            get
            {
                return computeCO2Reduce(ItemConfig.reductionRate, this.TotalEnergy);
            }
        }

        /// <summary>
        /// 根据发电量计算CO2减排
        /// </summary>
        /// <param name="energy"></param>
        /// <returns></returns>
        public static double computeCO2Reduce(double co2ReducationRate, float energy)
        {
            double res = co2ReducationRate * energy;
            return Util.upDigtal(res);
        }

        #endregion Model

        public string predictivedata { get; set; }//电站每月预测值逗号(,)分隔的串

        /// <summary>
        /// 取得某个某个月份的预测值
        /// </summary>
        /// <param name="month"></param>
        /// <returns></returns>
        public double? monthpredictValue(int month)
        {
            if (this.predictivedata == null) return null;
            string[] values = this.predictivedata.Split(',');
            if (month >= values.Length) return null;
            string temp = values[month];
            if (string.IsNullOrEmpty(temp)) return null;
            double res = double.Parse(temp);
            return res;
        }

        public int parentId { get; set; }

        public string plantIds { get; set; }
        /// <summary>
        /// 是否组合电站
        /// </summary>
        public bool isVirtualPlant { get; set; }

        public double revenueRate
        {
            get { return _revenueRate; }
            set { _revenueRate = value; }
        }

        /// <summary>
        /// 收益
        /// </summary>
        public double revenue
        {
            get
            {
                double res = _revenueRate * this.TotalEnergy;

                return res;
            }
        }
        /// <summary>
        /// 前台显示收入，带单位
        /// </summary>
        public string DisplayRevenue
        {
            get
            {
                return Currencies.format(currencies, revenue);
            }
        }
        /// <summary>
        /// 今日收益
        /// </summary>
        public string DisplayTodayRevenue
        {
            get
            {
                double todayRevenue = _revenueRate * TotalDayEnergy;
                return Currencies.format(currencies, todayRevenue);
            }
        }

        /// <summary>
        /// 今日co2减排单位
        /// </summary>
        public string TodayReductiongUnit
        {
            get
            {
                return computeReduceUnit(this.TodayReductiong);
            }
        }

        /// <summary>
        /// 总co2减排单位
        /// </summary>
        public string ReductiongUnit
        {
            get
            {
                return computeReduceUnit(ItemConfig.reductionRate * TotalEnergy);
            }
        }

        /// <summary>
        /// 计算减排单位
        /// </summary>
        /// <param name="reduce"></param>
        /// <returns></returns>
        public static string computeReduceUnit(double reduce)
        {
            return Util.upCo2Unit(reduce);
        }

        /// <summary>
        /// 取得电站的第一张图片
        /// </summary>
        public string firstPic
        {
            get
            {
                //if (isVirtualPlant)
                //{
                //    if (string.IsNullOrEmpty(pic))
                //    {
                //        return "/Images/gf/cimg/npr.jpg";
                //    }
                //    return pic;
                //}
                if (string.IsNullOrEmpty(pic))
                    return string.Empty;
                if (pic.StartsWith(","))
                    pic = pic.Substring(1);
                string[] picArr = pic.Split(',');
                if (picArr.Length > 0)
                    return picArr[0];
                else
                    return "";
            }
        }

        /// <summary>
        /// 用于图表kwh/kwp计算的功率
        /// 实际功率为0的情况下用设计功率
        /// </summary>
        public float chartPower
        {
            get
            {
                float t_dpower = 0;
                if (allFactPlants != null)
                    foreach (Plant p in this.allFactPlants)
                    {
                        t_dpower += p.design_power;

                    }

                if (t_dpower == 0)
                    return 1;
                return t_dpower;
            }
        }

        /// <summary>
        /// 是否有警告，包括超过一天没有数据
        /// </summary>
        public bool isDeviceFault
        {
            get
            {
                if (allFactUnits != null)
                    foreach (PlantUnit unit in this.allFactUnits)
                    {
                        foreach (Device device in unit.displayDevices)
                        {
                            if (device.Over1Day(this.timezone) || device.isFault())
                            {
                                return true;
                            }
                        }
                    }
                return false;
            }
        }

        /// <summary>
        /// 是否有单元警告，即有超过24小时没有发送数据的单元
        /// </summary>
        public bool isUnitFault
        {
            get
            {
                if (allFactUnits == null) return false;
                foreach (PlantUnit unit in this.allFactUnits)
                {
                    if (unit.collector == null) continue;
                    if (unit.collector.stopTime(this.timezone) >= 24)
                    {
                        return true;
                    }
                }
                return false;
            }
        }

        /// <summary>
        /// 是否工作，只要有个一个单元在工作即为工作
        /// </summary>
        public bool isWork
        {
            get
            {
                if (plantUnits == null) return false;
                foreach (PlantUnit unit in this.allFactUnits)
                {
                    if (unit.isWork(this.timezone)) return true;
                }
                return false;
            }
        }

        /// <summary>
        /// 取得一个环境检测仪所在单元
        /// </summary>
        public IList<PlantUnit> sunUnits
        {
            get
            {
                IList<PlantUnit> units = new List<PlantUnit>();
                if (allFactUnits == null) return units;
                foreach (PlantUnit unit in allFactUnits)
                {
                    if (unit.collector.runData != null && unit.collector.runData.sunStrength != null)
                    {
                        units.Add(unit);
                        return units;
                    }
                }
                return units;
            }
        }

        public string startDate { get; set; }
        public string endDate { get; set; }
        public double hours { get; set; }
        public bool dst_enable { get; set; }
        public string area { get; set; }//电站所属区域


        /// <summary>
        /// 1)电站名后出现感叹号的条件
        /// 1)有数据源在规定的时间内未上传数据 暂定一小时
        /// 2)有设备在规定的时间内未上传数据 
        /// </summary>
        /// <returns></returns>
        public bool getStatus
        {
            get
            {
                bool returnValue = false;
                if (this.allFactUnits != null)
                    if (this.allFactUnits.Count == 0)
                        returnValue = true;
                if (this.allFactUnits != null)
                    foreach (PlantUnit pu in this.allFactUnits)
                    {
                        if (returnValue)
                            break;
                        //判断单元是否一小时没上传数据
                        if (pu.over1Hour(this.timezone))
                        {
                            returnValue = true;
                            break;
                        }
                        else
                        {
                            foreach (Device de in pu.devices)
                            {
                                //周辉(745950652)  20120413 9:47:50
                                //隐藏的设备不在告警判断之内 
                                if (de.isHidden) continue;
                                //判断这么多啊，第二个判断(设备的判断时间)的1小时改成24小时 
                                //if (de.Over1Hour(this.timezone))
                                if (de.Over1Day(this.timezone))
                                {
                                    returnValue = true;
                                    break;
                                }
                            }
                        }
                    }
                return returnValue;
            }
        }

        /// <summary>
        /// 取得有增量日照的环境监测仪
        /// </summary>
        /// <returns></returns>
        public Device getDetectorWithRenderSunshine()
        {
            //string yyyMMdd = CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd");
            foreach (Device device in this.deviceList())
            {
                //if (device.isRenderSunlight(yyyMMdd))
                if (device.isRenderSunlight())
                    return device;
            }
            return null;
        }

        /// <summary>
        /// 取得第一个环境监测仪
        /// 优先取工作的，如果都不工作取得非隐藏的
        /// </summary>
        /// <returns></returns>
        public Device getFirstDetector()
        {
            Device displaydevice = null;
            foreach (Device device in this.deviceList())
            {
                if (device.deviceTypeCode == DeviceData.ENVRIOMENTMONITOR_CODE && !device.isHidden)
                {
                    displaydevice = device;
                    if (device.isWork(this.timezone)) return device;
                }
            }
            return displaydevice;
        }

        public DateTime waringLastSendTime { get; set; }

        /// <summary>
        /// 是否有告警的设备
        /// </summary>
        public bool hasFaultDevice
        {
            get
            {
                IList<Device> devices = this.deviceList();
                if (devices != null)
                    foreach (Device dce in devices)
                    {
                        if (!dce.isHidden && dce.isFault())
                            return true;
                    }
                return false;
            }
        }


        private string _longitudeString;

        public string longitudeString
        {
            get
            {
                if (string.IsNullOrEmpty(_longitudeString))
                {
                    return Util.DoubleToDegree(longitude);
                }
                return _longitudeString;
            }
            set
            {
                _longitudeString = value;
            }

        }

        private string _latitudeString;

        public string latitudeString
        {
            get
            {
                if (string.IsNullOrEmpty(_latitudeString))
                {
                    return Util.DoubleToDegree(latitude);
                }
                return _latitudeString;
            }
            set
            {
                _latitudeString = value;
            }

        }


        public string long1
        {
            get
            {
                string[] str = longitudeString.Split(',');
                if (str.Length > 0)
                    return str[0];
                return string.Empty;
            }
        }
        public string long2
        {
            get
            {
                string[] str = longitudeString.Split(',');
                if (str.Length > 1)
                    return str[1];
                return string.Empty;
            }
        }
        public string long3
        {
            get
            {
                string[] str = longitudeString.Split(',');
                if (str.Length > 2)
                    return str[2];
                return string.Empty;
            }
        }



        public string lat1
        {
            get
            {
                string[] str = latitudeString.Split(',');
                if (str.Length > 0)
                    return str[0];
                return string.Empty;
            }
        }
        public string lat2
        {
            get
            {
                string[] str = latitudeString.Split(',');
                if (str.Length > 1)
                    return str[1];
                return string.Empty;
            }
        }
        public string lat3
        {
            get
            {
                string[] str = latitudeString.Split(',');
                if (str.Length > 2)
                    return str[2];
                return string.Empty;
            }
        }

        /// <summary>
        /// 根据单元id取得某个单元的图表功率（即设计功率为0，则取1保证不会有除0情况出现），
        /// 对于只有一个单元的电站，取电站的设计功率，多余一个单元的电站，取对于单元的设计功率
        /// </summary>
        /// <param name="unitId"></param>
        /// <returns></returns>
        public float unitPower(long unitId)
        {
            if (this.allFactUnits.Count < 2)
            {
                return this.chartPower;
            }
            foreach (PlantUnit unit in allFactUnits)
            {
                if (unit.id == unitId)
                {
                    return unit.chartPower;
                }
            }
            return 1;
        }

        /// <summary>
        /// 下级电站集合
        /// </summary>
        public IList<Plant> childs { get; set; }
        /// <summary>
        /// 上一级电站
        /// </summary>
        public Plant parentPlant { get; set; }


        public IList<ElecPrice> ElecPriceList { get; set; }

        /// <summary>
        /// 取得电站的最上级电站,没有上一级的电站，最高层次电站就是本身
        /// 采用递归算法
        /// </summary>
        /// <returns></returns>
        public Plant getTopParentlant()
        {
            Plant parentPlant = this.parentPlant;
            if (parentPlant == null) return this;
            else
                return parentPlant.getTopParentlant();
        }

        /// <summary>
        /// 配置的“峰"价格表
        /// </summary>
        public ElecPrice FPrice
        {
            get
            {
                ElecPrice item = null;
                if (ElecPriceList != null && ElecPriceList.Count > 0)
                {
                    item = ElecPriceList.Where(m => m.ptype.Equals(ElecPrice.Feng)).FirstOrDefault<ElecPrice>();
                }
                if (item == null)
                    item = new ElecPrice();
                return item;
            }
        }


        /// <summary>
        /// 配置的“谷"价格表
        /// </summary>
        public ElecPrice GPrice
        {
            get
            {
                ElecPrice item = null;
                if (ElecPriceList != null && ElecPriceList.Count > 0)
                {

                    item = ElecPriceList.Where(m => m.ptype.Equals(ElecPrice.Gu)).FirstOrDefault<ElecPrice>();
                }
                if (item == null)
                    item = new ElecPrice();
                return item;
            }
        }


        /// <summary>
        /// 配置的“平"价格表
        /// </summary>
        public ElecPrice PPrice
        {
            get
            {
                ElecPrice item = null;
                if (ElecPriceList != null && ElecPriceList.Count > 0)
                {

                    item = ElecPriceList.Where(m => m.ptype.Equals(ElecPrice.Ping)).FirstOrDefault<ElecPrice>();
                }
                if (item == null)
                    item = new ElecPrice();
                return item;
            }
        }

        /// <summary>
        /// 配置的“尖"价格表
        /// </summary>
        public ElecPrice JPrice
        {
            get
            {
                ElecPrice item = null;
                if (ElecPriceList != null && ElecPriceList.Count > 0)
                {
                    item = ElecPriceList.Where(m => m.ptype.Equals(ElecPrice.Jian)).FirstOrDefault<ElecPrice>();
                }
                if (item == null)
                    item = new ElecPrice();
                return item;
            }
        }
        /// <summary>
        /// 取得所有实际电站,如果是实际电站 就是自己
        /// </summary>
        /// <returns></returns>
        public IList<Plant> allFactPlants
        {
            get
            {
                IList<Plant> factPlants = new List<Plant>();
                if (this.childs != null && this.childs.Count > 0)
                {
                    foreach (Plant plant in childs)
                    {
                        foreach (Plant p in plant.allFactPlants)
                        {
                            factPlants.Add(p);
                        }
                    }
                }
                else
                {
                    factPlants.Add(this);
                }
                return factPlants;
            }
        }

        /// <summary>
        /// 取得所有实际电站的单元
        /// </summary>
        /// <returns></returns>
        public IList<PlantUnit> allFactUnits
        {
            get
            {
                IList<PlantUnit> factPlantUnits = new List<PlantUnit>();
                if (this.allFactPlants != null && this.allFactPlants.Count > 0)
                {
                    foreach (Plant plant in this.allFactPlants)
                    {
                        if (plant.plantUnits != null)
                            foreach (PlantUnit p in plant.plantUnits)
                            {
                                factPlantUnits.Add(p);
                            }
                    }
                }
                return factPlantUnits;
            }
        }

        //年补偿
        public IList<YearCompensation> yearCompensation { get; set; }

        //发电量比例系数
        public double? energyRate { get; set; }    //下线比率系数
        public double? maxEnergyRate { get; set; } //上线比率系数

        public DateTime lastHandleDate { get; set; }//设备发电量告警最后处理日期，默认是功能上线时间，数据库要设置默认时间为当前时间

        public bool rateEnable { get; set; }        //是否启用比例系数

    }
}
