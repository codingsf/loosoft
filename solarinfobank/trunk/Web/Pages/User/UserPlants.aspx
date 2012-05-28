<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.PlantUser>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  分配电站
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table cellpadding=0 cellspacing=0 border=0>
<tr>
 <td background="/images/kj/kjbg01.jpg" valign="top" width="793">
 <script language="javascript" type="text/javascript">
                    function getradio(name) {
                        return $("input[name='" + name + "']:checked").val();
                    }

                    function getcheckboxes(name,attr) {
                        var values = "";
                        $("input[name='" + name + "']:checked").each(function() {
                            values += $(this).attr(attr) + ",";
                        });
                        values == "" ? '-1,' : values;
                        return values;
                    }

                    $().ready(function() {
                        $("#btnSave").click(function() {
                            $.ajax({
                                type: "POST",
                                url: "/user/saveshareplant",
                                data: { singlemark: '0', pids: getcheckboxes('plant', 'ref'), ut: 1, role: getradio('role'), uname: '<%=ViewData["uname"] %>', upwd: '<%=ViewData["pwd"] %>', ucfmpwd: '', email: '', sendmail: 'false' },
                                success: function(result) {
                                    if (result == "ok")
                                        window.location.href = "/user/plantuser";
                                    else
                                        alert(result.substring(6));
                                }
                            });
                        });
                    });
                </script>
 <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0" width="793" height="63">
          <tbody><tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63"></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
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
                  
               <%foreach (Plant plant in ViewData["plants"] as IList<Plant>)
                 { %>
                  
                  <%
                     var select=false;
                     foreach(var item in Model)
                    {
                        if (item.plantID==plant.id)
                        {
                            select = true;
                            break;
                        }
                        %>
                    <%}
                     if (select)
                     { %>
                       <li> <input type="checkbox" name="plant" checked="checked"  ref="<%=plant.id%>" /><span><%=plant.name%></span>  </li>
                 
                <%}
                     else
                     {%>
                      <li>  <input type="checkbox" name="plant" ref="<%=plant.id %>"/><span><%=plant.name%></span>  </li>
                  <%   }
                 
                     
                 }%>
                 
                  </ul>
                  </td>
                </tr>
                
              <tr style="display:none;">
                  <td style="padding-top: 10px;" valign="top" width="25%"><span class="pr_10">角色：</span></td>
                  <td style="padding-top: 10px;" width="75%">
                  
                  <table border="0" cellpadding="0" cellspacing="0" width="70%">
                                        <tr>
                                            <%int i = 0;
                                              foreach (var item in ViewData["roles"] as IList<Role>)
                                              {
                                                  if (i++ % 2 == 0 && i > 1)
                                                      Response.Write("<td width=\"33%\" bgcolor=\"#F3F3F3\" style=\"padding-left: 5px;\">&nbsp;</td></tr><tr>");
                                            %>
                                            <td width="33%" bgcolor="#F3F3F3">
                                                <strong>
                                                    <input checked="checked" type="radio" name="role" value="<%=item.id %>" />
                                                </strong>
                                                <%=item.name%>
                                            </td>
                                            <%}
                                              while ((i++ % 3) != 0)
                                                  Response.Write("<td width=\"33%\" bgcolor=\"#F3F3F3\" style=\"padding-left: 5px;\">&nbsp;</td>");
                                            %>
                                        </tr>
                                    </table>
                  
                  </td>
                </tr>  
                
                

              </tbody></table>
            </div>
            <div class="sb_down"></div>
          </div>
          <table align="center" border="0" cellpadding="0" cellspacing="0" width="244" height="60">
            <tbody><tr>
              <td width="111"><input id="btnSave" class="txtbu03" value="<%=Resources.SunResource.USER_EDIT_SAVE%>" type="button"></td>
              <td width="108"><input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.ADMIN_COLLECTOR_EDIT_CANCEL%>" type="button" onclick="window.location='/user/plantUser'"></td>
            </tr>

          </tbody></table>
        </form>  
          
          </td>
       </tr>
</table>
</asp:Content>
