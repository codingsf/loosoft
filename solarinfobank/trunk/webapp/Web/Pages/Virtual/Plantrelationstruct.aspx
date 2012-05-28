<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Virtual.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS%> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">  
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg" id="content_ajax">
    <!--空页面，只为了加载模板，实际页面是IncludePlantrelationstruct页面-->    
    </td>
</asp:Content>
