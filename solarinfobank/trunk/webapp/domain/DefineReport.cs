using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;


namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 报表定义业务类
    /// </summary>
    [Serializable]
    public class DefineReport
    {
        public const string sendmode_interval = "1";//循环
        public const string sendmode_fixtime = "2";//定时发送模式
        private int id;
        /// <summary>
        /// 报表id
        /// </summary>
        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        private string reportName;
        /// <summary>
        /// 报表名称
        /// </summary>
        public string ReportName
        {
            get { return reportName; }
            set { reportName = value; }
        }
        private int reportType;

        /// <summary>
        /// 报表类型
        /// </summary>
        public int ReportType
            {
            get { return reportType; }
            set { reportType = value; }
        }

        private int plantId;
        /// <summary>
        /// 所属电站id
        /// </summary>
        public int PlantId
        {
            get { return plantId; }
            set { plantId = value; }
        }
        private int userId;
        /// <summary>
        /// 所属用户id
        /// </summary>
        public int UserId
        {
            get { return userId; }
            set { userId = value; }
        }
        private DateTime saveTime;
        /// <summary>
        /// 定义时间
        /// </summary>
        public DateTime SaveTime
        {
            get { return saveTime; }
            set { saveTime = value; }
        }
        /// <summary>
        /// 数据项串，用逗号分隔多个数据项代码
        /// </summary>
        public string dataitem
        {
            get;
            set;
        }
        
        /// <summary>
        /// 所属电站对象
        /// </summary>
        public Plant plant { get; set; }
        /// <summary>
        /// 所属用户id
        /// </summary>
        public User  user { get; set; }

        public ReportConfig config { get; set; }
        /// <summary>
        /// 数据项代码数组
        /// </summary>
        public string[] dataItems {
            get {
                return this.dataitem.Split(',');
            }

        
        
        }
     
    }
}
