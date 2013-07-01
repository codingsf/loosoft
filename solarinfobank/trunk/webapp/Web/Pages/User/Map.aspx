<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.PLANT_MAP_PLANT_MAP%> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding=0 cellspacing=0 border=0>
    <tr>
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
		<table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777">
            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.PLANT_MAP_PLANT_MAP%></td>
                     <td align="center" class="help_r">
                    <img src="/images/f5.gif" style="float:left;"/>
                     <a  style="float:left; margin-left:5px; margin-top:1px; color:#59903E; text-decoration:underline;" href="#" onclick ="initialize()"><%=Resources.SunResource.USER_PLANT_MAP_RELOAD%> </a>
                     </td>
                      
                    <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; float:left; text-decoration:underline; width:80px;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.PLANT_MAP_PLANT_MAP_DETAIL%>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
		<div class="subrbox01"><div style=" background:#FFF; padding:10px; text-align:center;">
		<div id="map" class="map" style="width: 730px; height: 500px; border:5px soild Red; "></div></div>
		</div>
		
		     <script type="text/javascript" src="http://www.google.com/jsapi?key=<%= ConfigurationManager.AppSettings["map.key."+RequestUtil.getMainDomain(Request.Url.Host)]%>"></script>
		<script type="text/javascript">
        function addListener(pointMarker, latlng, content) {
            GEvent.addListener(pointMarker, latlng, function() {
                pointMarker.openInfoWindowHtml(content,50,50);
            });
        }
        
        google.load('maps', '2', {language: '<%= Session["Culture"]==null?"en-us":((CultureInfo)Session["Culture"]).Name.ToLower() %>'});
        var map;
        function initialize() {
            map = new GMap2(document.getElementById("map"));
            map.setCenter(new GLatLng(<%=(ViewData["plant"] as IList<Plant>).Count>0?(ViewData["plant"] as IList<Plant>)[0].latitude.ToString("0.0000"):"37.4419" %>, <%=(ViewData["plant"] as IList<Plant>).Count>0?(ViewData["plant"] as IList<Plant>)[0].longitude.ToString("0.0000"):"-122.1419" %>), <%=ViewData["point"] %>);
            map.addMapType(G_SATELLITE_3D_MAP);
            map.addControl(new GLargeMapControl());
            map.addControl(new GOverviewMapControl());
              <% for (int i = 0; i < (ViewData["plant"] as IList<Plant>).Count; i++)
               { %>
            var content = '<div style=\"text-align: left; height:110px; width:210px;\"><a href=\"/plant/overview/<%=(ViewData["plant"] as IList<Plant>)[i].id%>\" target=\"_parent\"><span style=\"font-size:12px; font-weight:bold; color:#41465C; line-height:20px;\"><%=(ViewData["plant"] as IList<Plant>)[i].name%></span></a><div style=\"font-size:11px; color: #5A5A5A; padding:10px 0px; \"><ul style=\"margin:0px; padding:0px; list-style:none;\"><li><%=(ViewData["plant"] as IList<Plant>)[i].country %><%=(ViewData["plant"] as IList<Plant>)[i].city %><%=(ViewData["plant"] as IList<Plant>)[i].street %></li><li><%=Resources.SunResource.PLANT_PROFILE_LONGITUDE %>：<%=(ViewData["plant"] as IList<Plant>)[i].long1 %>°<%=(ViewData["plant"] as IList<Plant>)[i].long2 %>\'<%=(ViewData["plant"] as IList<Plant>)[i].long3 %>"</li><li><%=Resources.SunResource.PLANT_PROFILE_LATITUDE %>：<%=(ViewData["plant"] as IList<Plant>)[i].lat1 %>°<%=(ViewData["plant"] as IList<Plant>)[i].lat2 %>\'<%=(ViewData["plant"] as IList<Plant>)[i].lat3 %>"<li></ul></div><div style=\"font-size:12px; text-align:right;text-decoration:none; color:#515772;line-height:25px; border-top:1px solid #E2E2E2;\"><a href=\"/plant/overview/<%=(ViewData["plant"] as IList<Plant>)[i].id%>\" target=\"_parent\" style=\"text-align:right;text-decoration:none; color:#515772;\"><%=Resources.SunResource.PLANT_MAP_ENTER %> >> </a></div></div>';
             var marker = new GMarker(new GLatLng(<%=(ViewData["plant"] as IList<Plant>)[i].latitude.ToString("0.0000")%>, <%=(ViewData["plant"] as IList<Plant>)[i].longitude.ToString("0.0000")%>));
             addListener(marker, "click", content);
             map.addOverlay(marker);

            <%} %>          
        }
        </script>
        <script type="text/javascript">
        initialize();
        </script>
		</td>
		</tr>
		</table>
</asp:Content>
