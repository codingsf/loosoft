using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// userinfo:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public class User
    {
        public User()
        { }
        public User(int id)
        {
            _id = id;
        }

        #region Model
        private int _id;
        private string _username;
        private string _password;
        private string _organize;
        private string _sex;
        private string _fullname;
        private string _address;
        private string _postalcode;
        private string _email;
        private string _city;
        private string _country;
        private string _tel;
        private long _languageid;
        private double _revenueRate;
        private string _mobilePhone;
        private string _faxPhone;

        private string _currencies; //货币种类
        private string _temperatureType;

        private string _firstName;


        private string _lastName;

        private int _parentUserId;

        private IList<PlantUser> _plantUsers;

        /// <summary>
        /// auto_increment
        /// 编号  非空  主键自增
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }

        public double revenueRate
        {
            get { return _revenueRate; }
            set { _revenueRate = value; }
        }

        public string LastName
        {
            get { return _lastName; }
            set { _lastName = value; }
        }

        public string FirstName
        {
            get { return _firstName; }
            set { _firstName = value; }
        }
        public int ParentUserId
        {
            get
            {
                return _parentUserId;
            }
            set
            {
                _parentUserId = value;
            }
        }
        /// <summary>
        /// 收益
        /// </summary>
        public double revenue
        {
            get
            {
                double res = 0;
                if (this.plants == null) return res;
                foreach (Plant p in this.plants)
                {
                    res += p.revenue;
                }
                return res;
            }
        }


        public string DisplayRevenue
        {
            get
            {
                if (currencies != null && currencies.ToLower().Equals("￥"))
                {
                    string revenueString = string.Empty;
                    revenueString = revenue.ToString("####-####-####-####");
                    revenueString = revenueString.Replace('-', ',');
                    while (true)
                    {
                        if (revenueString.StartsWith(","))
                            revenueString = revenueString.Substring(1);
                        else
                            break;
                    }
                    return revenueString;
                }
                return revenue.ToString("N0");
            }

        }

        /// <summary>
        /// 用户名  非空  
        /// </summary>
        public string username
        {
            set { _username = value; }
            get { return _username; }
        }
        /// <summary>
        /// 密码  非空
        /// </summary>
        public string password
        {
            set { _password = value; }
            get { return _password; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string organize
        {
            set { _organize = value; }
            get { return _organize; }
        }
        /// <summary>
        /// 性别  非空
        /// </summary>
        public string sex
        {
            set { _sex = value; }
            get { return _sex; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string fullname
        {
            set { _fullname = value; }
            get { return _fullname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string address
        {
            set { _address = value; }
            get { return _address; }
        }
        public string postalcode
        {
            get { return _postalcode; }
            set { _postalcode = value; }
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
        public string city
        {
            set { _city = value; }
            get { return _city; }
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
        public string tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        /// <summary>
        /// 
        /// </summary>
        public long languageId
        {
            set { _languageid = value; }
            get { return _languageid; }
        }
        public string currencies
        {
            get { return _currencies; }
            set { _currencies = value; }
        }

        public string mobilePhone
        {
            get { return _mobilePhone; }
            set { _mobilePhone = value; }
        }

        public string faxPhone
        {
            get { return _faxPhone; }
            set { _faxPhone = value; }
        }

        public IList<PlantUser> plantUsers
        {
            get
            {

                return _plantUsers;
            }
            set
            {
                _plantUsers = value;
            }
        }

        private UserRole _userRole;
        public UserRole UserRole
        {
            get { return _userRole; }
            set
            {
                _userRole = value;
            }
        }
        private IList<User> _childUsers;
        public IList<User> ChildUsers
        {
            get { return _childUsers; }
            set
            {
                _childUsers = value;
            }
        }

        public IList<Plant> plants
        {
            get
            {
                IList<Plant> _plantList = new List<Plant>();
                if (this.plantUsers == null) return _plantList;

                foreach (PlantUser plantUser in this.plantUsers)
                {
                    if (plantUser.plant != null)
                        _plantList.Add(plantUser.plant);
                }
                return _plantList;
            }
        }


        public int todayApplyCollectorCount { get; set; }//今日申请的采集器数量

        public DateTime lastApplyCollectorDate { get; set; }//最后申请采集器的时间

        #endregion Model

        public string TotalDayEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalDayEnergy);
            }
        }

        public double DisplayTotalDayEnergy
        {
            get
            {
                return Util.upDigtal(TotalDayEnergy);
            }
        }

        public float TotalDayEnergy
        {
            get
            {
                float total = 0;
                IList<Plant> plantList = this.plants;
                if (plantList == null) return total;
                foreach (Plant plant in plantList)
                {
                    total += plant.TotalDayEnergy;
                }
                return total;
            }
        }

        public double DisplayTotalEnergy
        {
            get
            {
                return Util.upDigtal(TotalEnergy);
            }
        }

        public float TotalEnergy
        {
            get
            {
                float total = 0;
                IList<Plant> plantList = this.plants;
                if (plantList == null) return total;

                foreach (Plant plant in plantList)
                {
                    total += plant.TotalEnergy;
                }
                return total;
            }
        }

        /// <summary>
        /// 提供家庭日用电户数
        /// </summary>
        public int TotalFamilies
        {
            get
            {
                return (int)(TotalEnergy / 8);
            }
        }

        public int TotalTrees
        {
            get
            {
                return (int)(TotalEnergy * ItemConfig.defaultreductionRate / ItemConfig.treeConvert);
            }
        }

        public string TotalEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalEnergy);
            }
        }

        public float TotalPower
        {
            get
            {
                float total = 0;
                IList<Plant> plantList = this.plants;
                if (plantList == null) return total;

                foreach (Plant plant in plantList)
                {
                    total += plant.TodayTotalPower;
                }
                return total;
            }
        }

        public double DisplayTotalPower
        {
            get
            {
                return Util.upDigtal(TotalPower);
            }
        }

        public string TotalPowerUnit
        {
            get
            {
                double power = TotalPower;
                return Util.upPowerUnit(power);
            }
        }


        // business method
        public Plant firstPlant
        {
            get
            {
                if (this.plantUsers.Count > 0)
                {
                    return plantUsers[0].plant;
                }
                else
                {
                    return null;
                }
            }
        }

        private int _timezone;
        /// <summary>
        /// 
        /// </summary>
        public int timezone
        {
            set { _timezone = value; }
            get { return _timezone; }
        }

        /// <summary>
        /// 总co2减排,用发电量
        /// </summary>
        public double TotalReductiong
        {
            get
            {
                return computeCo2Reduce(this.TotalEnergy * ItemConfig.reductionRate);
            }
        }

        /// <summary>
        /// 总co2减排单位
        /// </summary>
        public string TotalReductiongUnit
        {
            get
            {
                return computeCo2ReduceUnit(this.TotalEnergy * ItemConfig.reductionRate);
            }
        }

        /// <summary>
        /// 今日co2减排,用发电量
        /// </summary>
        public double TodayReductiong
        {
            get
            {
                return computeCo2Reduce(this.TotalDayEnergy * ItemConfig.reductionRate);
            }
        }

        /// <summary>
        /// 今日co2减排单位
        /// </summary>
        public string TodayReductiongUnit
        {
            get
            {
                return computeCo2ReduceUnit(this.TotalDayEnergy * ItemConfig.reductionRate);
            }
        }

        /// <summary>
        /// 格式化co2减排
        /// </summary>
        /// <param name="co2reduction"></param>
        /// <returns></returns>
        public double computeCo2Reduce(double co2reduction)
        {
            return Util.upDigtal(co2reduction);
        }


        /// <summary>
        /// 计算co2减排单位
        /// </summary>
        /// <param name="co2reduction"></param>
        /// <returns></returns>
        public string computeCo2ReduceUnit(double co2reduction)
        {
            return Util.upCo2Unit(co2reduction);
        }


        public string TemperatureType
        {
            get { return _temperatureType; }
            set { _temperatureType = value; }
        }

        private Language _language;
        public Language Language
        {
            get { return _language; }
            set { _language = value; }
        }

        /// <summary>
        /// 前台显示名称
        /// </summary>
        public string displayNick
        {
            get
            {
                if (string.IsNullOrEmpty(this.FirstName + this.LastName))
                    return this.username;
                else
                    return this.FirstName + " " + this.LastName;
            }
        }

        /// <summary>
        /// 取得用户的所有电站单元
        /// </summary>
        /// <returns></returns>
        public IList<PlantUnit> plantUnits()
        {
            IList<PlantUnit> plantUnits = new List<PlantUnit>();
            foreach (Plant plant in plants)
            {
                foreach (PlantUnit unit in plant.plantUnits)
                {
                    plantUnits.Add(unit);
                }
            }
            return plantUnits;
        }

        /// <summary>
        /// 解密后的密码
        /// </summary>
        public string depassword
        {
            get
            {
                return EncryptUtil.DecryptDES(this.password, EncryptUtil.defaultKey);
            }
        }

        public int menuDisplayCount { get; set; }

        public int overviewDisplayCount { get; set; }

        public bool hasFaultDevice
        {
            get
            {
                if (plants != null)
                    foreach (Plant plant in this.plants)
                        if (plant.hasFaultDevice)
                            return true;
                return false;
            }
        }

    }
}
