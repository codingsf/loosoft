using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using System.Globalization;
using System.Reflection;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 反射工具
    /// </summary>
    public static class ReflectionUtil
    {
        /// <summary>
        /// 反射赋值
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="perpertyName"></param>
        /// <param name="newValue"></param>
        public static void setProperty(object obj,string perpertyName,float? newValue) {
            Type ht = obj.GetType();
            PropertyInfo propertyInfo = ht.GetProperty(perpertyName);
            if (propertyInfo != null)
            {
                propertyInfo.SetValue(obj, newValue, null);
            }
        }

        /// <summary>
        /// 取得属性值
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="perpertyName"></param>
        /// <returns></returns>
        public static object getProperty(object obj,string perpertyName){
            Type ht = obj.GetType();
            PropertyInfo propertyInfo = ht.GetProperty(perpertyName);
            if (propertyInfo != null)
            {
                object ovalue = propertyInfo.GetValue(obj, null);
                return ovalue;
            }
            return null;
        }
    }
}