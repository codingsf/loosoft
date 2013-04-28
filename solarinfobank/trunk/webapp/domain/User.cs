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
    /// bank系统里面用户性质有两种：
    /// 1.一般用户，可以访问的是标准bank系统
    /// 2.门户用户，访问门户系统
    /// 系统中的用户只能是是其中之一，要么能访问标准bank系统，要么能访问门户用户，不允许两个功能都能访问，但是二者入口
    /// 是一样的，登录会根据器用户性质做不同跳转。两种性质用户都存在userinfo表中，用isBigCustomer做区分的，true标识是门户用户，false表示一般用户
    /// 一般用户都是有角色的，注册的用户默认都是系统管理员角色，有系统管理员创建的用户（包括已有或者新增的）都有另外角色，门户用户没有角色
    /// 有系统管理员创建的用户和其创建者有所属关系，用外键parentUserId建立关联
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
        private int _parentUserId;  //创建者id
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
        /// 是否门户用户，用于区分一般电站管理用户和门户用户
        /// </summary>
        public bool isBigCustomer { get; set; }
        /// <summary>
        /// 门户用户对涉及到的相关结构图的设置参数
        /// </summary>
        public IList<RelationConfig> configs { get; set; }
        /// <summary>
        /// 用户选择的模版
        /// </summary>
        public Template template { get; set; }//模板对象
        /// <summary>
        /// 门户用户设置的门户logo
        /// </summary>
        public string logo { get; set; }
        /// <summary>
        /// 门户用户设置的门户系统名称
        /// </summary>
        public string sysName { get; set; }
        /// <summary>
        /// 一般用户对应电站概览和实时数据自动刷新的开关状态
        /// </summary>
        public bool autoRefresh { get; set; }
        /// <summary>
        /// 一般用户设置的自动定时刷新的时间间隔
        /// </summary>
        public int refreshInterval { get; set; }
        /// <summary>
        /// 自动刷新功能开启时间
        /// </summary>
        public DateTime refreshStartDate { get; set; }

        private IList<PlantPortalUser> _plantPortalUsers;
        /// <summary>
        /// 用户关联的门户用户电站对象集合
        /// 用户对应的门户电站从这个集合取得
        /// </summary>
        public IList<PlantPortalUser> plantPortalUsers
        {
            get
            {
                return _plantPortalUsers;
            }
            set
            {
                _plantPortalUsers = value;
            }
        }

        /// <summary>
        /// 一般用户和电站的对应关系集合，包括自己创建的和别人分配过来的
        /// </summary>
        public IList<PlantUser> plantUsers { get; set; }

        private UserRole _userRole;
        /// <summary>
        /// 用户对应的用户角色对象，目前系统用户和用户角色是一对一关系
        /// </summary>
        public UserRole userRole
        {
            get {
                return _userRole; 
            }
            set
            {
                _userRole = value;
            }
        }

        /// <summary>
        /// 是否允许大屏幕展示
        /// </summary>
        public bool bigscreenEnable { get; set; }

        /// <summary>
        /// 系统管理员用户创建的其他一般用户集合
        /// isBigCustomer=false
        /// </summary>
        private IList<User> _childUsers;
        public IList<User> childUsers
        {
            get { return _childUsers; }
            set
            {
                _childUsers = value;
            }
        }

        /// <summary>
        /// 系统管理员创建的门户用户集合
        /// isBigCustomer=true
        /// </summary>
        private IList<User> _childPortalUsers;
        public IList<User> childPortalUsers
        {
            get { return _childPortalUsers; }
            set
            {
                _childPortalUsers = value;
            }
        }

        /// <summary>
        /// 
        /// 取得一般用户关联的顶层电站，包括自己创建后建立的关联关系以及别人分配的
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
        /// 取得一般用户自己创建的顶层电站，不是别人分配的，shared=false
        /// add by qhb in 20120915
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
        /// 取得所分配的顶层电站，不包括一般用户本身创建的电站，都是别人分配给他的电站
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

        /// <summary>
        /// 
        /// 取得门户用户关联的顶层电站，门户用户的电站从业务上说只会是电站创建者（是一般用户）分配过来的
        /// 从18版后出现，改自原先的public IList<Plant> plants方法，原方法随着新门户业务的出现，语义不在清楚了
        /// </summary>
        /// <returns></returns>
        public IList<Plant> assignedPortalPlants
        {
            get
            {
                IList<Plant> _plantList = new List<Plant>();
                if (this.plantPortalUsers == null) return _plantList;

                foreach (PlantPortalUser plantUser in this.plantPortalUsers)
                {
                    if (plantUser.plant != null)
                        _plantList.Add(plantUser.plant);
                }
                return _plantList;
            }
        }
        
        /// <summary>
        /// 今日申请的采集器数量
        /// </summary>
        public int todayApplyCollectorCount { get; set; }

        /// <summary>
        /// 最后申请采集器的时间
        /// </summary>
        public DateTime lastApplyCollectorDate { get; set; }

        #endregion Model

        /// <summary>
        /// 用户累计日发电量单位，包含进制规则
        /// </summary>
        public string TotalDayEnergyUnit
        {
            get
            {
                return Util.upEnergyUnit(TotalDayEnergy);
            }
        }

        /// <summary>
        /// 进制显示总今日发电量，返回字符串，格式化为“0.00”
        /// </summary>
        public string DisplayTotalDayEnergy
        {
            get
            {
                return StringUtil.formatDouble(upTotalDayEnergy, "0.00");
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
        /// 用户下所有关联电站的总今日发电量，不进制
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
                if (this.plantPortalUsers.Count > 0)
                {
                    return plantPortalUsers[0].plant;
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
        public IList<PlantUnit> ownPlantUnits()
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
        /// <summary>
        /// 是否有告警设备
        /// 所有的电站中只要有一个即是有告警设备
        /// </summary>
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

        /// <summary>
        /// 一般用户创建的角色集合，一个用户可以创建多个角色
        /// </summary>
        public IList<Role> Roles { get; set; }

        /// <summary>
        /// 用户创建的顶层电站
        /// 这个和ownPlants实际是一样的
        /// </summary>
        public IList<Plant> createToplevelPlants { get; set; }

        /// <summary>
        /// 用户显示的顶层电站列表，一般用户和门户用户各取不同集合列表
        /// </summary>
        /// <returns>顶层电站列表</returns>
        public IList<Plant> displayPlants
        {
            get
            {
                //门户用户取得分配的门户电站
                if(this.isBigCustomer)
                    return assignedPortalPlants;
                else
                    return relatedPlants;
            }
        }

        /// <summary>
        /// 取得所有分配的电站中所有实际电站
        /// 一般用户和门户所取的集合不同
        /// 一般用户：assignedPlants
        /// 门户用户：assignedPortalPlants
        /// </summary>
        public IList<Plant> allAssignedFactPlants
        {
            get
            {
                
                IList<Plant> factPlants = new List<Plant>();
                IList<Plant> plants = this.isBigCustomer ? this.assignedPortalPlants : assignedPlants;
                foreach (Plant plant in plants)
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
        /// 取得一般用户所拥有的的电站中所有实际电站
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
        /// 取得一般用户所关联的的电站中所有实际电站
        /// </summary>
        public IList<Plant> allRelatedFactPlants
        {
            get
            {
                IList<Plant> factPlants = new List<Plant>();
                foreach (Plant plant in relatedPlants)
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
                return this.ownPlantUnits().Count > 0;
            }
        }

        /// <summary>
        /// 用户设置的自动刷新的毫秒间隔
        /// </summary>
        public int refreshIntervalMS
        {
            get
            {
                return refreshInterval * 1000;
            }
        }
        /// <summary>
        /// 电站数据刷新功能开启时间，返回"yyyy-MM-dd"
        /// </summary>
        public string refreshStartDateFormat
        {
            get
            {
                return refreshStartDate.ToString("yyyy-MM-dd");
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
        /// <summary>
        /// 显示显示的格式化的收益
        /// </summary>
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
        /// 全屏幕LOGO
        /// </summary>
        public string BigScreenLogoPath { get; set; }

        /// <summary>
        /// 获取全屏LOGO
        /// </summary>
        public string BigScreenLogoFomartPath {
            get
            {
                if (string.IsNullOrEmpty(BigScreenLogoPath))
                    return "/bigscreen/images/logo.png";
                return BigScreenLogoPath;
            }
        }


        public DateTime createDate { get; set; }//创建时间

    }
}