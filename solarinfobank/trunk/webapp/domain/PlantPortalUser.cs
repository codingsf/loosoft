using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 功能：电站和门户用户的关系
    /// 只能关联顶层电站
    /// 门户用户电站只能是被分配过来的
    /// 作者：张月
    /// 时间：2011年4月24日
    /// </summary>
    [Serializable]
    public class PlantPortalUser
    {
        public PlantPortalUser() { }
        public PlantPortalUser(int id, int plantID, int userID)
        {
            this.id = id;
            this.plantID = plantID;
            this.userID = userID;
        }

        private int _id;
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
        } //id 自增

        private int _plantID;
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
        } //电站id 非空

        private int _userID;
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
        }  //用户id 非空

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

        /// <summary>
        /// 门户用户电站关系对象对应的某个电站
        /// </summary>
        private Plant _plant;
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

    }
}
