<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
    <script type="text/javascript">
        function readyinit() {
            //add by hbqian in 2013/03/18 for增加显示电站日日照和功率散点图
            //$('#pScatterDayChart').click(displayPScatterDayChart);
            $('#pScatterMonthChart').click(displayPScatterMonthChart);
            $('#pDayChart').click(displayPDayChart);
            $('#eDayChart').click(displayEDayChart);
            displayPScatterMonthChart();
        }

        //add by hbqian in 2013/03/18 for增加显示电站日日照和功率散点图
        function displayPScatterDayChart() {
            $("#chartType").val("scatter");
            $("#chartTypeSelect").attr("value", "scatter");
            $("#selectTable").show();
            curChart = "pScatterDayChart";
            PlantDayPowerSunScatterCompare("container", 90, false);
            changeALT();
        }
        
        function displayPScatterMonthChart() {
            $("#chartType").val("scatter");
            $("#chartTypeSelect").attr("value", "scatter");
            $("#selectTable").show();
            curChart = "pScatterMonthChart";
            PlantMonthPowerSunScatterCompare("container", 90, false);
            changeALT();
        }
        function displayPDayChart() {
            $("#chartType").val("area");
            $("#chartTypeSelect").attr("value", "area");
            $("#selectTable").show();
            curChart = "pDayChart";
            PlantDayPowerSunCompare("container", 90, false);
            changeALT();
        }
        
        function displayEDayChart() {
            $("#chartType").val("area");
            $("#chartTypeSelect").attr("value", "area");
            $("#selectTable").show();
            curChart = "eDayChart";
            PlantDayEnergySunCompare("container", 90, false);
            changeALT();
        }

        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }

        function largedc() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containerdc" });
            if (curChart == "eDayChart")
                PlantDayEnergySunCompare("large_containerdc", 130, true);
            else if (curChart == "pDayChart") {
                PlantDayPowerSunCompare("large_containerdc", 130, true);
            } else {
                PlantMonthPowerSunScatterCompare("large_containerdc", 130, true);
            }
        }
        
        //add by hbqian in 2013/03/18 for增加显示电站日日照和功率散点图
        function PlantDayPowerSunScatterCompare(curContainer, ajaxImgTop, isLarge) {
            changeStyle("pScatterDayChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantDayPowerSunScatterCompare",
                data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#pScatterStartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#pScatterEndYYYYMMDDHH").val(), chartType: "scatter", intervalMins: '5' },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#pstartYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    //setyAxis(data);
                    //setySeriesArr(data.series);
                    //var interval = isLarge ? 60 / 5 : 120 / 5;
                    //setCategoriesWithInterval(data.categories, isLarge, interval);
                    //散列图单独处理
                    defineChartWithScatter(curContainer,false,data);
                    showDetails(result, $("#pScatterStartYYYYMMDDHH").val());
                    //修改标题s
                    chart.setTitle({ text: data.name, x: 0, align: 'center', floating: true });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function PlantMonthPowerSunScatterCompare(curContainer, ajaxImgTop, isLarge) {
            changeStyle("pScatterMonthChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantDayPowerSunScatterCompare",
                data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#pScatterStartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#pScatterEndYYYYMMDDHH").val(), chartType: "scatter", intervalMins: '5' },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#pstartYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    //setyAxis(data);
                    //setySeriesArr(data.series);
                    //var interval = isLarge ? 60 / 5 : 120 / 5;
                    //setCategoriesWithInterval(data.categories, isLarge, interval);
                    //散列图单独处理
                    defineChartWithScatter(curContainer, false, data);
                    showDetails(result, $("#pScatterStartYYYYMMDDHH").val());
                    //修改标题s
                    chart.setTitle({ text: data.name, x: 0, align: 'center', floating: true });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }        

        function PlantDayPowerSunCompare(curContainer, ajaxImgTop, isLarge) {
            changeStyle("pDayChart");

            $.ajax({
                type: "POST",
                url: "/plantChart/PlantDayPowerSunCompare",
                data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#pstartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#pendYYYYMMDDHH").val(), chartType: "line,line", intervalMins: '5,5' },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#pstartYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var interval = isLarge ? 60 / 5 : 120 / 5;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    showDetails(result, $("#pstartYYYYMMDDHH").val());
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function PlantDayEnergySunCompare(curContainer, ajaxImgTop, isLarge) {
            changeStyle("eDayChart");

            $.ajax({
                type: "POST",
                url: "/plantChart/PlantDayEnergySunCompare",
                data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#estartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#eendYYYYMMDDHH").val(), chartType: "column,line", intervalMins: "60,5" },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#estartYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var interval = 2;//isLarge ? 30 / 5 : 60 / 5;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    showDetails(result, $("#estartYYYYMMDDHH").val());
                    //修改标题
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

            //$("#pScatterDayChart").attr("class", "noclick");
            $("#pScatterMonthChart").attr("class", "noclick");    
            $("#eDayChart").attr("class", "noclick");
            $("#pDayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");

            $("#date_pScatterMonthChart").hide();     
            $("#date_eDayChart").hide();
            $("#date_pDayChart").hide();       
            $("#date_" + curId).show();
        }

        //前日期框变化函数
        function changePreDay(obj) {
            var id;
            if (curChart == "eDayChart") {
                id = "t";
            } else if (curChart == "pDayChart") {
                id = "t2";
            } else if (curChart == "pScatterDayChart") {
                id = "t3";
            }
            var d = obj.value;
            var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
            nextDay.setDate(nextDay.getDate() + 1);
            var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
            $("#" + id).val(temp);
            if (curChart == "eDayChart") {
                changeEDay(document.getElementById("t"));
            } else if (curChart == "pDayChart") {
                changePDay(document.getElementById("t2"));
            } else if (curChart == "pScatterDayChart") {
                changePScatterDay(document.getElementById("t3"));
            }
        }
        
        function changeEDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#estartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#eendYYYYMMDDHH").val(aimDay + "23")
            displayEDayChart();
            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("."+obj.id).val(aimDay);
        }
       
        function changePDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#pstartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#pendYYYYMMDDHH").val(aimDay + "23")
            displayPDayChart();
            
            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("."+obj.id).val(aimDay);
        }
        //add by hbqian in 2013/03/18 for增加显示电站日日照和功率散点图
        function changePScatterDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#pScatterStartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#pScatterEndYYYYMMDDHH").val(aimDay + "23")
            displayPScatterDayChart();

            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("." + obj.id).val(aimDay);
        }

        function PreviouNextChange(oper) {
            if (curChart == "eDayChart") {
                changeDate(oper, "t");
                changeEDay(document.getElementById("t"));
            }else if (curChart == "pDayChart") {
                changeDate(oper, "t2");
                changePDay(document.getElementById("t2"));
            }else if (curChart == "pScatterDayChart") {
                changeDate(oper, "t3");
                changePScatterDay(document.getElementById("t3"));
            } else if (curChart == "pScatterMonthChart") {
                changeShowMonth(oper, "selectmonth", "selectyear");
                changeMonth();
            }
        }

        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            //$("#startYYYYMMDD").val(selectyear + selectmonth + "01")
           // $("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
            //displayMonthDDChart();
            $("#pScatterStartYYYYMMDDHH").val(selectyear + selectmonth + "0100")
            $("#pScatterEndYYYYMMDDHH").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth) + "23")
            displayPScatterMonthChart();
        }
    </script>
    <input type="hidden" value="5,5" id="intervalMins" />
    <input type="hidden" value="<%=Model.id%>" id="pid"/>
    <input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00" id="estartYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23" id="eendYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00" id="pstartYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23" id="pendYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>0100" id="pScatterStartYYYYMMDDHH" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays()%>23" id="pScatterEndYYYYMMDDHH" />    
    <input type="hidden" value="column" id="chartType" />
    
    <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
        <tr>
        <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
        <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
              <td width="93%" class="pv0216"><%=Resources.SunResource.CHART_DAY_COMPARE%></td>
            </tr>
            <tr>
              <td><%=Resources.SunResource.CHART_DAY_COMPARE_DETAIL%>&nbsp;</td>
            </tr>
        </table></td>
        <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
        </tr>
    </table>
    
    <div class="subrbox01">
        <div class="sb_top"></div>
        
        <div class="sb_mid">
            <div class="subico01">
                <ul id="change">
                    <!--
                    <li style="cursor: pointer;"><a id="pScatterDayChart" class="noclick"  href="javascript:void(0)">日照功率散列图</a></li>    
                    -->    
                    <li style="cursor: pointer;"><a id="pScatterMonthChart" class="noclick"  href="javascript:void(0)"><%=Resources.SunResource.CHART_POWER_SUNLIGHT%> (<%=Resources.SunResource.CUSTOM_CHART_MONTH%>)</a></li>
                    <li style="cursor: pointer;"><a id="pDayChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_POWER_COMPARE%></a></li>
                    <li style="cursor: pointer;"><a id="eDayChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_ENERGY_COMPARE%></a></li>
                </ul>
            </div>
            <div class="z_big">
                <a id="toLargeChart" href="javascript:void(0)" onclick="largedc()" onfocus="javascript:this.blur();"></a>
            </div>
            <div class="chart">
                <div class="chart_box">
                    <div id="chartDiv">
                        <div id='container' style='width: 100%; height: 300px; margin-left: 2px; margin-right: 2px;'>
                        </div>
                    </div>

                    <div style="display: none">
                        <center>
                            <div id='large_containerdc' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px; text-align:center;">
                            </div>
                        </center>
                    </div>
                    
                    <div class="date_sel">
                        <div id="selectTable" style="margin-top: 20px; text-align: center;">
                            <table border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="24">
                                        <img src="/images/chartLeft.gif" alt="" width="24" height="21" id="left"  onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                                    </td>
                                    <td>
                                        <div id="date_pScatterDayChart" style="display: none;">
                                             <input type="text" class="t3" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                             <input name="t" type="text" id="t3" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changePScatterDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                        </div>                                     
                                        <div id="date_eDayChart" style="display: none;">
                                            <input type="text" class="t" size="12"  onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                            <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeEDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                            <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                            <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" /> 

                                        </div>
                                        <div id="date_pDayChart" style="display: none;">
                                             <input type="text" class="t2" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" />-
                                             <input name="t" type="text" id="t2" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changePDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                       </div>
                                       <div id="date_pScatterMonthChart" style="display: none;">
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
                                        <img src="/images/chartRight.gif" alt="" width="24" height="21" id="right" onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    
                    <div id="chart_detail_grid" style=" width:100%; margin-top:15px; overflow:hidden;"></div>
                        
                </div>
                <div class="chart_down">
                </div>
            </div>
        </div>
        
        <div class="sb_down"></div>
    </div>
        
<script type="text/javascript">
    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_DAY_COMPARED_CHART %>'
</script>
