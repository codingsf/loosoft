﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>电站单元 <%=this.Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/slide.js" type="text/javascript"></script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
    <link href="../../style/lrtk.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=this.Model.name %></div>
                <div class="gf_toptittlel">
                    <a href="/portal/index">
                        <img src="/protalimg/<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="position: relative;">
                <center>
                    <img src="/ufile/<%=Model.structPic %>" usemap="#unitmap" alt="" /></center>
                <%--    <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
                  {%>
                <div style="position:absolute; top:<%=point.y %>px; left:<%=point.x %>px; color:Red;"><%=point.displayName %></div>
                <%} %>--%>
            </div>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>单元列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <% int j = 0;
                                       int cindex = 1;
                                       foreach (PlantUnit plantUnit in Model.plantUnits)
                                       {
                                           ++j;
                                    %>
                                    <td width="50%" class="down_line0<%=cindex%2+1 %>">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="8%" height="60" align="center">
                                                    <%
                                                        if (plantUnit.collector.runData != null)
                                                        {
                                                            if (!plantUnit.isWork(Model.timezone))
                                                            {%>
                                                    <img src="/images/gf/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                    <% }
                                                            else
                                                            {%>
                                                    <img src="/images/gf/line_on.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                                        title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                                    <%}
                                                        }
                                                        else
                                                        { %>
                                                    <img src="/images/gf/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                    <%} %>
                                                </td>
                                                <td width="92%">
                                                    <span class="xxbox_tt"><a target="_blank" href="/portal/unit?uid=<%=plantUnit.id %>&pid=<%=Model.id %>" class="dbl">
                                                        <%=plantUnit.displayname %></a> </span>
                                                    <br />
                                                    <%if (plantUnit.collector.runData != null)
                                                      { %>
                                                    <span class="lbl">
                                                       
                                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:
                                                        <%=plantUnit.TodayPower(Model.timezone)%>
                                                        kW
                                                        <br />
                                                         <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>:
                                                        <%=plantUnit.TodayEnergy(Model.timezone)%>
                                                        kWh
                                                        <br />
                                                        累计发电:
                                                        <%=plantUnit.displayTotalEnergyDigtal%>
                                                        <%=plantUnit.displayTotalEnergyUnit%> </span>
                                                    <%}
                                                      else
                                                      {%>
                                                    <span class="lbl">
                                                    <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>: 0 kW
                                                        <br />
                                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>: 0 kWh
                                                        <br />
                                                        
                                                        累计发电: 0 kW </span>
                                                    <%}%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <%if (j % 2 == 0) { Response.Write("</tr><tr>"); cindex++; }
                                       } if (j % 2 != 0)
                                       { %>
                                    <td width="50%" class="down_line0<%=cindex%2+1 %>">
                                    </td>
                                    <%} %>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9">
                            <img src="/images/gf/tci/tc06.gif" width="9" height="9" />
                        </td>
                        <td background="/images/gf/tci/tc07.gif">
                        </td>
                        <td>
                            <img src="/images/gf/tci/tc08.gif" width="9" height="9" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <%Html.RenderPartial("footer"); %>
    
    <map name="unitmap" id="unitmap">
        <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
          {%>
        <area shape="circle" coords="<%=point.x %>,<%=point.y %>,15" href="<%=point.targetUrl %>"
            target="_blank" title="<%=point.displayName %>" />
        <%} %>
    </map>
</body>
</html>
