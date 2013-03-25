<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.PAGECONFIG_TITLE%>
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
            $("#menuDisplayCount").get(0).focus();
            $("#userform").validate({
                errorElement: "em",
                rules: {
                    menuDisplayCount: {
                        required: true,
                        number: true,
                        digits: true,
                        min: 1
                    },
                    overviewDisplayCount: {
                        required: true,
                        number: true,
                        digits: true,
                        min: 1
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "menuDisplayCount") {
                        $("#error_menuDisplayCount").text('');
                        error.appendTo("#error_menuDisplayCount");
                        parent.iFrameHeight();
                    }
                    if (element.attr("name") == "overviewDisplayCount") {
                        $("#error_overviewDisplayCount").text('');
                        error.appendTo("#error_overviewDisplayCount");
                        parent.iFrameHeight();
                        
                    }
                },

                messages: {
                    menuDisplayCount: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        digits: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>"
                    },
                    overviewDisplayCount: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_OVERVIEW_ERROR1%></span>",
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_OVERVIEW_ERROR1%></span>",
                        digits: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_OVERVIEW_ERROR1%></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_OVERVIEW_ERROR1%></span>"
                    }
                },
                success: function(em) {
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
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <form id="userform" name="userform" method="post" action="/user/pageconfig">
                <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                        </td>
                        <td width="777">
                            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td class="pv0216">
                                        <%=Resources.SunResource.PAGECONFIG_TITLE%>
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
                                        &nbsp;
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
                                        <%=Resources.SunResource.PAGECONFIG_TITLE %></strong>
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
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Resources.SunResource.PAGECONFIG_TEXTBOX1_TITLE%>：
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Html.TextBoxFor(m => m.menuDisplayCount, new { @class = "txtbu01", style = "width:150px;" })%>
                                    <span class="red">*</span>
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <span id="error_menuDisplayCount"></span>
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Resources.SunResource.PAGECONFIG_TEXTBOX2_TITLE%>：
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <%=Html.TextBoxFor(m=>m.overviewDisplayCount, new {@class="txtbu01",style="width:150px;" }) %>
                                    <span class="red">*</span>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <span id="error_overviewDisplayCount"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="" align="left">
                                    <%= ViewData["error"] %>
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
