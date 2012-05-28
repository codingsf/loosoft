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

<% string t = Request.QueryString["t"].ToLower().Trim();%>
<% string date = Request.QueryString["date"] == null ? String.Empty : Request.QueryString["date"].ToLower();%>

<body>
<div class="mainbox01">
<div class="top">
<div class="fl02"><%=Resources.SunResource.WAP_DEVICE_CHART%></div>
<div class="fr02"><a class="fra" href="/wap/RunData/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>">
    <%=Resources.SunResource.MOBILE_BUTTON_BACK%> </a></div>

</div>
<div class="chart">
<div class="chart01"></div>
<div class="chart02">
  <div>
    <div class="scharttab">
      <ul>
        <li class="tab0<%=t.Equals("d")?1:2 %>"><a href="/wap/devicechart/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>"><%=Resources.SunResource.CHART_DAILY%></a></li>
        <li class="tab0<%=t.Equals("m")?1:2 %>"><a href="/wap/devicechart/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>&t=m&date=<%=DateTime.Now.ToString("yyyy-MM") %>"><%=Resources.SunResource.CUSTOMREPORT_MONTH%></a></li>
        <li class="tab0<%=t.Equals("y")?1:2 %>"><a href="/wap/devicechart/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>&t=y&date=<%=DateTime.Now.ToString("yyyy") %>"><%=Resources.SunResource.CUSTOMREPORT_YEAR%></a></li>
        <li class="tab0<%=t.Equals("t")?1:2 %>"><a href="/wap/devicechart/?did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&sid=<%=Session.SessionID %>&t=t"><%=Resources.SunResource.PLANT_OVERVIEW_TOTAL%></a></li>
      </ul>
    </div>
  </div>
  <%if (!t.Equals("t"))
    {%>
  <div class="chart02_m">
<form action="/wap/devicechart/" method="get">
  
  <table width="150" border="0" align="center" cellpadding="0" cellspacing="0" class="dateb">
    <tr>
      <td width="19">
        <%=Html.Hidden("t", t) %><%=Html.Hidden("sid", Session.SessionID)%><%=Html.Hidden("did", Request.QueryString["did"])%><%=Html.Hidden("pid", Request.QueryString["pid"])%>
      <a href="/wap/devicechart?sid=<%=Session.SessionID %>&did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&t=<%=t %>&date=<%=date %>&pre=true"><img src="/m_img/ico05.jpg" border="0" /></a></td>

      <td width="107"><input name="date" type="text" class="xsy" value="<%=date %>" /></td>
      <td width="51"><input type="image" src="/m_img/ico06.jpg" width="30" height="19" border="0" /></td>
      <td width="21"><a href="/wap/devicechart?sid=<%=Session.SessionID %>&did=<%=Request.QueryString["did"] %>&pid=<%=Request.QueryString["pid"] %>&t=<%=t %>&date=<%=date %>&next=true"><img src="/m_img/ico07.jpg" border="0" /></a></td>
    </tr>
  </table>
  
  </form>
  
  
</div>

    <%} %>
<div class="chart02_img">

<%switch (t)
  {
      case "d":
          Html.RenderAction("devicedaychart", "wap", new { day = date }); 
          break;
      case "m":
          Html.RenderAction("deviceMonthchart", "wap", new { month = date }); 
          break;
      case "y":
          Html.RenderAction("deviceYearchart", "wap", new { year = date }); 
          break;
      case "t":
          Html.RenderAction("deviceTotalchart", "wap"); 
          break;
      default:
          break;
  } %>

</div>
</div>
<div class="chart03"></div>
</div>
</div>
</body>

</html>
