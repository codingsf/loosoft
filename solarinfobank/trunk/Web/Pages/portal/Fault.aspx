<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>设备故障列表
        <%=Model.name%></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <% ArrayList invarray = ViewData["inv"] as ArrayList;
       ArrayList cabarray = ViewData["cab"] as ArrayList;
       ArrayList envarray = ViewData["env"] as ArrayList;
       ArrayList hlxarray = ViewData["hlx"] as ArrayList;
       ArrayList dbarray = ViewData["db"] as ArrayList;
    %>
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
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="clear: both; height: 10px;">
            </div>
            <%if (invarray.Count > 0)
              { %>
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
                                        <strong>逆变器列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
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
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICE_NAME%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_LOG_STATE%></strong>
                                    </td>
                                    <td width="9%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_WARING_PR_BEFOREYESTORDAY%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_WARING_PR_YESTORDAY%></strong>
                                    </td>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_WARING_PR_TODAY%></strong>
                                    </td>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_WARING_PR_MONTH%></strong>
                                    </td>
                                    <td width="12%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_WARING_PR_YEAR%></strong>
                                    </td>
                                </tr>
                                <%
                                    for (int i = 0; i < invarray.Count; i++)
                                    {
                                        Hashtable table = invarray[i] as Hashtable;
                                        if (table == null)
                                            continue;
                                %>
                                <tr>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                        <%=table["plantname"]%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=table["Unit"]%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=table["device"]%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=table["status"]%>
                                    </td>
                                    <td width="9%" class="down_line0<%=i%2 %>">
                                        <%=table["beforeYesterdayEnergy"]%>
                                    </td>
                                    <td width="10%" class="down_line0<%=i%2 %>">
                                        <%=table["yesterdayEnergy"]%>
                                    </td>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                        <%=table["todayEnergy"]%>
                                    </td>
                                    <td width="13%" class="down_line0<%=i%2 %>">
                                        <%=table["thisMonthEnergy"]%>
                                    </td>
                                    <td width="12%" class="down_line0<%=i%2 %>">
                                        <%=table["thisYearEnergy"]%>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if (envarray.Count > 0)
              { %>
            <div style="padding: 10px 0px 5px 0px; margin: 0px auto;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>环境监测仪列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICE_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_LOG_STATE%></strong>
                                    </td>
                                </tr>
                                <%
                                    for (int i = 0; i < envarray.Count; i++)
                                    {
                                        Hashtable table = envarray[i] as Hashtable;
                                        if (table == null)
                                            continue;
                                %>
                                <tr height="35">
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["plantname"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["Unit"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["device"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["status"]%>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td background="/images/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if (hlxarray.Count > 0)
              { %>
            <div style="padding: 10px 0px 5px 0px; margin: 0px auto; width: 98%;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>汇流箱列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICE_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_LOG_STATE%></strong>
                                    </td>
                                </tr>
                                <%
                                    for (int i = 0; i < hlxarray.Count; i++)
                                    {
                                        Hashtable table = hlxarray[i] as Hashtable;
                                        if (table == null)
                                            continue;
                                %>
                                <tr height="35">
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["plantname"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["Unit"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["device"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["status"]%>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td background="/images/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if (cabarray.Count > 0)
              { %>
            <div style="padding: 10px 0px 5px 0px; margin: 0px auto;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>配电柜列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICE_NAME%></strong>
                                    </td>
                                    <td width="25%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_LOG_STATE%></strong>
                                    </td>
                                </tr>
                                <%
                                    for (int i = 0; i < cabarray.Count; i++)
                                    {
                                        Hashtable table = cabarray[i] as Hashtable;
                                        if (table == null)
                                            continue;
                                %>
                                <tr height="35">
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["plantname"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["Unit"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["device"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["status"]%>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td background="/images/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <%if (dbarray.Count > 0)
              { %>
            <div style="padding: 10px 0px 5px 0px; margin: 0px auto;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>电表列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                            <strong>
                                <img src="/images/gf/dlo.gif" width="16" height="16" /><a href="#" class="rloa">下载</a></strong>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICE_NAME%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_LOG_STATE%></strong>
                                    </td>
                                    <td width="20%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.DEVICEMONITORITEM_924%>
                                        </strong>
                                    </td>
                                </tr>
                                <%
                                    for (int i = 0; i < dbarray.Count; i++)
                                    {
                                        Hashtable table = dbarray[i] as Hashtable;
                                        if (table == null)
                                            continue;
                                %>
                                <tr height="35">
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["plantname"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["Unit"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["device"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["status"]%>
                                    </td>
                                    <td class="down_line0<%=i%2 %>">
                                        <%=table["zxygdd"]%>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                        <td background="/images/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <%} %>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
