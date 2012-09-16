<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>

    <script src="/Script/SetChart.js" type="text/javascript"></script>

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    var tempData;
    function hiddenTab(item, container) {
        var url = "/unit/detail/?" + new Date().getMilliseconds();
        if ((item.indexOf("Summary") != -1)) {
            $("#" + container).html(tempData);
            parent.iFrameHeight();
        }
        else {
            $.ajax({
                type: "GET",
                url: url,
                data: { id: <%=Model.id %> },
                success: function(result) {
                    if (tempData == undefined) {
                        tempData = $("#unit_container").html();
                    }
                    $("#" + container).html(result);
                    parent.iFrameHeight();
                }
            });
        }
    }

    $(document).ready(function() {
        $("#Detailtab1").click(function() {
            hiddenTab("Detailtab1", "unit_container");
            $("#Detailtab1").addClass("onclick");
            $("#Summarytab1").removeClass("onclick");
        });

        $("#Summarytab1").click(function() {
            $("#Summarytab1").addClass("onclick");
            $("#Detailtab1").removeClass("onclick");
            hiddenTab("Summarytab1", "unit_container");
        });
        //loadUnitsChart();
    });
    
    //加载单元比较图表
    function loadUnitsChart() {
        $.ajax({
            type: "GET",
            url: "/plantchart/unitcomparepage?pid=<%=Model.id %>",
            data: {},
            success: function(result) {
                $('#UnitsChart').html(result);
                readyinit();
                parent.iFrameHeight();
            },
            beforeSend: function() {
                $('#UnitsChart').empty();
            }
        });
    }
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                        </td>
                        <td width="777">
                            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td class="pv0216">
                                        <%=Resources.SunResource.PLANT_UNIT_LIST_UNIT_LIST%>
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
                                        <%=Resources.SunResource.PLANT_UNIT_LIST_UNIT_LIST_DETAIL%>
                                    </td>
                                    <td width="18%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6" align="right">
                            <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                        </td>
                    </tr>
                </table>
                <div class="subrbox01">
                    <div>
                        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().username == UserUtil.demousername)
                                  { %>
                                <td width="6%" align="center">
                                    <img src="/images/sub/subico016.gif" width="15" height="16" alt="<%=Resources.SunResource.MONITORITEM_ADD %>"
                                        title="<%=Resources.SunResource.MONITORITEM_ADD %>" />
                                </td>
                                <td width="94%">
                                    <%=Resources.SunResource.MONITORITEM_ADD %>
                                </td>
                                <%}
                                  else
                                  {%>
                                <td width="6%" align="center">
                                    <a href="/unit/bind/<%=Model.id %>" class="dbl">
                                        <img src="/images/sub/subico016.gif" width="15" height="16" alt="<%=Resources.SunResource.MONITORITEM_ADD %>"
                                            title="<%=Resources.SunResource.MONITORITEM_ADD %>" /></a>
                                </td>
                                <td width="94%">
                                    <a href="/unit/bind/<%=Model.id %>" class="dbl">
                                        <%=Resources.SunResource.MONITORITEM_ADD %></a> | <a href="/unit/units_output/<%=Model.id %>"
                                            class="dbl">
                                            <%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%></a>
                                </td>
                                <%} %>
                            </tr>
                        </table>
                    </div>
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="Summarytab1" href="javascript: void(0);" class="onclick">
                                <%=Resources.SunResource.SUMMARY%></a></li>
                            <li><a id="Detailtab1" href="javascript: void(0);">
                                <%=Resources.SunResource.DETAIL%></a></li>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <div style="margin: 0 auto; width: 730px;" id="unit_container">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                            <tr>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.PLANT_UNIT_LIST_STATUS %></strong>
                                                    <br />
                                                    <span class="f11">&nbsp;</span>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.PLANT_UNIT_LIST_UNIT_NAME%></strong>
                                                    <br />
                                                    <span class="f11">&nbsp;</span>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.PLANT_UNIT_LIST_POWER %></strong>
                                                    <br />
                                                    <span class="f11">(kW)</span>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>日发电量</strong>
                                                    <br />
                                                    <span class="f11">(kWh)</span>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.PLANT_UNIT_LIST_ENERGY %></strong>
                                                    <br />
                                                    <span class="f11">(kWh)</span>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.MONITORITEM_OPERATION %></strong>
                                                    <br />
                                                    <span class="f11">&nbsp;</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%
                                    if (ViewData["plantUnits"] != null)
                                    {
                                        int i = 1;

                                        foreach (PlantUnit plantUnit in ViewData["plantUnits"] as IList<PlantUnit>)
                                        {
                                            float currentMonthEnergy = 0;
                                            float currentYearEnergy = 0;
                                            currentMonthEnergy = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(DateTime.Now.Year, plantUnit.collector.id, DateTime.Now.Month).count();
                                            CollectorYearData data = CollectorYearDataService.GetInstance().GetCollectorYearData(plantUnit.collector.id, DateTime.Now.Year);
                                            currentYearEnergy = data == null ? 0 : data.dataValue;
                                            i++;
                                            
                                %>
                                <tr>
                                    <td>
                                        <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tbody>
                                                <tr>
                                                    <td align="center" width="15%">
                                                        <%
                                                            if (plantUnit.collector.runData != null)
                                                            {
                                                                if (!plantUnit.isWork(Model.timezone))
                                                                {%>
                                                        <img src="/images/sub/line_off01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                            title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                        <% }
                                                                else
                                                                {%>
                                                        <img src="/images/sub/line_on01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                                            title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                                        <%}
                                                            }
                                                            else
                                                            {%>
                                                        <img src="/images/sub/line_off01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                            title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                        <%
                                                            } 
                                                        %>
                                                    </td>
                                                    <td align="center" height="25" width="15%">
                                                        <div title="<%=plantUnit.displayname%>" style="width: 100px; overflow: hidden;">
                                                            <%=plantUnit.displayname%></div>
                                                    </td>
                                                    <td align="center" width="15%">
                                                        <%=plantUnit.TodayPower(Model.timezone) %><%= Html.HiddenFor(model => model.id) %>
                                                    </td>
                                                    <td align="center" width="15%">
                                                        <%=plantUnit.TodayEnergy(Model.timezone)%>
                                                    </td>
                                                    <td align="center" width="15%">
                                                        <%=plantUnit.displayTotalEnergy%>
                                                    </td>
                                                    <td align="center" width="15%">
                                                        <%if (AuthService.isAllow(AuthorizationCode.EDIT_UNIT))
                                                          { %>
                                                        <a href="/unit/edit/?unitId=<%=plantUnit.id %>&plantId=<%=ViewData["plantid"]%>">
                                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                                title="<%=Resources.SunResource.MONITORITEM_EDIT%>" /></a>
                                                        <%}
                                                          else
                                                          {%>
                                                        <img src="/images/sub/pencil0.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                            title="<%=Resources.SunResource.MONITORITEM_EDIT%>" />
                                                        <%} %>
                                                        <%if (AuthService.isAllow(AuthorizationCode.DELETE_UNIT))
                                                          { %>
                                                        <a href="/unit/deleteunit/?plantid=<%=Model.id %>&unitid=<%=plantUnit.collector.id%>">
                                                            <img src="/images/sub/cross.gif" onclick="return confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>');"
                                                                width="16" height="16" border="0" title="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                                alt="<%=Resources.SunResource.MONITORITEM_DELETE%>" /></a>
                                                        <%}
                                                          else
                                                          {%>
                                                        <img src="/images/sub/cross00.gif" width="16" height="16" border="0" title="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                            alt="<%=Resources.SunResource.MONITORITEM_DELETE%>" />
                                                        <%} %>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </table>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div id="UnitsChart">
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Model.name %>
    <%=Resources.SunResource.PLANT_UNIT_LIST_UNIT_LIST%>
</asp:Content>
