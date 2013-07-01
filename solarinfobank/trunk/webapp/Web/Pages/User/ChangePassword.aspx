<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.USER_CHANGEPASSWORD_CHANGEPASSWORD%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/script/countrycity.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        function reset() {
            $("#confirmPassword").val('');
            $("#password").val('');
            $("#oldPassword").val('');
        }

        $().ready(function() {
            $("#oldPassword").get(0).focus();
            $("#pwdform").validate({
                errorElement: "em",
                rules: {
                    oldPassword: {
                        required: true
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#password"
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "oldPassword") {
                        $("#error_old_password").text('');
                        error.appendTo("#error_old_password");
                    }
                    if (element.attr("name") == "password") {
                        $("#error_password").text('');
                        error.appendTo("#error_password");
                    }
                    if (element.attr("name") == "confirmPassword") {
                        $("#error_confirm_password").text('');
                        error.appendTo("#error_confirm_password");
                    }
                },

                messages: {
                    oldPassword: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_CHANGEPASSWORD_PASSWORD_REQUIRED%></span>"
                    },
                    password: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_CHANGEPASSWORD_NEW_PASSWORD_REQUIRED%></span>",
                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_CHANGEPASSWORD_NEW_PASSWORD_MINLENGTH%></span>"
                    },
                    confirmPassword: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_CHANGEPASSWORD_CONFIRM_PASSWORD_REQUIRED%></span>",
                        equalTo: "<span class='error'>&nbsp;<%=Resources.SunResource.USER_CHANGEPASSWORD_CONFIRM_PASSWORD_EQUALTO%></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <script type="text/javascript">
        function clearMessage() {
            $("#errormessage").hide();
        }
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.gif">
                <form id="pwdform" name="pwdform" method="post" action="/user/changepassword">
                <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                        </td>
                        <td width="777">
                            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif"/>
                                    </td>
                                    <td class="pv0216">
                                        <%=Resources.SunResource.USER_CHANGEPASSWORD_CHANGEPASSWORD%>
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
                                        <%=Resources.SunResource.USER_CHANGEPASSWORD_CHANGEPASSWORD_DETAIL%>&nbsp;
                                    </td>
                                    <td width="18%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6" align="right">
                            <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                        </td>
                    </tr>
                </table>
                <div class="subrbox01">
                    <div>
                        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="94%" class="f_14">
                                    <strong>
                                        <%=Resources.SunResource.USER_CHANGEPASSWORD_CHANGEPASSWORD%></strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div class="note01">
                            <%=Resources.SunResource.MONITORITEM_NOTE %>:*
                            <%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM %></div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    <%=Resources.SunResource.USER_CHANGEPASSWORD_OLD_PASSWORD%>：
                                </td>
                                <td width="27%">
                                    <%=Html.Password("oldPassword", string.Empty, new {@class="txtbu01" }) %>
                                    <span class="red">*</span>
                                </td>
                                <td width="44%">
                                    <span id="error_old_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.USER_CHANGEPASSWORD_NEW_PASSWORD%>：
                                </td>
                                <td>
                                    <%=Html.Password("password", string.Empty, new {@class="txtbu01" }) %>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                    <span id="error_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.USER_CHANGEPASSWORD_CONFIRM_PASSWORD%>：
                                </td>
                                <td>
                                    <%=Html.Password("confirmPassword", string.Empty, new {@class="txtbu01" }) %>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                    <span id="error_confirm_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                </td>
                                <td>
                                    <%= ViewData["error"] %>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div>
                    <table width="244" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="111">
                                <%
                                    if (AuthService.isAllow(AuthorizationCode.USER_CHANGE_PASSWORD) && !UserUtil.isDemoUser)
                                    { %>
                                <input name="Submit2" type="submit" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />
                                <%}
                                    else
                                    { %>
                                <input name="Submit2" type="button" class="txtbu06" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />
                                <%} %>
                            </td>
                            <td width="108">
                                <input id="cancel" type="button" onclick="reset();" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_RESET %> " />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </div>
                </form>
            </td>
        </tr>
    </table>
</asp:Content>
