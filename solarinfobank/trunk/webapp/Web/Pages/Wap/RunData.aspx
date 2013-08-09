<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Collections.Generic" %>
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
    <div class="fl02"><%=Resources.SunResource.CHART_DEVICE_DATA%></div>
    <%Device device = (ViewData["device"] as Device);%>
    <div class="fr02"><a class="fra" href="/wap/device/?sid=<%=Session.SessionID %>&pid=<%=Request.QueryString["pid"] %>&did=<%=device.id %>">
        <%=Resources.SunResource.MOBILE_BUTTON_BACK%></a></div>
  </div>
  <div class="dfbg01">
<div class="pf02">
<div class="pfz01">
<span class="f26"><%=device.TotalPower %> W</span>
<span class="rimg"><a href="/wap/devicechart?pid=<%=Request.QueryString["pid"] %>&did=<%=device.id %>&sid=<%=Session.SessionID %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></span>
</div>
<div class="f14">
<div class="fl40"><%=Resources.SunResource.WAP_LAST_UPDATE_TIME%> : </div>
<div class="fr60">
  <%if ((ViewData["device"] as Device).Over1Day((ViewData["plant"] as Plant).timezone))
        { %>
      <font style=" color:Red;">
       <%=(ViewData["device"] as Device).runData.updateTime.ToString("MM-dd hh:mm")%>
       </font>
      <%}
        else
        { %>
         <%=(ViewData["device"] as Device).runData.updateTime.ToString("MM-dd hh:mm")%>
      <%} %>

</div>
</div>
</div>
</div>
  
    
    <%
    foreach (var item in ViewData["rundatas"] as IList)
    {
        IList<KeyValuePair<MonitorType, string>> rundatas = (IList<KeyValuePair<MonitorType, string>>)item;
        %>
        
  <div class="pp01">
       <div class="pp02">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tlist">
        
         <%
        for (int i = 0; i < rundatas.Count; i++)
        {
            
        %>
        <tr>
          <td width="12%" align="center">
          
<%if (rundatas[i].Key.isHistory())
              {%>
              <a id="A1" href="/wap/monitorchart?sid=<%=Session.SessionID %>&did=<%=Request.QueryString["did"] %>&mcode=<%=rundatas[i].Key.code %>&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>&pid=<%= Request.QueryString["pid"]%>"><img src="/m_img/ico013.gif" width="14" height="13" border="0" /></a>
              <%}%>
          
          
          </td>
          <td width="55%"><%=rundatas[i].Key.name%></td>
          <td width="33%" class="lbk">
          <%if (MonitorType.MIC_BUSBAR_TOTALCURRENT == rundatas[i].Key.code)
               { %>
              <%=Math.Round(StringUtil.stringtoDouble(rundatas[i].Value),2)%> <%=rundatas[i + 1].Key.unit%>
              <%}
               else
               { %>
              <%=rundatas[i].Value%> <%=rundatas[i].Key.unit%>
              <% }%>
          
          
          </td>
        </tr>
        <%}%>
        
              </table>
  
      </div>
    <div style="clear:both; height:5px;"> </div>
       </div>  
        
   <% } %>
        

 
</div>
</div>
</body>

