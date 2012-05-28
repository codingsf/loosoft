<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Device>>" %>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
  <% 
      int i = 0;
    foreach (var item in Model)
    {
        i++;
  %>
  <tr  >
  <td width="14%"  height="42" align="center"><%=item.deviceAddress %></td>
  <td width="15%" align="center"> <%=item.typeName %></td>
  <td width="19%" align="center"><%=item.xinhaoName %></td>
  <td width="30%" align="center">
  <a href="/devicechart/chart/?pId=<%=ViewData["plantId"]%>&dId=<%=item.id%>" onclick="viewChart(<%=item.id%>)" target=_blank onfocus="javascript:this.blur();" title="Device Chart"><%=Resources.SunResource.CHART_VIEW_CHART%></a>&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="/device/rundata/<%=item.id%>" onfocus="javascript:this.blur();" title="Device Runing Data" target=_blank><%=Resources.SunResource.CHART_VIEW_RUN_DATA%></a>
  &nbsp;&nbsp;&nbsp;
  <a href="/device/log/?pId=<%=ViewData["plantId"]%>&dId=<%=item.id%>" onfocus="javascript:this.blur();" title="Device Log" target=_blank><%=Resources.SunResource.CHART_VIEW_LOG%></a>
  
  </td>
  </tr>
  <%} %>
  <%if (i == 0)
    { %>
     <tr>
  <td colspan="4" align="center" height="45"><%=Resources.SunResource.USER_LOG_NO_DATA%></td>
  </tr>
    <%} %>
</table>
