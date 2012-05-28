<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Resources.SunResource.USER_FINDPASSWORD_FIND_PASSWORD  %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {

            $("#uname").focus(function() {
                $("#client_error").show();
                //$("#server_error").hide();
            });
            $("#findForm").validate({
                errorElement: "em",
                rules: {
                    uname: {
                        required: true

                    },
                    email: {
                        email: true,
                        required: true

                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "email") {
                        $("#error_email").text('');
                        error.appendTo("#error_email");
                    }
                    if (element.attr("name") == "uname") {
                        $("#error_uname").text('');
                        error.appendTo("#error_uname");
                    }
                },

                messages: {
                    email: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_FINDPASSWORD_EMAIL_REQUIRED  %></span>",
                        email: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_EDIT_EMAIL_EMAIL  %></span>"
                    },
                    uname:
                    {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.ADMIN_MANAGER_EDIT_USERNAME_REQUIRED  %></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <div class="mainbox">
        <div class="qbox">
            <form method="post" action="/public/findpassword" id="findForm">
            <table width="100%" height="222" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="13" background="/images/qimg/qbg01.jpg">
                        &nbsp;
                    </td>
                    <td width="728" background="/images/qimg/qbg03.jpg">
                        <table width="97%" height="143" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="11%" rowspan="3" valign="top">
                                    <img src="/images/qimg/qico02.gif" width="63" height="93" />
                                </td>
                                <td width="89%" height="54" valign="top" style="color: #5A9A41; line-height: 20px;">
                                    <%=Resources.SunResource.USER_FINDPASSWORD_YOU_FORGOT_YOUR_PASSWORD  %>?<br />
                                    <%=Resources.SunResource.USER_FINDPASSWORD_YOU_FORGOT_YOUR_PASSWORD_DTAIL  %>
                                </td>
                            </tr>
                            <tr>
                                <td height="38">
                                    <strong>
                                        <%=Resources.SunResource.USER_FINDPASSWORD_PLEASE_ENTER_YOUR_SUNINFOBANK_EMAIL_ADDRESS  %>:
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="680" border="0" cellspacing="0" cellpadding="0">
                                        <tr valign="top">
                                            <td width="80">
                                            <span style="white-space:nowrap"><%=Resources.SunResource.USER_ADDUSER_USER_NAME%>:</span>
                                            </td>
                                            <td width="146">
                                                <input name="uname" type="text" id="uname" class="txtbu04" size="18" onfocus="$('#serverError').hide()" />
                                            </td>
                                            <td width="50">
                                                <%=Resources.SunResource.USER_FINDPASSWORD_EMAIL  %>:
                                            </td>
                                            <td width="146">
                                                <input name="email" type="text" id="email" class="txtbu04" size="18" onfocus="$('#serverError').hide()" />
                                            </td>
                                            <td width="173">
                                                <input name="Submit" type="submit" class="subbu01" value="<%=Resources.SunResource.USER_FINDPASSWORD_GO  %>" />
                                            </td>
                                        </tr>
                                        <tr <%=ViewData["error"]==null?"":"style='display:none;'"  %> id="client_error" valign="top">
                                            <td colspan="2" height="45">
                                                <span id="error_uname"></span>
                                            </td>
                                            <td colspan="2" height="45">
                                                <span id="error_email"></span>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr id="server_error">
                                            <td colspan="5" height="45">
                                                <%= ViewData["error"] %>
                                            </td>
                                        
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="13" background="/images/qimg/qbg02.jpg">
                        &nbsp;
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
</asp:Content>
