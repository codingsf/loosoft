<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
      <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.PLANT_MAP_PLANT_MAP%> 
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#mapform").validate({
                errorElement: "em",
                rules: {
                    longitude: {
                        number: true,
                        max:180,
                        min: -180
                    },
                    latitude: {
                        number: true,
                        max: 180,
                        min:-180
                        
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "longitude") {
                        $("#error_longitude").text('');
                        error.appendTo("#error_longitude");
                    }
                    if (element.attr("name") == "latitude") {
                        $("#error_latitude").text('');
                        error.appendTo("#error_latitude");
                    }
                },

                messages: {
                    longitude: {
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>",
                        max: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_MAX_NUMBER %></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_MIN_NUMBER %></span>"
                    },
                    latitude: {
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>",
                        max: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_MAX_NUMBER %></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_MIN_NUMBER %></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
   <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form id="mapform" action="/plant/savemap" enctype="multipart/form-data" method="post">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.PLANT_MAP_PLANT_MAP%></td>
                     <td align="center" class="help_r">
               <img src="/images/f5.gif" style="float:left;"/>
                     <a  style="float:left; margin-left:5px; margin-top:1px; color:#59903E; text-decoration:underline;" href="#" onclick ="initialize()"><%=Resources.SunResource.USER_PLANT_MAP_RELOAD%> </a></td>
                      
                      
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank"style="color:#59903E; float:left; text-decoration:underline; width:80px;">
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
        <div class="subrbox02">
            <table width="700" border="0" cellspacing="0" cellpadding="0" style="text-align:left;">
                <tr>
                    <td><strong><%=Resources.SunResource.PLANT_MAP_LONGITUD%>:</strong></td>
                    <td >
                        <%--<%= Html.TextBoxFor(model => model.longitude, new { @class = "txtbu01" })%>--%>
                        <%=Html.TextBox("long1", string.IsNullOrEmpty(this.Model.latitudeString) == false && this.Model.longitudeString.Split(',').Length > 0 ? this.Model.longitudeString.Split(',')[0] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">°</span>
                        <%=Html.TextBox("long2", string.IsNullOrEmpty(this.Model.latitudeString) == false && this.Model.longitudeString.Split(',').Length > 1 ? this.Model.longitudeString.Split(',')[1] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">'</span>
                        <%=Html.TextBox("long3", string.IsNullOrEmpty(this.Model.latitudeString) == false && this.Model.longitudeString.Split(',').Length > 2 ? this.Model.longitudeString.Split(',')[2] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">"</span>
                                                                
                    </td>
                    
                    <td><strong><%=Resources.SunResource.PLANT_MAP_LATITUDE%>:</strong></td>
                    <td >
                         <%= Html.HiddenFor(model=>Model.id) %>
                        <%--<%= Html.TextBoxFor(model => model.latitude, new { @class = "txtbu01" })%>--%>
                        <%=Html.TextBox("lat1", string.IsNullOrEmpty(this.Model.latitudeString)==false && this.Model.latitudeString.Split(',').Length > 0 ? this.Model.latitudeString.Split(',')[0] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">°</span>
                        <%=Html.TextBox("lat2", string.IsNullOrEmpty(this.Model.latitudeString) == false && this.Model.latitudeString.Split(',').Length > 1 ? this.Model.latitudeString.Split(',')[1] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">'</span>
                        <%=Html.TextBox("lat3", string.IsNullOrEmpty(this.Model.latitudeString) == false && this.Model.latitudeString.Split(',').Length > 2 ? this.Model.latitudeString.Split(',')[2] : string.Empty, new { @class = "txtbu01", style = "width:50px;" })%><span style="line-height:10px; height:28px; vertical-align:top;">"</span>
                                                                
                                                                
                    </td>
                    <td >
                        <%if (!AuthService.isAllow(AuthorizationCode.EDIT_PLANT_MAP) || UserUtil.isDemoUser)
                          { %><input name="Submit" type="button" class="subbu09" value="<%=Resources.SunResource.MONITORITEM_SAVE%>" />
                        <%}
                          else
                          {%>
                        <input name="Submit" type="submit" class="subbu01" value="<%=Resources.SunResource.MONITORITEM_SAVE%>" />
                        <%} %>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="red">
                        <span id="error_longitude" ></span>
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                        <span id="error_latitude"></span>
                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div class="subrbox01">
            <div style="background: #FFF; padding: 10px; text-align: center;">
                <div id="map" class="map" style="width: 730px; height: 500px; border: 5px soild Red;">
                </div>
            </div>
        </div>
    <script type="text/javascript" src="http://www.google.com/jsapi?key=<%= ConfigurationManager.AppSettings["map.key."+RequestUtil.getMainDomain(Request.Url.Host)]%>"></script>

    <script type="text/javascript">
        google.load('maps', '2', {language: '<%= Session["Culture"]==null?"en-us":((CultureInfo)Session["Culture"]).Name.ToLower() %>'});
        var map;
        function initialize() {
            map = new GMap2(document.getElementById("map"));
            map.setCenter(new GLatLng(<%=Model.latitude.ToString("0.0000") %>, <%=Model.longitude.ToString("0.0000") %>), 8);
            map.addMapType(G_SATELLITE_3D_MAP);

            map.addControl(new GLargeMapControl());

            var marker = new GMarker(new GLatLng(<%=Model.latitude.ToString("0.0000") %>, <%=Model.longitude.ToString("0.0000") %>));
            GEvent.addListener(marker, "click", function() {
                var html = '<div style=\"text-align: left;\"><a href=\"/plant/overview/<%=Model.id %>\" target=\"_parent\"><span style=\"font-size:12px; font-weight:bold; color:#41465C; line-height:20px;\"><%=Model.name %></span></a><div style=\"font-size:11px; color: #5A5A5A; padding:10px 0px; \"><ul style=\"margin:0px; padding:0px; list-style:none;\"><li><%=Model.country %><%=Model.city %><%=Model.street %></li><li><%=Resources.SunResource.PLANT_PROFILE_LONGITUDE %>:<%=Model.long1 %>°<%=Model.long2 %>\'<%=Model.long3 %>"</li><li><%=Resources.SunResource.PLANT_PROFILE_LATITUDE %>:<%=Model.lat1 %>°<%=Model.lat2 %>\'<%=Model.lat3 %>"<li></ul></div><div style=\"font-size:12px; text-align:right;text-decoration:none; color:#515772;line-height:25px; border-top:1px solid #E2E2E2;\"><a href=\"/plant/overview/<%=Model.id %>\" target=\"_parent\" style=\"text-decoration:none; color:#515772;\"><%=Resources.SunResource.PLANT_MAP_ENTER %> >> </a></div></div>';
                marker.openInfoWindowHtml(html);
            });
            map.addOverlay(marker);
            GEvent.trigger(marker, "click");
        }
    </script>
        <script>
            initialize();
        </script>

        </form>
    </td>
	</tr>
</table>       
</asp:Content>
