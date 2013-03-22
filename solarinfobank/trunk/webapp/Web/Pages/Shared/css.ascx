<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>

<script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script>

<% string css = UserUtil.curTemplete.cssFolder + "/style/css.en-us.css";
   if (Session["Culture"] == null)
       css = UserUtil.curTemplete.cssFolder + "/style/css.en-us.css";
   else
       css = string.Format("{1}/style/css.{0}.css", (Session["Culture"] as CultureInfo).Name.ToLower(), UserUtil.curTemplete.cssFolder);
   if (System.IO.File.Exists(Server.MapPath(css)) == false)
       css = UserUtil.curTemplete.cssFolder + "/style/css.en-us.css";
%>
<link href="<%= UserUtil.curTemplete.cssFolder %>/style/switch.css" rel="stylesheet"
    type="text/css" />
<link href="<%=css %>" rel="stylesheet" type="text/css" />
<link href="<%= UserUtil.curTemplete.cssFolder %>/style/sub.css" rel="stylesheet"
    type="text/css" />
<link href="<%= UserUtil.curTemplete.cssFolder %>/style/share.css" rel="stylesheet"
    type="text/css" />
    <link href="<%= UserUtil.curTemplete.cssFolder %>/style/lc.css" rel="stylesheet"
    type="text/css" />
<style type="text/css">
/*适用于全屏的样式*/ 
#bigscreen:-webkit-full-screen { width: 100% ; background-color:White;} 
#bigscreen:-moz-full-screen { width: 100% ; background-color:White;} 
#bigscreen:-ms-full-screen { width: 100% ; background-color:White;}  
#bigscreen:-o-full-screen { width: 100% ; background-color:White;}  
#bigscreen:full-screen { width: 100% ; background-color:White;} 
</style>
