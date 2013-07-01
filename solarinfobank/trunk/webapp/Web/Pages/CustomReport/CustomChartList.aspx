<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CustomChart>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>

<link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    function cancelUrl() {
        parent.window.location.href = "/plant/customchart/" + $("#id").val();
    }

    function delitem(index) {
        if (confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE%>') == false)
            return;
        $.ajax({
            type: "POST",
            url: "/customreport/deletechart",
            data: { id: index },
            success: function(result) {
                if (result == "success")
                   // $('#item_' + index).hide();
                    parent.window.location.href = "/plant/customcharts/" + $("#id").val();
                else
                    alert('<%=Resources.SunResource.PLANT_LOG_ERROR%>');
               
            }
        });
    }

    function large() {
        if (!CheckSubmit()) { return false; }
        else {

            var timeInterval = $('#timeInterval').val();
            if (timeInterval == 'Month') {
                $('#startTime').val($('#curYYYY').val() + "01");
                $('#endTime').val($('#curYYYY').val() + "12");
            } else if (timeInterval == 'Day') {
                $('#startTime').val($('#curYYYYMM').val() + "01");
                $('#endTime').val($('#curYYYYMM').val() + getMaxDate($('#curYYYY').val(), $('#curMM').val()));
            } else {
                $('#startTime').val($('#curYYYYMMDD').val() + "00");
                $('#endTime').val($('#curYYYYMMDD').val() + "23");
            }

            parent.displayChart($('#id').val(), $('userId').val(), $('#plantId').val(), $('#customType').val(), $('#groupId').val(),
                                $('#productName').val(), $('#reportName').val(), $('#timeSlot').val(), $('#tcounter').val(), $('#timeInterval').val(),
                                $('#product').val(), $('#times').val(), $("#ProIdType").val(), $("#valueType").val(), $("#units").val(),
                                $('#cVal').val(), $('#productList').val(), $('#selTimes').val(), $('#startTime').val(), $('#endTime').val());
        }
    }
</script>
<style type="text/css">
    .style1
    {
        text-align: right;
        padding-right: 10px;
    }
</style>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td width="793" valign="top" background="/images/kj/kjbg01.gif">
    <input type="hidden" value="" id="startTime" />
    <input type="hidden" value="" id="endTime" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyy") %>"
        id="curYYYY" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"MM") %>"
        id="curMM" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyyMM") %>"
        id="curYYYYMM" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyyMMdd") %>"
        id="curYYYYMMDD" />
    <form method="post" action="/CustomReport/Save" id="formReportConfig">
    <%--<input id="product" name="product" type="hidden" />--%>
    <%=Html.HiddenFor(model => model.product) %>
    <%=Html.HiddenFor(model => model.productName) %>
    <%=Html.HiddenFor(model => model.times) %>
    <%=Html.HiddenFor(Model=>Model.userId) %>
    <%=Html.HiddenFor(Model=>Model.plantId) %>
    <%=Html.HiddenFor(Model=>Model.id) %>
    <%=Html.Hidden("cid",Request.QueryString["cid"]) %>
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
                            <%=Resources.SunResource.CUSTOMREPORT_USER_DEFINED_LIST%>
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
                            <%=Resources.SunResource.CUSTOMREPORT_USER_DEFINED_DETAIL%>&nbsp;
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
    
    
    </form>
    <div class="subrbox01">
        <div>
            <table width="90%" border="0" cellpadding="0" cellspacing="0" height="30">
                <tbody>
                    <tr>
                        <td width="6%" align="center">
                           <a href="/plant/customchart/<%=this.Model.plantId %>" class="dbl">  <img src="/images/sub/subico016.gif" width="18" height="19"></a>
                        </td>
                        <td class="f_14" width="94%">
                                <a href="/plant/customchart/<%=this.Model.plantId %>" class="dbl"> <%=Resources.SunResource.MONITORITEM_ADD%></a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="sb_top">
        </div>
        <div class="sb_mid">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0"
                                height="25">
                                <tbody>
                                    <tr>
                                        <td width="50%" align="center">
                                            <strong>
                                                <%=Resources.SunResource.CUSTOMREPORT_CHART_NAME %>
                                            </strong>
                                        </td>
                                        <td width="25%" align="center">
                                            <strong>
                                                <%=Resources.SunResource.CUSTOMREPORT_CHART_TIME%>
                                            </strong>
                                        </td>
                                        <td width="25%" align="center">
                                            <strong>
                                                <%=Resources.SunResource.MONITORITEM_OPERATION %></strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%
                        int i = 1;
                        foreach (var item in ViewData["charts"] as IList<CustomChart>)
                        {
                            i++;
                    %>
                    <tr id="item_<%=item.id %>">
                        <td>
                            <table class="down_line0<%=i%2 %>" width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="50%" align="center" height="35">
                                            <span class="chk" style="overflow: hidden; display: block; width: 300px"><a href="/plant/ViewCustomChart?pId=<%=item.plantId%>&cId=<%=item.id%>"
                                                target="_blank"><%=item.reportName %></a></span>
                                        </td>
                                        <td width="25%" align="center">
                                            <%=LanguageUtil.getDesc(string.Format("CUSTOM_CHART_{0}",item.timeInterval.ToUpper())) %>
                                        </td>
                                        <td width="25%" align="center">
                                            <a href="/plant/ViewCustomChart?pId=<%=item.plantId%>&cId=<%=item.id%>" target="_blank"
                                                title="<%=Resources.SunResource.RUN_REPORT_VIEW%>">
                                                <img src="../../Images/sub/ck.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.RUN_REPORT_VIEW%>" /></a>
                                            &nbsp;
                                            <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                                              { %>
                                            <img src="../../Images/sub/pencil0.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>" />
                                            <%}
                                              else
                                              { 
                                            %>
                                            <a href="/plant/customchart/<%= item.plantId%>?cid=<%=item.id%>" title="<%=Resources.SunResource.MONITORITEM_EDIT%>">
                                                <img src="../../Images/sub/pencil.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>" /></a>
                                            <%} %>
                                            <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().userRole.roleId.Equals(4))
                                              { %>
                                            <img src="../../Images/sub/cross00.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE %>" />
                                            <%}
                                              else
                                              { %>
                                            <a href="javascript:void(0)" onclick="delitem('<%=item.id %>')" title="<%=Resources.SunResource.MONITORITEM_DELETE %>">
                                                <img src="../../Images/sub/cross.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE %>" /></a>
                                            <%} %>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div>
        <div class="sb_down">
        </div>
    </div>
    <div style="display: none">
        <center>
            <div id='large_container' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px;large_container">
            </div>
        </center>
    </div>
    <br />
</td>

<script src="../../Script/jquery.colorbox.js" type="text/javascript"></script>
</tr>
</table>
