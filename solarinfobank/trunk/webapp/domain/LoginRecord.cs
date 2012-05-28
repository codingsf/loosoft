using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 登录日志类
    /// Author: qianhb
    /// Time: 2011年09月18日 11:34:33
    /// </summary>
    [Serializable]
    public class LoginRecord
    {
        #region Model
        //编号  非空
        public int id { get; set; }
        //用户Id  非空
        public int  userId { get; set; }
        //用户名  非空
        public string username { get; set; }
        //登录ip 飞库
        public string ip{get;set;}
        //  登录时间 非空
        public DateTime loginTime { get; set; }

        public float localZone { get; set; }
        #endregion Model
     
    }
}
