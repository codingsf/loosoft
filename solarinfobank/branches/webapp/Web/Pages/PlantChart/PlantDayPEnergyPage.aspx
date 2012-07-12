<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %>  <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_INVEST_INCOME_COMPARED  %> 
-->

    <script type="text/javascript">
        function readyinit() {
            $('#DayChart').click(displayDayChart);
            $('#MonthChart').click(displayMonthDDChart);
            $('#YearChart').click(displayyearMMChart);
            $('#TotalChart').click(displayyearChart);
            displayDayChart();
        }
        
        function displayDayChart() {
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

        function displayyearChart() {
            curChart = "TotalChart";
            totalChart("container", 70, false);
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
                url: "/plantchart/PEnergyChart",
                data: { id: $("#pId").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 2 : 2;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    //修改标题'
                    showDetails(result, $("#startYYYYMMDDHH").val());
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        var curChart;
        function largepdp() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containerpdp" });
            if (curChart == "MonthChart")
                monthChart("large_containerpdp", 130, true);
            else if (curChart == "YearChart") {
                yearChart("large_containerpdp", 130, true);
            } else if (curChart == "TotalChart") {
                totalChart("large_containerpdp", 130, true);
            } else
                dayChart("large_containerpdp", 130, true);
        }

        function monthChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/PlantMonthDDKwpChart",
                data: { id: $("#pId").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: 'column' },
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
                url: "/plantChart/PlantYearMMKwpChart",
                data: { id: $("#pId").val(), year: $("#year").val(), chartType: 'column' },
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

        function totalChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("TotalChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantYearKwpChart",
                data: { id: $("#pId").val(), chartType: 'column' },
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
            $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#endYYYYMMDDHH").val(aimDay + "23")
            dayChart("container", 80, false);

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
        function changeInterval() {
            $("#intervalMins").val($("#intervalSelect").val());
            CompareChart("container", 80, false);
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
    <input type="hidden" value="<%=Model.id%>" id="pId" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>" id="year" />
    <input type="hidden" value="<%=ChartType.line+","+ChartType.line %>" id="chartType" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"MM")%>" id="month" />   
    <input type="hidden" value="60,5" id="intervalMins" />
    <input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00" id="startYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd") %>23" id="endYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>01" id="startYYYYMMDD" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays(Model.timezone)%>" id="endYYYYMMDD" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>01" id="startYM" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>12" id="endYM" />

        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_INVEST_INCOME_COMPARED%></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="subico01">
                    <ul id="change">
                        <li style="cursor: pointer;"><a id="DayChart" class="onclick"  href="javascript: void(0);"><%=Resources.SunResource.PLANT_OVERVIEW_DAY %></a></li>
                        <li style="cursor: pointer;"><a  id="MonthChart"  class="onclick" href="javascript:void(0);"><%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
                        <li style="cursor: pointer;"><a  id="YearChart" class="noclick" href="javascript:void(0);"><%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
                        <li style="cursor: pointer;"><a  id="TotalChart"  class="noclick" href="javascript:void(0);"><%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
                    </ul>
                </div>
                <div class="z_big">
                    <a id="toLargeChart" href="javascript:void(0)" onclick="largepdp()" onfocus="javascript:this.blur();">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id='container' style='width: 100%; height: 350px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                        </div>

                        <div style="display: none">
                            <center>
                                <div id='large_containerpdp' style="width: 90%; height: 450px; margin-left: 50px; margin-right: 50px; text-align:center;">
                                </div>
                            </center>
                        </div>
                        <div class="date_sel" id="date_select_div">
                            <div id="selectTable" style="margin-top: 20px;">
                                <table border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="24">
                                            <img src="/images/chartLeft.gif" width="24" height="21"  id="left" onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                                        </td>
                                        <td align="center">
                                            <div id="date_DayChart" style="display: none;">
                                                                                               <input type="text" class="t" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                                    
                                                <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
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
                                            <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')" style="cursor:pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                             <div id="chart_detail_grid" style=" width:100%; margin-top:15px; overflow:hidden;">
                                
                            </div>
                            
                    </div>
                    <div class="chart_down">
                    </div>
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_INVEST_INCOME_COMPARED %>'</script>
        