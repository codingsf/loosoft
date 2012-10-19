<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/EmptyInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Device>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"> 
  <div style="width:100%; font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px; overflow:auto; overflow-y:hidden;" >
    <%IList<string> allmts = ViewData["allmts"] as IList<string>; %>
 
  <table width="<%=allmts.Count <= 0?"100":"160" %>%" border="1" bordercolor="#A8A8A8"  cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:24px;text-align:center">
  <tr>
    <td colspan="40" align="left" style="padding-left:10px; "><%=Model.fullName+" "+Resources.SunResource.DEVICE_DEVICE_HISTORYRUN_DATA%></td>
  </tr>
  <tr>
    <td width="5%"><%=allmts.Count > 0 ? Resources.SunResource.REPORT_TIME : Resources.SunResource.CHART_ERROR_NODATA%></td>
    <%
      foreach (string mt in allmts)
      {
    %>
    <td width="4%"><%=mt%></td>
    <%} %>
  </tr>
  <% 
  IDictionary<string, IDictionary<string, string>> timemtMap = ViewData["timemtMap"] as IDictionary<string, IDictionary<string, string>>;
  
  foreach(string timepoint in timemtMap.Keys)
  {
  %>
    <tr>
    <td><%=timepoint%></td>
    <%
      IDictionary<string, string> mtMap = timemtMap[timepoint];
      foreach (string mt in mtMap.Keys)
      {
          string value = mtMap[mt];
    %>
    <td><%=value%></td><!--设备名称-->
    <%} %>
  </tr>
  <%
  } %> 
</table>
    </div>
    <div style="height:15px; clear:both; width:100%"></div>
    <script>
        document.getElementById("devicename").value = ('<%=ViewData["devicename"] %>');
    </script>
</asp:Content>

