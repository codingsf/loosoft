<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Inside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
<%
    //add by hbqian for 增加判断是否有设备关系处理，确保设备和单元进行绑定 at 2013-07-31
    foreach (PlantUnit pu in Model.plantUnits)
    {
        Collector collector = Cn.Loosoft.Zhisou.SunPower.Service.CollectorInfoService.GetInstance().Get(pu.collectorID);
        if (collector.devices.Count > 0)
        {
            foreach (Device device in collector.devices)
            {
                //已有属主的话就不在更新了
                if (device.plantUnitId != null && device.plantUnitId.Value > 0)
                {
                    continue;
                }
                device.parentId = 0;
                device.plantUnitId = pu.id;
                if (device.deviceModel == null) device.deviceModel = new DeviceModel();
                Cn.Loosoft.Zhisou.SunPower.Service.DeviceService.GetInstance().Save(device);
            }
        }
    }

 %>
<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif" id="content_ajax">
    <!--空页面，只为了加载模板，实际页面是IncludeOverview页面-->      
    </td>
</asp:Content>
