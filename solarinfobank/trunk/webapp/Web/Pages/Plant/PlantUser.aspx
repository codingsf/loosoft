﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.ADMIN_USER_LIST_USER_LIST%> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.RenderAction("users", "user"); %>
</asp:Content>