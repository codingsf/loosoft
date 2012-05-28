﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    查看用户信息
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td background="/images/kj/kjbg01.jpg" valign="top" width="793">

                <script src="/script/jquery.js" type="text/javascript"></script>

                <script src="/script/jquery.validate.js" type="text/javascript"></script>

                <script type="text/javascript" language="javascript">
      $().ready(function() {
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
                                        oldname: "" 
                                }
                            }
                 },
                  password: {
                      required: true,
                      minlength: 6
                  },
                  repassword:
                  {
                   required: true,
                   minlength: 6,
                   equalTo: "#password"
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
                   if (element.attr("name") == "repassword") {
                      $("#error_repassword").text('');
                      error.appendTo("#error_repassword");
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
                  
                    repassword: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD_REQUIRED%></span>",
                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_MINLENGTH%></span>",
                        equalTo: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD_EQUALTO%></span>"
                    },
                  email: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_EMAIL_REQUIRED %></span>",
                      email: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_EMAIL %></span>",
                      maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AHTH_REG_CONFIRM_PASSWORD_MINLENGTH %></span>",
                      
                  }
              },
              success: function(em) {
              },
          });

      });
                </script>

                <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0"
                    width="793" height="63">
                    <tbody>
                        <tr>
                            <td width="8">
                                <img src="/images/kj/kjico02.jpg" width="8" height="63">
                            </td>
                            <td width="777">
                                <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="7%" rowspan="2" align="center">
                                            <img src="/images/kj/kjiico01.gif" />
                                        </td>
                                        <td class="pv0216">
                                            <%=Resources.SunResource.USER_ADD_USER_SHOW_INFO%>
                                        </td>
                                        <td align="right" class="help_r">
                                            <a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf"
                                                target="_blank" style="color: #59903E; text-decoration: underline;">
                                                <%=Resources.SunResource.MONITORITEM_HELP%>
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="75%">
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;
                                        </td>
                                        <td width="18%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" width="6">
                                <img src="/images/kj/kjico03.jpg" width="6" height="63">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="subrbox01">
                    <div>
                        <table border="0" cellpadding="0" cellspacing="0" width="90%" height="30">
                            <tbody>
                                <tr>
                                    <td align="center" width="6%">
                                        <img src="/images/sub/subico010.gif" width="18" height="19">
                                    </td>
                                    <td class="f_14" width="94%">
                                        <strong>
                                            <%=Resources.SunResource.USER_ADD_USER_SHOW_INFO%></strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                                <tr style="display:none">
                                    <td width="30%" height="35" class="pr_10">
                                        <strong>
                                            <%=Resources.SunResource.USER_ADDUSER_USER_ROLE%>： </strong>
                                    </td>
                                    <td width="70%">
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%" height="35" class="pr_10">
                                        <strong>
                                            <%=Resources.SunResource.USER_ADDUSER_USER_NAME%>： </strong>
                                    </td>
                                    <td>
                                        <%= Html.DisplayTextFor(model => model.username)%>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td height="35" class="pr_10">
                                        <span>
                                            <%=Resources.SunResource.USER_ADDUSER_PASSWORD%>：</span>
                                    </td>
                                    <td>
                                        <%= Html.DisplayTextFor(model => model.password)%>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="35" class="pr_10">
                                        <strong>
                                            <%=Resources.SunResource.USER_ADDUSER_EMAIL%>：</strong>
                                    </td>
                                    <td>
                                        <%= Html.DisplayTextFor(model => model.email)%>
                                        <span class="redzi">&nbsp;</span> &nbsp;&nbsp; <span id="error_email"></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                                <tr>
                                    <td style="padding-top: 10px;" valign="top" width="30%" class="pr_10">
                                        <span>
                                            <%=Resources.SunResource.USER_ADDUSER_SELECTED_PLANTS%>：</span>
                                    </td>
                                    <td style="padding-top: 10px;">
                                        <style>
                                            .txtbu05
                                            {
                                                padding: 5px;
                                                width: 500px;
                                                margin: 5px;
                                                float: left;
                                                max-height: 200px;
                                                overflow: auto;
                                            }
                                            .txtbu05, .txtbu05 li
                                            {
                                                list-style: none;
                                                margin: 0;
                                                padding: 0;
                                            }
                                            .txtbu05 li
                                            {
                                                height: 25px;
                                                line-height: 25px;
                                                float: left;
                                                width: 100%;
                                                clear: both;
                                            }
                                            .txtbu05 li input
                                            {
                                                margin-right: 5px;
                                                margin-left: 5px;
                                            }
                                            .txtbu05 li span
                                            {
                                                margin-right: 5px;
                                                margin-left: 5px;
                                                line-height: 23px;
                                                height: 23px;
                                            }
                                        </style>
                                        <ul class="txtbu05">
                                        <!--用户分配的电站-->
                                            <%foreach (Plant plant in Model.assignedPlants)
                                              { %>
                                            <li><span>
                                                <%=plant.name %></span> </li>
                                            <%} %>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="padding-top: 10px;">
                                        &nbsp;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <table align="center" border="0" cellpadding="0" cellspacing="0" width="244" height="60">
                    <tbody>
                        <tr>
                            <td width="111">
                                <input name="addUser" class="txtbu03" value="<%=Resources.SunResource.ADMIN_DBCONFIG_LIST_EDIT%>"
                                    type="button" onclick="window.location.href='/user/useredit?uid=<%=Model.id %>&role=0'">
                            </td>
                            <td width="108">
                                <input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.ADMIN_COLLECTOR_EDIT_CANCEL%>"
                                    type="button" onclick="window.location.href='/user/plantUser'">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
