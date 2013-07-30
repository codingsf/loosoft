<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>"%>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=Resources.SunResource.DETECTORCHART_DETECTOR_CHART%></title>
</head>
<body> 
    <script type="text/javascript">
        $(document).ready(function() {
            $("#startYYYYMMDDHH").val("<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>00")
            $("#endYYYYMMDDHH").val("<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23")
            displayDayChart();
            changeALT();
        });
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

        }
        function displayDayChart() {
            $("#chartType").val("line");
            $("#selectTable").show();
            curChart = "DayChart";
            dayChart("chartContainer", 90, false);
        }

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container" });
            dayChart("large_container", 130, true);
        }
        
        
        function dayChart(curContainer, ajaxImgTop, isLarge) {
            $("#intervalMins").val('5')
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
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    showDetails(result, $("#startYYYYMMDDHH").val());
                    //ÐÞ¸Ä±êÌâ
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"/Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
            loadCountData();
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
            //$("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "06");
            $("#startYYYYMMDDHH").val(aimDay + "00");
            $("#endYYYYMMDDHH").val(aimDay + "23")
            displayDayChart();

            //aimDay = getBeforDay(aimDay);
            //aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            //$("."+obj.id).val(aimDay);
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
        function loadCountData() {
            $("#countDataDiv").empty();
            $("#countDataDiv").html('<img src="/Images/ajax_loading_min.gif" style="margin-left:350px;" />');
            $.ajax({
                type: "GET",
                url: "/Device/sunlightCount",
                data: { id: $("#deviceID").val(), YYYYMMDDHH: $("#endYYYYMMDDHH").val() },
                success: function(result) {
                    $('#countDataDiv').empty();
                    $('#countDataDiv').html(result);
                    //$('#loading').hide();
                }
            });
        }

        function PreviouNextChange(oper) {
            changeDate(oper, "t1");
            changeDay(document.getElementById("t1"));
            
        }
    </script>
    
    <div class="z_big">
    <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
     </a></div>
    <div class="chart">
    <div class="chart_box">
        <div id="chartDiv">
            <div id='chartContainer' style='width: 100%; height: 550px; margin-left: 2px; margin-right: 2px;'>
            </div>
        </div>
        <div class="date_sel">
            <div id="selectTable" style="margin-top: 20px; text-align: center;">
                <table border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="24">
                            <img src="/images/chartLeft.gif" id="left" width="24" height="21"  onclick="PreviouNextChange('left')" style="cursor:pointer;"/>
                        </td>
                        <td>
                            <div id="date_DayChart">
                                <!--
                                <input name="t" type="text" class="t1" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                    readonly="readonly"  value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>" style="text-align:center;" /> -
                                -->
                                <input name="t1" type="text" id="t1" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})"
                                                    readonly="readonly"  value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" style="text-align:center;" />
                                <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" /> 
                            </div>                            
                        </td>
                        <td width="24">
                            <img src="/images/chartRight.gif" id="right" width="24" height="21" onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <div id="chart_detail_grid" style=" width:100%; margin-top:15px; overflow:hidden;">
                                
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
