<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Device>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<% Pager invpage = ViewData["invpage"] as Pager;
   Pager envpage = ViewData["envpage"] as Pager;
   Pager cabpage = ViewData["cabpage"] as Pager;
   Pager hlxpage = ViewData["hlxpage"] as Pager;
   Pager dbpage = ViewData["dbpage"] as Pager;
   string t = ViewData["t"] as string;
   Hashtable[] invarray = ViewData["inv"] as Hashtable[];
   Hashtable[] envarray = ViewData["env"] as Hashtable[];
   Hashtable[] cabarray = ViewData["cab"] as Hashtable[];
   Hashtable[] hlxarray = ViewData["hlx"] as Hashtable[];
   Hashtable[] dbarray = ViewData["db"] as Hashtable[];
%>
<%switch (t)
  {
      case "inv":%>
<%if (invarray.Length > 0 && invarray[0] != null)
  { %>
<div style="padding: 30px 0px 10px 0px; margin: 0px auto; width: 98%;">
    <table>
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <td align="left" width="2%">
                <img width="18" height="19" src="/images/sub/subico010.gif" />
            </td>
            <td width="98%" class="dblack">
                <p>
                    <%=Resources.SunResource.DEVICE_MONITOR_INVERTER%><a class="dbl" href="#" /></p>
            </td>
        </tr>
    </table>
    <div>
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
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
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
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_WARING_PR_BEFOREYESTORDAY%></strong>
                            </td>
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_WARING_PR_YESTORDAY%></strong>
                            </td>
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_WARING_PR_TODAY%></strong>
                            </td>
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_WARING_PR_MONTH%></strong>
                            </td>
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_WARING_PR_YEAR%></strong>
                            </td>
                        </tr>
                        <%
                            for (int i = 0; i < invarray.Length; i++)
                            {
                                Hashtable table = invarray[i] as Hashtable;
                                if (table == null)
                                    continue;
                        %>
                        <tr height="35">
                            <td class="down_line0<%=i%2 %>">
                                <%=table["plant"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["unit"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["device"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["status"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["beforeYesterdayEnergy"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["yesterdayEnergy"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["todayEnergy"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["thisMonthEnergy"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["thisYearEnergy"]%>
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
                <td background="/images/tc04.gif">
                    &nbsp;
                </td>
                <td align="center" height="36" bgcolor="#FFFFFF">
                    <span class="pagefy">
                        <%if ((invpage.IsFirst) == false)
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change('1','inv')">&lt;&lt;</a>
                        </span>
                        <%} %>
                        <%if ((invpage.IsPre))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=invpage.PageIndex-1%>,'inv')">
                            <%=Resources.SunInfoResource.PAGE_PRE%></a> </span>
                        <%} %>
                        <span>
                            <%=invpage.PageIndex%>/<%=invpage.PageCount%></span>
                        <%if ((invpage.IsNext))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=invpage.PageIndex+1%>,'inv')">
                            <%=Resources.SunInfoResource.PAGE_NEXT%></a> </span>
                        <%} %>
                        <%if ((invpage.IsLast) == false)
                          { %>
                        <span><a onclick="change(<%=invpage.PageCount%>,'inv')" class="green" href="javascript:void(0)">
                            &gt;&gt;</a></span>
                        <%} %>
                    </span>
                </td>
                <td background="/images/tc05.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="9" height="9">
                    <img src="/images/tc/tc06.gif" width="9" height="9" />
                </td>
                <td background="/images/tc/tc07.gif">
                </td>
                <td>
                    <img src="/images/tc/tc08.gif" width="9" height="9" />
                </td>
            </tr>
        </table>
    </div>
</div>
<%} %>
<%  break;
      case "env":%>
<%if (envarray.Length > 0 && envarray[0] != null)
  { %>
<div style="padding: 10px 0px 10px 0px; margin: 0px auto; width: 98%;">
    <table>
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <td align="left" width="2%">
                <img width="18" height="19" src="/images/sub/subico010.gif" />
            </td>
            <td width="98%" class="dblack">
                <p>
                    <%=Resources.SunResource.DEVICE_MONITOR_EM%><a class="dbl" href="#" /></p>
            </td>
        </tr>
    </table>
    <div>
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
                            for (int i = 0; i < envarray.Length; i++)
                            {
                                Hashtable table = envarray[i] as Hashtable;
                                if (table == null)
                                    continue;
                        %>
                        <tr height="35">
                            <td class="down_line0<%=i%2 %>">
                                <%=table["plant"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["unit"]%>
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
                <td background="/images/tc04.gif">
                    &nbsp;
                </td>
                <td align="center" height="36" bgcolor="#FFFFFF">
                    <span class="pagefy">
                        <%if ((envpage.IsFirst) == false)
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change('1','env')">&lt;&lt;</a>
                        </span>
                        <%} %>
                        <%if ((envpage.IsPre))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=envpage.PageIndex-1%>,'env')">
                            <%=Resources.SunInfoResource.PAGE_PRE%></a> </span>
                        <%} %>
                        <span>
                            <%=envpage.PageIndex%>/<%=envpage.PageCount%></span>
                        <%if ((envpage.IsNext))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=envpage.PageIndex+1%>,'env')">
                            <%=Resources.SunInfoResource.PAGE_NEXT%></a> </span>
                        <%} %>
                        <%if ((envpage.IsLast) == false)
                          { %>
                        <span><a onclick="change(<%=envpage.PageCount%>,'env')" class="green" href="javascript:void(0)">
                            &gt;&gt;</a></span>
                        <%} %>
                    </span>
                </td>
                <td background="/images/tc05.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="9" height="9">
                    <img src="/images/tc/tc06.gif" width="9" height="9" />
                </td>
                <td background="/images/tc/tc07.gif">
                </td>
                <td>
                    <img src="/images/tc/tc08.gif" width="9" height="9" />
                </td>
            </tr>
        </table>
    </div>
</div>
<%} %>
<%   break;
      case "hlx":%>
<%if (hlxarray.Length > 0 && hlxarray[0] != null)
  { %>
<div style="padding: 10px 0px 10px 0px; margin: 0px auto; width: 98%;">
    <table>
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <td align="left" width="2%">
                <img width="18" height="19" src="/images/sub/subico010.gif" />
            </td>
            <td width="98%" class="dblack">
                <p>
                    <%=Resources.SunResource.DEVICE_MONITOR_HLX%><a class="dbl" href="#" /></p>
            </td>
        </tr>
    </table>
    <div>
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
                            for (int i = 0; i < hlxarray.Length; i++)
                            {
                                Hashtable table = hlxarray[i] as Hashtable;
                                if (table == null)
                                    continue;
                        %>
                        <tr height="35">
                            <td class="down_line0<%=i%2 %>">
                                <%=table["plant"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["unit"]%>
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
                <td background="/images/tc04.gif">
                    &nbsp;
                </td>
                <td align="center" height="36" bgcolor="#FFFFFF">
                    <span class="pagefy">
                        <%if ((hlxpage.IsFirst) == false)
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change('1','hlx')">&lt;&lt;</a>
                        </span>
                        <%} %>
                        <%if ((hlxpage.IsPre))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=hlxpage.PageIndex-1%>,'hlx')">
                            <%=Resources.SunInfoResource.PAGE_PRE%></a> </span>
                        <%} %>
                        <span>
                            <%=hlxpage.PageIndex%>/<%=hlxpage.PageCount%></span>
                        <%if ((hlxpage.IsNext))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=hlxpage.PageIndex+1%>,'hlx')">
                            <%=Resources.SunInfoResource.PAGE_NEXT%></a> </span>
                        <%} %>
                        <%if ((hlxpage.IsLast) == false)
                          { %>
                        <span><a onclick="change(<%=hlxpage.PageCount%>,'hlx')" class="green" href="javascript:void(0)">
                            &gt;&gt;</a></span>
                        <%} %>
                    </span>
                </td>
                <td background="/images/tc05.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="9" height="9">
                    <img src="/images/tc/tc06.gif" width="9" height="9" />
                </td>
                <td background="/images/tc/tc07.gif">
                </td>
                <td>
                    <img src="/images/tc/tc08.gif" width="9" height="9" />
                </td>
            </tr>
        </table>
    </div>
