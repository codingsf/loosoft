using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：电站和一般用户的关系
    /// 一般用户只能共享顶层电站
    /// 组合电站也可以被
    /// 作者：张月
    /// 时间：2011年4月24日
    /// </summary>
    [Serializable]
    public class PlantUser
    {
        public PlantUser() { }
        public PlantUser(int id, int plantID, int userID)
        {
            this.id = id;
            this.plantID = plantID;
            this.userID = userID;
        }
        private int _id;//id 自增
        public int id
        {
            get
            {
                return _id;
            }
            set
            {
                _id = value;
            }
        }
        private int _plantID; //电站id 非空
        public int plantID
        {
            get
            {
                return _plantID;
            }
            set
            {
                _plantID = value;
            }
        }

        private int _userID;//用户id 非空
        public int userID
        {
            get
            {
                return _userID;
            }
            set
            {
                _userID = value;
            }
        }

        private string _username;
        public string username
        {
            get
            {
                return _username;
            }
            set
            {
                _username = value;
            }
        }
        private Plant _plant;
        /// <summary>
        /// 一般用户对应的电站，这个电站一定是顶层电站
        /// </summary>
        public Plant plant
        {
            get
            {
                return _plant;
            }
            set
            {
                _plant = value;
            }
        }
        /// <summary>
        /// 一般用户对这个电站具有的角色
        /// 
        /// </summary>
        public int roleId { get; set; }

        /// <summary>
        /// 是否是被别人分配过来的电站,true:是别人分配的，false是自己创建并管理的
        /// 和电站的userid字段意思是一致的
        /// 
        /// </summary>
        /// </summary>
        public bool shared { get; set; }
    }
}