<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>设备状态列表 <%=Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <% ArrayList invarray = ViewData["inv"] as ArrayList;
       ArrayList cabarray = ViewData["cab"] as ArrayList;
       ArrayList envarray = ViewData["env"] as ArrayList;
       ArrayList hlxarray = ViewData["hlx"] as ArrayList;
       ArrayList dbarray = ViewData["db"] as ArrayList;
    %>
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=Model.name %></div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
            
        </div>
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="clear: both; height: 10px;">
            </div>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>逆变器列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        <strong>
                                            <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="/plant/inverter_output/<%=Model.id %>" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%>
                                        </strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_INSTAL_POWER%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_STATUS%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                                <%
                                    int i = 1;
                                    bool fault = false;
                                    int count = 0;
                                    float curMonthEnergy = 0L;
                                    PlantUnit plantUnit;
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (fault)
                                        {
                                            count++;
                                            i++;
                                %>
                                <tr>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%=device.designPower%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%
                                            if (fault)
                                            {
                                        %>
                                        <font color="red">
                                            <%= device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%
                                            }
                                            else if (device.Over1Hour(Model.timezone))
                                            { %>
                                        <font color="#FF9912">
                                            <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%}
                                            else
                                            {%>
                                        <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                        <%} %>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();

                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%=device.designPower%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%
                                            if (fault)
                                            {
                                        %>
                                        <font color="red">
                                            <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%
                                            }
                                            else
                                                if (device.Over1Hour(Model.timezone))
                                                { %>
                                        <font color="#FF9912">
                                            <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%}
                                                else
                                                {%>
                                        <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                        <%} %>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (!device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%=device.designPower%>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%
                                            if (fault)
                                            {
                                        %>
                                        <font color="red">
                                            <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%
                                            }
                                            else
                                                if (device.Over1Hour(Model.timezone))
                                                { %>
                                        <font color="#FF9912">
                                            <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                        <%}
                                                else
                                                {%>
                                        <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                        <%} %>
                                    </td>
                                    <td width="20%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "-" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.ENVRIOMENTMONITOR_CODE)) > 0)
              { %>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_EM%></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        <strong>
                                            <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="/plant/em_output/<%=Model.id %>" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_SUNSHINE%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_WIND_SPEED%></strong>
                                    </td>
                                    <td width="9%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (fault)
                                        {
                                            count++;
                                            i++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault || device.Over1Day(Model.timezone))
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (!device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault || device.Over1Day(Model.timezone))
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.HUILIUXIANG_CODE)) > 0)
              { %>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_HLX%></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        <strong>
                                            <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="/plant/hlx_output/<%=Model.id %>" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_325%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_326%></strong>
                                    </td>
                                    <td width="9%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (fault)
                                        {
                                            count++;
                                            i++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null) fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault || device.Over1Day(Model.timezone))
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData==null?"N/A": device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.HUILIUXIANG_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                                        if (device.runData == null) fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (!device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault || device.Over1Day(Model.timezone))
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=device.fullName%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                    } %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <br/>
            <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.CABINET_CODE)) > 0)
              { %>
            <div style="margin-bottom:50px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_CABINET%></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        <strong>
                                            <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="/plant/cmb_output/<%=Model.id %>" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_325%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_326%></strong>
                                    </td>
                                    <td width="9%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (fault)
                                        {
                                            count++;
                                            i++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (!device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=device.fullName%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.AMMETER_CODE)) > 0)
              { %>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>
                                            <%=Resources.SunResource.DEVICE_MONITOR_AMMETER%></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        <strong>
                                            <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="/plant/ammeter_output/<%=Model.id %>" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_924%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.AMMETER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (fault)
                                        {
                                            count++;
                                            i++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.AMMETER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                                <%
                                    foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                                    {

                                        if (!device.deviceTypeCode.Equals(DeviceData.AMMETER_CODE))
                                            continue;
                                        plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                                        if (device.runData == null)
                                            fault = true;
                                        else
                                            fault = device.runData.isFault();
                                        if (!device.Over1Day(Model.timezone) && fault == false)
                                        {
                                            i++;
                                            count++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                            <%if (fault)
                                              { %>
                                            <img src="/images/bni.gif" alt="" class="img_list" />
                                            <%}
                                              else
                                              {%>
                                            <img src="/images/accept.gif" alt="" class="img_list" />
                                            <% }%>
                                            <%=plantUnit.displayname%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                            <%=device.fullName%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%if (fault)
                                          { %>
                                        <font color="red">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                        %>
                                        <%if (device.Over1Hour(Model.timezone))
                                          { %>
                                        <font color="#FF9912">
                                            <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></font>
                                        <%}
                                          else
                                          { %>
                                        <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                                        <%} %>
                                    </td>
                                </tr>
                                <%}
                                            } %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
