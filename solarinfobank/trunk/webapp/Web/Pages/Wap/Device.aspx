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
<div>
<div class="mainbox01">
  <div class="top">
    <div class="fl02"><%=Resources.SunResource.WAP_INVERTER_LIST%></div>
    <div class="fr02"><a class="fra" href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Model.id %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>">
    
<%=Resources.SunResource.MOBILE_BUTTON_BACK%>
    
    
    
    </a></div>
  </div>
</div>
</div>
<div>


  <%
      int i = 0;
      foreach (PlantUnit unit in Model.plantUnits)
      { 
               
          bool fault = false; 
    %>                      
	<%foreach (Device device in unit.devices)
        {
         
            fault = device.runData.isFault();
            if (device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE) == false)
                continue;
            i++;
        %>
<div class="loglist">
<div class="loglist01">
<div class="loglist01_l"><img src="/m_img/ico01<%=device.runData.isFault()?"2":"1" %>.png" width="18" height="29" /></div>
<div class="loglist01_r">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="52%" class="f16"><strong><%=device.fullName.Length>20?device.fullName.Substring(0,20)+ "...":device.fullName%></strong></td>
  </tr>
  <tr>
    <td class="fli12"><%=Resources.SunResource.DEVICEMONITORITEM_125%> : <%=device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER)%> W</td>
  </tr>
  <tr>
    <td colspan="2" class="fli12">
       <%if (fault)
          { %>
      <font color="red"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
          
          <%}
          else
               %>
        <%if (device.Over1Day(Model.timezone))
          { %>
      <font color="#FF9912"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
       <%}
          else
          { %>
       <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
          
      <%} %>
    
    
    
    </td>
    </tr>
</table>
</div>
<div class="dpr"><a href="/wap/RunData/?did=<%=device.id%>&pid=<%=Model.id %>&sid=<%=Session.SessionID %>"><img src="/m_img/ico010.png" width="31" height="31" border="0" /></a></div>
</div>
</div>

<%}
      } %>

<%
    if (i.Equals(0))
  { %>

<div class="loglist">
<div class="loglist01">
<div class="loglist01_l"></div>
<div class="loglist01_r">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" class="f16" colspan="3" align="center"><strong>
   <%=Resources.SunResource.NODATA%>
   </strong></td>
  </tr>
  
</table>
</div>
<div class="dpr"></div>
</div>
</div>
<%} %>
</div>
</body>
</html>
