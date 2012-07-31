<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>关于腾虎</title>
    <meta name="description" content="垂直振动,池州腾虎机械科技有限公司" />
    <meta name="keywords" content="垂直振动,池州腾虎机械科技有限公司" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
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
                            <img src="/img/banner/banner_2.jpg" width="964" height="147" /></div>
                        <div class="midbox">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="210" valign="top">
                                        <div class="left_dh">
                                            <div class="left_dh01">
                                                关于腾虎</div>
                                            <div class="left_dh02">
                                                <ul id="lmenu">
                                                    <%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                                                      { %>
                                                    <li><a href="/about/more/<%=cat.id %>">+
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
                                            <a href="/" class="lz">首页</a> &gt; <a href="/about" class="lz">关于腾虎</a></div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    企业简介</div>
                                                <div class="sr">
                                                    <a href="/about/more/8">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <div class="rbox01_ml">
                                                    <a href="/about/more/8">
                                                        <img src="<%=(ViewData["jianjie"] as Category).img %>" width="147" height="86" border="0" /></a></div>
                                                <div class="rbox01_mr">
                                                    <%=(ViewData["jianjie"] as Category).text.Length > 180 ? (ViewData["jianjie"] as Category).text.Substring(0, 180) : (ViewData["jianjie"] as Category).text%>...</div>
                                            </div>
                                        </div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    公司文化
                                                </div>
                                                <div class="sr">
                                                    <a href="/about/more/9">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <div class="rbox01_ml">
                                                    <a href="/about/more/9">
                                                        <img src="<%=(ViewData["wenhua"] as Category).img %>" width="147" height="86" border="0" /></a></div>
                                                <div class="rbox01_mr">
                                                    <%=(ViewData["wenhua"] as Category).text.Length > 180 ? (ViewData["wenhua"] as Category).text.Substring(0, 180) : (ViewData["wenhua"] as Category).text%>...</div>
                                            </div>
                                        </div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    管理团队
                                                </div>
                                                <div class="sr">
                                                    <a href="/about/more/10">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <div class="rbox01_ml">
                                                    <a href="/about/more/10">
                                                        <img src="<%=(ViewData["guanli"] as Category).img %>" width="147" height="86" border="0" /></a></div>
                                                <div class="rbox01_mr">
                                                    <%=(ViewData["guanli"] as Category).text.Length > 180 ? (ViewData["guanli"] as Category).text.Substring(0, 180) : (ViewData["guanli"] as Category).text%>...</div>
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
