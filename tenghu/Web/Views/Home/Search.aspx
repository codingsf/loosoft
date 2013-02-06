<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DataLinq.News>>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>腾虎 科技铸就未来</title>
<link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
    <script>
    function changePage(index) {
        window.location.href =  '/home.aspx/search?keyword=<%=Request.QueryString["keyword"]==null?"":Request.QueryString["keyword"] %>&page=' + index;
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
	  
	  <div class="ny_banner"><img src="/img/ny/nybanner02.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top">
			<div class="left_dh">
			<div class="left_dh01">在线搜索</div>
			<div class="left_dh02">
</div>
			
			<div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
			<div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
			<div class="left_dh03"></div>
			  </div>
			<div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="#" class="lz">搜索结果</a></div>
			<div class="rbox01">
              <div class="rbox01_ico">
                <div class="sl">检索结果 : <%= ViewData["recordCount"]%> 条符合条件的信息</div>
                <div class="sr"></div>
              </div>
              <%foreach (var item in Model)
                { %>
			  <div class="rbox01_m">
                
                  <div><a href="/news.aspx/info/<%=item.id %>"><strong><%=item.title %></strong></a></div>
                  <div class="lbla"><%=item.text.Length>70?item.text.Substring(0,70):item.text %>...</div>
               <div class="sline"></div>
			    </div>
			 <%} %>
			  <div class="nbu">
                <%Html.RenderPartial("mainpage");%>
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
<script>

    var nums = [], timer, n = $$("idSlider2").getElementsByTagName("li").length,
	st = new SlideTrans("idContainer2", "idSlider2", n, {
	    onStart: function() {//设置按钮样式
	        forEach(nums, function(o, i) { o.className = st.Index == i ? "on" : ""; })
	    }
	});
    for (var i = 1; i <= n; AddNum(i++)) { };
    function AddNum(i) {
        var num = $$("idNum").appendChild(document.createElement("li"));
        num.innerHTML = i--;
        num.onmouseover = function() {
            timer = setTimeout(function() { num.className = "on"; st.Auto = false; st.Run(i); }, 200);
        }
        num.onmouseout = function() { clearTimeout(timer); num.className = ""; st.Auto = true; st.Run(); }
        nums[i] = num;
    }
    st.Run();
</script>
</html>
