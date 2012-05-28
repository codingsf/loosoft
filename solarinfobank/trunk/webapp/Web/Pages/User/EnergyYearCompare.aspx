<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
    <script type="text/javascript">       
        function readyinit() {
            yearCompareChart("container", 50);
            selectYear2Month();
        }

        var curChart;
        function largeeyc() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containereyc" });
            yearCompareChart("large_containereyc", 130);
        }

        function yearCompareChart(curContainer, ajaxImgTop) {
            $.ajax({
                type: "POST",
                url: "/plantChart/UserYearCompare",
                data: {userId: <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id%>, chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "",data.name);                    
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories);
                    defineChart(curContainer);
                    //修改标题
                    showDetails(result);
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        
        function changeStyle(curId) {
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

        function changeYear(obj) {
            $("#year").val(obj.value)
            yearCompareChart("container", 50);
        }


        function changeChartType(obj) {
            var chartype = obj.value;
            $("#chartType").val(chartype)
            yearCompareChart("container", 70);
        }
        function selectYear2Month() {
            $("#selectYear1").attr("value", $("#year").val());
            $("#selectYear").attr("value", $("#year").val());
            $("#selectMonth").attr("value", $("#month").val());
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

    <input type="hidden" value="<%=ChartType.line %>" id="chartType" />
    <input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>  id="month" />

        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif"/>
                            </td>
                            <td class="pv0216">
                                <%=Resources.SunResource.CHART_ENERGY_YEAR_COMPARE %>
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
                                <%=Resources.SunResource.CHART_ENERGY_YEAR_COMPARE_DETAIL %>&nbsp;
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
        <div class="subrbox02" style="display: none;">
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
                    <a id="toLargeChart" href="javascript:void(0)" onclick="largeeyc()">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id="dayIntervalDiv" style="display: none;">
                                <%=Resources.SunResource.CHART_INTERVAL_MINS %>:
                                <select name="select" id="intervalSelect" onchange="changeInterval()">
                                    <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                    <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                                </select>
                            </div>
                            <div id='container' style='width: 100%; height: 300px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                                <div id="chart_detail_grid" style=" width:100%; overflow:hidden; margin-top:15px;">
                                
                            </div>
                        </div>
                        <div style="display: none">
                            <center>
                                <div id='large_containereyc' style="width: 90%; height: 450px; margin-left: 50px; margin-right: 50px; text-align:center;">
                                </div>
                            </center>
                        </div>
                        <div class="date_sel">
                            <div id="selectTable" style="margin-top: 20px;">
                                <div id="Div1" style="display: none;">
                                    <table width="182" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="24">
                                                <img src="/image/sub/left.gif" width="24" height="21" onclick="PreviouNextChange('left')" />
                                            </td>
                                            <td>
                                                <div id="date_DayChart" style="display: none;">
                                                    <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>'})"
                                                        readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>"
                                                        style="text-align: center;" />
                                                    <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                    <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" />
                                                </div>
                                                <div id="date_YearChart" style="display: none;">
                                                    <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                                </div>
                                                <div id="date_MonthChart" style="display: none;">
                                                    <div style="float: left;">
                                                        <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:65px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                                    </div>
                                                    <div style="float: right;">
                                                        <select style="width: 65px;" onchange="changeMonth(this)" id="selectmonth">
                                                            <%
                                                                for (int i = 0; i <= 12; i++)
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
                                                <img src="/image/sub/right.gif" width="24" height="21" onclick="PreviouNextChange('right')" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
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
<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_YEARS_ENERGY_COMPARED %>'</script>