<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div class="mainbox">
<div class="header">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="34%"><img src="" class="logo" width="225" height="46" /></td>
      <td width="66%" align="left"><label id="name"></label></td>
    </tr>
  </table>
</div>
<div class="table" id="page_<%=ViewContext.RouteData.Values["plantid"] %>_<%=ViewContext.RouteData.Values["id"] %>_chart">

</div>
<div class="tab"><img src="/bigscreen/images/img.png" width="127" height="33" /></div>
</div>