<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Role>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.SHARED_INSIDE_PLANT_USER%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td background="/images/kj/kjbg01.gif" valign="top" width="793">
                <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0"
                    width="100%" height="63">
                    <tbody>
                        <tr>
                            <td width="8">
                                <img src="/images/kj/kjico02.jpg" width="8" height="63">
                            </td>
                            <td width="777">
                                <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="7%" rowspan="2" align="center" height="35">
                                            <img src="/images/kj/kjiico01.gif" />
                                        </td>
                                        <td class="pv0216">
                                            角色列表
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
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;
                                        </td>
                                        <td width="18%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" width="6">
                                <img src="/images/kj/kjico03.jpg" width="6" height="63">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="subrbox01">
                    <div>
                        <table border="0" cellpadding="0" cellspacing="0" width="90%" height="30">
                            <tbody>
                                <tr>
                                    <td align="center" width="6%">
                                        <a href="/user/auth" class="dbl">
                                            <img src="/images/sub/subico016.gif" alt="Add" title="<%=Resources.SunResource.MONITORITEM_ADD %>"
                                                width="15" height="16"></a>
                                    </td>
                                    <td width="94%">
                                        <a href="/user/auth" class="dbl">
                                            <%=Resources.SunResource.MONITORITEM_ADD %></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                                <tr>
                                    <td>
                                        <table class="subline02" border="0" cellpadding="0" cellspacing="0" width="100%"
                                            height="25">
                                            <tbody>
                                                <tr>
                                                    <td align="center" width="50%">
                                                        <strong>角色名称</strong><span class="f11"></span>
                                                    </td>
                                                    <td align="center" width="50%">
                                                        <strong>操作</strong>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <% int i = 0;
                                   foreach (var item in Model)
                                   {
                                       i++;
                                %>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                            <tr>
                                                <td width="50%" height="35" align="center">
                                                    <div title="" style="width: 180px; overflow: hidden">
                                                        <%=item.name %>
                                                    </div>
                                                </td>
                                                <td width="50%" align="center">
                                                    <a onclick="return confirm('你确定要删除吗？')" href="/user/delrole/<%=item.id %>">
                                                        <img src="/images/sub/cross.gif" alt="删除" title="删除" border="0" height="16" width="16"></a>
                                                        <a href="/user/auth/<%=item.id %>">
                                            <img src="/images/sub/pencil.gif" alt="编辑" title="编辑" border="0" height="16" width="16"></a>
                                                </td>
                                            </tr>
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
            </td>
        </tr>
    </table>
</asp:Content>
