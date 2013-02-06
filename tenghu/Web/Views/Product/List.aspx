<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%= (ViewData["descr"] as Category).name%></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/ny.css" rel="stylesheet" type="text/css" />

    <script src="/script/jquery.js" type="text/javascript"></script>
    
    <script>
        function changePage(index) {
            window.location.href = "<%=Request.Url.ToString().Substring(0, Request.Url.ToString().Contains('?') ? Request.Url.ToString().LastIndexOf('?') : Request.Url.ToString().Length) %>?page=" + index;
        }   
    
</script>


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
	  
	  <div class="ny_banner"><img src="/img/banner/banner_<%= (ViewData["descr"] as Category).id%>.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">产品展示</div>
              <div class="left_dh02">
                <ul id="lmenu">
           	<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
        { %>
			<li><a href="/product.aspx/list/<%=cat.id %>">+ <%=cat.name %></a></li>
			<%} %>
                </ul>
              </div>
              <div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
            <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="/product.aspx" class="lz">产品展示</a> &gt; <%= (ViewData["descr"] as Category).name%></div>
			<div class="rbox01">
			  <div class="rbox01_ico">
                <div class="sl">产品</div>
			    <div class="sr"></div>
			    </div>
			  <div class="rbox01_m">
			<div class="rbox01_ml"><img src="<%=(ViewData["descr"] as Category).img %>" width="136" height="83" /></div>
			<div class="rbox01_mr">
			
			
			<%= (ViewData["descr"] as Category).text%>
			    
			    </div>
			</div>
			  <div class="zllist">
			    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
                   <% foreach (Category cate in (ViewData["descr"] as Category).ChildCategory)
                       { %>
                      <tr>
                    <td colspan="4" class="zllist_tt"><%=cate.name %> </td>
                    </tr>
                    
                    <%int i = 0;
                      foreach (Product product in ViewData["products"] as IList<Product>)
                      {
                          if (product.pid.Equals(cate.id) == false)
                              continue;
                          i++; %>
                    
                  <tr>
                    <td width="38%" class="lbg0<%=i%2+1 %>"><a href="/product.aspx/view/<%=product.id %>"><%=product.name %></a></td>
                    <td width="19%" class="lbg0<%=i%2+1 %>"><a target="_blank" href="/product.aspx/view/<%=product.id %>"><img src="/img/ny/moreimg.gif" width="66" height="18" border="0" /></a></td>
                    <td width="21%" class="lbg0<%=i%2+1 %>"><a href="/product.aspx/file/<%=product.id %>"><img src="/img/ny/pngimg.gif" width="102" height="18" border="0" /></a></td>
                    <td width="22%" class="lbg0<%=i%2+1 %>"> <a href="/product.aspx/buy/<%=product.id %>"><img src="/img/ny/buyimg.gif" width="64" height="18" border="0" /></a> </td>
                  </tr>
                  
                  
                       <%} %>
                  
                    
                  <%} %>
                </table>
			  </div>
			  <div class="nbu">
               <% Html.RenderPartial("mainpage"); %>
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
