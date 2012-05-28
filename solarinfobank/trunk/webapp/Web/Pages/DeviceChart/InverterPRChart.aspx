<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Resources.SunResource.INVERTERCHART_INVERTER_CHART%>
    </title>
</head>
<body>
    <script type="text/javascript">
        var curChart;
        function changeStyle(curId) {
            $("#YearMonthChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#MonthDayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
            $("#date_YearMonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_MonthDayChart").hide();
            $("#date_" + curId).show();
            if (curId == "YearChart") {
                document.getElementById("date_select_div").style.display = "none";
            } else {
                document.getElementById("date_select_div").style.display = "block";
            }
        }

        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }

        function monthDayChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthDayChart");
            $.ajax({
                type: "POST",
                url: "/deviceChart/PRMonthDDChart",
                data: { dId: $("#deviceID").val(), pId: <%=Model.id %>, startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer, 70);
                    showDetails(result, $("#startYYYYMMDD").val());

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function yearMonthChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearMonthChart");
            $.ajax({
                type: "POST",
                url: "/deviceChart/PRYearMMChart",
                data: { dId: $("#deviceID").val(), pId: <%=Model.id %>, year: $("#year").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val() + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer, 60);
                    showDetails(result, $("#year").val());

                    //修改标题
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
                url: "/deviceChart/PRYearChart",
                data: { dId: $("#deviceID").val(), pId: <%=Model.id %> },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    showDetails(result);
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function displayMonthDDChart() {
            curChart = "MonthDayChart";
            monthDayChart("chartContainer", 70, false);
            changeALT();
        }

        function displayYearMMChart() {
            curChart = "YearMonthChart";
            yearMonthChart("chartContainer", 70, false);
            changeALT();
        }

        function displayYearChart() {
            curChart = "YearChart";
            yearChart("chartContainer", 70, false);
        }

        function addZero(val) {
            return val < 10 ? "0" + val : val;
        }

        function changeYear(obj) {
            $("#year").val(obj.value)
            displayYearMMChart();
        }

        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            $("#startYYYYMMDD").val(selectyear + selectmonth + "01")
            $("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
            displayMonthDDChart();
        }

        function PreviouNextChange(oper) {
            if (curChart == "MonthDayChart") {
                changeShowMonth(oper, "selectmonth", "selectyear");
                changeMonth();
            }
            if (curChart == "YearMonthChart") {
                changeShowYear(oper, "selectYear1")
                changeYear(document.getElementById("selectYear1"));
            }
        }

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container" });
            if (curChart == "MonthDayChart")
                monthDayChart("large_container", 130, true);
            else if (curChart == "YearMonthChart") {
                yearMonthChart("large_container", 130, true);
            } else if (curChart == "YearChart") {
                yearChart("large_container", 130, true);
            }
        }     
        
        
        $(document).ready(function() {
            displayMonthDDChart();
            $("#MonthDayChart").click(displayMonthDDChart);
            $("#YearMonthChart").click(displayYearMMChart);
            $("#YearChart").click(displayYearChart);
        });
    
    </script>

    <div class="subico01" id="selectDate">
        <ul id="change">
            <li style="cursor: pointer;"><a id="MonthDayChart" class="onclick" href="javascript:void(0)">
                <%=Resources.SunResource.MONITORITEM_MONTH%></a></li>
            <li style="cursor: pointer;"><a id="YearMonthChart" class="noclick" href="javascript:void(0)">
                <%=Resources.SunResource.MONITORITEM_YEAR%></a></li>
            <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0)">
                <%=Resources.SunResource.MONITORITEM_TOTAL%></a></li>
        </ul>
    </div>
    <div class="z_big">
        <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
        </a>
    </div>
    <div class="chart">
        <div class="chart_box">
            <div id="chartDiv">
                <div id="dayIntervalDiv" style="display: none;">
                    Interval Mins:
                    <select name="select" id="intervalSelect" onchange="changeInterval()">
                        <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                        <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                        <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                        <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                    </select>
                </div>
                <div id='chartContainer' style='width: 100%; height: 350px; margin-left: 2px; margin-right: 2px;
                    text-align: center;'>
                </div>
            </div>
           <div class="date_sel" id="date_select_div">
                <div id="selectTable" style="margin-top: 20px; text-align: center;">
                    <table border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="24">
                                <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')"
                                    style="cursor: pointer;" />
                            </td>
                            <td>
                                <div id="date_YearMonthChart" style="display: none;">
                                    <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                </div>
                                <div id="date_MonthDayChart" style="display: none;">
                                    <div style="float: left;">
                                        <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:65px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                    </div>
                                    <div style="float: right;">
                                        <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth">
                                            <%
                                                for (int i = 1; i <= 12; i++)
                                                {
                                                    if (i == int.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone, "MM")))
                                                    {
                                            %>
                                            <option value="<%=i.ToString("00")%>" selected="selected">
                                                <%=i.ToString("00")%></option>
                                            <%}
                                                    else
                                                    { %>
                                            <option value="<%=i.ToString("00")%>">
                                                <%=i.ToString("00")%></option>
                                            <%}
                                                }%>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td width="24">
                                <img src="/images/chartRight.gif" width="24" height="21" onclick="PreviouNextChange('right')"
                                    style="cursor: pointer;" id="right" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- count data-->
            <div style="padding: 20px 0px;" id="countDataDiv">
            </div>
            <div id="chart_detail_grid" style="width: 100%; overflow: hidden;">
            </div>
        </div>
        <div class="chart_down">
        </div>
    </div>
</body>
</html>
