<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.MTinfounit>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    信息单元地址定义列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <style type="text/css">
            <!
            -- .am_line01
            {
                border-bottom: 1px solid #E9E9E9;
                line-height: 25px;
                background: #F7F7F7;
                text-align: center;
            }
            .am_line00
            {
                border-bottom: 1px solid #DFDFDF;
                line-height: 25px;
                background: #fff;
                text-align: center;
            }
            .lir
            {
                background: url(//images/am/ad_line.gif) right no-repeat;
            }
            -- ></style>

        <script>
            function changePage(page) {
                window.location.href = '/mtinfounit/list/?pn=' + page;
            }
        </script>

        <%=Html.Hidden("pageNo", ViewData["pageNo"]) %>
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif" />
                            </td>
                            <td width="93%" class="pv0216">
                                信息单元地址定义列表
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
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/images/am/am_bg03.jpg"
                                style="border: 1px solid #DADADA; text-align: center; font-weight: bold;">
                                <tr>
                                    <td width="25%" align="center" class="lir">
                                        编号
                                    </td>
                                    <td width="25%" align="center" class="lir">
                                        信息地址
                                    </td>
                                    <td width="25%" align="center" class="lir">
                                        默认名称
                                    </td>
                                    <td width="25%" align="center" class="lir">
                                        操作
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    
                    
                     <% int i = 0;
                       foreach (MTinfounit item in Model)
                       {
                           i++;
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <%=i %>
                                    </td>
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <%= item.addressCode%>
                                    </td>
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <%= item.defaultName%>
                                    </td>
                                 
                                    <td width="25%" align="center" class="am_line0<%=i%2 %>">
                                        <a href="/mtinfounit/edit/<%=item.id %>" >
                                            <img src="/images/sub/pencil.gif" alt="编辑" title="编辑" /></a>
                                            
                                        <a href="/mtinfounit/delete/<%=item.id %>" onclick="return confirm('您确定要删除吗')">
                                            <img src="/images/sub/cross.gif" alt="删除" title="删除" /></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    
                    
                    
                    <tr>
                        <td height="36" colspan="5" background="/images/am/am_bg02.jpg">
                            <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="30%">
                                        <a href="/mtinfounit/edit">
                                            <img src="/images/am/ad_bu16.gif" width="131" height="28" /></a>
                                    </td>
                                    <td width="70%">
                                        <%Html.RenderPartial("mpage"); %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
