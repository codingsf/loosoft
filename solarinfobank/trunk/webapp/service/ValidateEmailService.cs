using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 后台Email验证
    /// Author: 赵文辉
    /// Time: 2011年3月1日
    /// </summary>
    public class ValidateEmailService
    {
        // 新创建一个验证服务
        private static ValidateEmailService _valdateEmial = new ValidateEmailService();

        // 调用静态服务的方法
        public static ValidateEmailService GetInstance()
        {
            return _valdateEmial;
        }

        /// <summary>
        /// 后台验证Email
        /// </summary>
        /// <param name="str_Email">Emial字段</param>
        /// <returns>是否通过验证</returns>
        public bool IsEmail(string str_Email)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(str_Email, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
        }
    }
}
