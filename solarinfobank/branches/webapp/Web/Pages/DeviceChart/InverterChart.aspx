<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>"%>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=Resources.SunResource.INVERTERCHART_INVERTER_CHART%> </title>
    
</head>

<body> 

    <script type="text/javascript">
        $(document).ready(function() {
            $('#MonthChart').click(displayMonthDDChart);
            $('#YearChart').click(displayyearMMChart);
            $('#TotalChart').click(displayyearChart);
            $('#DayChart').click(displayDayChart);
            $('#DaykWpChart').click(displayDaykWpChart);
            //
            $("#startYYYYMMDDHH").val($("#startYYYYMMDDHHbefore").val());
            displayDayChart();
        });
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

        }
        function displayDayChart() {
            $("#chartType").val("line,line");
            $("#countDataDiv").empty();
            //document.getElementById("dayIntervalDiv").style.display = "block";
            $("#selectTable").show();
            curChart = "DayChart";
            dayChart("chartContainer", 90, false);
            changeALT();
        }

        function displayDaykWpChart() {
            $("#chartType").val("column,column");
            //document.getElementById("dayIntervalDiv").style.display = "block";
            $("#selectTable").show();
            curChart = "DaykWpChart";
            daykWpChart("chartContainer", 90, false);
            $("#countDataDiv").empty();
            changeALT();
        }

        function displayMonthDDChart() {
            $("#chartType").val("column");
            //document.getElementById("dayIntervalDiv").style.display = "none";
            $("#selectTable").show();
            curChart = "MonthChart";
            monthChart("chartContainer", 90, false);
            $("#countDataDiv").empty();
            changeALT();
        }
        function displayyearMMChart() {
            $("#chartType").val("column");
            //document.getElementById("dayIntervalDiv").style.display = "none";
            $("#selectTable").show();
            curChart = "YearChart";
            yearChart("chartContainer", 90, false);
            $("#countDataDiv").empty();
            changeALT();
        }

        function displayyearChart() {
            $("#chartType").val("column");
            //document.getElementById("dayIntervalDiv").style.display = "none";
            $("#selectTable").hide();
            curChart = "TotalChart";
            totalChart("chartContainer", 90, false);
            $("#countDataDiv").empty();
        }

        function loadCountData() {
            $("#countDataDiv").empty();
            $("#countDataDiv").html('<img src="/Images/ajax_loading.gif" style="margin-left:350px;" />');
            $.ajax({
                type: "GET",
                url: "/Device/PowerCount",
                data: { id: $("#deviceID").val(), startYYYYMMDDHH: $("#endYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val() },
                success: function(result) {
                    $('#countDataDiv').empty();
                    $('#countDataDiv').html(result);
                    //$('#loading').hide();
                }
            });
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
            } else if (curChart == "DaykWpChart") {
                daykWpChart("large_container", 130, true);
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
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    //修改标题
                    showDetails(result, $("#startYYYYMMDD").val());         
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function yearChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearChart");
            $.ajax({
                type: "POST",
                url: "/DeviceChart/DeviceYearMMChart",
                data: { dId: $("#deviceID").val(), startYM: $("#year").val() + '01', endYM: $("#year").val() + '12', chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result, $("#year").val());
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
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
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "", data.name);
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
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function dayChart(curContainer, ajaxImgTop, isLarge) {
            $("#intervalMins").val('5,5')
            changeStyle("DayChart");
            $.ajax({
                type: "POST",
                url: "/DeviceChart/CompareDayChart",
                data: { dId: $("#deviceID").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var interval = isLarge ? 60 / 5 : 120 / 5;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    if (!isLarge) {
                        loadCountData();
                        showDetails(result, $("#startYYYYMMDDHH").val());
                    }
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
            
        }

        function daykWpChart(curContainer, ajaxImgTop, isLarge) {
            $("#intervalMins").val('60,5')
            changeStyle("DaykWpChart");
            $.ajax({
                type: "POST",
                url: "/DeviceChart/CompareDaykWpChart",
                data: { dId: $("#deviceID").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + $("#deviceName").val(), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / 60 : 120 / 60;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    showDetails(result, $("#startYYYYMMDDHH").val());
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
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
            $("#DaykWpChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
            
            $("#date_MonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_DayChart").hide();
            $("#date_DaykWpChart").hide();
            $("#date_" + curId).show();
        }
        
        function changePreDay(obj) {
            var d = obj.value;
            var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
            nextDay.setDate(nextDay.getDate() + 1);
            var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
            if (curChart == "DayChart") {
                $("#t1").val(temp);
                changeDay(document.getElementById('t1'));
            }
            if (curChart == "DaykWpChart") {
                $("#t2").val(temp);
                changekWpDay(document.getElementById('t2'));
            }
            
            
        }
        
        function changeDay(obj) {
           
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#endYYYYMMDDHH").val(aimDay + "23")
            displayDayChart();

            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("."+obj.id).val(aimDay);
            
        }

        function changekWpDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#endYYYYMMDDHH").val(aimDay + "23")
            displayDaykWpChart();
            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("."+obj.id).val(aimDay);
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
            } else if (curChart == "DaykWpChart") {
                daykWpChart("container", 70, false);
            } else
                totalChart("container", 70, false);
        }

        function selectYear2Month() {
            $("#selectYear1").attr("value", $("#year").val());
            $("#selectYear").attr("value", $("#year").val());
            $("#selectMonth").attr("value", $("#month").val());
        }
        function changeInterval() {
            if (curChart=="DayChart")
                displayDayChart();
            else
                displayDaykWpChart();
        }

        function PreviouNextChange(oper) {

            if (curChart == "DayChart") {
                changeDate(oper, "t1");        
                changeDay(document.getElementById("t1"));
            }
            if (curChart == "DaykWpChart") {
                changeDate(oper, "t2");
                changekWpDay(document.getElementById("t2"));
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
    <div class="subico01" id="selectDate">
    <ul id="change">
        <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_DAILY%></a></li>
        <li style="cursor: pointer;"><a id="DaykWpChart" class="onclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_DAILY%>/kWp</a></li>
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
            <div id="dayIntervalDiv" style=" display:none;">
            Interval Mins:
                <select name="select" id="intervalSelect" onchange="changeInterval()">
                    <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                    <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                    <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                    <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                </select>
            </div>
            <div id='chartContainer' style='width: 100%; height: 550px; margin-left: 2px; margin-right: 2px; text-align:center;'>
            </div>
        </div>
        <div class="date_sel">
            <div id="selectTable" style="margin-top: 20px; text-align: center;">
                <table border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                                        
                        <td width="24">
                            <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                        </td>
                        <td>
                            <div id="date_DayChart" style="display: none;">
                            <input type="text" class="t1" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                <input name="t" type="text" id="t1" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                 <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" /> 

                            </div>
                            <div id="date_DaykWpChart" style="display: none;">
                            <input type="text" class="t2" size="12"  onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                <input name="t" type="text" id="t2" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changekWpDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                           </div>                            
                            <div id="date_YearChart" style="display: none;">
                            <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
   
                            </div>
                            <div id="date_MonthChart" style="display: none;">
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
                            <img src="/images/chartRight.gif" width="24" height="21" onclick="PreviouNextChange('right')" style="cursor:pointer;" id="right"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <!-- count data-->
        <div style="padding:20px 0px;" id="countDataDiv">

	    </div>
	    <div id="chart_detail_grid" style="width:100%; overflow:hidden;">
                                
        </div>
    </div>
    <div class="chart_down">
    </div>
    </div>

</body>
</html>