</div>
<%} %>
<%  break;
      case "cab":%>
<%if (cabarray.Length > 0 && cabarray[0] != null)
  { %>
<div style="padding: 10px 0px 10px 0px; margin: 0px auto; width: 98%;">
    <table>
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <td align="left" width="2%">
                <img width="18" height="19" src="/images/sub/subico010.gif" />
            </td>
            <td width="98%" class="dblack">
                <p>
                    <%=Resources.SunResource.DEVICE_MONITOR_CABINET%><a class="dbl" href="#" /></p>
            </td>
        </tr>
    </table>
    <div>
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
                            <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                <strong>
                                    <%=Resources.SunResource.PLANT_REPORTCONFIG_PLANT_NAME%></strong>
                            </td>
                            <td width="25%" bgcolor="#F3F3F3" class="lbtt">
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
                        </tr>
                        <%
                            for (int i = 0; i < cabarray.Length; i++)
                            {
                                Hashtable table = cabarray[i] as Hashtable;
                                if (table == null)
                                    continue;
                        %>
                        <tr height="35">
                            <td class="down_line0<%=i%2 %>">
                                <%=table["plant"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["unit"]%>
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
                <td background="/images/tc04.gif">
                    &nbsp;
                </td>
                <td align="center" height="36" bgcolor="#FFFFFF">
                    <span class="pagefy">
                        <%if ((cabpage.IsFirst) == false)
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change('1','cab')">&lt;&lt;</a>
                        </span>
                        <%} %>
                        <%if ((cabpage.IsPre))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=cabpage.PageIndex-1%>,'cab')">
                            <%=Resources.SunInfoResource.PAGE_PRE%></a> </span>
                        <%} %>
                        <span>
                            <%=cabpage.PageIndex%>/<%=cabpage.PageCount%></span>
                        <%if ((cabpage.IsNext))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=cabpage.PageIndex+1%>,'cab')">
                            <%=Resources.SunInfoResource.PAGE_NEXT%></a> </span>
                        <%} %>
                        <%if ((cabpage.IsLast) == false)
                          { %>
                        <span><a onclick="change(<%=cabpage.PageCount%>,'cab')" class="green" href="javascript:void(0)">
                            &gt;&gt;</a></span>
                        <%} %>
                    </span>
                </td>
                <td background="/images/tc05.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="9" height="9">
                    <img src="/images/tc/tc06.gif" width="9" height="9" />
                </td>
                <td background="/images/tc/tc07.gif">
                </td>
                <td>
                    <img src="/images/tc/tc08.gif" width="9" height="9" />
                </td>
            </tr>
        </table>
    </div>
