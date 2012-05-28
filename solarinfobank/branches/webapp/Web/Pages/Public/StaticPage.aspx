<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Pages/Shared/Index.Master" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="title" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Resources.SunResource.PAGE_UNDER_CONSTRUCTION_TITLE  %> 
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
<div style="height:120px;"></div><div style=" width:636px; height:94px; margin:0px auto; background:url(../../Images/wzz.jpg) no-repeat; font-size:24px; color:#8A8A8A; padding-top:200px; text-align:center;"><%=Resources.SunResource.PAGE_UNDER_CONSTRUCTION%></div><div style="height:150px;"></div>
</asp:Content>
