<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   编辑用户
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td background="/images/kj/kjbg01.gif" valign="top" width="793">

    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
      $().ready(function() {
            parent.iFrameHeight();
          $("#editForm").validate({
              errorElement: "em",
              rules: {
                  username: {
                      required: true,
                      minlength: 2,
                      maxlength: 30,
                        remote: {
                            type: "POST",
                            url: "/user/checkuser",
                            data: {
                                uname: function() { return $("#username").val(); },
                                oldname:function() { return $("#o_name").val(); }
                                }
                            }

                  },
                  password: {
                      required: true,
                      minlength: 6
                  },
                  email: {
                      email: true,
                      maxlength: 30
                      
                  }
              },
              errorPlacement: function(error, element) {
                  if (element.attr("name") == "username") {
                      $("#error_username").text('');
                      error.appendTo("#error_username");
                  }
                  if (element.attr("name") == "password") {
                      $("#error_password").text('');
                      error.appendTo("#error_password");
                  }
                  if (element.attr("name") == "email") {
                      $("#error_email").text('');
                      error.appendTo("#error_email");
                  }
              },

              messages: {
                  username: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_REQUIRED %></span>",
                      minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_MINLENGTH %></span>",
                      maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_TIP_USERNAME %></span>",
                      
                      remote: "<span class='error'>&nbsp;<%=Resources.SunResource.AJAX_CHACKING_USERNAME%></span>"
                      
                  },
                  password: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_REQUIRED%></span>",
                      minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_MINLENGTH%></span>"
                  },
                  email: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_EMAIL_REQUIRED %></span>",
                      email: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_EMAIL %></span>",
                      maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AHTH_REG_CONFIRM_PASSWORD_MINLENGTH %></span>"
                          
                          
                      
                  }
              },
              success: function(em) {
              }
          });

      });
    </script>
  
  <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0" width="793" height="63">
          <tbody><tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63"></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif" width="31" height="41"/></td>
                  <td class="pv0216"><%=Resources.SunResource.USER_EDIT_EDIT_USER%></td>
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
        
        <form method="post" action="/user/portaluseredit" name="editForm" id="editForm">
          <div class="subrbox01">

            <div>
              <table border="0" cellpadding="0" cellspacing="0" width="90%" height="30">
                <tbody><tr>
                  <td align="center" width="6%"><img src="/images/sub/subico010.gif" width="18" height="19"></td>
                  <td class="f_14" width="94%"><strong><%=Resources.SunResource.USER_EDIT_EDIT_USER%></strong></td>
                </tr>
              </tbody></table>
            </div>

            <div class="sb_top"></div>
            <div class="sb_mid">
              <div></div>
              <div class="note01" style="margin-bottom: 10px;"><%=Resources.SunResource.AUTH_REG_NOTE%> :*<%=Resources.SunResource.USER_EDIT_FOR_MUST_FILL_IN_THE_ITEM1%></div>
              <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
                <tbody><tr style="display:none">
                  <td class="pr_10" width="29%" height="35"><%=Resources.SunResource.USER_ADDUSER_USER_ROLE%>： </td>
                  <td>
                   <%=Html.RadioButton("role", 1, ViewData["roleId"].ToString().Trim() == "1")%>

                    <%=Resources.SunResource.USER_ROLE_1%>
                    
                    
                     <%=Html.RadioButton("role", 2, ViewData["roleId"].ToString().Trim() == "2")%>
                    <%=Resources.SunResource.USER_ROLE_2%>
                    
                    
                     <%=Html.RadioButton("role", 3, ViewData["roleId"].ToString().Trim() == "3")%>
                    <%=Resources.SunResource.USER_ROLE_3%>
                    </td>
                </tr>
                <tr>
                  <td class="pr_10" width="29%" height="35"><%=Resources.SunResource.USER_ADDUSER_USER_NAME%>： </td>
                  <td>
                  <%= Html.HiddenFor(model => model.id, new { @class = "txtbu01" })%>

                  <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01" })%>
                  
                  <%= Html.Hidden("o_name",Model.username)%>
                  

                      <span class="redzi">*</span>  &nbsp;<span id="error_username"></span></td>
                </tr>
                <tr>
                  <td class="pr_10" height="35"><%=Resources.SunResource.USER_ADDUSER_PASSWORD%>：</td>
                  <td>
                  
                              <input class="txtbu01" id="password" name="password" type="text" value="" />
                      <span class="redzi">*</span>  &nbsp;<span id="error_password"></span>
                      </td>
                </tr>

                <tr>
                  <td class="pr_10" height="35"><%=Resources.SunResource.USER_ADDUSER_EMAIL%>：</td>
                  <td>
                  
                     <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01" })%>
                     
                     <span class="redzi">&nbsp;&nbsp;</span>  &nbsp;<span id="error_email"></span>
                </tr>
                
                
                <tr>
                  <td class="pr_10" height="35"></td>
                  <td>
                  
                      <%=Html.CheckBox("mail",false) %>
                      <%=Resources.SunResource.USER_ADDUSER_SEND_ACCOUNT_MAIL%></td>
                </tr>
                
                
              </tbody></table>

            </div>
            <div class="sb_down"></div>
          </div>
          <table align="center" border="0" cellpadding="0" cellspacing="0" width="244" height="60">
            <tbody><tr>
              <td width="111"><input name="Submit22" class="txtbu03" value="<%=Resources.SunResource.USER_EDIT_SAVE%>" type="submit"></td>
              <td width="108"><input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.ADMIN_COLLECTOR_EDIT_CANCEL%>" type="button" onclick="window.location='/user/portalUser'"></td>
            </tr>
          </tbody></table>
          </form>
          
          </td>
  		</tr>
</table>
</asp:Content>