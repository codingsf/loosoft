<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Fault>>" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title> 
<link href="/css/wap.css" rel="stylesheet" type="text/css" />
</head>


<body>
<div class="mainbox01">
<div class="top">
<div class="fl02"><%=Resources.SunResource.USER_POWERENERGY_POWER_ENERGY_CHART%></div>
<div class="fr02"><a href="/wap/overview/?sid=<%=Session.SessionID %>" class="fra"><%=Resources.SunResource.MOBILE_BUTTON_BACK%> </a></div>

</div>

<%string t = Request.QueryString["t"].ToLower(); %>
<%string date = Request.QueryString["date"]==null?String.Empty:Request.QueryString["date"].ToLower(); %>
<div class="chart">
<div class="chart01"></div>
<div class="chart02">
<div>
<div class="charttab">
<ul>
<li class="tab0<%=t.Equals("m")?1:2 %>"><a href="/wap/energychart/?sid=<%=Session.SessionID %>&t=m&date=<%=DateTime.Now.ToString("yyyy-MM") %>"><%=Resources.SunResource.CUSTOMREPORT_MONTH%></a></li>
<li class="tab0<%=t.Equals("y")?1:2 %>"><a href="/wap/energychart/?sid=<%=Session.SessionID %>&t=y&date=<%=DateTime.Now.Year %>"><%=Resources.SunResource.CUSTOMREPORT_YEAR%></a></li>
<li class="tab0<%=t.Equals("t")?1:2 %>"><a href="/wap/energychart/?sid=<%=Session.SessionID %>&t=t"><%=Resources.SunResource.PLANT_OVERVIEW_TOTAL%></a></li>
</ul>
</div>
</div>
<%if (!t.Equals("t"))
  {%>
<div class="chart02_m">
<form action="/wap/energychart/" method="get">
  <table width="150" border="0" align="center" cellpadding="0" cellspacing="0" class="dateb">
    <tr>
    <%=Html.Hidden("t", t) %><%=Html.Hidden("sid", Session.SessionID)%>
      <td width="19"><a href="/wap/energychart?sid=<%=Session.SessionID %>&t=<%=t %>&date=<%=date %>&pre=true"><img src="/m_img/ico05.jpg" border="0" /></a></td>
      <td width="107"><input name="date" type="text" class="xsy" value="<%= date %>" /></td>
      <td width="51"><input type="image" src="/m_img/ico06.jpg" width="30" height="19" border="0" /></td>
      <td width="21"><a href="/wap/energychart?sid=<%=Session.SessionID %>&t=<%=t %>&date=<%=date %>&next=true"><img src="/m_img/ico07.jpg" border="0" /></a></td>
    </tr>
  </table>
  
</form>
  
</div>
<%} %>
<div class="chart02_img">



<%switch (t)
  {
   
      case "m":
          Html.RenderAction("EnergyMonthChart", "wap", new { month =date}); 
          break;
      case "y":
          Html.RenderAction("EnergyYearChart", "wap", new { year = date }); 
          break;
      case "t":
          Html.RenderAction("EnergyTotalChart", "wap"); 
          break;
      default:
          break;
  } %>



</div>
</div>
<div class="chart03"></div>
</div>
</div>
<%--<div class="lbgtop">
<div class="logslbg">
<div class="logslist">
<div class="logslist_l">
<span class="fl">All logs:</span>
<span class="fr">18</span></div>
<div class="logslist_r"><a href="#"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></div>
</div>
</div>
<div class="logslbg">

  <div class="logslist">
    <div class="logslist_l"> <span class="fl">All logs:</span> <span class="fr">18</span></div>
    <div class="logslist_r"><a href="#"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></div>
  </div>
</div>
</div>--%>
</body>
</html>
