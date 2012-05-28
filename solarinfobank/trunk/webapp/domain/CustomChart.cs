/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年03月09日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   
    /// <summary>
    /// 用户自定义报表
    /// </summary>
    [Serializable]
    public class CustomChart
    {
        #region Model
        private int _id;
        private int _userid;
        private int _plantId;
        private string _subtype;
        private string _customtype;
        private int? _groupid;
        private string _reportname;
        private string _timeslot;
        private int? _tcounter;
        private string _timeinterval;
        private string _product;
        private string _times;
        private string _productName;

        /// <summary>
        /// auto_increment
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }

        public string productName
        {
            get { return _productName; }
            set { _productName = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public int userId
        {
            set { _userid = value; }
            get { return _userid; }
        }

        /// <summary>
        /// 
        /// </summary>
        public int plantId
        {
            set { _plantId = value; }
            get { return _plantId; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string subType
        {
            set { _subtype = value; }
            get { return _subtype; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string customType
        {
            set { _customtype = value; }
            get { return _customtype; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? groupId
        {
            set { _groupid = value; }
            get { return _groupid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string reportName
        {
            set { _reportname = value; }
            get { return _reportname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string timeSlot
        {
            set { _timeslot = value; }
            get { return _timeslot; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? tcounter
        {
            set { _tcounter = value; }
            get { return _tcounter; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string timeInterval
        {
            set { _timeinterval = value; }
            get { return _timeinterval; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string product
        {
            set { _product = value; }
            get { return _product; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string times
        {
            set { _times = value; }
            get { return _times; }
        }
        #endregion Model


        /// <summary>
        /// 开始时间
        /// </summary>
        public string startTime { get; set; }

        /// <summary>
        /// 截止时间
        /// </summary>
        public string endTime { get; set; }


        /// <summary>
        ///设备
        /// </summary>
        public string ProIdType { get; set; }
        /// <summary>
        ///监测点
        /// </summary>
        public string valueType { get; set; }
        /// <summary>
        ///单位
        /// </summary>
        public string units { get; set; }
        /// <summary>
        /// 取值
        /// </summary>
        public string cVal { get; set; }
        /// <summary>
        ///产品
        /// </summary>
        public string productList { get; set; }
        /// <summary>
        ///产品
        /// </summary>
        public string selTimes { get; set; }

    }
}
