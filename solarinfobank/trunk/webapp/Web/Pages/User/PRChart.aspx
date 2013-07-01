<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.PLANT_OVERVIEW_PRCHART_TITLE%></title>
    <style type="text/css">
        <!
        -- .line_b
        {
            border-bottom: 1px solid #9EC93D;
        }
        body
        {
            background: #F7F7F7;
        }
        .fr30
        {
            float: right;
            padding-right: 20px;
        }
        .fl30
        {
            float: left;
            padding-left: 20px;
        }
        -- ></style>
</head>

<script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script>

<script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

<script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

<script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>

<script src="/Script/SetChart.js" type="text/javascript"></script>

<script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

<script>
    var curChart;
    function changeStyle(curId) {
        $("#MonthChart").attr("class", "noclick");
        $("#YearChart").attr("class", "noclick");
        $("#DayChart").attr("class", "noclick");
        $("#" + curId).attr("class", "onclick");
        $("#date_MonthChart").hide();
        $("#date_YearChart").hide();
        $("#date_DayChart").hide();
        $("#date_" + curId).show();
    }
    function changeALT() {
        var ImageButtonLeft = document.getElementById("left");
        var ImageButtonRight = document.getElementById("right");
        ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
        ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
    }


    function dayChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("DayChart");
        $.ajax({
            type: "POST",
            url: "/plantchart/PRDayChart",
            data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'area', intervalMins: $("#intervalMins").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + "", data.name);
                setyAxis(data);
                setySeriesArr(data.series);
                var intervalMins = $("#intervalMins").val();

                var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
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

    function monthChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("MonthChart");
        $.ajax({
            type: "POST",
            url: "/plantchart/PRMonthDDChart",
            data: { id: $("#pid").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6) + "", data.name);
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


    function yearChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("YearChart");
        $.ajax({
            type: "POST",
            url: "/plantChart/PRYearMMChart",
            data: { id: $("#pid").val(), year: $("#year").val(), chartType: $("#chartType").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val() + "", data.name);
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


    function displayDayChart() {
        $("#intervalMins").val($("#intervalSelect").val());
        curChart = "DayChart";
        dayChart("container", 70, false);
        changeALT();
    }
    function displayMonthDDChart() {
        curChart = "MonthChart";
        monthChart("container", 70, false);
        changeALT();
    }
    function displayyearMMChart() {
        curChart = "YearChart";
        yearChart("container", 70, false);
        changeALT();
    }

    function changeDay(obj) {
        var aimDay = obj.value;
        if (aimDay) {
            aimDay = aimDay.replace("-", "").replace("-", "");
        }
        $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "00");
        $("#endYYYYMMDDHH").val(aimDay + "23")
        displayDayChart();

        aimDay = getBeforDay(aimDay);
        aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
        if ($("." + obj.id) != undefined) {
            $("." + obj.id).val(aimDay);
        }
    }
    function addZero(val) {
        return val < 10 ? "0" + val : val;
    }

    function changePreDay(obj) {

        var d = obj.value;
        var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
        nextDay.setDate(nextDay.getDate() + 1);
        var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
        $("#t").val(temp);
        changeDay(document.getElementById('t'));
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

    $(document).ready(function() {
        displayDayChart();
        $("#DayChart").click(displayDayChart);
        $("#MonthChart").click(displayMonthDDChart);
        $("#YearChart").click(displayyearMMChart);
    });
    
</script>

<% Html.RenderPartial("css"); %>
<body>
    <div class="mainbody">
        <!--header开始-->
        <div style="background:url(/images/tc_topbg.jpg); height:57px;"><div style=" float:left; height:57px; padding:0px 0px 0px 20px; width:300px;"><img src="/images/tc_logo.gif" width="206" height="57" /></div>
<div style="float:right; padding-right:10px;"><img src="/images/rlogo.gif" width="137" height="57" /></div>
</div>
        <!--结束-->
        <!--main开始-->
        <div style="padding: 30px 0px 80px 0px; margin: 0px auto; width: 98%;">
            <div>
                <input type="hidden" value="<%=System.DateTime.Now.Year%>" id="year" />
                <input type="hidden" value="column" id="chartType" />

                <input type="hidden" value="5" id="intervalMins" />
                <input type="hidden" value="<%=CalenderUtil.getBeforeDay(DateTime.Now,"yyyyMMdd")%>00"
                    id="startYYYYMMDDHH" />
                <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23"
                    id="endYYYYMMDDHH" />
                <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01"
                    id="startYYYYMMDD" />
                <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays()%>"
                    id="endYYYYMMDD" />
                <input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
                <input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <div class="subico01">
                                <ul id="change">
                                    <li><a href="#" id="DayChart"><%=Resources.SunResource.MONITORITEM_DAY%></a></li>
                                    <li><a href="#" id="MonthChart"><%=Resources.SunResource.MONITORITEM_MONTH%></a> </li>
                                    <li><a href="#" id="YearChart"><%=Resources.SunResource.MONITORITEM_YEAR%></a></li>
                                </ul>
                            </div>
                            <div id='container' style='width: 100%; height: 320px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                            <table border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="24">
                                        <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')"
                                            style="cursor: pointer;" alt="Previous" />
                                    </td>
                                    <td>
                                        <div id="date_DayChart" style="display: none;">
                                            <input type="text" class="t" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(0,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                readonly="readonly" value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(0,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>"
                                                style="text-align: center;" />
                                            -
                                            <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(0,"yyyy-MM-dd")%>'})"
                                                readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(0,"yyyy-MM-dd")%>"
                                                style="text-align: center;" />
                                            <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                            <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(0,"yyyy-MM-dd")%>" />
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

                                                            if (i == int.Parse(CalenderUtil.curDateWithTimeZone(0, "MM")))
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
                                        <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')"
                                            style="cursor: pointer;" alt="Next" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td background="/images/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9">
                            <img src="/images/tc06.gif" width="9" height="9" />
                        </td>
                        <td background="/images/tc07.gif">
                        </td>
                        <td>
                            <img src="/images/tc08.gif" width="9" height="9" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!--结束-->
        <div style="clear: both">
        </div>
        <!--footer开始-->
        <div style="width: 100%; background: url(images/fbg.jpg); height: 34px; line-height: 34px;
            margin-top: 10px; text-align: center; color: #7E7E7E; margin: 0px auto;">
            <span><%=string.Format(Resources.SunResource.SHARED_MAINMASTREPAGE_COPYRIGHT, Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.SysName)%></span>
        </div>
        <!--结束-->
    </div>
</body>
</html>
