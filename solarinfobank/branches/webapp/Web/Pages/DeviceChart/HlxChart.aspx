<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>"%>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=Resources.SunResource.HLXCHART_HLX_CHART%></title>
</head>
<body> 
    <script type="text/javascript">
        $(document).ready(function() {
            $('#MonthChart').click(displayMonthDDChart);
            $('#YearChart').click(displayyearMMChart);
            $('#TotalChart').click(displayyearChart);
            $('#DayChart').click(displayDayChart);
            $("#startYYYYMMDDHH").val($("#startYYYYMMDDHHbefore").val());
            $("#endYYYYMMDDHH").val($("#endYYYYMMDDHHbefore").val());          
            displayDayChart();
        });
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

        }
        function displayDayChart() {
            $("#selectTable").show();
            curChart = "DayChart";
            dayChart("chartContainer", 90, false);
            changeALT();
        }

        function displayMonthDDChart() {
            $("#selectTable").show();
            curChart = "MonthChart";
            monthChart("chartContainer", 90, false);
            changeALT();
        }
        function displayyearMMChart() {
            $("#selectTable").show();
            curChart = "YearChart";
            yearChart("chartContainer", 90, false);
            changeALT();
        }

        function displayyearChart() {
            $("#selectTable").hide();
            curChart = "TotalChart";
            totalChart("chartContainer", 90, false);
        }

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container" });
            if (curChart == "MonthChart")
                monthChart("large_container", 130, true);
            else if (curChart == "YearChart") {
                yearChart("large_container", 130, true);
            } else if (curChart == "DayChart") {
                dayChart("large_container", 130, true);
            } else
                totalChart("large_container", 130, true);
        }

        function monthChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthChart");
            $.ajax({
                type: "POST",
                url: "/DeviceChart/DeviceMonthDayChart",
                data: { dId: $("#deviceID").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (result.indexOf("error:") > -1) {
                        $('#' + curContainer).empty();
                        $('#' + curContainer).append(result.substring(result.indexOf("error:") + 6));
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6) + $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result, $("#endYYYYMMDD").val());
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
                url: "/DeviceChart/DeviceYearMMChart",
                data: { dId: $("#deviceID").val(), startYM: $("#startYM").val(), endYM: $("#endYM").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (result.indexOf("error:") > -1) {
                        $('#' + curContainer).empty();
                        $('#' + curContainer).append(result.substring(result.indexOf("error:") + 6));
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYM").val().substring(0, 4) + $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result, $("#endYM").val());

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
                url: "/DeviceChart/DeviceYearChart",
                data: { dId: $("#deviceID").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (result.indexOf("error:") > -1) {
                        $('#' + curContainer).empty();
                        $('#' + curContainer).append(result.substring(result.indexOf("error:") + 6));
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result);

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
            $("#intervalMins").val('5')
            $.ajax({
                type: "POST",
                url: "/DeviceChart/CompareDayChart",
                data: { dId: $("#deviceID").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'line', intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    showDetails(result, $("#endYYYYMMDDHH").val());
                    if (!isLarge) {
                        loadCountData();
                    }
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function loadCountData() {
            $("#countDataDiv").empty();
            $("#countDataDiv").html('<img src="/Images/ajax_loading.gif" style="margin-left:350px;" />');
            $.ajax({
                type: "GET",
                url: "/Device/CurrentCount",
                data: { id: $("#deviceID").val(), YYYYMMDDHH: $("#endYYYYMMDDHH").val() },
                success: function(result) {
                    $('#countDataDiv').empty();
                    $('#countDataDiv').html(result);
                    //$('#loading').hide();
                }
            });
        }
        
        function changeStyle(curId) {
            $("#chart_detail_grid").empty();
           // $("#chart_detail_grid").html("<img src=\"/Images/ajax_loading_min.gif\" style=\"margin-left:48%\"/>");
            $("#MonthChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#TotalChart").attr("class", "noclick");
            $("#DayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
            
            $("#date_MonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_DayChart").hide();
            $("#date_" + curId).show();
        }

        function changePreDay(obj) {
            var d = obj.value;
            var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
            nextDay.setDate(nextDay.getDate() + 1);
            var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
            $("#t1").val(temp);
            changeDay(document.getElementById('t1'));
        }


        function changeDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "05");
            $("#endYYYYMMDDHH").val(aimDay + "21")
            displayDayChart();

            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("." + obj.id).val(aimDay);

        }
        function changeYear(obj) {
            $("#year").val(obj.value)
            displayyearMMChart();
        }

        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            $("#startYYYYMMDD").val(selectyear + selectmonth + "01")
            $("#endYYYYMMDD").val(selectyear + selectmonth + "31")
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
            $("#selectyear").attr("value", $("#year").val());
            $("#selectMonth").attr("value", $("#month").val());
        }
        
        function PreviouNextChange(oper) {
            changeDate(oper, "t1");
            changeDay(document.getElementById("t1"));
        }
    </script>
    <div class="subico01" id="selectDate" style="display:none;">
    <ul id="change">
        <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_DAILY%></a></li>
        <li style="cursor: pointer;"><a id="MonthChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
        <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
        <li style="cursor: pointer;"><a id="TotalChart"  class="noclick" href="javascript:void(0)"><%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
    </ul>
    </div>
    <div class="z_big">
    <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
    </a></div>
    <div class="chart">
    <div class="chart_box">
        <div id="chartDiv">
            <div id='chartContainer' style='width: 100%; height: 550px; margin-left: 2px; margin-right: 2px; text-align:center;'>
            </div>
        </div>
        <div class="date_sel">
            <div id="selectTable" style="margin-top: 20px; text-align: center;">
                <table  border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="24">
                            <img src="/images/chartLeft.gif" onclick="PreviouNextChange('left') " id="left" width="24" height="21" style="cursor:pointer;"/>
                        </td>
                        <td>
                           <div id="date_DayChart">
                                <input type="text" class="t1" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                <input name="t" type="text" id="t1" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                 <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                <input type="hidden" id="Hidden1" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" /> 
                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                           </div>
                        </td>
                        <td width="24">
                            <img src="/images/chartRight.gif" onclick="PreviouNextChange('right') " width="24" height="21" id="right" style="cursor:pointer;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- count data-->
        <div style="padding:20px 0px;" id="countDataDiv">

	    </div>
    </div>
    <div class="chart_down">
    </div>
    </div>
</body>
</html>
