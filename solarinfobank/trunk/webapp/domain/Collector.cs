using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Cn.Loosoft.Zhisou.SunPower.Common;
namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 采集器信息实体类
    /// Author: 赵文辉
    /// Time: 2011年2月16日 11:20:55
    /// </summary>
    /// 
    [Serializable]
    public class Collector
    {
        /// <summary>
        /// 不带参的构造函数
        /// </summary>
        public Collector() { }
        /// <summary>
        /// 带参的构造函数
        /// </summary>
        /// <param name="Code">编号</param>
        /// <param name="PassWord">密码</param>
        /// <param name="IsUsed">是否启用</param>
        public Collector(string code, string password, bool isUsed)
        {
            this.code = code;
            this.password = password;
            this.isUsed = isUsed;
        }
        public int id { get; set; }
        //采集器编号 非空
        public string code { get; set; }
        //密码  非空  明文
        public string password { get; set; }
        // 是否启用  非空  0为未启用 1为启用
        public bool isUsed { get; set; }

        public DateTime importDate { get; set; }
        public DateTime limitDate { get; set; }
        public int userId { get; set; }
        public string Descr { get; set; }

        //密码  非空  明文
        public int plantID { get; set; }
        public Plant plant { get; set; }
        /// <summary>
        /// 所有设备列表
        /// </summary>
        private IList<Device> _devices;
        public IList<Device> devices
        {
            get
            {
                return _devices;
            }
            set
            {
                _devices = value;
            }
        }

        private CollectorRunData _rundata;
        public CollectorRunData runData
        {
            get
            {
                //首先取自缓存
                string cacheKey = CacheKeyUtil.buildCollectorRunDataKey(this.id);
                object obj = MemcachedClientSatat.getInstance().Get(cacheKey);
                if (obj == null)
                    return _rundata;
                else
                {
                    return (CollectorRunData)obj;
                }
            }
            set
            {
                _rundata = value;
            }
        }//实时数据


        /// <summary>
        /// 这里要加入时区来判断
        /// 采集器停止发送数据时间
        /// </summary>
        /// <param name="tz"></param>
        /// <returns>如果没有实时数据，则返回-1</returns>
        public int stopTime(float tz)
        {
            if (runData == null)
                return 24;
            return (int)(CalenderUtil.curDateWithTimeZone(tz) - runData.sendTime).TotalHours;
        }

        /// <summary>
        /// s设备今日发电量
        /// 现为设备的累加起来
        /// </summary>
        public float deviceTodayEnergy(string yyyyMMdd)
        {
            float total = 0;
            if (devices == null) return total;
            foreach (Device device in devices)
            {
                total += device.TodayEnergy(yyyyMMdd);
            }
            return total;
        }


        public string MAC { get; set; }//mac 地址
        public string PNO { get; set; }//流水号
        public string Encryption { get; set; }//加密方式
        public string Date { get; set; }//生产日期


        public bool Isonline
        {
            get
            {
                return true;
            }
        }

        public string IsonlineStr
        {
            get
            {
                return LanguageUtil.getDesc("DEVICEONLINE_" + Isonline.ToString().ToUpper());
            }
        }

        public string Key { get; set; }

        public int DeviceCount
        {
            get
            {
                return this.devices == null ? 0 : devices.Count;
            }
        }

        public DateTime BindDate { get; set; }//绑定时间

        public bool Binded { get; set; }//是否绑定
    }
}


