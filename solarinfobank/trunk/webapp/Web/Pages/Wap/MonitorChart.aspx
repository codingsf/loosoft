<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title>
<link href="/css/wap.css" rel="stylesheet" type="text/css" /> 
</head>


<body>
<% string date = Request.QueryString["date"] == null ? String.Empty : Request.QueryString["date"].ToLower();%>

<div class="mainbox01">
<div class="top">
<div class="fl02"><%=Resources.SunResource.USER_MONITOR_VIDEO_MONITOR_POINT%></div>
<div class="fr02"><a class="fra" href="/wap/RunData/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>"><%=Resources.SunResource.MOBILE_BUTTON_BACK%> </a></div>

</div>
<div class="chart">
<div class="chart01"></div>
<div class="chart02">
  <div class="chart02_m">
<form action="/wap/monitorchart/" method="get">
  
  <table width="150" border="0" align="center" cellpadding="0" cellspacing="0" class="dateb">
    <tr>
      <td width="19">
      <%=Html.Hidden("sid", Session.SessionID)%><%=Html.Hidden("pid", Request.QueryString["pid"])%>
      <%=Html.Hidden("mcode", Request.QueryString["mcode"])%><%=Html.Hidden("did", Request.QueryString["did"])%>
      <a href="/wap/monitorchart?sid=<%=Session.SessionID %>&did=<%=Request.QueryString["did"] %>&mcode=<%=Request.QueryString["mcode"] %>&date=<%=date %>&pid=<%= Request.QueryString["pid"] %>&pre=true"><img src="/m_img/ico05.jpg" border="0" /></a></td>

      <td width="107"><input name="date" type="text" class="xsy" value="<%=date %>" /></td>
      <td width="51"><input type="image" src="/m_img/ico06.jpg" width="30" height="19" border="0" /></td>
      <td width="21"><a href="/wap/monitorchart?sid=<%=Session.SessionID %>&did=<%=Request.QueryString["did"] %>&mcode=<%=Request.QueryString["mcode"] %>&date=<%=date %>&pid=<%= Request.QueryString["pid"] %>&next=true"><img src="/m_img/ico07.jpg" border="0" /></a></td>
    </tr>
  </table>
  
  </form>
</div>
<div class="chart02_img">
<%Html.RenderAction("MonitorDayChart", "wap", new { mcode = Request.QueryString["mcode"], day = date, dId = Request.QueryString["dId"] });  %>

</div>
</div>
<div class="chart03"></div>
</div>
</div>
</body>

</html>
