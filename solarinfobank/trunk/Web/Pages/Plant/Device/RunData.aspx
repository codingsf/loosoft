<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title> <%=Resources.SunResource.DEVICE_DEVICE_RUN_DATA %></title>
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
                { %>>
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
              <td width="15" height="26" valign="center" align="left" class="pl1502"> 
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
</body>
</html>
