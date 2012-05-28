<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
     <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %>  <%=Resources.SunResource.PLANT_PROFILE_PROFILE%>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
    .pl01{ padding-left:15px; }
    .pl02{ padding-left:15px; background:#F3F3F2;}
    .ades{ line-height:24px; padding:0px 15px;}
    .help_r{ font-size:11px;}
</style>

    <script type="text/javascript">
    var plantpic="<%= ViewData["pic"]%>";
    if(plantpic!=""){
        var pic="";
        if(plantpic.substring(0,1)==",")
        {
             pic=  plantpic.substring(1);
        }
        else
        {
            pic=  plantpic.substring(0);
        }
        
        var ppicArr = pic.split(",");
        var curPicIndex=0;
        function playPic(){
      if(ppicArr[curPicIndex]!="")
      {
            var html="<div style='width:320px; overflow:hidden'><img src='/ufile/"+ppicArr[curPicIndex]+"' style='max-width:320px; max-height:315px;'/></div>";
            $("#idContainer").empty();
            $("#idContainer").append(html);
            }
        }
        function intervalDisplayPic(){
                if(curPicIndex+1>ppicArr.length-1){
                    curPicIndex = 0;
                }else{
                    curPicIndex+=1;
                }
                playPic();
        }
        $(document).ready(function() {
                playPic();
                window.setInterval(intervalDisplayPic,4000);
        });
    }else{
         $(document).ready(function() {
            var html="<img src='/ufile/nopic/nopico02.gif'  style='max-width:310px; max-height:315px;' class='kjdpic' />";
            $("#idContainer").append(html);
        });
    }
    </script>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
   <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
   <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.PLANT_PROFILE_PLANT_PROFILE  %></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%" class="pv0212"><%=Resources.SunResource.PLANT_PROFILE_PLANT_PROFILE_DETAIL  %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
          <div class="subrbox01">
            <div>
              <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="6%" align="center"><img src="/images/sub/subico010.gif" width="18" height="19" /></td>
                  <td class="f_14"><strong><%=Resources.SunResource.PLANT_PROFILE_EDIT_POWER_STATION_INFORMATION  %></strong></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="56%">
				  <div style="padding-bottom:10px;">
				  <div class="kjdbu"><img src="/images/kj/kjbg06.gif" width="417" height="8" /></div>
            <div class="kjdmid">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="35%" height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_NAME  %> :</strong></td>
                  <td width="65%"><span class="tb_g"><%=Html.Encode( Model.name) %></span></td>
                </tr>
                <tr>
                  <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_INSTALLDATE %> :</strong></td>
                  <td width="55%"><span class="tb_g"><%=Html.Encode( Model.installdate.ToString("yyyy-MM-dd"))%></span></td>
                </tr>
                <tr>
                  <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_DESIGNPOWER %> :</strong></td>
                  <td width="55%"><span class="tb_g"><%=Html.Encode( Model.design_power) %>&nbsp;kWp</span></td>
                </tr>
              </table>
            </div>
            <div class="kjdbd">
            
            </div>
			</div>
			</td>
                  <td width="44%" rowspan="2" align="center" id="idContainer">
                  </td>
                </tr>
                <tr>
                  <td><div style="padding-bottom:10px;">
                    <div class="kjdbu"><img src="/images/kj/kjbg06.gif" width="417" height="8" /></div>
                    <div class="kjdmid">
                      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="35%" height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_LOCATION %> :</strong></td>
                          <td width="65%"><span class="tb_g"><%=Html.Encode( Model.location) %></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_LONGITUDE %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Model.long1 %><span style="line-height:10px; height:28px; vertical-align:top;">°</span><%=Model.long2 %><span style="line-height:10px; height:28px; vertical-align:top;">'</span><%=Model.long3 %><span style="line-height:10px; height:28px; vertical-align:top;">"</span></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_LATITUDE %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Model.lat1 %><span style="line-height:10px; height:28px; vertical-align:top;">°</span><%=Model.lat2 %><span style="line-height:10px; height:28px; vertical-align:top;">'</span><%=Model.lat3 %><span style="line-height:10px; height:28px; vertical-align:top;">"</span></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_MANUFACTURER %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Html.Encode( Model.manufacturer) %></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_MODULE_TYPE %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Html.Encode( Model.module_type)%></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_ANGLE %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Html.Encode( Model.angle) %></span></td>
                        </tr>
                        <tr>
                          <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_TIMEZONE %> :</strong></td>
                          <td width="55%"><span class="tb_g"><%=Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(Model.timezone) %></span></td>
                        </tr>
                      </table>
                    </div>
                    <div class="kjdbd"></div>
                  </div></td>
                </tr>
              </table>
            </div>
          <div class="subrbox01">
            <div class="sb_top"></div>
            <div class="sb_mid">
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="19%" height="28"class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_OPERATOR %> :</strong></td>
                      <td width="81%"><span class="tb_g"><%=Html.Encode( Model.operater) %></span></td>
                      
                      </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_COUNTRY %> :</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.country) %></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_CITY %> :</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.city) %></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_STREET %> :</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.street) %></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_ZIPCODE %> :</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.postcode) %></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_PHONE %> :</strong></td>
                      <td><span class="tb_g"><%= Html.Encode( Model.phone) %></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_PROFILE_EMAIL %> :</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.email )%></span></td>
                      
                    </tr>
                    <tr>
                      <td height="28" class="pl20"><strong><%=Resources.SunResource.PLANT_ADDPLANT_REDUCTRATE%>:</strong></td>
                      <td><span class="tb_g"><%=Html.Encode( Model.revenueRate)%></span></td>
                      
                    </tr>
                    
                  </table>
            </div>
              
            <div class="sb_down"></div>
          </div>
          <div class="subrbox01">
            <div class="sb_top"></div>
            <div class="sb_mid">
			<div class="ades">
             <strong><%=Resources.SunResource.PLANT_PROFILE_DESCRIPTION %>:</strong>
             <%=Model.description==null?"":Model.description.Replace("script", string.Empty)%>
            </div>
            
          </div><div class="sb_down"></div>
          <div style="padding-right:20px; text-align:right; padding-top:15px; padding-bottom:15px;">
            <%if (!AuthService.isAllow(AuthorizationCode.EDIT_PLANT))
              { %><input name="Submit" type="button" class="subbu09" value="<%=Resources.SunResource.MONITORITEM_EDIT %>" />
            <%}
              else
              {%>
            <input name="Submit" type="button" class="subbu01" value="<%=Resources.SunResource.MONITORITEM_EDIT %>" onclick="javscript:window.location.href='/plant/edit/<%=Model.id %>'" />
            <%} %>
          </div>
        </td>
	</tr>
</table>             
</asp:Content>
