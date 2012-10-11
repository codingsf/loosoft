using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
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
                if (this.displayPlants == null) return res;
                foreach (Plant p in this.displayPlants)
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

        /// <summary>
        /// 所有关联的电站
        /// </summary>
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

        /// <summary>
        /// 
        /// 取得用户关联的电站，包括自己创建后建立的关联关系以及别人分配的
        /// 
        /// </summary>
        /// <returns></returns>
        public IList<Plant> relatedPlants
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

        /// <summary>
        /// 
        /// 取得自己创建的可管理的电站，不是别人分配的，shared=false
        /// add by qhb in 20120915 for
        /// </summary>
        /// <returns></returns>
        public IList<Plant> ownPlants
        {
            get
            {
                IList<Plant> _plantList = new List<Plant>();
                if (this.plantUsers == null) return _plantList;

                foreach (PlantUser plantUser in this.plantUsers)
                {
                    if (plantUser.plant != null && !plantUser.shared)
                        _plantList.Add(plantUser.plant);
                }
                return _plantList;
            }
        }

        /// <summary>
        /// 取得所分配的电站，不包括用户本身创建的电站，都是别人分配给他的电站
        /// 从18版后出现，改自原先的public IList<Plant> plants方法，原方法随着新门户业务的出现，语义不在清楚了
        /// </summary>
        /// <returns></returns>
        public IList<Plant> assignedPlants
        {
            get
            {
                IList<Plant> _plantList = new List<Plant>();
                if (this.plantUsers == null) return _plantList;

                foreach (PlantUser plantUser in this.plantUsers)
                {
                    if (plantUser.plant != null && plantUser.shared)
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

        /// <summary>
        /// 进制显示总今日发电量，凡是字符串
        /// </summary>
        public string DisplayTotalDayEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalDayEnergy), "0.00");
            }
        }

        /// <summary>
        /// 进制总今日发电量，返回数值型
        /// </summary>
        public double upTotalDayEnergy
        {
            get
            {
                return Util.upDigtal(TotalDayEnergy);
            }
        }

        /// <summary>
        /// 用户下所有关联电站的总今日发电量
        /// </summary>
        public float TotalDayEnergy
        {
            get
            {
                float total = 0;
                IList<Plant> plantList = this.displayPlants;
                if (plantList == null) return total;
                foreach (Plant plant in plantList)
                {
                    total += plant.TotalDayEnergy;
                }
                return total;
            }
        }

        /// <summary>
        /// 进制显示总发电量
        /// </summary>
        public string DisplayTotalEnergy
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalEnergy), "0.00");
            }
        }

        /// <summary>
        /// 进制总发电量
        /// </summary>
        public double upTotalEnergy
        {
            get
            {
                return Util.upDigtal(TotalEnergy);
            }
        }

        /// <summary>
        /// 用户所有电站的累计发电，包括自己创建的和别人分配过来的
        /// </summary>
        public float TotalEnergy
        {
            get
            {
                float total = 0;
                IList<Plant> plantList = this.displayPlants;
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
                IList<Plant> plantList = this.displayPlants;
                if (plantList == null) return total;

                foreach (Plant plant in plantList)
                {
                    foreach (PlantUnit unit in plant.allFactUnits)
                    {
                        total += unit.TodayPower(plant.timezone);
                    }
                }
                return total;
            }
        }
        /// <summary>
        /// 用于前台显示的总实时功率
        /// </summary>
        public string DisplayTotalPower
        {
            get
            {
                return StringUtil.formatDouble(Util.upDigtal(TotalPower), "0.00");
            }
        }

        /// <summary>
        /// 进制实时功率，返回数值型
        /// </summary>
        public double upTotalPower
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
        /// 取得用户的所有自己创建管理的电站单元
        /// </summary>
        /// <returns></returns>
        public IList<PlantUnit> ownplantUnits()
        {
            IList<PlantUnit> plantUnits = new List<PlantUnit>();
            foreach (Plant plant in this.ownPlants)
            {
                foreach (PlantUnit unit in plant.allFactUnits)
                {
                    plantUnits.Add(unit);
                }
            }
            return plantUnits;
        }


        /// <summary>
        /// 取得用户的所有电站单元
        /// </summary>
        /// <returns></returns>
        public IList<PlantUnit> plantUnits()
        {
            IList<PlantUnit> plantUnits = new List<PlantUnit>();
            foreach (Plant plant in this.displayPlants)
            {
                foreach (PlantUnit unit in plant.allFactUnits)
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
                if (this.displayPlants != null)
                    foreach (Plant plant in this.displayPlants)
                        if (plant.hasFaultDevice)
                            return true;
                return false;
            }
        }

        public IList<Role> Roles { get; set; }

        /// <summary>
        /// 用户创建的顶层电站
        /// </summary>
        public IList<Plant> createToplevelPlants { get; set; }

        /// <summary>
        /// 在bank里面显示的电站，包括自己创建的顶层电站和别人分配过来的电站
        /// 自己创建的电站也会在有关系表
        /// </summary>
        /// <returns></returns>
        public IList<Plant> displayPlants
        {
            get
            {
                //IList<Plant> plants = this.createToplevelPlants;
                //if (plants == null)
                //{
                // plants = new List<Plant>();
                //}
                //if (this.relatedPlants!=null)
                //plants.Union(this.assignedPlants);
                return relatedPlants;
            }
        }

        /// <summary>
        /// 取得所有分配的电站中所有实际电站
        /// </summary>
        public IList<Plant> allAssignedFactPlants
        {
            get
            {
                IList<Plant> factPlants = new List<Plant>();
                foreach (Plant plant in assignedPlants)
                {
                    foreach (Plant p in plant.allFactPlants)
                    {
                        factPlants.Add(p);
                    }
                }
                return factPlants;
            }
        }

        /// <summary>
        /// 取得所有管理的电站中所有实际电站
        /// </summary>
        public IList<Plant> allOwnFactPlants
        {
            get
            {
                IList<Plant> factPlants = new List<Plant>();
                foreach (Plant plant in ownPlants)
                {
                    foreach (Plant p in plant.allFactPlants)
                    {
                        factPlants.Add(p);
                    }
                }
                return factPlants;
            }
        }

        /// <summary>
        /// 当前用户下任何一个电站有绑定采集器
        /// </summary>
        public bool isBindUnit
        {
            get
            {
                return this.ownplantUnits().Count > 0;
            }
        }

        public bool isBigCustomer { get; set; }


        public IList<RelationConfig> configs { get; set; }

        public Template template { get; set; }//模板对象

        public string logo { get; set; }

        public string sysName { get; set; }//系统名称

    }
}
