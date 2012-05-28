<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.USER_FINDPASSWORD_FIND_PASSWORD%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#sendForm").validate({
                errorElement: "em",
                rules: {
                    email: {
                        email: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "textfield") {
                        $("#error_textfield").text('');
                        error.appendTo("#error_textfield");
                    }
                },

                messages: {
                    email: {
                        email: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_EDIT_EMAIL_EMAIL  %></span>"
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
            <table width="100%" height="222" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="13" background="/images/qimg/qbg01.jpg">
                        &nbsp;
                    </td>
                    <td width="728" background="/images/qimg/qbg03.jpg">
                        <form action="" method="post" id="sendForm">
                        <table width="97%" height="143" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="11%" rowspan="3" valign="top">
                                    <img src="/images/qimg/qico02.gif" width="63" height="93" />
                                </td>
                                <td width="89%" height="54" valign="top" style="color: #5A9A41; line-height: 20px;">
                                    You forgot your password?<br />
                                    Sunny Portal can generate a new password for your account and will send it to your
                                    e-mail adress.
                                </td>
                            </tr>
                            <tr>
                                <td height="38">
                                    <strong>Please enter your Sunny Portal e-mail address: </strong>
                                </td>
                            </tr>
                            <tr>
                                <td height="51">
                                    <table width="385" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="66">
                                                Longitud
                                            </td>
                                            <td width="146">
                                                <input name="textfield" type="text" class="txtbu04" size="18" />
                                            </td>
                                            <td width="173">
                                                <input name="Submit" type="submit" class="subbu01" value="Save" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td colspan="2">
                                                <span id="error_textfield"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        </form>
                    </td>
                    <td width="13" background="/images/qimg/qbg02.jpg">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
