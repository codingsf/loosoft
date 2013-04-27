<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--设备图表，实时数据，log等三者集成显示页面-->
<!--
     <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %>  <%=Resources.SunResource.CHART_DEVICE_DATA %> 
-->
<style type="text/css" >
    .ondbl
    {
        float: left;
        background: #fff;
    }
    .pl1501
    {
        padding-left: 2px;
        border-bottom: 1px solid #E6E6E6;
    }
    .pl1502
    {
        padding-left: 5px;
        background: #F7F7F7;
        border-bottom: 1px solid #E6E6E6;
    }
</style>

<script type="text/javascript">
        var pageNo = 1;
        var curtab=1;//默认图表
        if(chartInterval!=undefined)
            clearInterval(chartInterval);
        autoreload();
        function readyinit() {
            $('#rundata').click(displayRunData);
            $('#chart').click(displayChart);
            $('#fault').click(displayFault);
            displayRunData();
            deviceInint();
            if($('#prchart'))
            {
                $('#prchart').click(displayPRChart);
            }
        }
        function deviceInint() {
            var id = "unit" + $("#unitId").val();
            $("div[id='" + id + "']").show();
            $("#"+id+"_link").addClass("current");
        }
        function displayPRChart()
        {
            loadData("prchart");
            changeTopStyle('prchart');
        }
        function displayRunData() {
            curtab=2;
            loadData("rundata");
            changeTopStyle('rundata');
        }
        //填充 rundata 数据
        function fillingRunData()
        {
            curtab=2;
            $.ajax({
                type: "GET",
                url: "/device/rundatajson",
                data: { id: $("#deviceID").val(),rad: Math.random()},
                success: function(data) {
                    var result=eval('('+data+')');
                    for(var i=0;i<result.length;i++)
                    {
                        for(var j=0;j<result[i].length;j++)
                        {
                            if($("#lbl"+result[i][j].key.code).length)
                                $("#lbl"+result[i][j].key.code).html(result[i][j].value);
                            if($("#unit"+result[i][j].key.code).length)
                                $("#unit"+result[i][j].key.code).html(result[i][j].key.unit);
                        }
                    }
                }, 
                complete: function (XHR, TS) { XHR = null } 
            });
            changeTopStyle('rundata');
        }
        
        function displayChart() {
            curtab=1;
            loadData("chart");
            changeTopStyle('chart');
            changeALT() ;
        }
        
        function displayFault() {
            curtab=3;
            loadData("fault");
            changeTopStyle('fault')
        }

        function loadData(flag) {
            if (flag == "fault")
                loadLog(pageNo);
            if (flag == "rundata")
                loadRunDataHtml();
            if (flag == "chart")
                loadChartData();
            if (flag == "prchart")
                loadPRChartData();  
        }
        
        function loadRunData(deviceId)
        {
            $("#deviceID").val(deviceId);
            var did=deviceId;
            var uid=$('#unitId').val();
            var pid="<%=Model.id %>";
            //loadData("rundata");
            displayRunData();
          //  loadContent('content_container_control','/plant/devicedataoverview/'+pid+'/'+did+'/'+uid,'ajax','GET');
        }
        
        function loadRunDataHtml() {
            var did = $("#deviceID").val();
            //没有设备不做处理
            if(did==null || did=="" || did=="null" || did=="undefined") return;
            $("#container").empty();
            //$("#container").html('<img src="/Images/ajax_loading.gif" style="margin-left:210px;" />');
            $.ajax({
                type: "GET",
                url: "/device/RunData",
                data: { id: $("#deviceID").val(),rad: Math.random()},
                success: function(result) {
                    $('#container').empty();
                    $('#container').html(result);
                    $('#loading').hide();
                }, 
                complete: function (XHR, TS) { XHR = null } 
            });
        }

        function loadLog(No) {
            $("#container").empty();
            $("#container").html('<img src="/Images/ajax_loading.gif" style="margin-left:210px;" />');
            $.ajax({
                type: "POST",
                url: "/device/devicefault",
                data: { userId:<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id %>,dId: $("#deviceID").val(), pageNo: No },
                success: function(result) {
                    $("#container").empty();
                    $("#container").append(result);
                }, 
                complete: function (XHR, TS) { XHR = null } 
            });
        }

        function loadChartData() {
            $("#container").empty();
            $("#container").html('<img src="/Images/ajax_loading.gif" style="margin-left:210px;" />');
            $.ajax({
                type: "POST",
                url: "/DeviceChart/Chart",
                data: { pId: $("#plantID").val(),dId: $("#deviceID").val() },
                success: function(result) {
                    showDetails(result);
                    $("#container").empty();
                    $("#container").append(result);
                }, 
                complete: function (XHR, TS) { XHR = null } 
            });
        }


        function loadPRChartData() {
            $("#container").empty();
            $("#container").html('<img src="/Images/ajax_loading.gif" style="margin-left:210px;" />');
            $.ajax({
                type: "POST",
                url: "/DeviceChart/PRChart",
                data: { pId: $("#plantID").val(),dId: $("#deviceID").val() },
                success: function(result) {
                    showDetails(result);
                    $("#container").empty();
                    $("#container").append(result);
                }, 
                complete: function (XHR, TS) { XHR = null } 
            });
        }
        
        
        function changeTopStyle(curId) {
            $("#rundata").attr("class", "noclick");
            $("#chart").attr("class", "noclick");
            $("#fault").attr("class", "noclick");
            $("#prchart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
        }

         function cbxvalue(name) {
             var values = "";
             $("input[name='" + name + "']:checked").each(function() {
                 values += $(this).val() + ",";
             });
             return values == "" ? '-1' : values+"-1";
         }
         function changePage(No) {
             pageNo = No;
             loadLog(pageNo);
         }

         function monitorDayChart(curContainer, ajaxImgTop, isLarge) {
             $("#intervalMins").val(5)
             $.ajax({
                 type: "POST",
                 url: "/DeviceChart/MonitorDayChart",
                 data: { dId: $("#deviceID").val(), startYYYYMMDDHH: $("#mtStartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#mtEndYYYYMMDDHH").val(), chartType: $("#chartType").val(), monitorCode: $("#monitorCode").val(), intervalMins: $("#intervalMins").val() },
                 success: function(result) {
                     if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                     }   
                     var data = eval('(' + result + ')')
                     setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#mtStartYYYYMMDDHH").val().substring(0,8),data.name);
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
                 }, 
                complete: function (XHR, TS) { XHR = null } 
             });
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
          function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";

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
         
         function initDisplayLargeMonitorChart(monitorCode){
         var aimDay = $("#curYYYYMMDD").val();
             if (aimDay) {
                 aimDay = aimDay.replace("-", "").replace("-", "");
             }
            var preDay = getBeforDay(aimDay);
            preDay=preDay.substring(0, 4) + "-" + preDay.substring(4, 6) + "-" + preDay.substring(6, 8);
             
             $(".larget").val(preDay);
             $("#mtStartYYYYMMDDHH").val(getBeforDay(aimDay) + "00")
             $("#mtEndYYYYMMDDHH").val(aimDay + "23")
             
            //$("#mtStartYYYYMMDDHH").val($("#curYYYYMMDD").val() + "00")
             //$("#mtEndYYYYMMDDHH").val($("#curYYYYMMDD").val() + "23")
             $("#larget").val($("#curYYYYMMDD2").val());
             displayLargeMonitorChart(monitorCode);
         }
         
         function LargetPreviouNextChange(oper){
            changeDate(oper, 'larget');
            changeMonitorDay(document.getElementById('larget'));
         }
</script>

<input type="hidden" value="<%=ViewData["unitID"] %>" id="unitId" />
<input type="hidden" value="<%=ViewData["deviceID"] %>" id="deviceID" />
<input type="hidden" value="<%=ViewData["plantID"] %>" id="plantID" />
<input type="hidden" value="<%=(ViewData["device"] as Device).fullName %>" id="deviceName" />
<input type="hidden" value="5,5" id="intervalMins" />
<input type="hidden" value="" id="monitorCode" />
<input type="hidden" value="area" id="chartType" />
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00"
    id="startYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23"
    id="endYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>00"
    id="mtStartYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>23"
    id="mtEndYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>"
    id="year" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"MM")%>"
    id="month" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays(Model.timezone)%>"
    id="endYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>01"
    id="startYM" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>12"
    id="endYM" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="curYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
    id="curYYYYMMDD2" />
