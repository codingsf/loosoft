<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.PAGE_NO_AUTHORIZATION%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div class="mainbox">
            <div class="main_wz" style=" width:790px; text-align:right; padding-left:210px;">
             
             <div style=" float:right;">
                <a href="/user/edit/<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id %>">
                    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().displayNick%></a> , <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_WELCOME_TO_COME  %>! | <a href="/auth/loginout">
                        <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_LOGOUT  %></a>
             </div>
            </div>
<div style="width:886px; height:180px;margin:0px auto; "></div>
<div style="width:886px; height:226px; margin:0px auto; background:url(/images/qxbg.jpg) no-repeat;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:60px;">
    <tr>
      <td width="29%" align="right" style="padding-right:20px;"><img src="/images/gk.gif" width="68" height="67" /></td>
      <td width="71%" style="font-size:26px;"><%=Resources.SunResource.PAGE_NO_AUTHORIZATION%></td>
    </tr>
  </table>
</div>
<div style=" width:886px; height:25px;margin:0px auto; "></div>
</div>
</asp:Content>
