<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td background="/images/kj/kjbg01.jpg" valign="top" width="793">
  <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0" width="100%" height="63">
          <tbody><tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63"></td>
            <td width="777">
            
            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center" height="35"><img src="/images/kj/kjiico01.gif" width="31" height="41"/></td>
                  <td class="pv0216"><%=Resources.SunResource.ADMIN_USER_LIST_USER_LIST%></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table>
            
            
            
            </td>
            <td align="right" width="6"><img src="/images/kj/kjico03.jpg" width="6" height="63"></td>
          </tr>
        </tbody></table>
        <div class="subrbox01">
            <div>
                <table border="0" cellpadding="0" cellspacing="0" width="90%" height="30">
                    <tbody><tr>
                        
                        <td align="center" width="6%">

                            <a href="/user/adduser" class="dbl"><img src="/images/sub/subico016.gif" alt="Add" title="<%=Resources.SunResource.MONITORITEM_ADD %>" width="15" height="16"></a>
                        </td>
                        <td width="94%">
                            <a href="/user/adduser" class="dbl"><%=Resources.SunResource.MONITORITEM_ADD %></a>
                        </td>
                        
                    </tr>
                </tbody></table>
            </div>

            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody><tr>
                        <td>
                            <table class="subline02" border="0" cellpadding="0" cellspacing="0" width="100%" height="25">
                                <tbody><tr>
                                <td align="center" width="25%">

                                        <strong><%=Resources.SunResource.PLANT_UNIT_EDIT_USERNAME%></strong><span class="f11"></span>
                                    </td>
                                    <td align="center" width="20%">
                                        <strong><%=Resources.SunResource.USER_PLANTUSER_ROLE%></strong>
                                    </td>
                                    <td align="center" width="30%">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_EMAIL%></strong>

                                    </td>
                               
                                    <td align="center" width="25%">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_OPERATION%></strong>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line00">
                                <tr>
                                    <td width="25%" height="35" align="center">
                                     <div title="<%= Model.username %>" style="width:180px; overflow:hidden">
                                    <img src="/images/sub/user_mature.gif" /> <%=Html.Encode( Model.username)%></div>
                                    </td>
                                    <td width="20%" align="center">
                                            <%=Html.Encode(Model.UserRole.Role.displayName)%>
                                     
                                    </td>
                                    <td width="30%" align="center">
                                      <div style="width:220; overflow:hidden"> <%=Html.Encode(Model.email)%></div>
                                     
                                    </td>
                                    <td width="25%" align="center">
                                        <img alt="<%=Resources.SunResource.CUSTOMREPORT_VIEW %>" title="<%=Resources.SunResource.CUSTOMREPORT_VIEW %>" src="/Images/sub/ck00.gif" border="0" height="16" width="16">
                                        <a href="/user/edit">
                                        <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.PLANT_REPORTCONFIG_EDIT %>" title="<%=Resources.SunResource.PLANT_REPORTCONFIG_EDIT %>" border="0" width="16" height="16"></a>
                                        <img src="/images/sub/view_c00.gif"  border="0" width="16" height="16" alt="<%=Resources.SunResource.USERS_ASSIGN_PLANT %>" title="<%=Resources.SunResource.USERS_ASSIGN_PLANT %>">
                                        <img src="/images/sub/cross00.gif" title="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" alt="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" border="0" width="16" height="16">
                                   </td>
                                </tr>
                            </table>
                        </td>
                    </tr>                
                    <% int i = 0;
                        foreach (var user in Model.ChildUsers)
                       {
                           i++;
                             %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                <tr>
                                    <td width="25%" height="35" align="center">
                                    <div title="<%=user.username %>" style="width:180px; overflow:hidden">
                                    <%=user.username %></div>
                                    </td>
                                    <td width="20%" align="center">
                                    <%=user.UserRole.Role.displayName %>
                                    </td>
                                    <td width="30%" align="center">
                                      <div style="width:220; overflow:hidden"> <%=user.email %></div>
                                     
                                    </td>
                                    <td width="25%" align="center">
                                    
                                    <a href="/user/viewinfo/<%=user.id %>"><img alt="<%=Resources.SunResource.CUSTOMREPORT_VIEW %>" title="<%=Resources.SunResource.CUSTOMREPORT_VIEW %>" src="/Images/sub/ck.gif" border="0" height="16" width="16"></a>
                                    
                                    
                                       <a href="/user/useredit?uid=<%=user.id %>&role=<%=user.UserRole.Role.id %>">
                                            <img src="/images/sub/pencil.gif" alt="<%=Resources.SunResource.PLANT_REPORTCONFIG_EDIT %>" title="<%=Resources.SunResource.PLANT_REPORTCONFIG_EDIT %>" border="0" width="16" height="16"></a>
                     <a href="/user/userplants?uid=<%=user.id %>">
                                            <img src="/images/sub/view_c.gif"  border="0" width="16" height="16" alt="<%=Resources.SunResource.USERS_ASSIGN_PLANT %>" title="<%=Resources.SunResource.USERS_ASSIGN_PLANT %>"></a>
                                        <a href="/user/deleteuser/?uid=<%=user.id %>">
                                            <img src="/images/sub/cross.gif" onclick="return confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE %>');" title="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" alt="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" border="0" width="16" height="16"></a>
                                        
                                    </td>
                                
                                    
                             
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    
                    
                    
                    
                    <%} %>
                </tbody></table>
            </div>

            <div class="sb_down">
            </div>
        </div>
    </td>
    </tr>
</table>    