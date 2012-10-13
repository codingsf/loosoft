<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>

<script type="text/javascript">
    function displayLanguagePanel() {
        document.getElementById("languagePanel").style.display = "block";
    }

    function changeculture(lang ,name ,returnuri) {
        window.location.href = " /home/ChangeCulture?lang=" + lang + "&name=" + name + "&returnUrl=" + returnuri + "&inituri=" + $("#current_uri").val() + "&loading_type=" + $("#loading_type").val();
    }
    var isHidden;
    function hiddenLanguagePanel() {
        if (isHidden) {
            document.getElementById("languagePanel").style.display = "none";
            isHidden = false;
        }
    }
    function timeputHidden() {
        isHidden = true;
        window.setTimeout(hiddenLanguagePanel, 500);
    }
</script>
<%
   ViewData["langs"]= Cn.Loosoft.Zhisou.SunPower.Service.LanguageService.GetInstance().GetList();
 %>
<div style="display: none;" id="previewdiv">
<center>
    <div id='large_container' style="width: 90%; height: 550px; margin-left: 40px; margin-right: 40px; text-align:center;">
    </div>
</center>
</div>
<div class="header">
    <div class="headermain">
        <div class="header_l">
            <a href="/">
                &nbsp;<img src="<%= UserUtil.UserLogo %>" width="169" height="29" border="0" id="logo" /></a></div>
        <div class="header_r">
            <div class="header_rt">
                <a href="#" id="outpreview">&nbsp;</a>
                <a href="/qa/ask" target="_blank" class="dgreen">FAQ</a></div>
            <div class="header_rdh">
            <div class="header_rdhname"><span class="wf"><%=UserUtil.SysName %></span> <span class="wr"></span></div>
                <div class="header_rdhl">
                    <span><a href="/" class="gwhite"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_HOME%></a></span>|<span><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" class="gwhite"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_USER_MANUAL%></a></span>|
                    <span><a href="/public/contactus" target="_blank" class="gwhite"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_CONTACTS%></a></span></div>

                <div class="header_rdhr" style="position: relative;">
                   <div style="width:134px; z-index:1000; position: absolute; display:block; z-index:100; left: 7px; top: 3px; cursor:pointer;">
                    <div class="ensel" onclick="displayLanguagePanel()">
                      <table width="86%" height="27" border="0" cellpadding="0" cellspacing="0">
                        <tr onmouseout="timeputHidden();" onmouseover="isHidden=false">
                          <td width="35%" align="center"><img src="/images/lang/<%=(Session["Culture"] as CultureInfo).Name%>.jpg" width="18" height="12" /></td>
                          <td width="65%" align="left" style=" color:#F4CD72"><%=(Session["display"]==null)?"English":Session["display"]%></td>
                        </tr>
                      </table>
                    </div>
                    
                    <div class="lansel" id="languagePanel" style="display:none;" onmousemove="isHidden=false" onmouseout="timeputHidden()" >
                   
                      <div class="lansel_top"><img src="/images/lansel_top.gif" width="134" height="5" /></div>
                      <div class="lansel_mid">
                      <% foreach (var item in ViewData["langs"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.Language>)
                         { 
                      %>
                        <div class="lmid_list">
                          <table width="86%" height="27" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                              <td width="35%" align="center"><a class="dyreen" onclick="changeculture('<%=item.codename%>','<%=item.name %>','<%=this.Request.RawUrl %>')"  href="javascript:void(0);"><img src="/images/lang/<%=item.codename %>.jpg" width="18" height="12"  alt="language"/></a></td>
                              <td width="65%" align="left"><a onclick="changeculture('<%=item.codename%>','<%=item.name %>','<%=this.Request.RawUrl %>')" class="dyreen" href="javascript:void(0);"><%=item.name %></a></td>
                              
                            </tr>
                          </table>
                        </div>
                        <%} %>
                      </div>
                      <div class="lansel_down"></div>
                    </div>
                  </div>
                </div>
    </div>
</div>
</div> </div>
<%=Html.Hidden("current_uri", string.Empty)%>
<%=Html.Hidden("loading_type", string.Empty)%>
