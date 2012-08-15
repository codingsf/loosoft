<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--
<%=Resources.SunResource.INVERTERCOMPAREPAGE_INVERTER_COMPARE_PAGE%></asp:Content>
-->
<style type="text/css">
    /*模拟对角线*/
    .out
    {
        border-top: 40px #F2F4E1 solid; /*上边框宽度等于表格第一行行高*/
        width: 0px; /*让容器宽度为0*/
        height: 0px; /*让容器高度为0*/
        border-left: 80px #F7F7F7 solid; /*左边框宽度等于表格第一行第一格宽度*/
        position: relative; /*让里面的两个子容器绝对定位*/
    }
    b
    {
        font-style: normal;
        display: block;
        position: absolute;
        top: -35px;
        left: -45px;
        width: 35px;
        text-align:right;
    }
    em
    {
        font-style: normal;
        display: block;
        position: absolute;
        top: -20px;
        left: -75px;
        width: 55px;
    }
</style>

<script type="text/javascript">
        var isFirst=true;
        function readyinit() {
            currentSel="#unit"+$("#id").val();
            $(currentSel+"_link").attr("href","javascript:void(0);");
            var id = "unit" + $("#uid").val();
            $("#"+id+"_link").addClass("current");
            $("#unit<%=(ViewData["plantUnit"] as PlantUnit).id%>").show();
            $('#unit').change(unitDeviceInit);
            unitDeviceInit();
            <%if (bool.Parse(ViewData["hasinverter"].ToString()))
            { %>
            loadInvertCompare(1);
            <%}else if (bool.Parse(ViewData["hashlx"].ToString())){%>
            loadInvertCompare(2);
            <%}%>
        }
        
        function deviceChartInit()
        {
            var did=$('#dces').val();
            var uid=$('#uid').val();
            var pid=<%=Model.id %>
            if(did==-1)
            {
                $('#intervalMins').val(60);
                <%if (bool.Parse(ViewData["hasinverter"].ToString()))
                { %>
                loadInvertCompare(1);
                <%}else if (bool.Parse(ViewData["hashlx"].ToString())){%>
                loadInvertCompare(2);
                <%}%>
                //$('#type_container').show();
            }
            else
            {
                loadContent('content_container_control','/plant/device/'+pid+'/'+did+'/'+uid,'ajax','GET');
               // $('#type_container').hide();
            
            }
        }
        
        function unitDeviceInit()
        {   
                //$('#type_container').show();
                var uid=$('#uid').val();
                $.ajax({
                type: "POST",
                url: "/deviceChart/unitDevice",
                data: { uId: uid },
                success: function(result) {
                    $('#dce_control').html(result);
                    if(isFirst==false)
                    {
                        $('#intervalMins').val(60);
                        <%if (bool.Parse(ViewData["hasinverter"].ToString()))
                        { %>
                        loadInvertCompare(1);
                        <%}else if (bool.Parse(ViewData["hashlx"].ToString())){%>
                        loadInvertCompare(2);
                        <%}%>
                    }
                    isFirst=false;
                },
                beforeSend: function() {
                }
            });
        }
        
        //根据单元和类型加载相应的比较图表
        function loadInvertCompare(type){
            var uid=$('#uid').val();
		    //var type = $("input[name='deviceType']:checked").val()+"";
           // alert(type);
            $('#content_container_control').html();
            if(type==1){
                loadContent('content_container_control','/devicechart/InverterComparePage/'+uid,'ajax','GET');
            }else {
                loadContent('content_container_control','/devicechart/HlxComparePage/'+uid,'ajax','GET');
            }
        }
        
</script>
<input type="hidden" value="<%=CalenderUtil.getBeforeDay(CalenderUtil.curDateWithTimeZone(Model.timezone),"yyyyMMdd")%>06"
    id="startYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>20"
    id="endYYYYMMDDHH" />
<input type="hidden" value="<%=(ViewData["plantUnit"] as PlantUnit).id%>" id="uid" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>" id="year" />
<input type="hidden" value="<%=ChartType.line %>" id="chartType" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>"
    id="month" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="YYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>06"
    id="unitstartYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>20"
    id="unitendYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays(Model.timezone)%>"
    id="endYYYYMMDD" />
    
    <input type="hidden" value="60" id="intervalMins" />
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
                        <%=Resources.SunResource.CHART_UNIT_CHART %>
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
                        <%=Resources.SunResource.CHART_UNIT_CHART_DETAIL %>&nbsp;
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

<div class="subrbox03">
		  <table width="69%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="auto" height="30" align="right"><span style="white-space:nowrap"><%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%>:</span></td>
              <td width="auto" align="left" style="padding-left:5px" id="dce_control" >
              
                <select name="dces" id="dces" class="subselect02" style="width:150px">
              <option><%=Resources.SunResource.UDEVICE_PAGE_PLEASESELECT%></option>
              </select>
              </td>
              <td width="auto" align="right" style="padding-left:100px"><span style="white-space:nowrap"><%--<%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%>:--%></span></td>
              <td width="auto"style="padding-left:5px">
             
              </td>
              </tr>
            <%--<tr id="type_container">
              <td height="30"  align="right"><span style="white-space:nowrap"><%=Resources.SunResource.PLANT_DEVICE_DEVICE_TYPE%>:</span></td>
              <td colspan="3" style="padding-left:5px"><input type="radio" checked="checked" name="deviceType" value="1" onclick="loadInvertCompare();" />
              <span style="white-space:nowrap"><%=Resources.SunResource.DEVICETYPE_1%></span>
                  <input type="radio" name="deviceType" value="2" onclick="loadInvertCompare();"/>        
                  <span style="white-space:nowrap"><%=Resources.SunResource.DEVICETYPE_3%></span></td>
              </tr>--%>
          </table>
</div>

<div id="content_container_control">
</div>
<script type="text/javascript">document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_DEVICE_LIST %>'</script>
