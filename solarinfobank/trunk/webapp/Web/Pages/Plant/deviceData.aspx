<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
    <script type="text/javascript">

        function readyinit() {
        }
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
        var powermc =  <%=MonitorType.MIC_INVERTER_TOTALYGPOWER %>;
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
        function LargetPreviouNextChange(oper){
                changeDate(oper, 'larget');
                changeMonitorDay(document.getElementById('larget'));
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
         

    </script>
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
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216"><%=Resources.SunResource.DEVICE_RUN_DATA %></td>
                </tr>
                <tr>
                  <td><%=Resources.SunResource.CHART_DAY_COMPARE_DETAIL%>&nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div class="gf_midbody" style="padding-left:0px; padding-top:0px; padding-right:0px;">
                    <div class="gf_boxb">
                        <div>
                        <!--左边设备导航-->
                        <div style="float:left;">                   
                            <iframe src="/plant/devicestructtree/<%=Model.id %>" width="220" scrolling="auto" frameborder="0"
                                        height="650">
                            </iframe>
                        </div>
                        <!--右边边设备数据-->
                        <div style=" float:right; width:500px; text-align:left;" id="container"></div>
                        </div>
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
        </div>
<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.DEVICE_RUN_DATA %>'</script>
