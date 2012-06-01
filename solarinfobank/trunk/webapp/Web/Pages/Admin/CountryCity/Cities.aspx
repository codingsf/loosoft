﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CountryCity>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
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
        <script>

            $(document).ready(function() {
                $('#country').change(function() {
                    window.location.href = "/admin/cities/" + $(this).val();
                });
            });
            function changePage(page) {
                window.location.href = '/admin/countrycity/' + page;
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
                                城市列表
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
            <div>
                <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="70%">
                            <select id="country">
                                <% foreach (CountryCity country in ViewData["countries"] as IList<CountryCity>)
                                   {
                                       if (country.id.Equals(Model.id))
                                       {
                                %>
                                <option value="<%=country.id %>" selected="selected">
                                    <%=country.name%></option>
                                <%}
                           else
                           { %>
                                <option value="<%=country.id %>">
                                    <%=country.name%></option>
                                <%} %>
                                <%} %>
                            </select>
                        </td>
                        <td width="5%" align="center">
                            <a href="/admin/countries" class="dbl">
                                <img src="/images/sub/tzimh.gif" width="15" height="16" /></a>
                        </td>
                        <td width="10%">
                            <%if (AuthService.isAllow("admin", "countries"))
                              { %>
                            <a href="/admin/countries/" class="dbl">返回国家列表</a>
                            <%} %>
                        </td>
                        <td width="5%" align="center">
                            <%if (AuthService.isAllow("admin", "city_add"))
                              { %>
                            <a href="/admin/city_add/?cid=<%=Model.id %>" class="dbl">
                                <img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                            <%} %>
                        </td>
                        <td width="10%">
                            <%if (AuthService.isAllow("admin", "city_add"))
                              { %>
                            <a href="/admin/city_add/?cid=<%=Model.id %>" class="dbl">添加城市</a>
                            <%} %>
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
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="15%" align="center">
                                        <strong>城市名称</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>雅虎天气Code</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>夏令时开始时间</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>夏令时结束时间</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>提前小时</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                        int i = 1;
                        foreach (CountryCity item in Model.Cities)
                        {
                            i++;%>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="15%" align="center"  class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.name) %>
                                    </td>
                                    <td width="15%" align="center"  class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.weather_code) %>
                                    </td>
                                    <td width="15%" align="center"  class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.startdate) %>
                                    </td>
                                    <td width="15%" align="center" class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.enddate) %>
                                    </td>
                                    <td width="15%" align="center" class="am_line0<%=i%2 %>">
                                        <%=Html.Encode(item.hours) %>
                                    </td>
                                    <td width="15%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "city_edit"))
                                          { %>
                                        <a href="/admin/city_edit/<%=item.id %>">
                                            <img src="/images/sub/pencil.gif" alt="Delete" title="编辑" height="16" border="0"
                                                width="16"></a>
                                        <%} %>
                                          <%if (AuthService.isAllow("admin", "city_del"))
                                            { %>
                                        <a onclick="return confirm('你确定删除吗?')" href="/admin/city_del/<%=item.id %>?cid=<%=Model.id %>">
                                            <img src="/images/sub/cross.gif" alt="删除" title="删除" height="16" border="0" width="16"></a>
                                            <%}
                                            else
                                            { %>
                                            <img src="/images/sub/nodelete.gif" alt="删除" title="删除" height="16" border="0" width="16">
                                            <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    国家 城市 - SolarInfoBank
</asp:Content>