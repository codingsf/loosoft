<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td background="/images/kj/kjbg01.jpg" valign="top" width="793">

            <script src="/script/jquery.js" type="text/javascript"></script>

            <script src="/script/jquery.validate.js" type="text/javascript"></script>

            <script type="text/javascript" language="javascript">
                function cando() {
                    if ('<%=ViewData["cando"] %>' == 'false') {
                        alert('您没有创建门户请先创建门户');
                        return false;
                    }
                    return true;
                }
                $().ready(function() {
                    $("#username").get(0).focus();
                    cando();
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
                                maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AHTH_REG_CONFIRM_PASSWORD_MINLENGTH %></span>"

                            }
                        },
                        success: function(em) {
                        }
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
                                        <%=Resources.SunResource.USER_ADD_USER_CREATE%>
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
            <form action="/user/addportaluser" method="post" id="editForm">
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
                                        <%=Resources.SunResource.USER_ADD_USER_CREATE%></strong>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="sb_top">
                </div>
                <div class="sb_mid">
                    <div>
                    </div>
                    <div class="note01" style="margin-bottom: 10px;">
                        <%=Resources.SunResource.AUTH_REG_NOTE%>
                        :*<%=Resources.SunResource.USER_EDIT_FOR_MUST_FILL_IN_THE_ITEM1%></div>
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr style="display: none">
                                <td width="23%" height="35" class="pr_10">
                                    <strong>
                                        <%=Resources.SunResource.USER_ADDUSER_USER_ROLE%>： </strong>
                                </td>
                                <td width="77%">
                                    <%=Html.RadioButton("role",1,true) %>
                                    <%=Resources.SunResource.USER_ROLE_1%>
                                    <%=Html.RadioButton("role",2,false) %>
                                    <%=Resources.SunResource.USER_ROLE_2%>
                                    <%=Html.RadioButton("role",3,false) %>
                                    <%=Resources.SunResource.USER_ROLE_3%>
                                </td>
                            </tr>
                            <tr>
                                <td width="23%" height="35" class="pr_10">
                                    <strong>
                                        <%=Resources.SunResource.USER_ADDUSER_USER_NAME%>： </strong>
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01",style="width:160px" })%>
                                    <span class="redzi">*</span> &nbsp; <span id="error_username"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <span>
                                        <%=Resources.SunResource.USER_ADDUSER_PASSWORD%>：</span>
                                </td>
                                <td>
                                    <%= Html.PasswordFor(model => model.password, new { @class = "txtbu01", style = "width:160px" })%>
                                    <span class="redzi">*</span> &nbsp; <span id="error_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <span>
                                        <%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD%>：</span>
                                </td>
                                <td>
                                    <%= Html.Password("repassword", string.Empty, new { @class = "txtbu01", style = "width:160px" })%>
                                    <span class="redzi">*</span> &nbsp; <span id="error_repassword"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <strong>
                                        <%=Resources.SunResource.USER_ADDUSER_EMAIL%>：</strong>
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", style = "width:160px" })%>
                                    <span class="redzi">&nbsp;</span> &nbsp;&nbsp; <span id="error_email"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35">
                                    &nbsp;
                                </td>
                                <td height="18">
                                    <%=Html.CheckBox("mail",false) %>
                                    <%=Resources.SunResource.USER_ADDUSER_SEND_ACCOUNT_MAIL%>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td style="padding-top: 10px;" valign="top" width="23%" class="pr_10">
                                    <span>
                                        <%=Resources.SunResource.USER_ADDUSER_SELECTPLANTS%>：</span>
                                </td>
                                <td width="77%">
                                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <%int i = 0;
                                              foreach (Plant item in ViewData["displayPlants"] as IList<Plant>)
                                              {
                                                  if (i++ % 2 == 0 && i > 1)
                                                      Response.Write("<td width=\"33%\" style=\"padding-left: 5px;\">&nbsp;</td></tr><tr>");
                                            %>
                                            <td width="33%" height="30">
                                                <strong>
                                                    <input type="checkbox" name="plants" value="<%=item.id%>" ref="<%=item.id%>" />
                                                </strong>
                                                <%=item.name%>
                                            </td>
                                            <%} %>
                                        </tr>
                                    </table>
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
                            <input name="addUser" onclick="return cando()" class="txtbu03" value="<%=Resources.SunResource.USER_EDIT_SAVE%>"
                                type="submit" />
                        </td>
                        <td width="108">
                            <input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.ADMIN_COLLECTOR_EDIT_CANCEL%>"
                                type="button" onclick="window.location.href='/user/portalUser'">
                        </td>
                    </tr>
                </tbody>
            </table>
            </form>
        </td>
    </tr>
</table>
