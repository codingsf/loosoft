<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Language>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
       
       <style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
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
                            <td width="93%" class="pv0216">
                                语言列表
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="6" align="right">
                    <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                </td>
            </tr>
        </table>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="9%" align="center">
                                        <strong>名称</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>启用</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>编码</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>显示名称</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>货币</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>操作</strong>
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
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9%"  align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.name)%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <% =Html.Encode(item.isenabled == true ? "Yes" : "No")%>
                                    </td>
                                    <td width="20%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.HiddenFor(model => item.id) %>
                                        <%= Html.Encode(item.codename)%>
                                    </td>
                                    <td width="20%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.displayName)%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.currencies)%>
                                    </td>
                                    <td width="20%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "language_edit"))
                                          { %>
                                        <a href="/admin/language_edit/<%=item.id%>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="编辑" title="编辑" /></a>
                                        <%} %>
                                        &nbsp;&nbsp;&nbsp;
                                        <%if (AuthService.isAllow("admin", "language_delete"))
                                          { %>
                                        <a href="/admin/language_delete/?id=<%=item.id%>&language=<%=item.name %>" onclick="<%=item.isEdited?"return confirm( '确人删除 ？ ')":"confirm( 'donot deleted default language'); return false;" %>">
                                            <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="删除" title="删除" /></a>
                                        <%}
                                          else
                                          { %>
                                        <img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="删除" title="删除" />
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                            <%}
                            %>
                        </td>
                    </tr>
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="30%">
                     <%if (AuthService.isAllow("admin", "language_upload"))
              { %>
                    <a href="/admin/language_upload/"> <img src="/images/am/ad_bu011.gif" width="131" height="28" /></a>
                    <%} %>
                    </td>
                    <td width="70%">
                    </td>
                  </tr>
                </table></td>
              </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    语言列表 - SolarInfoBank
</asp:Content>
