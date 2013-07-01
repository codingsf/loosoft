<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.CommonInfo>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
<style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
        <script>
            function changePage(page) {
                window.location.href = '/admin/currencies/' + page;
            }
        </script>

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
                                货币列表
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
                                    <td width="25%" align="center">
                                        <strong>编号</strong>
                                    </td>
                                    <td width="25%" align="center">
                                        <strong>货币符号</strong>
                                    </td>
                                    <td width="25%" align="center">
                                        <strong>货币简称</strong>
                                    </td>
                                    <td width="25%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                        int i = 0;
                        foreach (CommonInfo item in Model)
                        {
                            i++;%>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            
                                <tr>
                                    <td width="25%" align="center"  class="am_line0<%=i%2 %>">
                                        <%=i %>
                                    </td>
                                    <td width="25%" align="center"  class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.code)%>
                                    </td>
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.name) %>
                                    </td>
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "currency_edit"))
                                          { %>
                                        <a href="/admin/currency_edit/<%=item.id %>">
                                            <img src="/images/sub/pencil.gif" alt="Delete" title="编辑" height="16" border="0"
                                                width="16"></a>
                                        <%} %>
                                        
                                        
                                        
                                        <%if (AuthService.isAllow("admin", "currency_del"))
                                          { %>
                                        <a onclick="return confirm('你确定删除吗?')" href="/admin/currency_del/<%=item.id %>">
                                            <img src="/images/sub/cross.gif" alt="Delete" title="删除" height="16" border="0" width="16"></a>
                                            
                                            <%}
                                          else
                                          { %>
                                          <img src="/images/sub/nodelete.gif" alt="Delete" title="删除" height="16" border="0" width="16">
                                          <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="30%">
                    <%if (AuthService.isAllow("admin", "currency_add"))
                      { %>
                    <a href="/admin/currency_add/"> <img src="/images/am/ad_bu02.gif" width="131" height="28" /></a>
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
    所有货币列表 - SolarInfoBank
</asp:Content>
