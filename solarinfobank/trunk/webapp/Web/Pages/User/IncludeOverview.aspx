<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<script>document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_PLANT_OVERVIEW %>'</script>
    <%if (Session["firstLogin"] != null)
      { %>
    <script>        
        loadContent('content_ajax', '/user/includeAllplants', 'iframe', 'GET');
        $(".nav a").each(function() {
            $(this).removeClass("lefttabclick");
        });
    </script>
    <%Session["firstLogin"] = null; Response.End();
    } %>
<style type="text/css">
    .noclick
    {
        float: left;
        background: url(../images/sub/subtb2.gif);
        height: 27px;
        line-height: 27px;
        border: 1px solid #727171;
        padding: 0px 15px;
        text-align: center;
        color: #FFFFFF;
        font-weight: bold;
        display: block;
    }
    .onclick
    {
        float: left;
        background: url(../images/sub/subtb1.gif);
        height: 27px;
        line-height: 27px;
        border: 1px solid #727171;
        padding: 0px 15px;
        text-align: center;
        color: #FFFFFF;
        font-weight: bold;
        display: block;
    }
</style>

<script type="text/javascript">
        function readyinit() {
            //$('#DayChart').click(displayDayChart);
            $('#MonthDDChart').click(displayMonthDDChart);
            $('#YearMMChart').click(displayyearMMChart);
            $('#YearChart').click(displayyearChart);
            $('#maptab2').click(displayMap);
            $('#planttab1').click(displayPlant);
            displayMonthDDChart();
            //initialize(); 
            //$("#map").hide();
        }
        
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }
        
        function displayMap() {
            $("#planttab1").attr("class", "noclick");
            $("#maptab2").attr("class", "onclick");
            $("#showplant").hide();
            //$("#map").show();
        }

        function displayPlant() {
            $("#planttab1").attr("class", "onclick");
            $("#maptab2").attr("class", "noclick");
            $("#showplant").show();
            //$("#map").hide();
        }
        function displayDayChart() {
            $("#intervalMins").val($("#intervalSelect").val());
            curChart = "DayChart";
            dayChart("container", 70, false);
            changeALT();
        }
        function displayMonthDDChart() {
            curChart = "MonthDDChart";
            monthDDChart("container", 70, false);
            changeALT();
        }

        function displayyearMMChart() {
            curChart = "YearMMChart";
            yearMMChart("container", 70, false);
            changeALT();
        }

        function displayyearChart() {
            curChart = "YearChart";
            yearChart("container", 70, false);
        }
        
        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container_u" });
            if (curChart == "MonthDDChart")
                monthDDChart("large_container_u", 130, true);
            else if (curChart == "YearMMChart") {
                yearMMChart("large_container_u", 130, true);
            } else if (curChart == "YearChart") {
                yearChart("large_container_u", 130, true);
            }else
                dayChart("large_container_u", 130, true);
        }
        
        function monthDDChart(curContainer, ajaxImgTop, isLarge) {
            clearDetails();
            changeStyle("MonthDDChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/UserMonthDDChart",
                data: {userId: <%=Model.id%>, startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')');
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0,6),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    
                    showDetails(result,$("#startYYYYMMDD").val());
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        
        function dayChart(curContainer, ajaxImgTop, isLarge) {
            clearDetails();       
            changeStyle("DayChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/UserDayChart",
                data: {userId: <%=Model.id%>, startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'area', mts: $("#mts").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val(),data.name);
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
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                    
                }
            });
        }
        
        function yearMMChart(curContainer, ajaxImgTop, isLarge) {
            clearDetails();
            changeStyle("YearMMChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/UserYearMMChart",
                data: {userId: <%=Model.id%>, startYM: $("#year").val() + '01', endYM: $("#year").val() + '12', chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val(),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    showDetails(result,$("#year").val() + '01');
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        
        function changePage(index)
        {
         $.ajax({
                type: "POST",
                url: "/user/plantspage",
                data: {index:index },
                success: function(result) {
                $("#showplant").empty();
                $("#showplant").html(result);
                },
                beforeSend: function() {
                }
            });
        }

        function yearChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearChart");
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
                    showDetails(result);
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function changeStyle(curId) {
            clearDetails();
            $("#MonthDDChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#YearMMChart").attr("class", "noclick");
            //$("#DayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");

            $("#date_MonthDDChart").hide();
            $("#date_YearMMChart").hide();
            //$("#date_DayChart").hide();
            $("#date_" + curId).show();
            if (curId == "YearChart") {
                document.getElementById("date_select_div").style.display = "none";
            } else {
                document.getElementById("date_select_div").style.display = "block";
            }
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
        function changeInterval() {
            displayDayChart();
        }

        function PreviouNextChange(oper) {
          
            if (curChart == "DayChart") {
                changeDate(oper, "t");
                changeDay(document.getElementById("t"));             
            }
            if (curChart == "MonthDDChart") {
                changeShowMonth(oper, "selectmonth", "selectyear");               
                changeMonth();
            }
            if (curChart == "YearMMChart") {
                changeShowYear(oper, "selectYear1")
                changeYear(document.getElementById("selectYear1"));
            }
        }
</script>

<!-- 1b) Optional: the exporting module -->
<input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
<input type="hidden" value="5" id="intervalMins" />
<input type="hidden" value="column" id="chartType" />
<input type="hidden" value="<%=MonitorType.PLANT_MONITORITEM_POWER_CODE%>" id="mts" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>00"
    id="startYYYYMMDDHH" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23"
    id="endYYYYMMDDHH" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays() %>"
    id="endYYYYMMDD" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>"
    id="month" />
<input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
<input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />
<table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
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
                        <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW %>
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
                        <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;
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
    <%--<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background: url(/images/kj/rbg01.jpg) no-repeat right center;">
                <tr>
                    <td width="30%" style="padding-top: 5px">
                        <div class="kjrb">
                            <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="2" width="50">
                                        <img src="/images/sub/tyn.gif" />
                                    </td>
                                    <td class="sb_top14" align="left">
                                        <%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="sb_top24">
                                        <% = Model.DisplayTotalDayEnergy%>
                                        <span style="font-size: 15px">
                                            <%=Model.TotalDayEnergyUnit %></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="kjrb">
                            <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="2" width="50">
                                        <img src="/images/sub/ttyn.gif" />
                                    </td>
                                    <td class="sb_top14" align="left">
                                        <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL_ENERGRY %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="sb_top24">
                                        <% = Model.DisplayTotalEnergy%><span style="font-size: 15px">
                                            <%=Model.TotalEnergyUnit %></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td width="70%" style="padding-left: 20px;">
                        <div class="kjrb">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="2" width="50" align="right">
                                        <img src="/images/sub/subico03.gif" />
                                    </td>
                                    <td class="sb_top14">
                                        <%=Resources.SunResource.PLANT_OVERVIEW_CO2_AVOIDED %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="sb_top24">
                                        <%=Model.TotalReductiong %>
                                        <span style="font-size: 15px;">
                                            <%=Model.TotalReductiongUnit%></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="kjrb">
                            <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="2">
                                        <img src="/images/sub/subico04.gif" width="42" height="45" />
                                    </td>
                                    <td class="sb_top14">
                                        <%=Resources.SunResource.PLANT_OVERVIEW_REVENUE%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="sb_top24">
                                        <%=Model.currencies %>
                                        <%=Model.DisplayRevenue%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>--%>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background: url(/images/kj/rbg01.jpg) no-repeat right center;">
        
        <%if (Model.hasFaultDevice)
          { %>
        <tr>
            <td height="50">
                <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7">
                            <img src="/images/sub/tll.gif" />
                        </td>
                        <td width="100%" valign=top>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif" style="height:34px;">
                                <tr>
                                    <td width="5%">
                                    <img src="/images/sub/kjjh.gif" width="16" height="16" />
                                    </td>
                                    <td width="87%">
                                     <a target="_blank" href="/user/warningfilter/" style="color: #E87006;
                                            text-decoration: underline;">
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PR_WARNING%></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="7">
                            <img src="/images/sub/tlr.gif" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%} %>
        <tr>
            <td>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/tyn.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY %><br />
                                <span class="sz_fb"><%=StringUtil.formatDouble(Model.DisplayTotalDayEnergy)%></span>                                
                                <%=Model.TotalDayEnergyUnit %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/ttyn.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL_ENERGRY %><br />
                                <span class="sz_fb"><% = StringUtil.formatDouble(Model.DisplayTotalEnergy)%></span>                                                                
                                <%=Model.TotalEnergyUnit %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico10.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TREES%>
                                <br />
                                <span class="sz_fb"><%=Model.TotalTrees%></span> <%=Resources.SunResource.PLANT_OVERVIEW_FAMILIES%>         
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico04.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_REVENUE%><br />
                                <%=Model.currencies %>
                                <span class="sz_fb"><%=Model.DisplayRevenue%></span>   
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" height="43" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico03.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_CO2_AVOIDED %>
                                <br />
                                <span class="sz_fb"><%=StringUtil.formatDouble(Model.TotalReductiong) %></span> 
                                <%=Model.TotalReductiongUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<div class="subrbox01">
    <div class="sb_top">
    </div>
    <div class="sb_mid">
        <div class="subico01">
            <ul id="change">
                <li style="cursor: pointer; display: none;"><a id="DayChart" class="onclick" href="javascript: void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_DAY %></a></li>
                <li style="cursor: pointer;"><a id="MonthDDChart" class="noclick" href="javascript: void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
                <li style="cursor: pointer;"><a id="YearMMChart" class="noclick" href="javascript: void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
                <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript: void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
            </ul>
        </div>
        <div class="z_big">
            <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
            </a>
        </div>
        <div>
            <div id="chartDiv">
                <div id='container' style='width: 100%; height: 350px; margin-left: 2px; margin-right: 2px;'>
                </div>
            </div>
            <div style="display: none">
                <center>
                    <div id='large_container_u' style="width: 90%; height: 450px; margin-left: 40px;
                        margin-right: 40px; text-align: center;">
                    </div>
                </center>
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
                                <div id="date_DayChart" style="display: none;">
                                    <input name="t" type="text" id="t" size="12" class="indate" onfocus="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>'})"
                                        readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>"
                                        style="text-align: center;" />
                                    <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                    <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" />
                                </div>
                                <div id="date_YearMMChart">
                                    <%=Html.DropDownList("selectYear1", (IList<SelectListItem>)ViewData["plantYear"], new { id = "selectYear1", onchange = "changeYear(this)" })%>
                                </div>
                                <div id="date_MonthDDChart" style="display: none;">
                                    <div style="float: left;">
                                        <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style = "width:60px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                    </div>
                                    <div style="float: right;">
                                        <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth">
                                            <%
                                                for (int i = 1; i <= 12; i++)
                                                {
                                                    if (i == int.Parse(CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone, "MM")))
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
                                    style="cursor: pointer;" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="chart_detail_grid" style="width: 100%; overflow: hidden; margin-top: 15px;">
            </div>
        </div>
    </div>
    <div class="sb_down">
    </div>
</div>
<div class="subrbox01">
    <div class="sb_top">
    </div>
    <div class="sb_mid">
        <!--
                <div class="subico01">
                    <ul id="change">
                        <li style="cursor: pointer;"><a  id="planttab1" class="onclick" href="javascript:void(0)"><%=Resources.SunResource.PLANT_OVERVIEW_PLANTS %></a></li>
                        <li style="cursor: pointer;"><a  id="maptab2" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.PLANT_OVERVIEW_MAPS %></a></li>
                    </ul>
                </div>
                -->
        <div class="xxbox" id="showplant" style="display: block;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <% int j = 0;
                       IList<Plant> pnts = Model.displayPlants;
                       pnts=pnts.Take(Model.overviewDisplayCount).ToList<Plant>();
                       foreach (Plant plant in pnts)
                       {
                           ++j;%>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                            <tr>
                                <td width="12%" height="60" align="center">
                                    <% 
                                    %>
                                    <%if (plant.isWork)
                                      { %>
                                    <img src="/images/sub/line_on.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                        title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                    <%}
                                      else
                                      { %>
                                    <img src="/images/sub/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                    <%} %>
                                </td>
                                <td width="18%" align="center">
                                    <%if (!string.IsNullOrEmpty(plant.pic))
                                      {
                                    %>
                                    <img src="/ufile/small/<%=plant.onePic%>" width="48" height="48" />
                                    <%}
                                      else
                                      { %>
                                    <img src="/ufile/Nopic/nopico02.gif" width="48" height="48" />
                                    <%} %>
                                </td>
                                <td width="70%">
                                    <span class="xxbox_tt" style="overflow: hidden; width: 220px; float: left;"><a title="<%=plant.name %>"
                                        href="/plant/overview/<%=plant.id %>" class="dbl">
                                        <%=StringUtil.cutStr(plant.name,22,"...")%></a> </span>
                                    <br />
                                    <span class="lbl">
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_TODAYENERGY%>:&nbsp;<%=StringUtil.formatDouble(plant.DisplayTotalDayEnergy) + " " + plant.TotalDayEnergyUnit%>
                                        <br />
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:&nbsp;<%=StringUtil.formatDouble(plant.TodayTotalPower)%>&nbsp;kW<br />
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_INSTALL_POWER%>:&nbsp;<%=StringUtil.formatDouble(plant.TotalDegignPower)%>&nbsp;kW
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <% 
                        if (j % 2 == 0)
                        {
                    %>
                </tr>
                <tr>
                    <%}

                       }
                       if (j % 2 != 0)
                       {
                    %>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                            <tr>
                                <td align="center" height="70" width="17%">
                                </td>
                                <td align="center" width="20%">
                                </td>
                                <td width="63%">
                                    <span class="xxbox_tt" style="overflow: hidden; width: 200px; float: left;"></span>
                                    <br>
                                    <span class="lbl">&nbsp;<br>
                                        &nbsp;<br>
                                        &nbsp; </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%} %>
                </tr>
                <%Html.RenderPartial("page"); %>
            </table>
        </div>
        <!--
                <div id="map" class="map" style="width: 100%; height: 228px;">
                </div>
                -->
    </div>
    <div class="sb_down">
    </div>
    <br />
</div>
