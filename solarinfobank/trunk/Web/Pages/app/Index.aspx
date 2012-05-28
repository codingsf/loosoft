<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
App Store iPhone
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="/style/xcy.css" rel="stylesheet" type="text/css" />
<div class="mainbox">

<div class="xc_main">
<div class="xcy_banner">
<div class="xcy_banner01">SolarInfo Bank for Mobile App</div>
<div class="xcy_banner02">All the important data are glance. You can easily demonstrate 
the power plant anywhere at any time !</div>
</div>
<div class="xcy_pr">
<div class="xcy_ico01">SolarInfo Bank for iPhone App</div>
<div class="xcy_ab">
<div class="xcy_l"><img src="/images/xcy/xcy_img01.jpg" width="225" height="175" /></div>
<div class="xcy_r">

<div class="xcy_r01">  


<%=Resources.SunResource.PUBLIC_APP_CONTENT1%>
</div>
  <div style="padding-left:10px;">
    <!--<input name="Submit" type="submit" class="xcy_bu01" value="Download" />-->
  </div>
</div>
</div>
</div>
<div style="clear:both;"> </div>
<div class="xcy_pr">
  <div class="xcy_ico01">SolarInfo Bank for iPad App</div>
  <div class="xcy_ab">
    <div class="xcy_l"><img src="/images/xcy/xcy_img02.jpg" width="225" height="175" /></div>
    <div class="xcy_r">
      <div class="xcy_r01">
       <%=Resources.SunResource.PUBLIC_APP_CONTENT11%></div>
      <div  style="padding-left:10px;">
        <!--<input name="Submit2" type="submit" class="xcy_bu01" value="Download" />-->
      </div>
    </div>
  </div>
</div>
<div style="clear:both;"> </div>
<div class="xcy_pr">
  <div class="xcy_ico01">SolarInfo Bank for Android App</div>
  <div class="xcy_ab">
    <div class="xcy_l"><img src="/images/xcy/xcy_img03.jpg" width="225" height="175" /></div>
    <div class="xcy_r">
      <div class="xcy_r01">
       <%=Resources.SunResource.PUBLIC_APP_CONTENT111%></div>
      <div  style="padding-left:10px;">
        <!--<input name="Submit2" type="submit" class="xcy_bu01" value="Download" />-->
      </div>
    </div>
  </div>
</div>
<div style="height:40px;"> </div>
</div>
</div>
</asp:Content>
