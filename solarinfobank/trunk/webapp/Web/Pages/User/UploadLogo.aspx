<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    上传LOGO
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        $().ready(function() {
            var random = new Date().getMilliseconds();
            var src = '<%=UserUtil.UserLogo %>?' + random;
            $("#logo", window.parent.document).attr("src", src);
        })
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <form id="uploadform" name="uploadform" method="post" action="/user/uploadlogo" enctype="multipart/form-data">
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
                                        上传LOGO
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
                                    <strong>上传LOGO</strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    选择图片：
                                </td>
                                <td width="27%">
                                    <%=Html.TextBox("logopic", string.Empty, new { @class = "txtbu01", type = "file" })%>
                                </td>
                                <td width="44%">
                                    <span id="error_old_password"></span>
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
                                    if (AuthService.isAllow(AuthorizationCode.USER_CHANGE_PASSWORD))
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
