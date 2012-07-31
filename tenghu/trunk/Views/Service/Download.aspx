<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.Tenghu.Domain.Video>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>保养资料下载</title>
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script>
        function changePage(index) {
            window.location.href ="/service/download?page=" + index;
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
	  
	  <div class="ny_banner"><img src="/img/banner/banner_24.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">新闻动态</div>
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
              <div class="left_dh04"><a href="/product" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
            <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>			</td>
            <td width="753" rowspan="2" valign="top" class="tdp"><div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="/service" class="lz">服务</a> &gt; 保养资料下载 </div>
              <div class="nbu">
			<%Html.RenderPartial("mainpage");%>
	 			  </div>
						 <div class="rnewlist">
						 <ul>
						 <%foreach (var item in Model)
         {
             if (string.IsNullOrEmpty(item.path))
             { %>
								 <li><a href="#"  onclick="javascript:alert('文件不存在');" class="list_l">·<%=item.name%></a><a  href="#"  onclick="javascript:alert('文件不存在');"  class="list_r"><img src="/img/ny/drive-download.gif" width="16" height="16"  style="border:none;"/>点击下载</a></li>
        <%}
             else
             {%>
								 <li><a href="/service/downfile/<%=item.id %>" class="list_l">·<%=item.name%></a><a  href="/service/downfile/<%=item.id %>"  class="list_r"><img src="/img/ny/drive-download.gif" width="16" height="16"  style="border:none;"/>点击下载</a></li>
            
    <%}
         }%>
						 </ul>
				  </div>
						 <div class="nbu">
			<%Html.RenderPartial("mainpage");%>
                         
			      </div></td>
            </tr>
          <tr>
            <td valign="bottom">
			<div class="ny_top"><a href="#"><img src="/img/ny/click_up.jpg" width="40" height="15" border="0" /></a></div>			</td>
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
