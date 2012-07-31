<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<div class="footer01">
	  <div class="footer_l"><a href="/product">最新产品</a> <span class="rs"> |</span> <a href="/service/network">售后服务</a><span class="rs"> |</span><a href="/contact">联系我们</a> </div> 
	  <div class="footer_r"><%=WebconfigService.GetInstance().Config.beian %>     Copyright @2011 腾虎科技 版权所有</div>
	  </div> 