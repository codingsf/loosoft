<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Inside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.PLANT_INFO_TOTALl_METER%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <td width="793" valign="top" background="/images/kj/kjbg01.gif">
		<table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216">Total Meter</td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"> classHere you can display visual configuration. By clicking on the elements in the tree </td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
		<div class="subrbox01">
		  <table width="100%" height="250" border="0" cellpadding="0" cellspacing="0">
            <tr>
             <td width="35%" valign="middle">
             <%if (string.IsNullOrEmpty(Model.firstPic))
               { %> 
               <img src="/ufile/nopic/nopico02.gif"  style="border:3px solid #545454; max-width:234px ; max-height:205px" />
              <%}
               else
               { %>
               <img src="/ufile/<%=Model.firstPic %>"  style="border:3px solid #545454;  max-width:234px ; max-height:205px"  />
              <%} %>
              </td>
              <td width="65%" valign="middle"><table width="80%" border="0" cellspacing="0" cellpadding="0" style=" font-size:16px;">
                  <tr>
                    <td height="60" style=" border-bottom:1px dotted #BDBDBD;">Name: <span class="sb_top24"><%=Model.name %></span></td>
                  </tr>
                  <tr>
                    <td height="60" style=" border-bottom:1px dotted #BDBDBD;">Today Energy(kWh): <span class="sb_top24"><%=Model.TotalDayEnergy %></span></td>
                  </tr>
                  <tr>
                    <td height="60">Total Energy (kWh): <span class="sb_top24"><%=Model.TotalEnergy%> </span></td>
                  </tr>
                </table></td>
            </tr>
          </table>
		</div>
		<div class="subrbox01">
		  <div class="sb_top"></div>
		    <div class="sb_mid">
		      <div class="Desc">
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="170"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td rowspan="2"><img src="/images/sub/subico01.gif" width="34" height="34" /></td>
                          <td class="sb_top14">Light Intensity</td>
                        </tr>
                        <tr>
                          <td class="sb_top24"> <%=(Model.Sunstrength!=0.0)?Model.Sunstrength.ToString():""%> W/m2</td>
                        </tr>
                    </table></td>
                    <td width="150"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td rowspan="2"><img src="/images/sub/subico02.gif" width="23" height="47" /></td>
                          <td class="sb_top14">Temperature</td>
                        </tr>
                        <tr>
                          <td class="sb_top24"> <%=ViewData["temp"]%>°<span style="font-size:18px;"><%=(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).TemperatureType %></span></td>
                        </tr>
                    </table></td>
                    <td width="190"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td rowspan="2"><img src="/images/sub/subico03.gif" width="42" height="45" /></td>
                          <td class="sb_top14">CO2 Reductiong</td>
                        </tr>
                        <tr>
                          <td class="sb_top24"> <%=Model.Reductiong %> <span style="font-size:18px;"><%=Model.ReductiongUnit %></span></td>
                        </tr>
                    </table></td>
                    <td width="200"><table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td rowspan="2"><img src="/images/sub/subico04.gif" width="42" height="45" /></td>
                          <td class="sb_top14">Revenue</td>
                        </tr>
                        <tr>
                          <td class="sb_top24"><span style="font-size:18px;"> 
                          <%=Model.revenue%> 
                          <%=Model.currencies %>
                          </span></td>
                        </tr>
                    </table></td>
                  </tr>
                </table>
		      </div>
		  </div>
		  <div class="sb_down"></div>
		  </div></td>
</asp:Content>
