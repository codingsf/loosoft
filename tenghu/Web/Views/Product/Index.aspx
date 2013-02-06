<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>产品展示</title>
    <meta name="description" content="垂直振动压路机,压路机,垂直振动" />
    <meta name="keywords" content="垂直振动压路机,压路机,垂直振动" />
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/ny.css" rel="stylesheet" type="text/css" />

    <script src="/script/jquery.js" type="text/javascript"></script>

</head>
<body>
    <div class="main">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <img src="/img/bg01.png" width="1004" height="14" />
                </td>
            </tr>
            <tr>
                <td background="/img/bg02.png">
                    <div class="mainbody">
                        <%Html.RenderAction("header", "home"); %>
                        <div class="ny_banner">
                            <img src="/img/banner/banner_4.jpg" width="964" height="147" /></div>
                        <div class="midbox">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="210" valign="top">
                                        <div class="left_dh">
                                            <div class="left_dh01">
                                                产品展示</div>
                                            <div class="left_dh02">
                                                <ul id="lmenu">
                                                    <%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                                                      { %>
                                                    <li><a href="/product.aspx/list/<%=cat.id %>">+
                                                        <%=cat.name %></a></li>
                                                    <%} %>
                                                </ul>
                                            </div>
                                            <div class="left_dh04">
                                                <a href="/product.aspx" class="lyn">> 最新产品</a></div>
                                            <div class="left_dh04">
                                                <a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
                                            <div class="left_dh03">
                                            </div>
                                        </div>
                                        <div class="nytel">
                                            <%=WebconfigService.GetInstance().Config.tel %></div>
                                    </td>
                                    <td width="753" rowspan="2" valign="top" class="tdp">
                                        <div class="ny_wz">
                                            <span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt;
                                            <a href="/" class="lz">首页</a> &gt; <a href="#" class="lz">产品展示</a></div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    产品</div>
                                                <div class="sr">
                                                </div>
                                            </div>
                                            <div class="rbox01_m">
                                                秉承“一切为了客户，创造客户价值”的服务理念，以客户需求为中心，用一流的速度、一流的技能、一流的态度实现“超越客户期 望，超越行业标准”的服务目标。通过标准化、差异化、超值化的服务来降低客户的心理成本和使用成本，最终提高客户的过渡价值
                                                赢利能力和购买能力，从而提升服务品牌竞争力，引领行业服务新潮流。
                                            </div>
                                        </div>
                                        <div style="border-top: 1px dotted #B9B8B8; margin: 15px 0px; clear: both;">
                                        </div>
                                        <div class="rbox01_m">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <% int i = 0;
                                                       foreach (Category cat in ViewData["childCat"] as IList<Category>)
                                                       {
                                                           if (i++ % 4 == 0)
                                                           {%>
                                                </tr>
                                                <tr>
                                                    <%} %>
                                                    <td width="25%" align="center">
                                                        <div>
                                                            <div>
                                                                <img src="<%=cat.img %>" width="136" height="83" class="video01" /></div>
                                                            <div class="video02">
                                                                <a href="/product.aspx/list/<%=cat.id %>">
                                                                    <%=cat.name%></a></div>
                                                        </div>
                                                    </td>
                                                    <%}%>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="bottom">
                                        <div class="ny_top">
                                            <a href="#">
                                                <img src="/img/ny/click_up.jpg" width="40" height="15" border="0" /></a></div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <%Html.RenderPartial("footer"); %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="/img/bg03.png" width="1004" height="12" />
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
