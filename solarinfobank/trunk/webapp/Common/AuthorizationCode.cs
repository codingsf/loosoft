using System.Collections.Generic;
using System.Linq;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class UserControllerActionType
    {
        public const int PLANT_MANAGER = 1;
        public const int UNIT_MANAGER = 2;
        public const int PLANT_MAP = 3;
        public const int VIDEO_MANAGER = 4;
        public const int DEVICE_MONITOR = 5;
        public const int LOGS = 5 + 1;
        public const int CHART = 7;
        public const int DEVICE_DATA = 5 + 3;
        public const int RUN_REPORT = 5 + 4;
        public const int EVENT_REPORT = 10;
        public const int CUSTOM_CHART = 11;
        public const int USER_INFO = 12;
        public const int OTHER = 13;
        public static Dictionary<int, string> dictionaries = new Dictionary<int, string>();
        static UserControllerActionType()
        {
            dictionaries.Add(PLANT_MANAGER, "电站管理");
            dictionaries.Add(UNIT_MANAGER, "单元管理");
            //dictionaries.Add(PLANT_MAP, "电站地图");
            dictionaries.Add(VIDEO_MANAGER, "视频监控");
            dictionaries.Add(DEVICE_MONITOR, "设备检测");
            dictionaries.Add(LOGS, " 日志");
            dictionaries.Add(CHART, "分析图表");
            //dictionaries.Add(DEVICE_DATA, "设备数据");
            dictionaries.Add(RUN_REPORT, "运行报表");
            dictionaries.Add(EVENT_REPORT, "事件报表");
            dictionaries.Add(CUSTOM_CHART, "自定义图表");
            //dictionaries.Add(USER_INFO, "用户信息");
            //dictionaries.Add(OTHER, "其他配置");
        }

        public static string TypeName(int id)
        {
            if (dictionaries.ContainsKey(id))
                return dictionaries[id];
            return string.Empty;
        }



    }


    public class ControllerAction
    {
        public int typeId { get; set; }
        public string controller { get; set; }
        public string action { get; set; }
        public string displayName { get; set; }
        public bool IsUsered { get; set; }
    }

    public static class AuthorizationCode
    {
        private static Dictionary<int, ControllerAction> controllerActionRoles = new Dictionary<int, ControllerAction>();


        public const int ADD_PLANT = 0X01;//添加电站
        public const int EDIT_PLANT = 0X02;//编辑电站
        public const int DELETE_PLANT = 0X03;//删除电站
        public const int PLANTS_LIST = 0X04;//电站列表
        public const int PLANT_PROFILE = 0X05;//电站资料
        public const int PLANTS_OVERVIEW = 0X06;//所有电站概览
        public const int PLANT_OVERVIEW = 0X07;//单个电站概览
        public const int UNIT_LIST = 0X08;//单元列表
        public const int ADD_UNIT = 0X09;//添加单元
        public const int EDIT_UNIT = 10;//编辑单元
        public const int DELETE_UNIT = 11;//删除单元
        public const int PLANT_MAP = 12;//电站地图
        public const int EDIT_PLANT_MAP = 13;//编辑电站地图
        public const int PLANT_MONITOR = 14;//视频监控
        public const int ADD_MONITOR = 15;//添加视频监控
        public const int DELETE_MONITOR = 16;//删除视频监控
        public const int DEVICE_LIST = 17;//设备列表
        public const int EDIT_DEVICE = 18;//编辑设备
        public const int LOGS_LIST = 19;//日志列表
        public const int LOGS_CONFIRM = 20;//日志确认
        public const int YEAR_ENERGY_COMPARE = 21;//年发电量比较
        public const int TOUZISHOUYI_COMPARE = 22;//投资收益比较
        public const int XINNENG_COMPARE = 23;//性能比较
        public const int DAY_COMPARE = 24;//日比较图表
        public const int MULTI_ENERGY_COMPARE = 25;//多年电量和投资比较
        public const int TOUZISHOUYI = 26;//投资收益
        public const int DEFINED_CHART = 27;//自定义图表
        public const int REPORT_LIST = 28;//报表列表


        public const int ADD_REPORT = 29;//添加报表
        public const int SHOW_REPORT = 30;//查看报表
        public const int REPORT_CONFIG = 31;//报表设置
        public const int DELETE_REPORT = 32;//删除报表


        public const int REPORT_DOWNLOAD = 33;//下载报表
        public const int EVENT_REPORT = 34;//事件报表
        public const int CREATE_CHART = 35;//创建图表
        public const int USER_LIST = 36;//用户列表
        public const int SHOW_USER = 37;//查看用户信息
        public const int EDIT_USER = 38;//修改用户信息
        public const int DELETE_USER = 39;//删除用户信息
        public const int DEVICE_MENU_LIST = 40;//设备列表菜单
        public const int USER_CHANGE_PASSWORD = 41;//设备列表菜单
        public const int LOGS_SELECT = 42;//日志列表菜单
        public const int APPLY_DATASOURCE = 43;
        public const int PAGE_CONFIG = 44;
        public const int LOGIN_RECORD = 45;

        public const int DEVICE_RELATION = 46;//设备关系设置


        static AuthorizationCode()
        {
            //添加电站
            controllerActionRoles.Add(ADD_PLANT, new ControllerAction() { displayName = "添加电站", controller = "user", action = "addplant", typeId = 1 });
            //编辑电站
            controllerActionRoles.Add(EDIT_PLANT, new ControllerAction() { displayName = "编辑电站", controller = "plant", action = "edit", typeId = 1, IsUsered = true });
            //删除电站
            controllerActionRoles.Add(DELETE_PLANT, new ControllerAction() { displayName = "删除电站", controller = "user", action = "delete", typeId = 1, IsUsered = true });
            //电站列表
            controllerActionRoles.Add(PLANTS_LIST, new ControllerAction() { displayName = "电站列表", controller = "plant", action = "allplants", typeId = 1 });
            //电站资料
            controllerActionRoles.Add(PLANT_PROFILE, new ControllerAction() { displayName = "电站资料", controller = "plant", action = "overview", typeId = 1, IsUsered = true });
            //所有电站概览
            controllerActionRoles.Add(PLANTS_OVERVIEW, new ControllerAction() { displayName = "所有电站概览", controller = "user", action = "overview", typeId = 1 });
            //单个电站概览
            controllerActionRoles.Add(PLANT_OVERVIEW, new ControllerAction() { displayName = "单个电站概览", controller = "plant", action = "overview", typeId = 1, IsUsered = true });
            //单元列表
            controllerActionRoles.Add(UNIT_LIST, new ControllerAction() { displayName = "单元列表", controller = "unit", action = "list", typeId = 2, IsUsered = true });
            //添加单元
            controllerActionRoles.Add(ADD_UNIT, new ControllerAction() { displayName = "添加单元", controller = "unit", action = "bind", typeId = 2, IsUsered = true });
            //编辑单元
            controllerActionRoles.Add(EDIT_UNIT, new ControllerAction() { displayName = "编辑单元", controller = "unit", action = "edit", typeId = 2, IsUsered = true });
            //删除单元
            controllerActionRoles.Add(DELETE_UNIT, new ControllerAction() { displayName = "删除单元", controller = "unit", action = "deleteunit", typeId = 2, IsUsered = true });
            //电站地图
            controllerActionRoles.Add(PLANT_MAP, new ControllerAction() { displayName = "电站地图", controller = "plant", action = "map", typeId = 1, IsUsered = true });
            //编辑电站地图
            controllerActionRoles.Add(EDIT_PLANT_MAP, new ControllerAction() { displayName = "编辑电站地图", controller = "plant", action = "savemap", typeId = 3 });
            //电站视频监控
            controllerActionRoles.Add(PLANT_MONITOR, new ControllerAction() { displayName = "电站视频监控", controller = "plant", action = "monitor", typeId = 4, IsUsered = true });
            //添加视频监控
            controllerActionRoles.Add(ADD_MONITOR, new ControllerAction() { displayName = "添加视频监控", controller = "plant", action = "monitor_add", typeId = 4, IsUsered = true });
            //删除视频监控
            controllerActionRoles.Add(DELETE_MONITOR, new ControllerAction() { displayName = "删除视频监控", controller = "plant", action = "monitor_delete", typeId = 4, IsUsered = true });
            //设备列表
            controllerActionRoles.Add(DEVICE_LIST, new ControllerAction() { displayName = "设备列表", controller = "plant", action = "devicemonitor", typeId = 5, IsUsered = true });
            //编辑设备监控
            controllerActionRoles.Add(EDIT_DEVICE, new ControllerAction() { displayName = "编辑设备监控", controller = "plant", action = "modifydevicemonitor", typeId = 5, IsUsered = true });
            //日志列表
            controllerActionRoles.Add(LOGS_LIST, new ControllerAction() { displayName = "日志列表", controller = "plant", action = "log", typeId = 6, IsUsered = true });
            //日志确认
            controllerActionRoles.Add(LOGS_CONFIRM, new ControllerAction() { displayName = "日志确认", controller = "plant", action = "logconfirm", typeId = 6, IsUsered = true });
            //年发电量比较
            controllerActionRoles.Add(YEAR_ENERGY_COMPARE, new ControllerAction() { displayName = "年发电量比较", controller = "user", action = "EnergyYearCompare", typeId = 7, IsUsered = true });
            //投资收益比较
            controllerActionRoles.Add(TOUZISHOUYI_COMPARE, new ControllerAction() { displayName = "投资收益比较", controller = "user", action = "PEnergyCompare", typeId = 7, IsUsered = true });
            //添加电站
            controllerActionRoles.Add(XINNENG_COMPARE, new ControllerAction() { displayName = "电站性能比较", controller = "user", action = "PerformanceCompare", typeId = 7 });
            //日比较
            controllerActionRoles.Add(DAY_COMPARE, new ControllerAction() { displayName = "日比较", controller = "plantchart", action = "daycompare", typeId = 7, IsUsered = true });
            //多发电量比较
            controllerActionRoles.Add(MULTI_ENERGY_COMPARE, new ControllerAction() { displayName = "多发电量比较", controller = "plantchart", action = "YearComparePage", typeId = 7 });
            //投资收益
            controllerActionRoles.Add(TOUZISHOUYI, new ControllerAction() { displayName = "投资收益", controller = "plantchart", action = "PlantDayPEnergyPage", typeId = 7, IsUsered = true });
            //自定义图表
            controllerActionRoles.Add(DEFINED_CHART, new ControllerAction() { displayName = "自定义图表", controller = "user", action = "customchart", typeId = 11, IsUsered = true });
            //报告列表
            controllerActionRoles.Add(REPORT_LIST, new ControllerAction() { displayName = "报告列表", controller = "user", action = "AllPlantsReport", typeId = 8 });
            //添加报告
            controllerActionRoles.Add(ADD_REPORT, new ControllerAction() { displayName = "添加报告", controller = "user", action = "AllPlantsReport", typeId = 8 });
            //查看报告
            controllerActionRoles.Add(SHOW_REPORT, new ControllerAction() { displayName = "查看报告", controller = "reports", action = "ViewReport", typeId = 8 });
            //报表设置
            controllerActionRoles.Add(REPORT_CONFIG, new ControllerAction() { displayName = "报表设置", controller = "user", action = "AllPlantsReport", typeId = 9, IsUsered = true });
            //删除报告
            controllerActionRoles.Add(DELETE_REPORT, new ControllerAction() { displayName = "删除报告", controller = "Reports", action = "DeleteReport" });
            //下载报告
            controllerActionRoles.Add(REPORT_DOWNLOAD, new ControllerAction() { displayName = "下载报告", controller = "DataDownLoad", action = "DownLoadReport" });
            //事件报告
            controllerActionRoles.Add(EVENT_REPORT, new ControllerAction() { displayName = "事件报告", controller = "Reports", action = "EventReport", typeId = 10, IsUsered = true });
            //创建图表
            controllerActionRoles.Add(CREATE_CHART, new ControllerAction() { displayName = "创建图表", controller = "plant", action = "customchart" });
            //用户列表
            controllerActionRoles.Add(USER_LIST, new ControllerAction() { displayName = "用户列表", controller = "user", action = "plantuser", typeId = 12 });
            //查看用户
            controllerActionRoles.Add(SHOW_USER, new ControllerAction() { displayName = "查看用户", controller = "user", action = "plantuser", typeId = 12 });
            //编辑用户
            controllerActionRoles.Add(EDIT_USER, new ControllerAction() { displayName = "编辑用户", controller = "user", action = "edituser", typeId = 12 });
            //删除用户
            controllerActionRoles.Add(DELETE_USER, new ControllerAction() { displayName = "删除用户", controller = "user", action = "deleteuser", typeId = 12 });
            //设备列表菜单
            controllerActionRoles.Add(DEVICE_MENU_LIST, new ControllerAction() { displayName = "设备列表菜单", controller = "null", action = "null" });
            //修改用户密码
            controllerActionRoles.Add(USER_CHANGE_PASSWORD, new ControllerAction() { displayName = "修改用户密码", controller = "user", action = "changepassword", typeId = 12 });
            //申请数据源
            controllerActionRoles.Add(APPLY_DATASOURCE, new ControllerAction() { displayName = "申请数据源", controller = "user", action = "changepassword" });
            //页面配置
            controllerActionRoles.Add(PAGE_CONFIG, new ControllerAction() { displayName = "页面配置", controller = "user", action = "pageconfig", typeId = 13 });
            //登录日志
            controllerActionRoles.Add(LOGIN_RECORD, new ControllerAction() { displayName = "登录日志", controller = "user", action = "record", typeId = 13 });
            //设备关系设置
            controllerActionRoles.Add(DEVICE_RELATION, new ControllerAction() { displayName = "设备关系设置", controller = "plant", action = "relation", typeId = 13 });
        }

        public static ControllerAction GetRole(int code)
        {
            if (controllerActionRoles.ContainsKey(code))
            {
                return controllerActionRoles[code];
            }
            return null;
        }

        public static Dictionary<int, ControllerAction> GetTypeRoles(int type)
        {
            return controllerActionRoles.Where(m => m.Value.typeId.Equals(type)).ToDictionary(m => m.Key, m => m.Value);
        }
    }
}
