<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--
<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW %></asp:Content>
-->

   <%--此处用于切换语言跳转到当前页面--%>
   <%if (Session["initurl"] != null&&(string.IsNullOrEmpty(Session["initurl"].ToString())==false))
      { %>
    <script>
        $('a[href="<%=Session["initurl"] %>"]', window.parent.document).addClass("lefttabclick");
        $("#current_uri").val('<%=Session["initurl"] %>');
        parent.loadContent('content_ajax', '<%=Session["initurl"] %>', '<%=Session["loading_type"] %>', 'GET');
    </script>
    <%Session["initurl"] = null; Session["loading_type"] = null; Response.End();
    } %>
    
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

<script type="text/javascript">

    function readyinit() {
        $('#DayChart').click(displayDayChart);
        $('#MonthChart').click(displayMonthDDChart);
        $('#YearChart').click(displayyearMMChart);
        $('#TotalChart').click(displayyearChart);
        displayDayChart();
    }

    function changeALT() {
        var ImageButtonLeft = document.getElementById("left");
        var ImageButtonRight = document.getElementById("right");
        ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
        ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
    }

    function displayDayChart() {
        $("#intervalMins").val($("#intervalSelect").val());
        curChart = "DayChart";
        dayChart("container", 70, false);
        $("#countDataDiv").empty();
        changeALT();
    }
    function displayMonthDDChart() {
        curChart = "MonthChart";
        monthChart("container", 70, false);
        $("#countDataDiv").empty();
        changeALT();
    }

    function displayyearMMChart() {
        curChart = "YearChart";
        yearChart("container", 70, false);
        $("#countDataDiv").empty();
        changeALT();
    }

    function displayyearChart() {
        curChart = "TotalChart";
        totalChart("container", 70, false);
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
            data: {random:new Date().getMilliseconds(), id: $("#pid").val(), startYYYYMMDDHH: $("#endYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val() },
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
            monthChart("large_container_chart", 130, true);
        else if (curChart == "YearChart") {
            yearChart("large_container_chart", 130, true);
        } else if (curChart == "TotalChart") {
            totalChart("large_container_chart", 130, true);
        } else
            dayChart("large_container_chart", 130, true);
    }

    function monthChart(curContainer, ajaxImgTop, isLarge) {
        changeStyle("MonthChart");
        $.ajax({
            type: "POST",
            url: "/plantchart/PlantMonthDDChart",
            data: { id: $("#pid").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6) + "<%=Model.name%>", data.name);
                setyAxis(data);
                setySeriesArr(data.series);
                setCategories(data.categories, isLarge);
                defineChart(curContainer);
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
            url: "/plantChart/PlantYearMMChart",
            data: { id: $("#pid").val(), year: $("#year").val(), chartType: $("#chartType").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val() + "<%=Model.name%>", data.name);
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
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "" + "<%=Model.name%>", data.name);
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
            url: "/plantchart/PlantDayChart",
            data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'area', intervalMins: $("#intervalMins").val() },
            success: function(result) {
                if (appendChartError(curContainer, result, ajaxImgTop)) {
                    return;
                }
                var data = eval('(' + result + ')')
                setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                setyAxis(data);
                setySeriesArr(data.series);
                var intervalMins = $("#intervalMins").val();

                var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
                setCategoriesWithInterval(data.categories, isLarge, interval);
                defineChart(curContainer);
                //修改标题
                chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                showDetails(result, $("#startYYYYMMDDHH").val());
                //天数据统计加载
                loadCountData();
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
        $("#t").val(temp);
        changeDay(document.getElementById('t'));
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

<input type="hidden" value="<%=Model.id%>" id="pid" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>" id="year" />
<input type="hidden" value="column" id="chartType" />
<input type="hidden" value="5" id="intervalMins" />
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00"
    id="startYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23"
    id="endYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays(Model.timezone)%>"
    id="endYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>01" id="startYM" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>12" id="endYM" />
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
                    <td width="75%" class="pv0212">
                        <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>
                        &nbsp;
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background: url(/images/kj/rbg01.jpg) no-repeat right center;">
        <%if (Model.getDetectorWithRenderSunshine() != null || Model.hasFaultDevice)
          {%>
        <tr>
            <td height="50">
                <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7">
                            <img src="/images/sub/tll.gif" />
                        </td>
                       <%if (Model.getDetectorWithRenderSunshine()!= null)
                         { %>
                        <td width="200" valign="top">
                        
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif"
                                style="height: 34px">
                          
                                <tr>
                                    <td width="13%">
                                                     
                                        <img src="/images/sub/kjjk.gif" width="16" height="16" />
                                   
                                   
                                    </td>
                                
                                    <td width="75%" style="padding-right: 10px">
                                              
                                        <a target="_blank" href="/plantchart/prchart?pid=<%=Model.id %>" style="color: #E87006;
                                            text-decoration: underline;"><span style="white-space: nowrap">
                                                <%=Resources.SunResource.PLANT_OVERVIEW_PRCHART_TITLE%></span></a>
                                    </td>
                                     
                                    <td width="13%">
                                        <img src="/images/sub/tline.gif" width="3" height="34" />
                                    </td>
                                </tr>
                                
                                 
                            </table>
                          
                        </td>
                        <%} %>
                        
                        <td valign="top">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif"
                                style="height: 34px;">
                                <tr>
                                    <td width="4%" style="padding-left: 5px;">
                                            <%if (Model.hasFaultDevice)
                                              { %>
                                        <img src="/images/sub/kjjh.gif" width="16" height="16" />
                                    <%} %>
                                    </td>
                                    <td width="96%">
                                    <%if (Model.hasFaultDevice)
                                    { %>
                                        <a target="_blank" href="/plant/warningfilter/?pid=<%=Model.id %>" style="color: #E87006;
                                            text-decoration: underline;">
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PR_WARNING%></a>
                                   
                                    <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                        <td width="8">
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY%><br />
                                <span class="sz_fb">
                                    <%=Model.DisplayTotalDayEnergy%></span>
                                <%=Model.TotalDayEnergyUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico02.gif" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TEMPERATURE%><br />
                                <span class="sz_fb">
                                    <%=ViewData["temp"]!=null?((ViewData["temp"] as float?).Equals(double.NaN) ? "" : ViewData["temp"].ToString()):string.Empty%></span>
                                °<%=(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).TemperatureType.ToUpper() %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico05.gif" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_SOLAR_RADIATION_INTENSITY%>
                                <br />
                                <span class="sz_fb">
                                    <%=(Model.Sunstrength!=null)?Model.Sunstrength.ToString():""%></span> W/m2
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL_ENERGRY%><br />
                                <span class="sz_fb">
                                    <% = Model.DisplayTotalEnergy%></span>
                                <%=Model.TotalEnergyUnit%>
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_CO2_AVOIDED%>
                                <br />
                                <span class="sz_fb">
                                    <%=StringUtil.formatDouble(Model.Reductiong) %></span>
                                <%=Model.ReductiongUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" height="43" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico04.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_REVENUE%>
                                <br />
                                <%=Model.currencies %>
                                <span class="sz_fb">
                                    <%= Model.DisplayRevenue%></span>
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
                <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript: void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_DAY %></a></li>
                <li style="cursor: pointer;"><a id="MonthChart" class="onclick" href="javascript:void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
                <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
                <li style="cursor: pointer;"><a id="TotalChart" class="noclick" href="javascript:void(0);">
                    <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
            </ul>
        </div>
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
                <div id='container' style='width: 100%; height: 480px; margin-left: 2px; margin-right: 2px;'>
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
                <div id="selectTable" style="margin-top: 20px; text-align: center;">
                    <table border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="24">
                                <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')"
                                    style="cursor: pointer;" alt="Previous" />
                            </td>
                            <td>
                                <div id="date_DayChart" style="display: none;">
                                    <input type="text" class="t" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                        readonly="readonly" value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>"
                                        style="text-align: center;" />
                                    -
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
                                <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')"
                                    style="cursor: pointer;" alt="Next" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="chart_detail_grid" style="width: 100%; margin-top: 15px; overflow: hidden;
                clear: both;">
            </div>
        </div>
        <!-- count data-->
        <div style="padding: 20px 0px;" id="countDataDiv">
        </div>
    </div>
    <div class="sb_down">
    </div>
</div>
<%
    if (Model.plantUnits.Count >= 1)
    {
%>
<div class="subrbox01">
    <div>
        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="6%" align="center">
                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                </td>
                <td width="94%" class="f_14">
                    <strong>
                        <%=Resources.SunResource.PLANT_OVERVIEW_UNIT_LIST %></strong>
                </td>
            </tr>
        </table>
    </div>
    <div class="sb_top">
    </div>
    <div class="sb_mid">
        <div class="xxbox">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <% int j = 0;
                       foreach (PlantUnit plantUnit in Model.plantUnits)
                       {
                           ++j; 
                    %>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                            <tr>
                                <td width="17%" height="60" align="center">
                                    <%
                                        if (plantUnit.collector.runData != null)
                                        {
                                            if (!plantUnit.isWork(Model.timezone))
                                            {%>
                                    <img src="/images/sub/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                    <% }
                                            else
                                            {%>
                                    <img src="/images/sub/line_on.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                        title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                    <%}
                                        }
                                        else
                                        { %>
                                    <img src="/images/sub/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                    <%} %>
                                </td>
                                <td width="63%">
                                    <div style="width: 250px; overflow: hidden; height: 22px; line-height: 22px;" title="<%=plantUnit.displayname %>">
                                        <span class="xxbox_tt">
                                            <%=plantUnit.displayname %></span>
                                    </div>
                                    <%if (plantUnit.collector.runData != null)
                                      { %>
                                    <span class="lbl">
                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>:<%=plantUnit.TodayEnergy(Model.timezone)%>kWh
                                        <br />
                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:<%=plantUnit.TodayPower(Model.timezone)%>kW
                                    </span>
                                    <%}
                                      else
                                      {%>
                                    <span class="lbl">
                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>: 0kWh
                                        <br />
                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>: 0kW </span>
                                    <%}%>
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
                                <td width="17%" height="70" align="center">
                                </td>
                                <td width="20%" align="center">
                                </td>
                                <td width="63%" height="70">
                                    <div style="width: 250px; overflow: hidden; height: 22px; line-height: 22px;" title="">
                                        <span class="xxbox_tt">&nbsp;</span>
                                    </div>
                                    <span class="lbl">&nbsp;</span><span class="lbl">&nbsp;</span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%} %>
                </tr>
            </table>
        </div>
    </div>
    <div class="sb_down">
    </div>
</div>
<%} %>
<br />

<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW %>'</script>

