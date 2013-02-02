﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.Tenghu.Domain.Job>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>联系我们</title>
    <meta name="description" content="垂直振动,池州腾虎机械科技有限公司" />
    <meta name="keywords" content="垂直振动,池州腾虎机械科技有限公司" />
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
                            <img src="/img/banner/banner_7.jpg" width="964" height="147" /></div>
                        <div class="midbox">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="210" valign="top">
                                        <div class="left_dh">
                                            <div class="left_dh01">
                                                联系我们</div>
                                            <div class="left_dh02">
                                                <ul id="lmenu">
                                                    <%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                                                      { %>
                                                    <li><a href="<%=cat.url %>">+
                                                        <%=cat.name %></a></li>
                                                    <%} %>
                                                </ul>
                                            </div>
                                            <div class="left_dh04">
                                                <a href="/product" class="lyn">> 最新产品</a></div>
                                            <div class="left_dh04">
                                                <a href="/service/network" class="lyn">> 售后服务网点</a></div>
                                            <div class="left_dh03">
                                            </div>
                                        </div>
                                        <div class="nytel">
                                            <%=WebconfigService.GetInstance().Config.tel %></div>
                                    </td>
                                    <td width="753" rowspan="2" valign="top" class="tdp">
                                        <div class="ny_wz">
                                            <span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt;
                                            <a href="/" class="lz">首页</a> &gt; <a href="/contact" class="lz">联系我们</a></div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    <%=(ViewData["contactUs"] as Category).name%></div>
                                                <div class="sr">
                                                    <a href="/contact/info">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <%=(ViewData["contactUs"] as Category).descr%>
                                            </div>
                                        </div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    人才招聘
                                                </div>
                                                <div class="sr">
                                                    <a href="/contact/job">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <div class="zbu_bg">
                                                    <%foreach (var item in Model)
                                                      { %>
                                                    <div class="zbu">
                                                        <a href="/contact/jobinfo/<%=item.id %>">
                                                            <%=item.name %></a></div>
                                                    <%} %>
                                                </div>
                                                <div style="clear: both;">
                                                    <p>
                                                        <strong>招聘说明</strong></p>
                                                    <p>
                                                        1、 每个招聘职位备注中都注明了该职位的简历投递邮箱，请您将简历投递至该邮箱；</p>
                                                    <p>
                                                        2、 如果您在三个工作日内未收到电话或短信初试通知，则表示您的简历未通过筛选，但简历会保留到公司人才库中；</p>
                                                    <p>
                                                        3、 投递简历时，请在主题注明应聘职位。<br />
                                                    </p>
                                                </div>
                                            </div>
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
