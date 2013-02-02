<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>新闻动态</title>
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
                            <img src="/img/banner/banner_3.jpg" width="964" height="147" /></div>
                        <div class="midbox">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="210" valign="top">
                                        <div class="left_dh">
                                            <div class="left_dh01">
                                                新闻动态</div>
                                            <div class="left_dh02">
                                                <ul>
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
                                            <a href="/" class="lz">首页</a> &gt; <a href="/news" class="lz">新闻动态</a></div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    企业新闻
                                                </div>
                                                <div class="sr">
                                                    <a href="/news/more/11">
                                                        <img src="/img/ny/more.jpg" width="39" border="0" style="height: 7px" /></a></div>
                                            </div>
                                            <% if ((ViewData["qiye"] as IList<News>).Count >= 1)
                                               { %>
                                            <div class="rbox01_m">
                                                <div>
                                                    <div class="nl02_img">
                                                        <a href="/news/info/<%=(ViewData["qiye"] as IList<News>)[0].id  %>">
                                                            <img src="<%=(ViewData["qiye"] as IList<News>)[0].imgUrl  %>" width="79" height="46"
                                                                border="0" /></a></div>
                                                    <div class="nl02_rn">
                                                        <div>
                                                            <a href="/news/info/<%=(ViewData["qiye"] as IList<News>)[0].id  %>"><strong>
                                                                <%=(ViewData["qiye"] as IList<News>)[0].title  %></strong></a></div>
                                                        <div class="lbla">
                                                            <%=(ViewData["qiye"] as IList<News>)[0].text.Length > 80 ? (ViewData["qiye"] as IList<News>)[0].text.Substring(0, 80) : (ViewData["qiye"] as IList<News>)[0].text%>...</div>
                                                    </div>
                                                </div>
                                                <div class="nl02_dn">
                                                    <ul>
                                                        <%for (int i = 1; i < (ViewData["qiye"] as IList<News>).Count; i++)
                                                          {
                                                              if (i % 2 == 0)
                                                              {
                                                        %>
                                                        <li class="nbg"><a href="/news/info/<%=(ViewData["qiye"] as IList<News>)[i].id  %>">
                                                            ·<%=(ViewData["qiye"] as IList<News>)[i].title%></a></li>
                                                        <%}
                      else
                      { %>
                                                        <li><a href="/news/info/<%=(ViewData["qiye"] as IList<News>)[i].id  %>">·<%=(ViewData["qiye"] as IList<News>)[i].title%></a></li>
                                                        <%}
                  } %>
                                                    </ul>
                                                </div>
                                            </div>
                                            <%} %>
                                        </div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    产品新闻
                                                </div>
                                                <div class="sr">
                                                    <a href="/news/more/12">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <% if ((ViewData["chanpin"] as IList<News>).Count >= 1)
                                               { %>
                                            <div class="rbox01_m">
                                                <div>
                                                    <div class="nl02_img">
                                                        <a href="/news/info/<%=(ViewData["chanpin"] as IList<News>)[0].id  %>">
                                                            <img src="<%=(ViewData["chanpin"] as IList<News>)[0].imgUrl  %>" width="79" height="46"
                                                                border="0" /></a></div>
                                                    <div class="nl02_rn">
                                                        <div>
                                                            <a href="/news/info/<%=(ViewData["chanpin"] as IList<News>)[0].id  %>"><strong>
                                                                <%=(ViewData["chanpin"] as IList<News>)[0].title%></strong></a></div>
                                                        <div class="lbla">
                                                            <%=(ViewData["chanpin"] as IList<News>)[0].text.Length > 80 ? (ViewData["chanpin"] as IList<News>)[0].text.Substring(0, 80) : (ViewData["chanpin"] as IList<News>)[0].text%>...</div>
                                                    </div>
                                                </div>
                                                <div class="nl02_dn">
                                                    <ul>
                                                        <%for (int i = 1; i < (ViewData["chanpin"] as IList<News>).Count; i++)
                                                          {
                                                              if (i < 5)
                                                                  break;
                                                              if (i % 2 == 0)
                                                              {
                                                        %>
                                                        <li class="nbg"><a href="/news/info/<%=(ViewData["chanpin"] as IList<News>)[i].id  %>">
                                                            ·<%=(ViewData["chanpin"] as IList<News>)[i].title%></a></li>
                                                        <%}
                      else
                      { %>
                                                        <li><a href="/news/info/<%=(ViewData["chanpin"] as IList<News>)[i].id  %>">·<%=(ViewData["chanpin"] as IList<News>)[i].title%></a></li>
                                                        <%}
                  } %>
                                                    </ul>
                                                </div>
                                            </div>
                                            <%} %>
                                        </div>
                                        <div class="rbox01">
                                            <div class="rbox01_ico">
                                                <div class="sl">
                                                    视频新闻
                                                </div>
                                                <div class="sr">
                                                    <a href="/news/video">
                                                        <img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div>
                                            </div>
                                            <div class="rbox01_m">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <%int x = 0;
                                                          foreach (Video video in ViewData["video"] as IList<Video>)
                                                          {
                                                              x++;
                                                              if (x > 4)
                                                                  break; %>
                                                        <td width="25%" align="center">
                                                            <div>
                                                                <div>
                                                                    <a href="/video/view/<%=video.id %>">
                                                                        <img src="/video/file/<%=video.pic %>" width="136" height="83" class="video01" /></a></div>
                                                                <div class="video02">
                                                                    <a href="/video/view/<%=video.id %>">
                                                                        <%=video.name %></a></div>
                                                            </div>
                                                        </td>
                                                        <%}
                      while (x++ < 4)
                      {
                                                        %>
                                                        <td width="25%" align="center">
                                                            <%} %>
                                                    </tr>
                                                </table>
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
