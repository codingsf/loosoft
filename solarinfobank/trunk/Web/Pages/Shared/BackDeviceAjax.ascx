<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Device>>" %>


  <% 
      int i = 1;
    foreach (var item in Model)
    {
        i++;
  %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
  <tr  >
  <td width="33%"  height="42" align="center"><%=item.deviceAddress %></td>
  <td width="33%" align="center"> <%=item.typeName %></td>
  <td width="33%" align="center"><%=item.xinhaoName %></td>
  
  </tr>
  </table>
  <%} %>
  <%if (i == 0)
    { %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
    
     <tr>
  <td colspan="4" align="center" height="45"><%=Resources.SunResource.USER_LOG_NO_DATA%></td>
  </tr>
  </table>
    <%} %>
 <%Html.RenderPartial("page"); %>
   