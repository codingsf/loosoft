using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    /// <summary>
    /// 发电量补偿设置
    /// </summary>
    public class Compensation
    {
        public const int TYPE_TOTAL = 0;
        public const int TYPE_YEAR = 1;
        public const int TYPE_MONTH = 2;
        public const int TYPE_DAY = 3;

        public int id { get; set; }
        public int plantid { get; set; }//关联电站id  如果isplant为false 则为设备id
        public bool isplant { get; set; }
        public int year { get; set; }
        public int month { get; set; }
        public int day { get; set; }
        public double dataValue { get; set; }
        public int type { get; set; }//补偿类型 年月日 总体
        public DateTime? compensationDate { get; set; }//补偿时间 查询用

        public Plant plant { get; set; }//电站
        public Device device { get; set; }//设备

        public string typeStr
        {
            get
            {
                string returnStr = "未知";
                switch (type)
                {
                    case TYPE_TOTAL:
                        returnStr = "总电量";
                        break;
                    case TYPE_YEAR:
                        returnStr = "年发电量";
                        break;
                    case TYPE_MONTH:
                        returnStr = "月发电量";
                        break;
                    case TYPE_DAY:
                        returnStr = "日发电量";
                        break;
                    default:
                        break;
                }
                return returnStr;
            }
        }

        public string DateStr
        {
            get
            {
                string returnStr = "";
                if (year > 0)
                    returnStr = year.ToString();
                if (month > 0)
                    returnStr += string.Format("-{0}", month);
                if (day > 0)
                    returnStr += string.Format("-{0}", day);
                return returnStr;
            }
        }

        public string displayName
        {
            get
            {
                if (isplant)
                    return this.plant!=null?this.plant.name:string.Empty;
                return this.device != null ? this.device.fullName : string.Empty;
            }
        }
    }
}
