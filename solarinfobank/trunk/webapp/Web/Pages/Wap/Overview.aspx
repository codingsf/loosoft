<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>
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
<div>
<div class="mainbox01">
<div class="top">
<div class="fl01"><%=Resources.SunResource.ADMIN_PLANT_LIST_PLANT_LIST%></div>
<div class="fr01"><a href="/wap/logout?sid=<%=Session.SessionID %>" class="fra"><%=Resources.SunResource.MOBILE_BUTTON_QUIE%></a></div>
</div>

<div class="pfbg01">
<div class="pf02">
<div class="pfz01">
<span class="f26"><% = Model.DisplayTotalDayEnergy%>    <%=Model.TotalDayEnergyUnit %></span>
<span class="rimg"><a href="/wap/energychart?sid=<%=Session.SessionID %>&t=m&date=<%=DateTime.Now.ToString("yyyy-MM") %>"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></span>
</div>
<div class="f16"><% = Model.DisplayTotalEnergy%>   <%=Model.TotalEnergyUnit %></div>
<div class="f14">
<div class="fl55"><%=Resources.SunResource.HOME_INDEX_AVOIDED_CO2%>:</div>
<div class="fr45"><%=Model.TotalReductiong %>  <%=Model.TotalReductiongUnit%></div>
</div>
<div class="f14">

<div class="fl55"><%=Resources.SunResource.PLANT_OVERVIEW_DAILYENERGY%> : </div>
<div class="fr45"><%=Model.TotalFamilies%>  <%=Resources.SunResource.PLANT_OVERVIEW_FAMILIES %></div>
</div>
</div>
</div>
</div>
</div>
<div>

  <%
foreach (Plant plant in Model.plants)
{
  %>
   <div class="plist01">
  <div class="plistbg01">
    <div class="lfl">
       <img src="<%=ConfigurationSettings.AppSettings["domain"] %>/ufile/small/<%=plant.onePic%>" width="45" height="44" />
    </div>
    <div class="lfm">

	<span class="lfm01"> <%=plant.name.Length>8?plant.name.Substring(0,8)+ "...": plant.name %></span><br />
     <span class="lfm02"><%= plant.DisplayTotalDayEnergy%> <%=plant.TotalDayEnergyUnit%> /<% = plant.DisplayTotalEnergy%> <%=plant.TotalEnergyUnit%>
                                                </span> </div>
    <div class="lfr"><a href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=plant.id %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>"><img src="/m_img/ico04.gif" border="0" /></a></div>
  </div>
</div>

 <%} %>

</div>
</body>
</html>

