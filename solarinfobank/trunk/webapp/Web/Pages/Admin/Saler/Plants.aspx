<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    电站列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <style type="text/css">
            .am_line01
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
            }</style>

        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <script>
            function changePage(page) {
                window.location.href = '/saler/plants/?index=' + page + "&uname=" + $("#uname").val() + "&install_start=" + $("#install_start").val() + "&install_end=" + $("#install_end").val() + "&plantname=" + $("#plantName").val();

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
                                电站列表
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
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="10%" height="40">
                        安装日期
                    </td>
                    <td width="20%">
                        从:
                        <input id="install_start" name="install_start" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                            readonly="readonly" size="13" type="text" value='<%=Request.QueryString["install_start"]==null?"":Request.QueryString["install_start"] %>'
                            class="txtbu04 Wdate" />
                    </td>
                    <td width="20%" id="country_ctl">
                        到:
                        <input id="install_end" name="install_end" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                            readonly="readonly" size="13" type="text" value='<%=Request.QueryString["install_end"]==null?"":Request.QueryString["install_end"] %>'
                            class="txtbu04 Wdate" />
                    </td>
                    <td width="20%">
                        <input name="Submit" id="checking" type="button" class="subbu01" value="查询" onclick="changePage(1);" />
                    </td>
                    <td width="20%" rowspan="2" align="center" valign="bottom" style="padding-bottom: 5px;">
                    </td>
                </tr>
                <tr>
                    <td width="10%" height="40">
                        电站名:
                    </td>
                    <td width="20%">
                        <input type="text" class="txtbu04 " id="plantName" name="plantName"  value='<%=Request.QueryString["plantName"] %>'/>
                    </td>
                    <td>
                    </td>
                    <td width="20%">
                        <span style="white-space: nowrap">用户名:<input type="text"  value='<%=Request.QueryString["uname"] %>' class="txtbu04 " id="uname" name="uname" /></span>
                    </td>
                    <td width="20%">
                    </td>
                </tr>
            </table>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/images/am/am_bg03.jpg"
                                style="border: 1px solid #DADADA; text-align: center; font-weight: bold;">
                                <tr>
                                    <td width="15%" align="center" class="lir">
                                        电站名
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        用户名
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        安装日期
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        安装功率
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        国家
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        城市
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        付款到期
                                    </td>
                                    <td width="12%" align="center" class="lir">
                                        操作
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <% int i = 0;
                       foreach (Plant plant in Model)
                       {
                           i++;
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="15%" align="center" class="am_line0<%=i%2 %>">
                                        <%=plant.name %>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%=plant.User==null?"":plant.User.username %>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%=plant.installdate.ToShortDateString() %>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= plant.design_power%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= plant.country%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= plant.city%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%=plant.PaymentLimitDate.ToShortDateString() %>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                    <a href="/saler/plant_extend/<%=plant.id %>">延期</a>
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
                                        <a href="/saler/plants_output/?index=<%=(ViewData["page"]  as Pager).PageIndex %>&uname=<%=Request["uname"] %>&install_start=<%=Request["install_start"] %>&install_end=<%=Request["install_end"] %>&plantname=<%=Request["plantname"] %>">
                                            <img src="/images/am/ad_bu01.gif" width="131" height="28" /></a>
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

    <script>        $("#hasplants").val('<%=Request["hasplants"]%>');</script>

</asp:Content>
