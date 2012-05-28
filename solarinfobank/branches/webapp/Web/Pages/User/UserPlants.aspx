<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.PlantUser>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   <%=Resources.SunResource.PLANT_ADDPLANT_ADD_PLANT  %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table cellpadding=0 cellspacing=0 border=0>
<tr>
 <td background="/images/kj/kjbg01.jpg" valign="top" width="793">
 <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0" width="793" height="63">
          <tbody><tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63"></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/sub/subico0120.gif" width="31" height="41"/></td>
                  <td class="pv0216"><%=Resources.SunResource.USER_ADDUSER_SELECTPLANTS%></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td align="right" width="6"><img src="/images/kj/kjico03.jpg" width="6" height="63"></td>
          </tr>
        </tbody></table>
        
        <form method="post" action="/user/userplantedit/">
        
        <%=Html.Hidden("uid",Request.QueryString["uid"]) %>
          <div class="subrbox01">

            <div class="sb_top"></div>
            <div class="sb_mid">
              <div></div>
              <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tbody><tr>
                  <td style="padding-top: 10px;" valign="top" width="25%"><span class="pr_10"><%=Resources.SunResource.USER_ADDUSER_SELECTPLANTS%>：</span></td>
                  <td style="padding-top: 10px;" width="75%">
                          <style>
                  .txtbu55{ padding:5px; width:500px; margin:5px; border:none; clear:both;  }
                  .txtbu55,.txtbu05 li{  list-style:none; margin:0; padding:0; }
                  .txtbu55 li{ height:25px; line-height:25px; width:100%;}
                  .txtbu55 li input{ margin-right:5px; margin-left:5px; }
                  .txtbu55 li span{ margin-right:5px; margin-left:5px; line-height:23px; height:23px;}
                  
                  </style>
                        <ul class="txtbu55">
                  
               <%foreach (Plant plant in Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().plants)
                 { %>
                  
                  <%
                     var select=false;
                     foreach(var item in Model)
                    {
                        if (item.plantID.Equals(plant.id))
                        {
                            select = true;
                            break;
                        }
                        %>
                    <%}
                     if (select)
                     { %>
                       <li> <input type="checkbox" name="plants" checked="checked" value="<%=plant.id %>" /><span><%=plant.name%></span>  </li>
                 
                <%}
                     else
                     {%>
                      <li>  <input type="checkbox" name="plants" value="<%=plant.id %>" /><span><%=plant.name%></span>  </li>
                  <%   }
                 
                     
                 }%>
                  </ul>
                  
                  
                  </td>
                </tr>

              </tbody></table>
            </div>
            <div class="sb_down"></div>
          </div>
          <table align="center" border="0" cellpadding="0" cellspacing="0" width="244" height="60">
            <tbody><tr>
              <td width="111"><input name="Submit22" class="txtbu03" value="<%=Resources.SunResource.USER_EDIT_SAVE%>" type="submit"></td>
              <td width="108"><input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.ADMIN_COLLECTOR_EDIT_CANCEL%>" type="button" onclick="window.location='/user/plantUser'"></td>
            </tr>

          </tbody></table>
        </form>  
          
          </td>
       </tr>
</table>
</asp:Content>
