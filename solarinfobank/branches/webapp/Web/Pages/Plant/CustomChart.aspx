<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>"%>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content3" ContentPlaceHolderID="TitleContent" runat="server">
        <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_DEFINED_CHART  %> - SolarInfoBank
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<% Html.RenderAction("DefinedPlantChart", "CustomReport"); %>
</asp:Content>