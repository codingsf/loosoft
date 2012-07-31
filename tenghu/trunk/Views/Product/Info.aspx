<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>产品信息</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
</head>
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
	  
	  <div class="ny_banner"><img src="/img/banner/banner_<%=(ViewData["info"] as Category).id %>.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">产品展示</div>
              <div class="left_dh02">
                <ul id="lmenu">
                	<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
                { %>
			<li><a href="/product/list/<%=cat.id %>">+ <%=cat.name %></a></li>
			        <%} %>
                </ul>
              </div>
              <div class="left_dh04"><a href="/product" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
              <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> > <a href="/home" class="lz">首页</a>  > <a href="/product" class="lz">产品展示</a> >  <%=(ViewData["info"] as Category).name %></div>
			<div>
			<div class="ntt"><%=(ViewData["info"] as Category).name%></div>
			<div>
			<div class="nabout">
			<%=(ViewData["info"] as Category).descr %>
			
			
				 </div>
	 
	 
	 </div>
			</div>
			
			</td>
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