</div>
<%} %>
<%  break;
      case "db":%>
<%if (dbarray.Length > 0 && dbarray[0] != null)
  { %>
<div style="padding: 10px 0px 10px 0px; margin: 0px auto; width: 98%;">
    <table>
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <td align="left" width="2%">
                <img width="18" height="19" src="/images/sub/subico010.gif" />
            </td>
            <td width="98%" class="dblack">
                <p>
                    <%=Resources.SunResource.DEVICE_MONITOR_AMMETER%><a class="dbl" href="#" /></p>
            </td>
        </tr>
    </table>
    <div>
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
                            for (int i = 0; i < dbarray.Length; i++)
                            {
                                Hashtable table = dbarray[i] as Hashtable;
                                if (table == null)
                                    continue;
                        %>
                        <tr height="35">
                            <td class="down_line0<%=i%2 %>">
                                <%=table["plant"]%>
                            </td>
                            <td class="down_line0<%=i%2 %>">
                                <%=table["unit"]%>
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
                <td background="/images/tc04.gif">
                    &nbsp;
                </td>
                <td align="center" height="36" bgcolor="#FFFFFF">
                    <span class="pagefy">
                        <%if ((dbpage.IsFirst) == false)
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change('1','db')">&lt;&lt;</a>
                        </span>
                        <%} %>
                        <%if ((dbpage.IsPre))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=dbpage.PageIndex-1%>,'db')">
                            <%=Resources.SunInfoResource.PAGE_PRE%></a> </span>
                        <%} %>
                        <span>
                            <%=dbpage.PageIndex%>/<%=dbpage.PageCount%></span>
                        <%if ((cabpage.IsNext))
                          { %>
                        <span><a class="green" href="javascript:void(0)" onclick="change(<%=dbpage.PageIndex+1%>,'db')">
                            <%=Resources.SunInfoResource.PAGE_NEXT%></a> </span>
                        <%} %>
                        <%if ((cabpage.IsLast) == false)
                          { %>
                        <span><a onclick="change(<%=dbpage.PageCount%>,'db')" class="green" href="javascript:void(0)">
                            &gt;&gt;</a></span>
                        <%} %>
                    </span>
                </td>
                <td background="/images/tc05.gif">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="9" height="9">
                    <img src="/images/tc/tc06.gif" width="9" height="9" />
                </td>
                <td background="/images/tc/tc07.gif">
                </td>
                <td>
                    <img src="/images/tc/tc08.gif" width="9" height="9" />
                </td>
            </tr>
        </table>
    </div>
</div>
<%} %>
<%  break;
      default:
  break;
  }
%>
