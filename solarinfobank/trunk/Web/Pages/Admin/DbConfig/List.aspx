<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Dbconfig>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
数据分布配置列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">数据配置列表</td>
                </tr>
                <tr>
                  <td> &nbsp; </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <a href="/admin/dbconfig_edit" class="dbl">
                                <img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                        </td>
                        <td width="94%">
                            <a href="/admin/dbconfig_edit" class="dbl">
                                添加</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr>
                                    <td width="9%" align="center">
                                        <strong>
                                            电站编号<strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>
                                            是否启用</strong>
                                    </td>
                                    <td width="19%" align="center">
                                        <strong>
                                            年</strong>
                                    </td>
                                    <td width="26%" align="center">
                                        <strong>
                                            链接地址</strong><span class="f11"></span>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>
                                            操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                                <%
                                    int i = 1;
                                    foreach (var item in Model)
                                    {
                                        i++;
                                            
                                %>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                
                                <tr  >
                                    <td width="9%" height="42" align="center">
                                        <%= Html.Encode(item.id)%>
                                    </td>
                                    <td width="12%" align="center">
                                        <% =Html.Encode(item.isEnabled == true ? "Yes" : "No")%>
                                    </td>
                                    <td width="19%" align="center">
                                        <%= Html.HiddenFor(model => item.id) %>
                                        <%= Html.Encode(item.year)%>
                                    </td>
                                    <td width="26%" align="center">
                                        <div style="width: 200px; overflow: hidden;" title="<%= Html.Encode(item.url)%>">
                                            <%= Html.Encode(item.url)%></div>
                                    </td>
                                    <td width="20%" align="center">
                                        <a href="/admin/dbconfig_edit/<%=item.id%>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="编辑"
                                                title="编辑" /></a> <a href="/admin/dbconfig_delete/<%=item.id%>"
                                                    onclick="return(confirm( '是否确定删除？ '))">
                                                    <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="删除"
                                                        title="删除" /></a>
                                    </td>
                                </tr>
                                 </table>
                                <%}
                                %>
                           
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
