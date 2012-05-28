<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%=Resources.SunResource.REPORT_CONFIG_REPORT_TITLE%>:<%=ViewData["title"]%>
  <br />
  <br />
<%=Resources.SunResource.REPORT_CONFIG_SENDER%>
  <br />
  <br />

<%=Resources.SunResource.REPORT_CONFIG_REPORT_CONTENT%>
  <br />
  <br />
<div style="border:solid 1px #ccc; padding:10px;">
<%=ViewData["user"]%> <br /><br />
&nbsp;&nbsp;&nbsp;<%=Resources.SunResource.REPORT_CONFIG_HELLO%>
  <br />
  <br />

<%=Resources.SunResource.REPORT_CONFIG_CONTENT_TITLE%>[<font color="red"><%=ViewData["plantName"]%></font> ]<%= ViewData["reportName"] %>：
  <br />
  <br />



 <%=ViewData["content"]%>



  <br />
  <br />

<div style=" text-align:right; color:Blue;">
<%=Resources.SunResource.REPORT_CONFIG_MAIL_MANAGER%>
</div>

  <br />

</div>