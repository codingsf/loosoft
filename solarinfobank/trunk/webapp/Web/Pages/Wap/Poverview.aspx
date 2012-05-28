<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title>
<link href="/css/wap.css" rel="stylesheet" type="text/css" /> 
</head>


<body>
<% string t = Request.QueryString["t"].ToLower().Trim();%>
<% string date = Request.QueryString["date"] == null ? String.Empty : Request.QueryString["date"].ToLower();%>

<div class="mainbox01">
<div class="top">
<div class="fl02"><%=Model.name %></div>
<div class="fr02"><a class="fra" href="/wap/overview/?sid=<%=Session.SessionID %>"><%=Resources.SunResource.MOBILE_BUTTON_BACK%>  </a></div>
</div>
<div class="pfbg02">
  <div class="pf02">
  <div class="sonp01">
  
  <img src="<%=ConfigurationSettings.AppSettings["domain"] %>/ufile/small/<%=Model.onePic%>" width="58" height="50" />
  
  
  </div>
  <div class="sonp02">
    <div class="pfz01"> <span class="f26"><%= Model.DisplayTotalDayEnergy%>  <%=Model.TotalDayEnergyUnit%></span> <span class="rimg"><a href="/wap/profile/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></span> </div>
    <div class="f14">
      <div class="fl50"><%=Model.city %></div>
      <div class="fr50"><%=Model.country %></div>
    </div>
    <div class="f14">
      <div class="fl50"><%= Model.DisplayRevenue%> <%=Model.currencies %></div>
      <div class="fr50"><% = Model.DisplayTotalEnergy%>  <%=Model.TotalEnergyUnit%></div>
    </div>
  </div>
  </div>
</div>
<div class="chart">
<div class="chart01"></div>
<div class="chart02">
<div>
<div class="scharttab">
<ul>
<li class="tab0<%=t.Equals("d")?1:2 %>"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>"><%=Resources.SunResource.CHART_DAILY%></a></li>
<li class="tab0<%=t.Equals("m")?1:2 %>"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=m&date=<%=DateTime.Now.ToString("yyyy-MM") %>"><%=Resources.SunResource.CUSTOMREPORT_MONTH%></a></li>
<li class="tab0<%=t.Equals("y")?1:2 %>"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=y&date=<%=DateTime.Now.ToString("yyyy") %>"><%=Resources.SunResource.CUSTOMREPORT_YEAR%></a></li>
<li class="tab0<%=t.Equals("t")?1:2 %>"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=t"><%=Resources.SunResource.PLANT_OVERVIEW_TOTAL%></a></li>
</ul>
</div>
</div>
<%if (!t.Equals("t"))
  {%>
<div class="chart02_m">
<form action="/wap/poverview/" method="get">
  <table width="150" border="0" align="center" cellpadding="0" cellspacing="0" class="dateb">
    <tr>
      <td width="19">
      <%=Html.Hidden("t", t) %><%=Html.Hidden("sid", Session.SessionID)%><%=Html.Hidden("pid", Model.id)%>
      <a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=<%=t %>&date=<%=date %>&pre=true""><img src="/m_img/ico05.jpg" border="0" /></a></td>
      <td width="107"><input name="date" type="text" class="xsy" value="<%= date %>" /></td>
      <td width="51"><input type="image" src="/m_img/ico06.jpg" width="30" height="19" border="0" /></td>
      <td width="21"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=<%=t %>&date=<%=date %>&next=true"><img src="/m_img/ico07.jpg" border="0" /></a></td>
    </tr>
  </table>
  </form>
</div>

<%} %>
<div class="chart02_img">
<%switch (t)
  {
      case "d":
          Html.RenderAction("plantdaychart", "wap", new { pid = Model.id, day = date }); 
          break;
      case "m":
          Html.RenderAction("plantMonthchart", "wap", new { pid = Model.id, month = date }); 
          break;
      case "y":
          Html.RenderAction("plantYearchart", "wap", new { pid = Model.id, year = date }); 
          break;
      case "t":
          Html.RenderAction("plantTotalchart", "wap", new { pid = Model.id }); 
          break;
      default:
          break;
  } %>
</div>
</div>
<div class="chart03"></div>
</div>
</div>
<div class="lbgtop">
<div class="sonbu">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="left">
      <div class="ybu"><a href="/wap/profile/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>" class="ybua"><%=Resources.SunResource.PLANT_PROFILE_PROFILE%></a></div>
      
      </td>
      <td align="center">
      
      
         <div class="ybu"><a href="/wap/device/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>" class="ybua"><%=Resources.SunResource.SHARED_BACKMANAGERMASTERPAGE_DEVICE_LIST%></a></div>
      
      
      </td>
      <td align="right">
      
      <div class="ybu"><a href="/wap/logs/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>" class="ybua"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_LOGS%></a></div>
      </td>
    </tr>
  </table>
</div>
</div>
</body>
</html>

