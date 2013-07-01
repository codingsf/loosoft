<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/UserInside.Master" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
 <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_DAY_COMPARED_CHART  %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function() {
            $('#MonthChart').click(displayMonthDDChart);
            $('#YearChart').click(displayyearMMChart);
            $('#TotalChart').click(displayyearChart);
            $('#DayChart').click(displayDayChart);
            displayDayChart();
            selectYear2Month();
        });
        function displayDayChart() {
            $("#selectTable").show();
            curChart = "DayChart";
            dayChart("container", 70, false);
            changeALT();
        }
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

        }
        function displayMonthDDChart() {
            $("#selectTable").show();
            curChart = "MonthChart";
            monthChart("container", 70, false);
            changeALT();
        }
        function displayyearMMChart() {
            $("#selectTable").show();
            curChart = "YearChart";
            yearChart("container", 70, false);
            changeALT();
        }

        function displayyearChart() {
            $("#selectTable").hide();
            curChart = "TotalChart";
            totalChart("container", 70, false);
        }

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container_chart" });
            if (curChart == "MonthChart")
                monthChart("large_container_chart", 130, true);
            else if (curChart == "YearChart") {
                yearChart("large_container_chart", 130, true);
            } else if (curChart == "DayChart") {
                dayChart("large_container_chart", 130, true);
            } else
                totalChart("large_container_chart", 130, true);
        }

        function monthChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/UserMonthDDChart",
                data: {userId: <%=Model.id%>, startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "",data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function yearChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/UserYearMMChart",
                data: {userId: <%=Model.id%>, startYM: $("#startYM").val(), endYM: $("#endYM").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "",data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function totalChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("TotalChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/UserYearChart",
                data: {userId: <%=Model.id%>, chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "",data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function dayChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("DayChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/UserDayChart",
                data: {userId: <%=Model.id%>, startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'line,column', mts: $("#mts").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "",data.name);
                    setyAxis(data);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / intervalMins : 60 / intervalMins;
                    setySeriesArr(data.series, interval);

                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        
        function changeStyle(curId) {
            $("#DayChart").attr("class", "noclick");
            $("#MonthChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#TotalChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
            $("#date_MonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_DayChart").hide();
            $("#date_" + curId).show();
        }

        function changeDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(aimDay + "00")
            $("#endYYYYMMDDHH").val(aimDay + "23")
            displayDayChart();
        }
        function changeYear(obj) {
            $("#year").val(obj.value)
            displayyearMMChart();
        }

        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            $("#startYYYYMMDD").val(selectyear + selectmonth + "01")
            $("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
            displayMonthDDChart();
        }

        function changeChartType(obj) {
            var chartype = obj.value;
            $("#chartType").val(chartype)
            if (curChart == "MonthChart")
                monthChart("container", 70, false);
            else if (curChart == "YearChart") {
                yearChart("container", 70, false);
            } else if (curChart == "DayChart") {
                dayChart("container", 70, false);
            } else
                totalChart("container", 70, false);
        }

        function selectYear2Month() {
            $("#selectYear1").attr("value", $("#year").val());
            $("#selectYear").attr("value", $("#year").val());
            $("#selectMonth").attr("value", $("#month").val());
        }

        function PreviouNextChange(oper) {

            if (curChart == "DayChart") {
                changeDate(oper, "t");
                changeDay(document.getElementById("t"));
            }
            if (curChart == "MonthChart") {
                changeShowMonth(oper, "selectmonth", "selectyear");
                changeMonth();
            }
            if (curChart == "YearChart") {
                changeShowYear(oper, "selectYear1")
                changeYear(document.getElementById("selectYear1"));
            }
        }
    </script>

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>
	<script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>    
    <script src="/Script/SetChart.js" type="text/javascript"></script> 
    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>
    
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
        <input type="hidden" value="60" id="intervalMins" />
        <input type="hidden" value="<%=MonitorType.PLANT_MONITORITEM_POWER_CODE%>,<%=MonitorType.PLANT_MONITORITEM_ENERGY_CODE%>" id="mts" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>00" id="startYYYYMMDDHH" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>23" id="endYYYYMMDDHH" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01" id="startYYYYMMDD" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays()%>" id="endYYYYMMDD" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>" id="month" />
        <input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
        <input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />       
        <input type="hidden" value="column" id="chartType" />
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.CHART_ALL_PLANTS_DAY_COMPARE %></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.CHART_ALL_PLANTS_DAY_COMPARE_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox02" style="display:none;">
            <select name="select" onchange="changeChartType(this)">
                <option value="line" style="text-align: left;" id="changeOption_Line">
                    <%=Resources.SunResource.USER_POWERENERGY_LINE %></option>
                <option value="bar" style="text-align: left;"id="changeOption_Bar">
                    <%=Resources.SunResource.USER_POWERENERGY_BAR%></option>
                <option value="column" style="text-align: left;" id="changeOption_Column">
                    <%=Resources.SunResource.USER_POWERENERGY_COLUMN%></option>
                <option value="area" style="text-align: left;" id="changeOption_Area">
                    <%=Resources.SunResource.USER_POWERENERGY_AREA%></option>
                <option value="scatter" style="text-align: left;" id="changeOption_Scatter">
                    <%=Resources.SunResource.USER_POWERENERGY_SCATTER %></option>
            </select>
        </div>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="subico01" style=" display:none;">
                    <ul id="change">
                        <li style="cursor: pointer;"><a id="DayChart" class="onclick"  href="javascript: void(0);"><%=Resources.SunResource.MONITORITEM_DAY %></a></li>
                        <li style="cursor: pointer;"><a id="MonthChart"  class="noclick" href="javascript:void(0)"><%=Resources.SunResource.MONITORITEM_MONTH %></a></li>
                        <li  style="cursor: pointer;"><a id="YearChart"  class="noclick" href="javascript:void(0)"><%=Resources.SunResource.MONITORITEM_YEAR %></a></li>
                        <li style="cursor: pointer;"><a  id="TotalChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.MONITORITEM_TOTAL %></a></li>
                    </ul>
                </div>
                <div class="z_big">
                    <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id='container' style='width: 100%; height: 300px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                        </div>

                        <script src="../../Script/jquery.colorbox.js" type="text/javascript"></script>

                        <div style="display: none">
                            <center>
                                <div id='large_container_chart' style="width: 90%; height: 400px; margin-left: 50px; margin-right: 50px; text-align:center;">
                                </div>
                            </center>
                        </div>
                        <div class="date_sel">
                            <div id="selectTable" style="margin-top: 10px;">
                                <table border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="24">
                                            <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                                        </td>
                                        <td>
                                            <div id="date_DayChart" style="display: none;">
                                                <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                                <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" /> 
                                            </div>
                                            <div id="date_YearChart">
                                               <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                            </div>
                                            <div id="date_MonthChart" style="display: none;">
                                                <div style="float: left;">
                                                    <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:60px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                                </div>
                                                <div style="float: right;">
                                                    <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth">
                                                        <%
                                                        for (int i = 1; i <= 12; i++)
                                                        {
                                                            if (i == int.Parse(CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone, "MM")))
                                                            {
                                                        %>
                                                            <option value="<%=i.ToString("00")%>" selected="selected"><%=i.ToString("00")%></option>
                                                            <%}else { %>
                                                            <option value="<%=i.ToString("00")%>"><%=i.ToString("00")%></option>
                                                            <%}
                                                        }%>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                        <td width="24">
                                            <img src="/images/chartRight.gif" id="right" width="24" height="21" onclick="PreviouNextChange('right')" style="cursor:pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div style='float: right; z-index: 1001; margin-bottom: 200px;'>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