<div class="subrbox01" style="width: 560px">
    <div class="bitab" style="background:url(../../images/sub/subico006-01.jpg) no-repeat;">
        <ul id="bitab">
            <li><a href="javascript:void(0);" id="chart"><%=Resources.SunResource.CHART_CHART %></a></li>
            <%
            if ((ViewData["device"] as Device).deviceTypeCode.Equals(DeviceData.INVERTER_CODE) && Model.getDetectorWithRenderSunshine() != null)
            {%>
            <li><a href="javascript:void(0);" id="prchart"><%=Resources.SunResource.DEVICE_PR_CHART%></a></li>
            <%}%>
            <li><a href="javascript:void(0);" id="rundata"><%=Resources.SunResource.CHART_RUN_DATA %></a></li>
            <li><a href="javascript:void(0);" id="fault"><%=Resources.SunResource.CHART_FAULT %></a></li>
        </ul>
    </div>
    <!--class="sb_mid"-->
    <div  style="width: 560px;">
        <div class="">
            <!-- This contains the hidden content for inline calls -->
            <div style='display: none'>
                <div id='inline_example1' style='padding: 10px; background: #fff;'>
                    <center>
                        <div id='monitor_container' style="width: 90%; height: 400px; margin-left: 40px; margin-right: 40px;">
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
            <div style='display: none'>
                <center>
                    <div id='large_container_chart' style="width: 90%; height: 400px; margin-left: 40px;
                        margin-right: 40px; text-align: center;">
                    </div>
                </center>
            </div>
            <!-- 数据容器 -->
            <div id="container">
            </div>
        </div>
    </div>
    <!--
    <div class="sb_down" style="width: 560px">
    </div>
    -->
</div>
