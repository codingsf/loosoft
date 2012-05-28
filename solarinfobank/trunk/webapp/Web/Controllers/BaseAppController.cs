using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Service.vo;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;
using System.Threading;
using System.Configuration;
using System.Globalization;
namespace Cn.Loosoft.Zhisou.SunPower.Web.Controllers
{
    /// <summary>
    /// 功能：为安卓 app应用提供各种接口
    /// 19日及以后的改动未同步到主干
    /// 作者：钱厚兵
    /// 时间：2011年3月24日 16:31:48
    /// </summary>
    public class BaseAppController : BaseController
    {
        public static int intervalTime = 15;

        /// <summary>
        /// /
        /// </summary>
        /// <param name="language"></param>
        protected void setlan(string language)
        {

            if (language != null && (language.ToLower().IndexOf("cn") > -1 || language.ToLower().IndexOf("zh") > -1))
                language = Language.zhCN;

            else if (language != null && (language.ToLower().IndexOf("en") > -1))
                language = Language.enUS;

            else if (language != null && (language.ToLower().IndexOf("de") > -1))
                language = Language.de;

            else if (language != null && (language.ToLower().IndexOf("it") > -1))
                language = Language.itCH;

            if(language == null || !Language.lans.Contains(language.ToLower())) language = Language.enUS;

            CultureInfo cultureInfo = new CultureInfo(language);
            Session["Culture"] = cultureInfo;
            Thread.CurrentThread.CurrentCulture = cultureInfo;
        }

        protected string getAppErrorType(int errorTypeCode) { 
            switch (errorTypeCode){
                case ErrorType.ERROR_TYPE_ERROR:
                    return "fault";
                case ErrorType.ERROR_TYPE_FAULT:
                    return "fault";
                case ErrorType.ERROR_TYPE_INFORMATRION:
                    return "info";
                default:
                    return "warning";
            }                
        }

        /// <summary>
        /// 取得CO2减排换算率
        /// </summary>
        /// <returns></returns>
        protected float getCO2Rate()
        {

            ItemConfig modcon = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.CO2);
            if (modcon == null)
            {
                return 1F;
            }
            else
            {
                return modcon.value;
            }
        }
    }
}
