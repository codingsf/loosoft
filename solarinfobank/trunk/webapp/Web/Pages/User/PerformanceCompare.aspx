<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/UserInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.CHART_PLANT_PERFORMANCE_CHART %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function() {
            CompareChart("container", 70, false);
            changeALT(); 
        });

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container_chart" });
            CompareChart("large_container_chart", 110, true);
          
        }

        function CompareChart(curContainer, ajaxImgTop, isLarge) {
            $.ajax({
                type: "POST",
                url: "/plantchart/PerformanceChart",
                data: {userId: <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id%>, startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0,8),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / intervalMins : 60 / intervalMins;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    //ÐÞ¸Ä±êÌâ
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

        }
        function changeDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(aimDay + "00")
            $("#endYYYYMMDDHH").val(aimDay + "23")
            CompareChart("container", 70, false);
           
        }
        function changeInterval() {
            $("#intervalMins").val($("#intervalSelect").val());
            CompareChart("container", 70, false);
        }

        function PreviouNextChange(oper) {
            curChart = "DayChart";
            if (curChart == "DayChart") {
                changeDate(oper, "t");
                changeDay(document.getElementById("t"));
            }
        }
    </script>

    <input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
    <input type="hidden" value="<%=ChartType.line %>" id="chartType" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>" id="month" />   
    <input type="hidden" value="60" id="intervalMins" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>00" id="startYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23" id="endYYYYMMDDHH" />

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>
	<script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>    
    <script src="/Script/SetChart.js" type="text/javascript"></script>    
    <script src="/Script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.CHART_PLANT_PERFORMANCE_CHART %></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.CHART_PLANT_PERFORMANCE_CHART_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox02" style="display:none;">
            <select name="select" onchange="changeChartType(this)">
                <option value="line" style="text-align: left;">
                    <%=Resources.SunResource.USER_POWERENERGY_LINE %></option>
                <option value="bar" style="text-align: left;">
                    <%=Resources.SunResource.USER_POWERENERGY_BAR%></option>
                <option value="column" style="text-align: left;">
                    <%=Resources.SunResource.USER_POWERENERGY_COLUMN%></option>
                <option value="area" style="text-align: left;">
                    <%=Resources.SunResource.USER_POWERENERGY_AREA%></option>
                <option value="scatter" style="text-align: left;">
                    <%=Resources.SunResource.USER_POWERENERGY_SCATTER %></option>
            </select>
        </div>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="z_big">
                    <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id="dayIntervalDiv" style="margin-left:20px; display:none;">
                                <%=Resources.SunResource.CHART_INTERVAL_MINS %>:
                                <select name="select" id="intervalSelect" onchange="changeInterval()">
                                    <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                                </select>
                            </div>
                            <div id='container' style='width: 100%; height: 350px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                        </div>

                        <script src="../../Script/jquery.colorbox.js" type="text/javascript"></script>

                        <div style="display: none">
                            <center>
                                <div id='large_container_chart' style="width: 90%; height: 450px; margin-left: 50px; margin-right: 50px; text-align:center;">
                                </div>
                            </center>
                        </div>
                        <div class="date_sel">
                            <div id="selectTable" style="margin-top: 20px;">
                                <table border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="24">
                                            <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;" />
                                        </td>
                                        <td align="center">
                                            <div id="date_DayChart">
                                                <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01"%>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                                <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" /> 

                                            </div>                                            
                                        </td>
                                        <td width="24">
                                            <img src="/images/chartRight.gif" id="right" width="24" height="21" onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="chart_down">
                    </div>
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
    
</asp:Content>
