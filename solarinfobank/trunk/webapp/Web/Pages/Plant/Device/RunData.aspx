<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service.vo" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title> <%=Resources.SunResource.DEVICE_DEVICE_RUN_DATA %></title>
    <!--the styl add by qhb in20120825-->
    <style type="text/css">
    body,td,th {
	    font-size: 12px;
	    font-family: Verdana, Arial, Helvetica, sans-serif;
    }
    .xtable{ border-collapse:collapse;}
    .xtable td{line-height:24px; text-align:center;}
    .xgreen{ color:#66CC33;}
    .xred{ color:#FF0000;}

    .xfl{ float:left; display:block; width:15px; text-align:center;}
    .xfr{ float:right; display:block; width:15px; text-align:center;}

    .xrlist{ float:right; width:240px; display:block; margin:0px; padding:0px; font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif;}
    .xrlist li{ list-style:none; float:left; display:block; margin-right:15px; width:45px; height:12px; line-height:12px;}
    .irlist{ float:right; width:240px; display:block; margin:8px 0 3px 0; padding:0px; font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
    .irlist li{ list-style:none; float:left; display:block; margin-right:15px; width:45px; height:12px; line-height:12px; margin-bottom:3px;}


    .xrlist0{ float:right; width:240px; display:block; margin:0px; padding:0px; font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif;}
    .xrlist0 li{ list-style:none; float:left; display:block; margin-right:15px; width:45px; height:24px; line-height:24px;}
    .irlist0{ float:right; width:240px; display:block; margin:8px 0 3px 0; padding:0px; font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
    .irlist0 li{ list-style:none; float:left; display:block; margin-right:15px; width:45px; margin-bottom:3px;}
    </style>
</head>
<body>
   <table width="100%" border="0" cellspacing="0" bordercolor="#E6E6E6"  style=" border-collapse:collapse;">
       <tr> 
      <td height="36" colspan="9" valign="center" style="padding-left:5px; background-color:#EEEEEE;"><strong><%=Resources.SunResource.CHART_TYPE%>:<%=(ViewData["device"] as Device).typeName%>&nbsp;&nbsp;<%=Resources.SunResource.CHART_MODEL%>:<%=(ViewData["device"] as Device).xinhaoName%>&nbsp;&nbsp;<%=Resources.SunResource.CHART_ADDRESS%>:<%=(ViewData["device"] as Device).deviceAddress%></strong></td>
      <td align="right" style=" background-color:#EEEEEE; padding-right:5px;">
      <%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%>:
      <%if ((ViewData["device"] as Device).Over1Day((ViewData["plant"] as Plant).timezone))
        { %>
      <font style=" color:Red;">
       <%=(ViewData["device"] as Device).runData.updateTime%>
       </font>
      <%}
        else
        { %>
         <%=(ViewData["device"] as Device).runData.updateTime%>
      <%} %>
      </td>
    </tr>
   </table>
   <%
    int index = 0;
    foreach (var item in ViewData["rundatas"] as IList)
    {
        index++;
        IList<KeyValuePair<MonitorType, string>> rundatas = (IList<KeyValuePair<MonitorType, string>>)item;
        %>
        <table width="100%" border="0" cellspacing="0" bordercolor="#E6E6E6"  style=" border-collapse:collapse;">
        <%
        for (int i = 0; i < rundatas.Count; i = i + 2)
        {
        %>
            <tr>
              <td width="25%" height="26" valign="center" align="right" class="pl1502">
              <%=rundatas[i].Key.name%>&nbsp;
              </td>
             <%if (MonitorType.MIC_BUSBAR_TOTALCURRENT == rundatas[i].Key.code)
               { %>
              <td width="15%" valign="center" class="pl1501" align="right"><span class=""><%=Math.Round(double.Parse(rundatas[i].Value),2)%></span></td>
              <%}
               else
               { %>
               <td width="15%" valign="center" class="pl1501" align="right">
               <%if (MonitorType.MIC_INVERTER_DEVICESTATUS == rundatas[i].Key.code && (ViewData["device"] as Device).isFault())
                  { %>
                <span style="color:Red"><%=rundatas[i].Value%></span>
                <%}
                  else
                  { %>
                  <span><%=rundatas[i].Value%></span>
                <%} %>
               
               </td>
              <% }%>
              <td width="5%" valign="center" class="pl1501" align="left"><span class="lbl"><%=rundatas[i].Key.unit%></span>&nbsp;
              </td>
              <td width="5%" height="26" valign="center" align="left" class="pl1502" style="border-right:1px solid #E6E6E6;">
              <%if (rundatas[i].Key.isHistory())
              {%>
              <a id="toLarge<%=rundatas[i].Key.code %>" href="javascript:void(0)" onclick="initDisplayLargeMonitorChart(<%=rundatas[i].Key.code %>)" onfocus="javascript:this.blur();" title="<%=Resources.SunResource.CUSTOMREPORT_VIEW%> <%=rundatas[i].Key.name %> <%=Resources.SunResource.RUNDATA_PAGE_HISTORYCHART%>"><img src="/images/sub/chart_curve.gif" width="22" height="21" border="0"  alt="<%=Resources.SunResource.CUSTOMREPORT_VIEW%><%=Resources.SunResource.RUNDATA_PAGE_HISTORYCHART%>"/></a>
              <%}%>
              </td>              
              <%if (i + 1 < rundatas.Count)
              {
              %>
              <td width="25%" height="26" valign="center" align="right" class="pl1502" >
              <%=rundatas[i + 1].Key.name%>&nbsp;
              </td>
              <%if (MonitorType.MIC_BUSBAR_TOTALCURRENT == rundatas[i+1].Key.code)
                { %>
              <td width="15%" valign="center" class="pl1501" align="right" ><span><%=Math.Round(double.Parse(rundatas[i+1].Value),2)%></span></td>
               <%}
                else
                { %>
                <td width="15%" valign="center" class="pl1501" align="right" >
                <%if (MonitorType.MIC_INVERTER_DEVICESTATUS == rundatas[i+1].Key.code && (ViewData["device"] as Device).isFault())
                  { %>
                <span style="color:Red"><%=rundatas[i + 1].Value%></span>
                <%}
                  else
                  { %>
                  <span><%=rundatas[i + 1].Value%></span>
                <%} %>
                </td>
               <%} %>
               
              <td width="5%" valign="center" class="pl1501" align="left">
              <span class="lbl"><%=rundatas[i + 1].Key.unit%>&nbsp;</span>
              </td>
              <td width="5%" height="26" valign="center" align="left" class="pl1502">
              
              <%if (rundatas[i + 1].Key.isHistory())
                {%>
              <a id="toLarge<%=rundatas[i+1].Key.code %>" href="javascript:void(0)" onclick="initDisplayLargeMonitorChart(<%=rundatas[i+1].Key.code %>)" onfocus="javascript:this.blur();" title="<%=Resources.SunResource.CUSTOMREPORT_VIEW%> <%=rundatas[i+1].Key.name %> <%=Resources.SunResource.RUNDATA_PAGE_HISTORYCHART%>"><img src="/images/sub/chart_curve.gif" width="22" height="21" border="0" alt="<%=Resources.SunResource.CUSTOMREPORT_VIEW%><%=Resources.SunResource.RUNDATA_PAGE_HISTORYCHART%>" /></a>
              <%}%>
              </td>
              <%}
                else
                {%>
              <td width="125" valign="center" class="pl1502" >&nbsp;</td>
              <td width="70" valign="center" class="pl1502" >&nbsp;</td>
              <td width="10" valign="center" class="pl1502" >&nbsp;</td> 
              <td width="15" height="26" valign="center" align="left" class="pl1502"></td>
              <%} %> 
            </tr>
    <%
    } %>
   <%if (rundatas.Count>0)
     {
   %>
   
    <tr>
      <td height="36" colspan="9" valign="center" class="pl1502"  style=" background-color:#EEEEEE;"></td>
    </tr>

    </table>
<%}
    }%>
 
    <!--详细数据 add by qhb in 20120825--> 
    <%if ((ViewData["digitalinputdetail"] as IList).Count > 0)
      { %>    
    <table width="500" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8D8" class="xtable">
  <tr>
    <td colspan="3" background="images/sub/xbg00.jpg" bgcolor="#F5F5F5"><strong style=" float:left; padding-left:10px;">数字输入</strong></td>
  </tr>
  
    <%
    foreach (var item in ViewData["digitalinputdetail"] as IList)
    {
        index++;
        DigitalInputDetailVO  vo = (DigitalInputDetailVO)item;
     %>
    <tr>
    <%if(vo.status.Equals(DigitalInputDetailVO.status_no)){ %>
        <td width="20%"><img src="/images/sub/xxico01.jpg"/></td>
    <%}else{ %>
        <td width="20%"><img src="/images/sub/xxico02.jpg" /></td>
    <%} %>
    <td width="30%"><%=vo.statusItem%></td>
    <%if(vo.status.Equals(DigitalInputDetailVO.status_no)){ %>
        <td width="50%" class="xgreen"><%=vo.statusDesc%>&nbsp;</td>
    <%}else{ %>
        <td width="50%" class="xred"><%=vo.statusDesc%></td>
    <%} %>
    </tr>
    <%}%>
</table>
<p>&nbsp;</p>
<%} %>

    <%if ((ViewData["workstatusdetail"] as IList).Count > 0)
      { %>  
<table width="500" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8D8" class="xtable">
  <tr>
    <td colspan="3" align="left" background="images/sub/xbg00.jpg" bgcolor="#F5F5F5" ><strong  style=" float:left; padding-left:10px;">工作状态</strong>
    <%if (int.Parse(ViewData["displayHxlroute"].ToString()) > 8)
      {%>
	<ul class="xrlist">
	<li><span class="xfl">1</span><span class="xfr">2</span></li>
	<li><span class="xfl">3 </span><span class="xfr">4</span></li>
	<li><span class="xfl">5</span><span class="xfr">6</span></li>
	<li><span class="xfl">7</span><span class="xfr">8</span></li>
	<li><span class="xfl">9</span><span class="xfr">10</span></li>
	<li><span class="xfl">11</span><span class="xfr">12</span></li>
	<li><span class="xfl">13</span><span class="xfr">14</span></li>
	<li><span class="xfl">15</span><span class="xfr">16</span></li>
    </ul>
	<%}
      else
    { %>
  	<ul class="xrlist0">
    <li><span class="xfl">1</span><span class="xfr">2</span></li>
    <li><span class="xfl">3 </span><span class="xfr">4</span></li>
    <li><span class="xfl">5</span><span class="xfr">6</span></li>
    <li><span class="xfl">7</span><span class="xfr">8</span></li>
    </ul>
	<%} %>

	</td>
  </tr>
  <%
      foreach (var item in ViewData["workstatusdetail"] as IList)
      {
          DigitalInputDetailVO vo = (DigitalInputDetailVO)item;
  %>
  <tr>
    <%if(vo.status.Equals(DigitalInputDetailVO.status_no)){ %>
        <td width="20%"><img src="/images/sub/xxico01.jpg" /></td>
    <%}else{ %>
        <td width="20%"><img src="/images/sub/xxico02.jpg" /></td>
    <%} %>

    <td width="30%"><%=vo.statusItem%></td>
    <td width="50%">
    <%if(vo.routeStatus!=null){
          if (int.Parse(ViewData["displayHxlroute"].ToString()) > 8)
          {%>
        <ul class="irlist">
      <%
        }
          else { 
              %>
                  <ul class="irlist0">
      <%
          }
          for (int ii = 0; ii < vo.routeStatus.Length; ii = ii + 2)
          {
              string route1 = vo.routeStatus[ii];
              string route2 = vo.routeStatus[ii + 1];
      %>
      <li><span class="xfl">
      <%if (route1.Equals(DigitalInputDetailVO.status_no))
        { %>
        <img src="/images/sub/xxico03.jpg" width="10" height="10" />
      <%}
        else if (route1.Equals(DigitalInputDetailVO.status_off))
        {%>
        <img src="/images/sub/xxico04.jpg" width="10" height="10" />
      <%}
        else
        { %>
        <%=route1%>
      <%} %>
      </span><span class="xfr">
      <%if (route2.Equals(DigitalInputDetailVO.status_no))
        { %>
        <img src="/images/sub/xxico03.jpg" width="10" height="10" />
      <%}
        else if (route2.Equals(DigitalInputDetailVO.status_off))
        {%>
        <img src="/images/sub/xxico04.jpg" width="10" height="10" />
      <%}
        else
        { %>
        <%=route2%>
      <%} %>
      </span>
      </li>
      <%} %>
    </ul>
    <%} %>
    </td>
  </tr>
  <%} %>
</table>
<p>&nbsp;</p>
<%} %>
</body>
</html>
