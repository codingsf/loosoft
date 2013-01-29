<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>

<script>
    function autoreload() {
    if(<%=ViewData["autoRefresh"] %>)
     chartInterval= setInterval("loaddeviceData()",<%=ViewData["refreshInterval"] %>);
    }
    //
    function loaddeviceData(){
    //显示图表 这里比较麻烦
    if(curtab==1)
    {
        if(chartId==0)displayDayChart();
        if(chartId==1)displayDaykWpChart();
        if(chartId==2)displayMonthDDChart();
        if(chartId==3)displayyearMMChart();
        if(chartId==4)displayyearChart();
    }
    if(curtab==2)displayRunData();
    if(curtab==3)displayFault();
    }
    
</script>

    <script type="text/javascript">
        function loadRunData(deviceId) {
        }
    </script>
    
    <script type="text/javascript">
        var isFirst = true;
        function readyinit() {
            deviceChartInit();
            //autoreload();
        }
        function deviceChartInit() {
            loadContent('content_container_control', '/plant/devicedataoverview/<%=ViewData["plantID"] %>/<%=ViewData["deviceID"] %>/<%=ViewData["unitID"] %>', 'ajax', 'GET');
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
                  <td><%=(bool.Parse(ViewData["autoRefresh"].ToString ())? string.Format(Resources.SunResource.AUTO_REFRESH_NOTICE, int.Parse(ViewData["refreshInterval"].ToString())/1000) : string.Empty)%>&nbsp;</td>
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
                            <iframe src="/plant/devicestructtree/<%=Model.id %>" width="150" scrolling="auto" frameborder="0"
                                        height="650">
                            </iframe>
                        </div>
                        <!--右边边设备数据-->
                        <div style=" float:right; width:570px; text-align:left;" id="content_container_control"></div>
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
       