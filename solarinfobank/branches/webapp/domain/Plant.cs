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
                if (plantUnits != null)
                    foreach (PlantUnit unit in plantUnits)
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
            if (plantUnits == null) return deviceList;
            foreach (PlantUnit unit in this.plantUnits)
            {
                foreach (Device d in unit.devices)
                {
                    deviceList.Add(d);
                }
            }
            return deviceList;
        }

        /// <summary>
        /// 电站下的所有设备
        /// </summary>
        /// <returns></returns>
        public IList<Device> displayDevices()
        {
            IList<Device> deviceList = new List<Device>();
            if (plantUnits == null) return deviceList;
            foreach (PlantUnit unit in this.plantUnits)
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
        public IList<Device> typeDevices(int deviceType,bool isHidden)
        {
            IList<Device> typeDevices = new List<Device>();
            if (plantUnits == null) return typeDevices;
            foreach (Device device in this.deviceList())
            {
                if (device.deviceTypeCode == deviceType && isHidden == device.isHidden)
                {
                    typeDevices.Add(device);
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


        public float TotalDayEnergy
        {
            get
            {
                string curDate = CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd");
                float total = 0;
                if (plantUnits != null)
                    foreach (PlantUnit unit in plantUnits)
                    {
                        total += unit.TodayEnergy(this.timezone);
                        //    if (unit.collector.runData != null)
                        //    {

                        //        float daye = !CalenderUtil.formatDate(unit.collector.runData.sendTime, "yyyyMMdd").Equals(curDate) ? 0 : unit.collector.runData.dayEnergy;
                        //        total += daye;
                        //    }
                    }
                return total;
            }
        }

        public string TotalDayEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalDayEnergy);
            }

        }

        public double upTotalDayEnergy
        {
            get
            {
                return Util.upDigtal(TotalDayEnergy);
            }
        }

        public string DisplayTotalDayEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalDayEnergy),"0.00");
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
                if (this.plantUnits == null) return total;
                foreach (PlantUnit unit in plantUnits)
                {
                    total += unit.totalEnergy;
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

        public double upTotalEnergy
        {
            get
            {
                return Util.upDigtal(TotalEnergy);
            }
        }

        public string DisplayTotalEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalEnergy),"0.00");
            }
        }

        /// <summary>
        /// 今日功率
        /// </summary>
        public float TodayTotalPower
        {
            get
            {
                float total = 0;
                if (plantUnits == null) return total;
                foreach (PlantUnit unit in plantUnits)
                {
                    if (unit.collector.runData != null && CalenderUtil.formatDate(unit.collector.runData.sendTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd")))
                        total += unit.TodayPower(this.timezone);
                }
                return float.Parse(Math.Round(total, 2).ToString());
            }
        }

        /// <summary>
        /// 环境温度
        /// </summary>
        public double Temperature
        {
            get
            {
                float _temperature = 0;
                if (plantUnits == null) return _temperature;
                foreach (PlantUnit unit in plantUnits)
                {
                    if (unit.collector.runData != null && unit.collector.runData.temperature != null && CalenderUtil.formatDate(unit.collector.runData.sendTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd")))
                    {
                        _temperature = float.Parse(unit.collector.runData.temperature.ToString());

                        break;
                    }
                }
                return _temperature;
            }
        }

        /// <summary>
        /// 日照强度
        /// </summary>
        public double? Sunstrength
        {
            get
            {
                if (plantUnits == null) return null;
                foreach (PlantUnit unit in plantUnits)
                {
                    if (unit.collector.runData != null && unit.collector.runData.sunStrength != null && CalenderUtil.formatDate(unit.collector.runData.sendTime, "yyyyMMdd").Equals(CalenderUtil.curDateWithTimeZone(this.timezone, "yyyyMMdd")))
                    {
                        return unit.collector.runData.sunStrength;
                    }

                }
                return null;
            }
        }

        /// <summary>
        /// co2减排
        /// </summary>
        public double TodayReductiong
        {
            get
            {
                return computeCO2Reduce(ItemConfig.reductionRate, this.TotalDayEnergy);
            }
        }

        /// <summary>
        /// co2减排
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
                if (this.design_power == 0)
                    return 1;
                return design_power;
            }
        }

        /// <summary>
        /// 是否有警告，包括超过一天没有数据
        /// </summary>
        public bool isDeviceFault
        {
            get
            {
                if (plantUnits != null)
                    foreach (PlantUnit unit in this.plantUnits)
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
                if (plantUnits == null) return false;
                foreach (PlantUnit unit in this.plantUnits)
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
                foreach (PlantUnit unit in this.plantUnits)
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
                if (plantUnits == null) return units;
                foreach (PlantUnit unit in plantUnits)
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
                if (this.plantUnits != null)
                    if (this.plantUnits.Count == 0)
                        returnValue = true;
                if (this.plantUnits != null)
                    foreach (PlantUnit pu in this.plantUnits)
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

        public DateTime waringLastSendTime { get; set; }

        /// <summary>
        /// 是否有告警的设备,隐藏的设备不算
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
        /// 更加单元id取得某个单元的图表功率（即设计功率为0，则取1保证不会有除0情况出现），
        /// 对于只有一个单元的电站，取电站的设计功率，多余一个单元的电站，取对于单元的设计功率
        /// </summary>
        /// <param name="unitId"></param>
        /// <returns></returns>
        public float unitPower(long unitId) {
            if (this.plantUnits.Count < 2) {
                return this.chartPower;
            }
            foreach (PlantUnit unit in plantUnits) {
                if (unit.id == unitId) {
                    return unit.chartPower;
                }
            }
            return 1;
        }
    }
}
