<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Model.name %>
    <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_MONITOR%></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td valign="top" width="793" background="/images/kj/kjbg01.jpg">
    <script type="text/javascript">
         var currentContainer;
         var tempData1;
         var tempData2;
         var tempData3;
         var tempData4;
         var tempData5;

         function hiddenDevice(id, item) {
             currentContainer = undefined;
             tempData1 = undefined;
             tempData2 = undefined;
             tempData3 = undefined;
             tempData4 = undefined;
             tempData5 = undefined;
             
             var status = $("#" + id).attr('rof');
             $.ajax({
                 type: "POST",
                 url: "/plant/hiddendevice",
                 data: { id: id, status: status },
                 success: function(result) {
                     if (status == "True") {
                         $("#" + id).hide();
                         $("#" + id).addClass('hidden_' + item);
                         $("#img" + id).attr('src', '/images/yc.gif');
                         $("#img" + id).attr('title', '<%=Resources.SunResource.PLANT_DEVICEMONITOR_SHOW%>');
                         $("#" + id).attr('rof', 'False');
                     }
                     else {
                         $("#" + id).removeClass('hidden_' + item);
                         $("#img" + id).attr('src', '/images/xs.gif');
                         $("#img" + id).attr('title', '<%=Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>');
                         $("#" + id).attr('rof', 'True');
                     }
                     //重新更新框架内容高度
                     parent.iFrameHeight();
                 }
             });

         }

         function viewAll(item) {
             $(".hidden_" + item).each(function() {
                 $(this).show();
             })
             //重新更新框架内容高度
             parent.iFrameHeight();
         }

         function hiddenTab(type, item, container) {
             var url = "/plant/emList/";
             if (type == "inv") {
                 url = " /plant/inverterlist";
             } else if (type == "hlx") {
                 url = "/plant/hlxList";
             } else if(type=='cabinet') {
                 url = "/plant/cabinetList";
             }else if(type=='db'){
             url="/plant/ammeterList";
             }

             if ((item.indexOf("Summary") != -1)) {
                 if (item.indexOf("Summary") != -1) {
                     if (item == "Summarytab1") {
                         $("#" + container).html(tempData1);
                     }
                     if (item == "Summarytab2") {
                         $("#" + container).html(tempData2);
                     }
                     if (item == "Summarytab3") {
                         $("#" + container).html(tempData3);
                     }
                     if (item == "Summarytab4") {
                         $("#" + container).html(tempData4);
                     }
                      if (item == "Summarytab5") {
                         $("#" + container).html(tempData5);
                     }
                     //重新更新框架内容高度
                     parent.iFrameHeight();
                 }
             }
             else {
                 if (item == "Detailtab1" && tempData1 == undefined) {
                     tempData1 = $("#" + container).html();
                 }
                 if (item == "Detailtab2" && tempData2 == undefined) {
                     tempData2 = $("#" + container).html();
                 }
                 if (item == "Detailtab3" && tempData3 == undefined) {
                     tempData3 = $("#" + container).html();
                 }
                 if (item == "Detailtab4" && tempData4 == undefined) {
                     tempData4 = $("#" + container).html();
                 }
                 if (item == "Detailtab5" && tempData5 == undefined) {
                     tempData5 = $("#" + container).html();
                 }

                 $.ajax({
                     type: "POST",
                     url: url,
                     data: { pid: <%=Model.id %> },
                     success: function(result) {
                         $("#" + container).html(result);
                         //重新更新框架内容高度
                         parent.iFrameHeight();
                     }
                 });
                 currentContainer = container;
             }
         }

         $(document).ready(function() {

             $("#Detailtab1").click(function() {
                 hiddenTab("inv", "Detailtab1", "inverter_container");
                 $("#Detailtab1").addClass("onclick");
                 $("#Summarytab1").removeClass("onclick");


                 $("#Summarytab1").click(function() {
                     $("#Summarytab1").addClass("onclick");
                     $("#Detailtab1").removeClass("onclick");

                     hiddenTab("inv", "Summarytab1", "inverter_container");

                 });
             });

             $("#Detailtab2").click(function() {
                 hiddenTab("jcy", "Detailtab2", "jcy_container");
                 $("#Detailtab2").addClass("onclick");
                 $("#Summarytab2").removeClass("onclick");
                 $("#Summarytab2").click(function() {
                     $("#Summarytab2").addClass("onclick");
                     $("#Detailtab2").removeClass("onclick");
                     hiddenTab("jcy", "Summarytab2", "jcy_container");

                 });
             });


             $("#Detailtab3").click(function() {
                 hiddenTab("hlx", "Detailtab3", "hlx_container");
                 $("#Detailtab3").addClass("onclick");
                 $("#Summarytab3").removeClass("onclick");
                 
                 
                 $("#Summarytab3").click(function() {
                     $("#Summarytab3").addClass("onclick");
                     $("#Detailtab3").removeClass("onclick");
                     hiddenTab("hlx", "Summarytab3", "hlx_container");

                 });
             });
             
             $("#Detailtab4").click(function() {
                 hiddenTab("cabinet", "Detailtab4", "cabinet_container");
                 $("#Detailtab4").addClass("onclick");
                 $("#Summarytab4").removeClass("onclick");


                 $("#Summarytab4").click(function() {
                     $("#Summarytab4").addClass("onclick");
                     $("#Detailtab4").removeClass("onclick");
                     hiddenTab("cabinet", "Summarytab4", "cabinet_container");

                 });
             });
             
                 $("#Detailtab5").click(function() {
                 hiddenTab("db", "Detailtab5", "db_container");
                 $("#Detailtab5").addClass("onclick");
                 $("#Summarytab5").removeClass("onclick");


                 $("#Summarytab5").click(function() {
                     $("#Summarytab5").addClass("onclick");
                     $("#Detailtab5").removeClass("onclick");
                     hiddenTab("db", "Summarytab5", "db_container");

                 });
             });
         })
      
                </script>

                <style type="text/css">
                    .img_list
                    {
                        float: left;
                    }
                    .edit
                    {
                        width: 30px;
                    }
                    .hidden, .hidden_hlx, .hidden_env, .hidden_inv, .hidden_cabinet, .hidden_db
                    {
                        color: #B4B4B4;
                    }
                    .hidden font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_hlx font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_inv font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_env font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_cabinet font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_db font
                    {
                        color: #B4B4B4;
                    }
                    .hidden_hlx, .hidden_env, .hidden_inv, .hidden_cabinet, .hidden_db
                    {
                        display: none;
                    }
                </style>
                <table width="100%" background="/images/kj/kjbg02.jpg" border="0" cellpadding="0"
                    cellspacing="0" height="63">
                    <tbody>
                        <tr>
                            <td width="8">
                                <img src="/images/kj/kjico02.jpg" width="8" height="63">
                            </td>
                            <td width="777">
                                <table width="98%" border="0" cellpadding="0" cellspacing="0" height="45">
                                    <tbody>
                                        <tr>
                                            <td rowspan="2" width="7%" align="center">
                                                <img src="/images/kj/kjiico01.gif" width="36" height="44">
                                            </td>
                                            <td class="pv0216">
                                                <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_MONITOR%>
                                            </td>
                                            <td align="right" class="help_r">
                                                <a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf"
                                                    target="_blank" style="color: #59903E; text-decoration: underline;">
                                                    <%=Resources.SunResource.MONITORITEM_HELP%>
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="75%">
                                                <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_MONITOR_DETAIL%>&nbsp;
                                            </td>
                                            <td width="18%">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td width="6" align="right">
                                <img src="/images/kj/kjico03.jpg" width="6" height="63">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div style="padding-left: 22px; padding-top: 30px;">
                    <span style="background-color: #858585; width: 30px; padding-left: 15px">&nbsp;</span>
                    &nbsp;<%=Resources.SunResource.TIP_NORMAL%>
                    &nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: red; width: 30px; padding-left: 15px">&nbsp;</span>&nbsp;<%=Resources.SunResource.TIP_FAULT%>
                    &nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #FF9912; width: 30px; padding-left: 15px;">&nbsp;</span>&nbsp;<%=Resources.SunResource.TIP_ONDATA%>
                </div>
                <div class="subrbox01">
                    <div style="padding-top: 5px; font-weight: bold; margin-bottom: 15px; background: url(/images/sub/namebb.gif) no-repeat;
                        padding-left: 20px;">
                        <%=Resources.SunResource.DEVICE_MONITOR_INVERTER%></div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab1" href="javascript: void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab1" href="javascript: void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                            <%if (!Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                              {%>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.PLANT_DEVICEMONITOR_VIEW_ALL%>"
                                    style="background: #5A8C28; cursor: pointer; color: #FFFFFF; border: 1px solid #256525;
                                    font-family: Arial, Helvetica, sans-serif; height: 20px;" onclick="viewAll('inv')" /></li>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%>"
                                    onclick="window.open('/plant/inverter_output/<%=Model.id %>')" style="background: #5A8C28;
                                    cursor: pointer; color: #FFFFFF; border: 1px solid #256525; font-family: Arial, Helvetica, sans-serif;
                                    height: 20px;" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; max-height: 420px; overflow: hidden;" id="inverter_container">
                            <div style="width: 720px; max-height: 420px; overflow-y: auto; overflow-x: hidden;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table class="subline02" width="98%" border="0" cellpadding="0" cellspacing="0"
                                                    height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                                            </td>
                                                            <td width="18%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_INSTAL_POWER%></strong><span class="f11">(kW)</span>
                                                            </td>
                                                            <td width="12%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_STATUS%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                                            </td>
                                                            <td width="10%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_inv":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="18%">
                                                                <%=device.designPower%>
                                                            </td>
                                                            <td align="center" width="12%">
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
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/inverteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'inv');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img1" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_inv":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="18%">
                                                                <%=device.designPower%>
                                                            </td>
                                                            <td align="center" width="12%">
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
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/inverteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'inv');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img1" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_inv":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="18%">
                                                                <%=device.designPower%>
                                                            </td>
                                                            <td align="center" width="12%">
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
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/inverteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'inv');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img1" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <%}
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.ENVRIOMENTMONITOR_CODE)) >= 0)
                  { %>
                <div class="subrbox01">
                    <div style="padding-top: 5px; font-weight: bold; margin-bottom: 15px; padding-right: 50px;
                        background: url(/images/sub/namebb.gif) no-repeat; padding-left: 20px;">
                        <%=Resources.SunResource.DEVICE_MONITOR_EM%></div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab2" href="javascript: void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab2" href="javascript: void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                            <%if (!Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                              {%>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.PLANT_DEVICEMONITOR_VIEW_ALL%>"
                                    style="background: #5A8C28; cursor: pointer; color: #FFFFFF; border: 1px solid #256525;
                                    font-family: Arial, Helvetica, sans-serif; height: 20px;" onclick="viewAll('env')" /></li>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%>"
                                    onclick="window.open('/plant/em_output/<%=Model.id %>')" style="background: #5A8C28;
                                    cursor: pointer; color: #FFFFFF; border: 1px solid #256525; font-family: Arial, Helvetica, sans-serif;
                                    height: 20px;" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; max-height: 420px; overflow: hidden;" id="jcy_container">
                            <div style="width: 720px; max-height: 420px; overflow-y: auto; overflow-x: hidden;">
                                <table width="98%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0"
                                                    height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td width="22%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICE_MONITOR_SUNSHINE%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICE_MONITOR_WIND_SPEED%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                                            </td>
                                                            <td width="10%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_env":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="22%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 120px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/emedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'env');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img2" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_env":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="22%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault || device.Over1Day(Model.timezone))
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 120px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/emedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'env');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img5" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_env":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="22%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault || device.Over1Day(Model.timezone))
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="10%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/emedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'env');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img6" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <%}
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%} %>
                <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.HUILIUXIANG_CODE)) >= 0)
                  { %>
                <div class="subrbox01">
                    <div style="padding-top: 5px; font-weight: bold; padding-right: 50px; background: url(/images/sub/namebb.gif) no-repeat;
                        padding-left: 20px; margin-bottom: 15px;">
                        <%=Resources.SunResource.DEVICE_MONITOR_HLX%></div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab3" href="javascript: void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab3" href="javascript: void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                            <%if (!Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                              {%>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.PLANT_DEVICEMONITOR_VIEW_ALL%>"
                                    style="background: #5A8C28; cursor: pointer; color: #FFFFFF; border: 1px solid #256525;
                                    font-family: Arial, Helvetica, sans-serif; height: 20px;" onclick="viewAll('hlx')" /></li>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%>"
                                    onclick="window.open('/plant/hlx_output/<%=Model.id %>')" style="background: #5A8C28;
                                    cursor: pointer; color: #FFFFFF; border: 1px solid #256525; font-family: Arial, Helvetica, sans-serif;
                                    height: 20px;" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; max-height: 420px; overflow: hidden;" id="hlx_container">
                            <div style="width: 720px; max-height: 420px; overflow-y: auto; overflow-x: hidden;">
                                <table width="98%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0"
                                                    height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td width="25%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICEMONITORITEM_325%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICEMONITORITEM_326%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_hlx":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 110px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/hlxedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'hlx');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img7" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_hlx":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault || device.Over1Day(Model.timezone))
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 110px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/hlxedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'hlx');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img8" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_hlx":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault || device.Over1Day(Model.timezone))
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 110px; overflow: hidden" title="<%=device.fullName%>">
                                                                    <%=device.fullName%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/hlxedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'hlx');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img9" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <%}
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%} %>
                <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.CABINET_CODE)) >= 0)
                  { %>
                <div class="subrbox01">
                    <div style="padding-top: 5px; font-weight: bold; padding-right: 50px; background: url(/images/sub/namebb.gif) no-repeat;
                        padding-left: 20px; margin-bottom: 15px;">
                        <%=Resources.SunResource.DEVICE_MONITOR_CABINET%></div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab4" href="javascript:void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab4" href="javascript:void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                            <%if (!Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                              {%>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.PLANT_DEVICEMONITOR_VIEW_ALL%>"
                                    style="background: #5A8C28; cursor: pointer; color: #FFFFFF; border: 1px solid #256525;
                                    font-family: Arial, Helvetica, sans-serif; height: 20px;" onclick="viewAll('cabinet')" /></li>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%>"
                                    onclick="window.open('/plant/cmb_output/<%=Model.id %>')" style="background: #5A8C28;
                                    cursor: pointer; color: #FFFFFF; border: 1px solid #256525; font-family: Arial, Helvetica, sans-serif;
                                    height: 20px;" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; max-height: 420px; overflow: hidden;" id="cabinet_container">
                            <div style="width: 720px; max-height: 420px; overflow-y: auto; overflow-x: hidden;">
                                <table width="98%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0"
                                                    height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td width="25%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICEMONITORITEM_325%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICEMONITORITEM_326%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_cabinet":"" %>' id="<%=device.id %>"  rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/cabinetedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'cabinet');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img7" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_cabinet":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/cabinetedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'cabinet');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img8" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_cabinet":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="25%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=device.fullName%>">
                                                                    <%=device.fullName%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                                            </td>
                                                            <td width="15%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="15%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/cabinetedit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'cabinet');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img9" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <%}
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%}%>
                <%if ((ViewData["data"] as IList<Device>).Count(model => model.deviceTypeCode == (DeviceData.AMMETER_CODE)) >= 0)
                  { %>
                <div class="subrbox01">
                    <div style="padding-top: 5px; font-weight: bold; margin-bottom: 15px; background: url(/images/sub/namebb.gif) no-repeat;
                        padding-left: 20px;">
                        <%=Resources.SunResource.DEVICE_MONITOR_AMMETER%></div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab5" href="javascript:void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab5" href="javascript:void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                            <%if (!Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                              {%>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.PLANT_DEVICEMONITOR_VIEW_ALL%>"
                                    style="background: #5A8C28; cursor: pointer; color: #FFFFFF; border: 1px solid #256525;
                                    font-family: Arial, Helvetica, sans-serif; height: 20px;" onclick="viewAll('db')" /></li>
                            <li style="float: right; padding-right: 5px; padding-top: 3px;">
                                <input type="button" name="Submit2" value="<%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%>"
                                    onclick="window.open('/plant/ammeter_output/<%=Model.id %>')" style="background: #5A8C28;
                                    cursor: pointer; color: #FFFFFF; border: 1px solid #256525; font-family: Arial, Helvetica, sans-serif;
                                    height: 20px;" /></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; max-height: 420px; overflow: hidden;" id="db_container">
                            <div style="width: 720px; max-height: 420px; overflow-y: auto; overflow-x: hidden;">
                                <table width="98%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0"
                                                    height="25">
                                                    <tbody>
                                                        <tr>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.DEVICEMONITORITEM_924%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <strong>
                                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_db":"" %>'  id="<%=device.id %>"  rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="20%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/ammeteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'db');">
                                                                    <img id="img3" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img7" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_db":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                                                                </div>
                                                            </td>
                                                            <td width="20%" align="center">
                                                                <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="20%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/ammeteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'db');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img8" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
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
                                        <tr class='<%=device.isHidden?"hidden_db":"" %>' id="<%=device.id %>" rof="<%=!device.isHidden %>">
                                            <td>
                                                <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" height="35" width="20%">
                                                                <div style="width: 150px; overflow: hidden; float: left; text-align: center;" title="<%=plantUnit.displayname%>">
                                                                    <%if (fault)
                                                                      { %>
                                                                    <img src="/images/bni.gif" alt="" class="img_list" />
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <img src="/images/accept.gif" alt="" class="img_list" />
                                                                    <% }%>
                                                                    <%=plantUnit.displayname%></div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <div style="width: 100px; overflow: hidden" title="<%=device.fullName%>">
                                                                    <%=device.fullName%>
                                                                </div>
                                                            </td>
                                                            <td align="center" width="20%">
                                                                <%=device.getMonitor(MonitorType.MIC_AMMETER_POSITIVEACTIVEPOWERDEGREE)%>
                                                            </td>
                                                            <td width="20%" align="center">
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
                                                            <td width="20%" align="center">
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="/plant/ammeteredit/<%=Model.id%>?<%=device.id%>">
                                                                    <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img src="/images/sub/pencil0.gif" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                    title="<%=Resources.SunResource.MONITORITEM_EDIT%>" width="16" border="0" height="16">
                                                                <%} %>
                                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_DEVICE) && !UserUtil.isDemoUser)
                                                                  { %>
                                                                <a href="javascript:void(0)" onclick="hiddenDevice(<%=device.id %>,'db');">
                                                                    <img id="img<%=device.id %>" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                        src='/images/<%=device.isHidden==false?"xs":"yc" %>.gif' />
                                                                </a>
                                                                <%}
                                                                  else
                                                                  { %>
                                                                <img id="img9" title="<%=device.isHidden?Resources.SunResource.PLANT_DEVICEMONITOR_SHOW: Resources.SunResource.PLANT_DEVICEMONITOR_HIDDEN%>"
                                                                    src='/images/yc.gif' />
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <%}
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            
                <%}%>
               <br/>
            </td>
        </tr>
    </table>
     
</asp:Content>
 