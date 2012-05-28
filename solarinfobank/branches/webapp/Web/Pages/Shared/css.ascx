<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Globalization" %>

<script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script> 
<% string css = "/style/css.en-us.css";
   if (Session["Culture"] == null)
       css = "/style/css.en-us.css";
   else
       css = string.Format("/style/css.{0}.css", (Session["Culture"] as CultureInfo).Name.ToLower());
   if (System.IO.File.Exists(Server.MapPath(css)) == false)
       css = "/style/css.en-us.css";
     %>
<link href="/style/switch.css" rel="stylesheet" type="text/css" />
<link href="<%=css %>" rel="stylesheet" type="text/css" />
<link href="/style/sub.css" rel="stylesheet" type="text/css" />
<link href="/style/kj.css" rel="stylesheet" type="text/css" />

