<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Video>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Model.name %></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
</head>

<script src="../../script/jquery.js" type="text/javascript"></script>
<body>

<div class="main">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="/img/bg01.png" width="1004" height="14" /></td>
    </tr>
    <tr>
      <td background="/img/bg02.png">
	  <div class="mainbody">
	  <%Html.RenderAction("header","home"); %>
	  
	  <div class="ny_banner"><img src="/img/banner/banner_13.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">新闻动态</div>
              <div class="left_dh02">
                <ul id="lmenu">
                 		<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                     {
                         if (Model.category.id.Equals(cat.id))
                         { %>
			<li><a class="hover" href="<%=cat.url %>">+ <%=cat.name%></a></li>
			<%}
                         else
                         { %>
			<li><a href="<%=cat.url %>">+ <%=cat.name%></a></li>
                         
			<%}
                     }%>
                </ul>
              </div>
              <div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
            <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp"><div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="/news.aspx" class="lz">新闻动态</a> &gt; <%=Model.name %> </div>
              <div>
			<div class="ntt"><%=Model.name %></div>
			<div>
			
			<%=Model.descr %>
			
			
			</div>
			  </div></td>
            </tr>
          <tr>
            <td valign="bottom">
			<div class="ny_top"><a href="#"><img src="/img/ny/click_up.jpg" width="40" height="15" border="0" /></a></div>
			</td>
          </tr>
        </table>
	  </div>
	  <%Html.RenderPartial("footer"); %>
	 
	  </div>
	  </td>
    </tr>
    <tr>
      <td><img src="/img/bg03.png" width="1004" height="12" /></td>
    </tr>
  </table>
</div>

</body>
</html>
