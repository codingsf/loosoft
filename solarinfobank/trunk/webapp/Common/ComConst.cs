﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 系统常量定义
    /// </summary>
    public abstract class ComConst
    {
        public const string User = "User";
        public const string ChartGroup = "ChartGroup";
        public const string ChartGroupDefault = "ChartGroupDefault";
        public const string ChartOutGroup = "ChartOutGroup";
        public const string Manager = "Manager";
        public const string Report = "Report";
        public const string ReportCode = "ReportCode";
        public const string WorkYears = "plantYear";
        public const string PlantId = "PlantId";
        public const string portalautoLogin = "portalautoLogin";
        public const string validatecode = "validatecode";
        public const int PageSize = 20;
        public const string defaultSysName = "SolarInfo Bank";
        public const string ReportGroupList = "ReportGroupList";
        public const string Templete = "Templete";
        public const string Session_CurPlantId = "session_curplantid";
        public const string Session_PaymentLimitTime = "session_paymentlimittime";
        public const string Session_Anonymous = "anonymous";
        public const string DateFormat = "yyyy/MM/dd";
        /// <summary>
        /// 图表div名称
        /// </summary>
        public const string ChartDivContainer = "container";
        /// <summary>
        /// 用户的当前电站
        /// </summary>
        public const string PlantName = "plantName";

        /// <summary>
        /// 用户电站列表
        /// </summary>
        public const string PlantList = "PlantList";

        /// <summary>
        /// 电站下电站单元列表
        /// </summary>
        public const string UnitList = "UnitList";

        /// <summary>
        /// 设备列表
        /// </summary>
        public const string DeviceList = "DeviceList";

        /// <summary>
        /// 设备类型：逆变器
        /// </summary>
        public const string DevType_Inverter = "Inverter";

        /// <summary>
        /// 设备类型：逆变器
        /// </summary>
        public const string DevType_Plant = "Plant";

        /// <summary>
        /// 设备类型：电站单元
        /// </summary>
        public const string DevType_PlantUnit = "PlantUnit";

        /// <summary>
        /// 检测点：电量
        /// </summary>
        public const string Monitor_Energy = "Energy";

        /// <summary>
        /// 检测点：功率
        /// </summary>
        public const string Monitor_Power = "Power";

        /// <summary>
        /// 图表类型：区域
        /// </summary>
        public const string Subtype_area = "area";

        /// <summary>
        /// 图表类型：条状
        /// </summary>
        public const string Subtype_bar = "bar";

        /// <summary>
        /// 图表类型：柱形
        /// </summary>
        public const string Subtype_column = "column";

        /// <summary>
        /// 图表类型：复合
        /// </summary>
        //public const string Subtype_combo = "combo"; //保留

        /// <summary>
        /// 图表类型：曲线
        /// </summary>
        public const string Subtype_line = "line";

        /// <summary>
        /// 图表类型：拼图
        /// </summary>
        //public const string Subtype_pie = "pie";//保留
        /// <summary>
        /// 时间类型-年
        /// </summary>
        public static string Time_YEAR = "";
        /// <summary>
        /// 时间类型-月
        /// </summary>
        public static string Time_MONTH = "";
        /// <summary>
        /// 时间类型-天
        /// </summary>
        public static string Time_DAY = "";
        /// <summary>
        /// 时间类型-小时
        /// </summary>
        public static string Time_HOUR = "";

        public const string ModelCustomReport = "ModelCustomReport";

        static ComConst()
        {
            Time_YEAR = "YEAR";//LanguageUtil.getDesc("CUSTOMREPORT_YEAR");
            Time_MONTH = "MONTH";//LanguageUtil.getDesc("CUSTOMREPORT_MONTH");
            Time_DAY = "DAY";//LanguageUtil.getDesc("CUSTOMREPORT_DAY");
            Time_HOUR = "HOUR";//LanguageUtil.getDesc("CUSTOMREPORT_HOUR");
        }
    }
}