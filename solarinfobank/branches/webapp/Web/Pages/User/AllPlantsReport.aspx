<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>"  MasterPageFile="~/Pages/Shared/ContentInside.Master" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
      <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_REPORT_CONFIGURATION%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<%
 if  (ViewData["type"].Equals("edit"))
   {%>
   <%Html.RenderAction("EditReport", "Reports", new { @id = ViewData["reportId"], plantId = ViewData["plantId"] }); %>
<%}
 else if (ViewData["type"].Equals("add"))
 {%>
  <%Html.RenderAction("CreateReport", "Reports", new { @id =0,  @plantId = ViewData["plantId"] }); %>
<%}
 else if (ViewData["type"].Equals("load"))
 {%>
  <%Html.RenderAction("DownLoadReport", "Reports", new { @id = ViewData["reportId"], @plantId = ViewData["plantId"], @cTime = ViewData["dTime"]  }); %>
<%}
 else
 {%>
<%Html.RenderAction("allReportIndex", "Reports", new { @userId = Session[ComConst.User] }); %>
<%} %>
</asp:Content>