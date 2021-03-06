﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;

namespace Cn.Loosoft.Zhisou.SunPower.Service.vo
{
    /// <summary>
    /// 峰谷平尖数据vo
    /// </summary>
    public class TIMEFGPJVO
    {
        /// <summary>
        /// 统计时间
        /// </summary>
        public string time { get; set; }
        /// <summary>
        /// 发电量
        /// </summary>
        public double energy { get; set; }
        
        /// <summary>
        /// 峰谷平尖数据组
        /// </summary>
        public double?[] fgpjdata { get; set; }

    }

    /// <summary>
    /// 峰谷平尖数据vo
    /// </summary>
    public class FGPJVO
    {
        /// <summary>
        /// 电站名称
        /// </summary>
        public string plantName { get; set; }

        /// <summary>
        /// 当前功率
        /// </summary>
        public float power { get; set; }

        /// <summary>
        /// 峰谷平尖数据组
        /// </summary>
        public IList<TIMEFGPJVO> timevos { get; set; }

    }

    /// <summary>
    /// 电站用户vo
    /// </summary>
    public class PlantUserVO {

        public PlantUserVO(User user, Role role)
        {
            this.user = user;
            this.plantRole = role;
        }
        /// <summary>
        /// 用户
        /// </summary>
        public User user { get; set; }

        /// <summary>
        /// 电站角色
        /// </summary>
        public Role plantRole { get; set; }

    
    }
}
