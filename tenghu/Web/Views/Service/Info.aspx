<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.News>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=(ViewData["info"] as Category).name%></title>
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
	  
	  <div class="ny_banner"><img src="/img/banner/banner_<%=(ViewData["info"] as Category).id%>.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top">
			<div class="left_dh">
			<div class="left_dh01">服务</div>
			<div class="left_dh02">
			<ul id="lmenu">
				<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
      { %>
			<li><a href="<%=cat.url %>">+ <%=cat.name%></a></li>
			<%
                    if (cat.ChildCategory != null && cat.ChildCategory.Count > 0)
                    {%>
                    	<li id="llo">
			 <%foreach (var item in cat.ChildCategory)
      { %>
        <a href="<%=item.url %>">&gt;&gt; <%=item.name %> </a>
			  
       <%} %>      
			</li>
			
     <% }
      }   %>
		
            </ul>
</div>
			
			<div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
			<div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
			<div class="left_dh03"></div>
			  </div>
			<div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; 
			<a href="/" class="lz">首页</a> &gt; <a href="/service.aspx" class="lz">服务</a> &gt; 采购配套 &gt; <%=(ViewData["info"] as Category).name%></div>
			<div class="rbox01">
			<div class="rbox01_ico">
			<div class="sl"><%=(ViewData["info"] as Category).name%></div>
			<div class="sr"></div> 
			</div>
			<div class="rbox01_m">
			<%=(ViewData["info"] as Category).descr%>
			
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
