<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>设备数据-<%=Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />
        <script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var exportXlsTitle = "<%=Resources.SunResource.CHART_EXPORT_XLS%>";
        var exportCsvTitle = "<%=Resources.SunResource.CHART_EXPORT_CSV%>";
        var exportPdfTitle = "<%=Resources.SunResource.CHART_EXPORT_PDF%>";
        var infoTitle = "<%=Resources.SunResource.CHART_EXPORT_DATA%>";
        var largeButtonTitle = "<%=Resources.SunResource.LARGEBUTTONTITLE %>"
        var exportButtonTitle = "<%=Resources.SunResource.EXPORTBUTTONTITLE %>"
        var curDeviceId;
        function loadRunData(deviceId) {
            curDeviceId = deviceId;
            $("#container").empty();
            $("#container").html('');
            $.ajax({
                type: "GET",
                url: "/device/RunData",
                data: { id: deviceId, rad: Math.random() },
                success: function(result) {
                
                    $('#container').empty();
                    $('#container').html(result);
                    $('#loading').hide();
                }
            });
        }
        function initDisplayLargeMonitorChart(monitorCode) {
            var aimDay = $("#curYYYYMMDD").val();
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            var preDay = getBeforDay(aimDay);
            preDay = preDay.substring(0, 4) + "-" + preDay.substring(4, 6) + "-" + preDay.substring(6, 8);

            $(".larget").val(preDay);
            $("#mtStartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
            $("#mtEndYYYYMMDDHH").val(aimDay + "23")

            //$("#mtStartYYYYMMDDHH").val($("#curYYYYMMDD").val() + "00")
            //$("#mtEndYYYYMMDDHH").val($("#curYYYYMMDD").val() + "23")
            $("#larget").val($("#curYYYYMMDD2").val());
            displayLargeMonitorChart(monitorCode);
        } 
                 var powermc =  <%=MonitorType.MIC_INVERTER_TOTALYGPOWER %>;
         function displayLargeMonitorChart(monitorCode) {
            if(powermc == monitorCode){
                $("#chartType").val('area');
            }else{
                $("#chartType").val('line');
            }
             $("#toLarge" + monitorCode).colorbox({ width: "100%", inline: true, href: "#inline_example1" });
             $("#monitorCode").val(monitorCode);
             monitorDayChart("monitor_container", 130, true);
         }
         
        function monitorDayChart(curContainer, ajaxImgTop, isLarge) {
            $("#intervalMins").val(5)
            $.ajax({
                type: "POST",
                url: "/DeviceChart/MonitorDayChart",
                data: { dId: curDeviceId, startYYYYMMDDHH: $("#mtStartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#mtEndYYYYMMDDHH").val(), chartType: $("#chartType").val(), monitorCode: $("#monitorCode").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#mtStartYYYYMMDDHH").val().substring(0, 8), data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();
                    var interval = isLarge ? 60 / intervalMins : 60 / intervalMins;
                    showDetails(result, $("#mtEndYYYYMMDDHH").val());
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
        function displayLargeMonitorChart(monitorCode) {
            if (powermc == monitorCode) {
                $("#chartType").val('area');
            } else {
                $("#chartType").val('line');
            }
            $("#toLarge" + monitorCode).colorbox({ width: "100%", inline: true, href: "#inline_example1" });
            $("#monitorCode").val(monitorCode);
            monitorDayChart("monitor_container", 130, true);
        }
               
         function changeMonitorPreDay(obj) {
        var d = obj.value;
        var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
        nextDay.setDate(nextDay.getDate() + 1);
        var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
        $("#larget").val(temp);
        changeMonitorDay(document.getElementById('larget'))
        
    }
    
    function changeMonitorDay(obj) {
         var aimDay = obj.value;
         if (aimDay) {
             aimDay = aimDay.replace("-", "").replace("-", "");
         }
         $("#mtStartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
         $("#mtEndYYYYMMDDHH").val(aimDay + "23")
         displayLargeMonitorChart($("#monitorCode").val());
         
         aimDay = getBeforDay(aimDay);
         aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
         if ($("." + obj.id) != undefined) {
                $("." + obj.id).val(aimDay);
         }
     }
    function LargetPreviouNextChange(oper){
            changeDate(oper, 'larget');
            changeMonitorDay(document.getElementById('larget'));
    }
    </script>
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />
        <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>

    <script src="/Script/SetChart.js" type="text/javascript"></script>

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
<input type="hidden" value="<%=ViewData["unitID"] %>" id="unitId" />
<input type="hidden" value="<%=ViewData["deviceID"] %>" id="deviceID" />
<input type="hidden" value="<%=ViewData["plantID"] %>" id="plantID" />

<input type="hidden" value="5,5" id="intervalMins" />
<input type="hidden" value="" id="monitorCode" />
<input type="hidden" value="area" id="chartType" />
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(DateTime.Now,"yyyyMMdd")%>00"
    id="startYYYYMMDDHH" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23"
    id="endYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(DateTime.Now,"yyyyMMdd")%>00"
    id="mtStartYYYYMMDDHH" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23"
    id="mtEndYYYYMMDDHH" />
<input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>"
    id="month" />
<input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays()%>"
    id="endYYYYMMDD" />
<input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
<input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="curYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
    id="curYYYYMMDD2" />

    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=Model.name %></div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
            
        </div>
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="clear: both; height: 0px;">
            </div>
            <!--左边设备导航-->
            <div style="float:left;">                   
                <iframe src="/plant/devicestructchart/<%=Model.id %>" width="300" scrolling="auto" frameborder="0"
                            height="650">
                </iframe>
            </div>
            <!--右边边设备数据-->
            <div style=" float:right; width:700px; text-align:left;" id="container"></div>
            
            <div style="clear: both; height: 60px;">
            </div>
            <div style='display: none'>
            <div id='inline_example1' style='padding: 10px; background: #fff;'>
                <center>
                    <div id='monitor_container' style="width: 90%; height: 400px; margin-left: 40px;
                        margin-right: 40px;">
                    </div>
                    <div id="date_MonitorDayChart">
                        <div id="selectMonitorTable" style="margin-top: 10px;">
                            <table border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="24">
                                        <img src="/images/chartLeft.gif" width="24" height="21" id="left" onclick="LargetPreviouNextChange('left')"
                                            style="cursor: pointer;" />
                                    </td>
                                    <td align="center">
                                        <input name="t" type="text" size="12" class="indate larget" onclick="WdatePicker({onpicked:function(){changeMonitorPreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                            readonly="readonly" value="<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>"
                                            style="text-align: center;" />
                                        -
                                        <input name="t" type="text" id="larget" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeMonitorDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                            readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
                                            style="text-align: center;" />
                                        <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                        <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                                    </td>
                                    <td width="24">
                                        <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="LargetPreviouNextChange('right')"
                                            style="cursor: pointer;" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </center>
            </div>
        </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
    
            <div style='display: none'>
            <center>
                <div id='large_container_chart' style="width: 90%; height: 400px; margin-left: 40px;
                    margin-right: 40px; text-align: center;">
                </div>
            </center>
        </div>
</body>
</html>
