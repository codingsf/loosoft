<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service.vo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>电站峰谷平尖数据-<%=ViewData["portalName"]%></title>
    <link href="/style/mhcss.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .lb
    {
        line-height: 40px;
        height: 40px;
    }
    .state_img
    {
        margin-top: 5px;
    }
</style>
<script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script> 
<link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var exportXlsTitle = "<%=Resources.SunResource.CHART_EXPORT_XLS%>";
    var exportCsvTitle = "<%=Resources.SunResource.CHART_EXPORT_CSV%>";
    var exportPdfTitle = "<%=Resources.SunResource.CHART_EXPORT_PDF%>";
    var infoTitle = "<%=Resources.SunResource.CHART_EXPORT_DATA%>";
    var largeButtonTitle = "<%=Resources.SunResource.LARGEBUTTONTITLE %>"
    var exportButtonTitle = "<%=Resources.SunResource.EXPORTBUTTONTITLE %>"
    $(document).ready(function() {
        $('#DayChart').click(displayDayChart);
        $('#MonthChart').click(displayMonthDDChart);
        $('#YearChart').click(displayyearMMChart);
        $('#TotalChart').click(displayyearChart);
        displayDayChart();
    });

    function changeALT() {
        var ImageButtonLeft = document.getElementById("left");
        var ImageButtonRight = document.getElementById("right");
        ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
        ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
    }

    function displayDayChart() {
        $("#intervalMins").val($("#intervalSelect").val());
        curChart = "DayChart";
        dayChart("container", 120, false);
        $("#countDataDiv").empty();
        changeALT();
    }
    function displayMonthDDChart() {
        curChart = "MonthChart";
        monthChart("container", 120, false);
        $("#countDataDiv").empty();
        changeALT();
    }

    function displayyearMMChart() {
        curChart = "YearChart";
        yearChart("container", 120, false);
        $("#countDataDiv").empty();
        changeALT();
    }

    function displayyearChart() {
        curChart = "TotalChart";
        totalChart("container", 120, false);
        $("#countDataDiv").empty();
    }

    function showDetails(data, date) {
        h_data = data;
        h_date = date;
        //                 $.ajax({
        //                     type: "POST",
        //                     url: "/plantchart/usermonthdetail",
        //                     data: { data: data,date:date },
        //                     success: function(result) {
        //                         $("#chart_detail_grid").html(result);
        //                     }
        //                 });

        //        var obj = $("#h_date");
        //        if (obj) {
        //            $("#h_date").val(date);
        //        }
        //        else {
        //            var h1 = document.createElement("input");
        //            h1.type = "hidden";
        //            h1.value = date;
        //            h1.name = "h_date";
        //            h1.id = "h_date";
        //            document.body.appendChild(h1);
        //        }
        //        obj = null;
        //        obj = $("#h_data");
        //        if (obj) {
        //            $("#h_data").val(data);
        //        }
        //        else {
        //            var h2 = document.createElement("input");
        //            h2.type = "hidden";
        //            h2.value = data;
        //            h2.name = "h_data";
        //            h2.id = "h_data";
        //            document.body.appendChild(h2);
        //        }
    }

    function loadCountData() {
        $("#countDataDiv").empty();
        $("#countDataDiv").html('<img src="/Images/ajax_loading_min.gif" style="margin-left:350px;" />');
        $.ajax({
            type: "GET",
            url: "/plant/PowerCount/?" + new Date().getMilliseconds(),
            data: { random: new Date().getMilliseconds(), id: $("#pid").val(), startYYYYMMDDHH: $("#endYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val() },
            success: function(result) {
                $('#countDataDiv').empty();
                $('#countDataDiv').html(result);
            }
        });
    }

    var curChart;
    function large() {
        $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container_chart" });
        if (curChart == "MonthChart")
            monthChart("large_container_chart", 180, true);
        else if (curChart == "YearChart") {
            yearChart("large_container_chart", 180, true);
        } else if (curChart == "TotalChart") {
            totalChart("large_container_chart", 180, true);
        } else
            dayChart("large_container_chart", 180, true);
    }

    function monthChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("MonthChart");
        $.ajax({
            type: "POST",
            url: "/plantchart/userFgpjMonthChart",
            data: { uid: $("#uid").val(), YYYYMM: $("#YYYYMM").val(), chartType: $("#chartType").val(), intervalMins: 5 },
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
                showDetails(result, $("#YYYYMM").val());

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
            url: "/plantChart/userFgpjYearChart",
            data: { uid: $("#uid").val(), year: $("#year").val(), chartType: $("#chartType").val() },
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
                $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
            }
        });
    }

    function totalChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("TotalChart");
        $.ajax({
            type: "POST",
            url: "/plantChart/PlantYearChart",
            data: { id: $("#pid").val(), chartType: $("#chartType").val() },
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
                $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
            }
        });
    }

    function dayChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("DayChart");
        $.ajax({
            type: "POST",
            url: "/plantchart/userFgpjDayChart",
            data: { uid: $("#uid").val(), YYYYMMDD: $("#YYYYMMDD").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8), data.name);
                setyAxis(data);
                setySeriesArr(data.series);
                var intervalMins = $("#intervalMins").val();

                var interval = 1;
                setCategoriesWithInterval(data.categories, isLarge, interval);
                defineChart(curContainer);
                //修改标题
                chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                //showDetails(result, $("#startYYYYMMDDHH").val());
                //天数据统计加载
                //loadCountData();
            },
            beforeSend: function() {
                $('#' + curContainer).empty();
                $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
            }
        });
    }
    function changeStyle(curId) {
        clearDetails();
        $("#MonthChart").attr("class", "noclick");
        $("#YearChart").attr("class", "noclick");
        $("#TotalChart").attr("class", "noclick");
        $("#DayChart").attr("class", "noclick");
        $("#" + curId).attr("class", "onclick");

        $("#date_MonthChart").hide();
        $("#date_YearChart").hide();
        $("#date_DayChart").hide();
        $("#date_" + curId).show();
        if (curId == "TotalChart") {
            document.getElementById("date_select_div").style.display = "none";
        } else {
            document.getElementById("date_select_div").style.display = "block";
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
        alert(temp)
        $("#t").val(temp);
        changeDay(document.getElementById('t'));
    }

    function changeDay(obj) {
        var aimDay = obj.value;
        // alert(obj.value)
        if (aimDay) {
            aimDay = aimDay.replace("-", "").replace("-", "");
        }
        //alert(aimDay)
        //$("#YYYYMMDD").val(getBeforDay(aimDay) + "00");
        $("#YYYYMMDD").val(aimDay)
        displayDayChart();

        //aimDay = getBeforDay(aimDay);
        //aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
        //if ($("." + obj.id) != undefined) {
        // $("." + obj.id).val(aimDay);
        //}
    }

    function changeYear(obj) {
        $("#year").val(obj.value)
        displayyearMMChart();
    }

    function changeMonth() {
        var selectyear = $("#selectyear").val();
        var selectmonth = $("#selectmonth").val();
        //$("#startYYYYMMDD").val(selectyear + selectmonth + "01")
        //$("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
        $("#YYYYMM").val(selectyear + selectmonth);
        displayMonthDDChart();
    }

    function changeInterval(obj) {
        displayDayChart();
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
<script src="/script/jquery.colorbox.js" type="text/javascript"></script>   
<script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>
<script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>
<script src="/script/SetChart.js" type="text/javascript"></script>    
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
<input type="hidden" value="<%=Model.id%>" id="uid" />
<input type="hidden" value="<%=System.DateTime.Now.Year%>" id="year" />
<input type="hidden" value="pie" id="chartType" />
<input type="hidden" value="5" id="intervalMins" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>"
    id="YYYYMMDD" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00") %>"
    id="YYYYMM" />    
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
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=ViewData["portalName"]%>
                </div>
                <div class="gf_toptittle2"><a href="/portal/index"><img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="clear: both; height: 10px;">
            </div>
            <div>
          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="9" height="9" background="/images/gf/tci/tc01.gif"></td>
              <td background="/images/gf/tci/tc02.gif"></td>
              <td width="9" height="9" background="/images/gf/tci/tc03.gif"></td>
            </tr>
            <tr>
              <td background="/images/gf/tci/tc04.gif">&nbsp;</td>
              <td bgcolor="#FFFFFF">
                        <div class="subico01">
                            <ul id="change">
                                <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript: void(0);">
                                    <%=Resources.SunResource.PLANT_OVERVIEW_DAY %></a></li>
                                <li style="cursor: pointer;"><a id="MonthChart" class="onclick" href="javascript:void(0);">
                                    <%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
                                <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0);">
                                    <%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
                                <!--
                                <li style="cursor: pointer;"><a id="TotalChart" class="noclick" href="javascript:void(0);">
                                    <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
                                    -->
                            </ul>
                        </div>
                    <div >
                        <div class="z_big">
                            <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
                            </a>
                        </div>
                        <div>
                            <div id="chartDiv">
                                <div id="dayIntervalDiv" style="display: none;">
                                    <%=Resources.SunResource.PLANT_OVERVIEW_INTERVAL_MINS %>:
                                    <select name="select" id="intervalSelect" onchange="changeInterval()">
                                        <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                        <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                        <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                        <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                                    </select>
                                </div>
                                <div id='container' style='width: 97%; height: 380px; margin-left: 2px; margin-right: 2px;'>
                                </div>
                            </div>
                            <div style="display: none">
                                <center>
                                    <div id='large_container_chart' style="width: 90%; height: 500px; margin-left: 50px;
                                        margin-right: 50px; text-align: center;">
                                    </div>
                                </center>
                            </div>
                            <div class="date_sel" id="date_select_div">
                                <div id="selectTable" style="margin-top: 10px; text-align: center;">
                                    <table border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="24">
                                                <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')"
                                                    style="cursor: pointer;" alt="Previous" />
                                            </td>
                                            <td>
                                                <div id="date_DayChart" style="display: none;">
                                                    <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                        readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
                                                        style="text-align: center;" />
                                                    <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                    <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                                                </div>
                                                <div id="date_YearChart">
                                                    <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                                </div>
                                                <div id="date_MonthChart" style="display: none;">
                                                    <div style="float: left;">
                                                        <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:60px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                                    </div>
                                                    <div style="float: right;">
                                                        <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth" 
                                                            name="D1">
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
                                                <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')"
                                                    style="cursor: pointer;" alt="Next" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                <table width="100%" cellpadding="0" cellspacing="0" style="line-height:24px; text-align:center">
                </table>
              </td>
              <td background="/images/gf/tci/tc05.gif">&nbsp;</td>
            </tr>
            <tr>
              <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td>
              <td background="/images/gf/tci/tc07.gif"></td>
              <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
            </tr>
          </table>
    </div>
    <!--main开始-->
    <div style="clear: both; height: 20px;"></div> 

    <!--图表结束-->
    <div>
    <!--
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
          <td width="15%" height="26"><table width="200" border="0" cellspacing="0" cellpadding="0">
          <tr>
              <td width="17%" align="center"><img src="/images/gf/subico010.gif" width="18" height="19" /></td>
            <td width="83%"><strong></strong></td>
          </tr>
          </table></td>
        <td width="62%">&nbsp;</td>
        <td width="23%" align="right" style="padding-right:15px;"><strong><img src="/images/gf/dlo.gif" width="16" height="16" /><a href="#" class="rloa">下载</a></strong></td>
      </tr>
      </table>
      -->
        <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD"  style="border-collapse:collapse; line-height:24px; text-align:center">
          <tr>
            <td width="10%" rowspan="2" bgcolor="#F3F3F3">电站</td>
            <td width="6%" rowspan="2" bgcolor="#F3F3F3">当前功率（W）</td>
            <td width="4%" rowspan="2" bgcolor="#F3F3F3">时间</td>
            <td width="8%" rowspan="2" bgcolor="#F3F3F3">发电量(MWh)</td>
            <td colspan="4" bgcolor="#F3F3F3">发电量（MWh）</td>
            <td colspan="4" bgcolor="#F3F3F3">单价（元/kWh）</td>
            <td colspan="4" bgcolor="#F3F3F3">电费（万元）</td>
            <td width="6%" rowspan="2" bgcolor="#F3F3F3">基础电价(元)</td>
            <td width="8%" rowspan="2" bgcolor="#F3F3F3">总电价(万元)</td>            
          </tr>
          
          <tr>
            <td width="5%" bgcolor="#F3F3F3">峰</td>
            <td width="5%" bgcolor="#F3F3F3">谷</td>
            <td width="5%" bgcolor="#F3F3F3">平</td>
            <td width="5%" bgcolor="#F3F3F3">尖</td>
            <td width="5%" bgcolor="#F3F3F3">峰</td>
            <td width="5%" bgcolor="#F3F3F3">谷</td>
            <td width="5%" bgcolor="#F3F3F3">平</td>
            <td width="5%" bgcolor="#F3F3F3">尖</td>
            <td width="5%" bgcolor="#F3F3F3">峰</td>
            <td width="5%" bgcolor="#F3F3F3">谷</td>
            <td width="5%" bgcolor="#F3F3F3">平</td>
            <td width="5%" bgcolor="#F3F3F3">尖</td>
          </tr>
          <%foreach (FGPJVO fvo in ViewData["fjpjvo"] as IList<FGPJVO>){%>
          <tr>
            <td rowspan="3"><%=fvo.plantName%></td>
            <td rowspan="3"><%=fvo.power.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].time%></td>
            <td><%=fvo.timevos[0].energy.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[0].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[1].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[2].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[3].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[0].fgpjdata[5].Value)?"-":StringUtil.formatDouble(fvo.timevos[0].fgpjdata[5].Value,"0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[0].fgpjdata[6].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[0].fgpjdata[6].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[0].fgpjdata[7].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[0].fgpjdata[7].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[0].fgpjdata[8].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[0].fgpjdata[8].Value, "0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[10].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[11].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[12].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[13].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[0].fgpjdata[9].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[0].fgpjdata[9].Value, "0.0")%></td>
            <td><%=fvo.timevos[0].fgpjdata[14].Value.ToString("0.0")%></td>                    
          </tr>
          <tr>
            <td><%=fvo.timevos[1].time%></td>
            <td><%=fvo.timevos[1].energy.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[0].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[1].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[2].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[3].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[1].fgpjdata[5].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[1].fgpjdata[5].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[1].fgpjdata[6].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[1].fgpjdata[6].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[1].fgpjdata[7].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[1].fgpjdata[7].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[1].fgpjdata[8].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[1].fgpjdata[8].Value, "0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[10].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[11].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[12].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[13].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[1].fgpjdata[9].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[1].fgpjdata[9].Value, "0.0")%></td>
            <td><%=fvo.timevos[1].fgpjdata[14].Value.ToString("0.0")%></td>                         
          </tr>
          <tr>
            <td><%=fvo.timevos[2].time%></td>
            <td><%=fvo.timevos[2].energy.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[0].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[1].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[2].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[3].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[2].fgpjdata[5].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[2].fgpjdata[5].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[2].fgpjdata[6].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[2].fgpjdata[6].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[2].fgpjdata[7].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[2].fgpjdata[7].Value, "0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[2].fgpjdata[8].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[2].fgpjdata[8].Value, "0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[10].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[11].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[12].Value.ToString("0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[13].Value.ToString("0.0")%></td>
            <td><%=double.IsNaN(fvo.timevos[2].fgpjdata[9].Value) ? "-" : StringUtil.formatDouble(fvo.timevos[2].fgpjdata[9].Value, "0.0")%></td>
            <td><%=fvo.timevos[2].fgpjdata[14].Value.ToString("0.0")%></td>                           
          </tr>
          <%}%>
        </table>
      </div>
    <!--main 结束-->
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
