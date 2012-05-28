<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage"%>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>

    <script type="text/javascript">
        var chartTime = '<%=(ViewData["customChart"] as CustomChart).timeInterval%>';
        function readyinit() {
            var cur = "#dm-1";
            deviceHidden(cur);
            if (chartTime == "Year") {
                displayyearChart();
            } else if (chartTime == "Month") {
                displayyearMMChart();
            } else if (chartTime == "Day") {
                displayMonthDDChart();
            } else {
                displayDayChart();
            }
            $("#dm" + $('#cid').val()).show();

            changeALT();
        }

        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }
        
        function largeccp() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containerccp" });
            dispalyChart("large_containerccp",70,true);
        }
        var curChart;
        function displayDayChart() {
            curChart = "DayChart";
            changeStyle(curChart)
            $('#startTime').val($("#startYYYYMMDDHH").val())
            $('#endTime').val($("#endYYYYMMDDHH").val())
            dispalyChart("container",60,false);
            
        }
        
        function displayMonthDDChart() {
            curChart = "MonthChart";
            changeStyle(curChart)
            $('#startTime').val($("#startYYYYMMDD").val())
            $('#endTime').val($("#endYYYYMMDD").val())
            dispalyChart("container", 60, false);
        }

        function displayyearMMChart() {
            curChart = "YearChart";
            changeStyle(curChart)
            $('#startTime').val($("#startYM").val())
            $('#endTime').val($("#endYM").val())
            dispalyChart("container", 60, false);
        }

        function displayyearChart() {
            curChart = "TotalChart";
            changeStyle(curChart)
            dispalyChart("container", 60, false);
        }

        function dispalyChart(curContainer, ajaxImgTop, isLarge) {
            $.ajax({
                type: "POST",
                url: "/CustomReport/ChartView",
                data: { id: $('#cid').val(), startTime: $('#startTime').val(), endTime: $('#endTime').val() },
                success: function(result) {
                    var timei = $('#startTime').val();
                    if (timei.length == 10) {
                        timei = timei.substring(0, 8);
                    } else if (timei.length == 8) {
                        timei = timei.substring(0, 6);
                    } else if (timei.length == 6) {
                        timei = timei.substring(0, 4);
                    } else {
                        timei = "";
                    }
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, timei);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    if (curChart != "DayChart") {
                        setCategories(data.categories, true);
                        defineChart(curContainer);
                    } else {
                        var interval = isLarge ? 60 / 5 : 120 / 5;
                        setCategoriesWithInterval(data.categories, isLarge, interval);
                        //setCategories(data.categories, true);
                        defineChart(curContainer);
                    }

                    //修改标题
                    showDetails(result, $('#startYYYYMMDDHH').val());
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function changeStyle(curId) {
            clearDetails();
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
            displayDayChart();
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

        <input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
        <input type="hidden" value="60" id="intervalMins" />
        <input type="hidden" value="<%=ViewData["gid"]%>" id="gid" />
        <input type="hidden" value="<%=ViewData["cid"]%>" id="cid" />
        <input type="hidden" value="<%=CalenderUtil.getBeforeDay(DateTime.Now,"yyyyMMdd")%>00" id="startYYYYMMDDHH" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>23" id="endYYYYMMDDHH" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01" id="startYYYYMMDD" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays()%>" id="endYYYYMMDD" />
        <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>" id="month" />
        <input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
        <input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />   
        <input type="hidden" value="" id="startTime" />          
        <input type="hidden" value="" id="endTime" />   
        <input type="hidden" value="column" id="chartType" />
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.CUSTOMREPORT_CUSTOM_CHART%></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.CUSTOMREPORT_CUSTOM_CHART_DETAIL%>&nbsp;</td>
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
                <div class="z_big">
                    <a id="toLargeChart" href="javascript:void(0)" onclick="largeccp()" onfocus="javascript:this.blur();">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id='container' style='width: 100%; height: 500px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                        </div>
                        <div style="display: none">
                            <center>
                                <div id='large_containerccp' style="width: 90%; height: 500px; margin-left: 50px; margin-right: 50px; text-align:center;">
                                </div>
                            </center>
                        </div>
                        <div class="date_sel" style="display: none;" id="date_select_div">
                            <div id="selectTable" style="margin-top: 10px;">
                                <table border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                    
                                        <td width="24">
                                            <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                                        </td>
                                        <td>
                                            <div id="date_DayChart" style="display: none;">
                                            <input type="text" class="t" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" /> -
                                                <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                                   <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" /> 
  
                                            </div>
                                            <div id="date_YearChart" style="display: none;">
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
                                                            if (i == DateTime.Now.Month)
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
                                            <img src="/images/chartRight.gif" id="right" width="24" height="21"  onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div style='float: right; z-index: 1001; margin-bottom: 200px;'>
                        </div>
                    </div>
                        <div id="chart_detail_grid" style=" width:100%; margin-top:15px; overflow:hidden;">
                                
                            </div>
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>

