<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Manager>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Login</title>
    <link href="/css/css.css" rel="stylesheet" type="text/css" />
    
    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#username").get(0).focus();
            $("#loginform").validate({
                rules: {
                    username: "required",
                    password:
                {
                    required: true
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
                },
                messages: {
                    username: {
                        required: "请输入用户名"
                    },
                    password: {
                        required: "请输入密码 "
                    }
                }

            });
        });
    
</script>

</head>
<body style="background: #385F8E;">
            <form method="post" action="/auth/login" id="loginform">

    <div class="lgobox">
        <div class="lgobox_top">
            <a href="/" class="lw">Visit Website</a> | <a href="javascript:void(0);" onclick="javascript:window.close();" class="lw">Close</a></div>
        <div class="lgobox_mid">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="43%">
                        <img src="/images/login/lobg02.jpg" />
                    </td>
                    <td width="57%">
                        <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="17%" height="36" class="lott">
                                    用户名
                                </td>
                                <td>
                                <%=Html.TextBoxFor(m => m.username, new { @class = "lobu" })%>
                                </td>
                                <td class="redt">
                                  <%=ViewData["error"] %><span id="error_username"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="36" class="lott">
                                    密 码
                                </td>
                                <td>
                                <%=Html.PasswordFor(m => m.password, new { @class = "lobu" })%>
                                </td>
                                <td class="redt">
                                   <span id="error_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="36">
                                    &nbsp;
                                </td>
                                <td width="53%">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <input type="image" src="/images/login/l0bu.gif" />
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="30%">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="lgobox_down">
            Copyright @ 2011 腾虎科技 版权所有 电话：<%=WebconfigService.GetInstance().Config.tel %> 传真：0551-5328502</div>
    </div>
        </form>
    
</body>
</html>
