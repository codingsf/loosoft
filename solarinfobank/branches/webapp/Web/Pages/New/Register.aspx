<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注册</title>
    <link href="../../style/lc.css" rel="stylesheet" type="text/css" />
    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />
    <link href="../../style/kj.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script src="/country/city" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        String.prototype.Trim = function() {
            return this.replace(/(^\s*)|(\s*$)/g, "");
        }
        $().ready(function() {
            var d = new Date();
            var localZone = d.getTimezoneOffset() / 60;
            $("#localZone").val(localZone);

            $("#username").focus();
            $("#s1").change(function() {

                if ($("#s1").val() == "Other") {
                    $("#s1").css("width", "60px");
                    $("#country").show();
                    $("#city").show();
                    $("#s2").hide();
                    $("#country").attr("value", '');
                    $("#city").attr("value", '');
                }
                else {
                    $("#s1").css("width", "180px");
                    $("#country").hide();
                    $("#city").hide();
                    $("#s2").show();
                    $("#country").attr("value", $("#s1").val());
                    $("#city").attr("value", $("#s2").val());
                }
            })
            ;
            $("#s2").change(function() {
                $("#country").attr("value", $("#s1").val());
                $("#city").attr("value", $("#s2").val());
            });

            jQuery.validator.addMethod("tel",
            function(value, element) {
                var length = (value.Trim()).length;
                var tel = /^[\d\+\-]{5}$/;
                return this.optional(element) || (tel.test(value.Trim()));
            })

            $("#regform").validate({
                errorElement: "em",
                rules: {
                    username: {
                        required: true,
                        minlength: 2,
                        maxlength: 30,
                        remote: {
                            type: "POST",
                            url: "/auth/checkuser",
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
                    confirm_password: {
                        required: true,
                        minlength: 6,
                        equalTo: "#password"
                    },

                    revenueRate: {
                        required: true
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    faxPhone: {
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
                    if (element.attr("name") == "confirm_password") {
                        $("#error_confirm_password").text('');
                        error.appendTo("#error_confirm_password");
                    }
                    if (element.attr("name") == "revenueRate") {
                        $("#error_revenueRate").text('');
                        error.appendTo("#error_revenueRate");
                    }
                    if (element.attr("name") == "email") {
                        $("#error_email").text('');
                        error.appendTo("#error_email");
                    }
                    if (element.attr("name") == "faxPhone") {
                        $("#error_fax").text('');
                        error.appendTo("#error_fax");
                    }
                },

                messages: {
                    username: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_REQUIRED %></span>",
                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_MINLENGTH %></span>",
                        maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_MAXLENGTH %></span>",
                        remote: "<span class='error'>&nbsp;<%=Resources.SunResource.AJAX_CHACKING_USERNAME%></span>"

                    },
                    password: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_REQUIRED%></span>",
                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_MINLENGTH%></span>"
                    },
                    confirm_password: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD_REQUIRED%></span>",
                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_PASSWORD_MINLENGTH%></span>",
                        equalTo: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD_EQUALTO%></span>"
                    },

                    revenueRate: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_REQUIRED %></span>"
                    },
                    email: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_EMAIL_REQUIRED %></span>",
                        email: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_EMAIL %></span>"
                    },
                    faxPhone: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_FAX_REQUIRED%></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
        function clearMessage() {
            $("#errormessage").hide();
        }
        function fillEmail() {

            var str = /^[a-zA-Z]\w+@\w+\.\w+$/;
            if (str.test($("#username").val())) {
                $("#email").val($("#username").val());
            } else {
                $("#email").val("");
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            $("#change").click(function() {
                if ($("#unessential").is(":hidden")) {
                    $("#unessential").slideDown(0);
                } else {
                    $("#unessential").slideUp(0);
                }
            });
        });
    </script>

</head>
<body>
    <form id="regform" name="regform" method="post" action="/new/save">
    <input type="hidden" id="localZone" name="localZone" />
    <div class="lcbox">
        <div class="lctab">
            <ul>
                <li class="lc_yellowbg">1、用户信息 </li>
                <li>2、电站信息</li>
                <li>3、设备信息</li>
            </ul>
        </div>
        <div class="lcabout">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="9" height="9" background="images/tc/tc01.gif">
                    </td>
                    <td background="images/tc/tc02.gif">
                    </td>
                    <td width="9" height="9" background="images/tc/tc03.gif">
                    </td>
                </tr>
                <tr>
                    <td background="images/tc/tc04.gif">
                        &nbsp;
                    </td>
                    <td bgcolor="#FFFFFF">
                        <span class="lcts01">注：* 为必填项</span>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tlist">
                            <tr>
                                <td width="29%" class="pr_10">
                                    用户名：
                                </td>
                                <td width="29%">
                                    <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01", @onmousedown = "clearMessage()", onblur = "fillEmail()" })%>
                                </td>
                                <td width="42%">
                                    <span class="redzi">* </span>用户名的长度必须在2~30个字符之间
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    密码：
                                </td>
                                <td>
                                    <%= Html.PasswordFor(model => model.password, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td>
                                    <span class="redzi">*</span> 密码不能少于6个字符
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    确认密码：
                                </td>
                                <td>
                                    <input type="password" class="txtbu01" id="confirm_password" name="confirm_password" />
                                </td>
                                <td>
                                    <span class="redzi">*</span> 确认密码必须与密码相同
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    邮箱：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", @onmousedown ="clearMessage()"})%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    &nbsp;
                                </td>
                                <td>
                                    <input type="checkbox" name="checkbox" value="checkbox" />
                                    <a href="#" class="green">同意《用户协议内容》</a>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                        <div class="ss_zk">
                            <span class="ss_zkico"><a href="#" class="sza" id="change">收起选填项</a></span></div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tlist"
                            id="unessential">
                            <tr>
                                <td width="19%" class="pr_10">
                                    名字：
                                </td>
                                <td width="28%">
                                    <%= Html.TextBoxFor(model => model.FirstName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td width="17%" class="pr_10">
                                    地址：
                                </td>
                                <td width="36%">
                                    <%= Html.TextBoxFor(model => model.address, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    姓氏：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.LastName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    邮政编码：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.postalcode, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    固定电话：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.tel, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    国家：
                                </td>
                                <td>
                                    <select id="s1" class="txtbu01">
                                        <option>
                                            <%=Resources.SunResource.AUTH_REG_SELECT_COUNTRY %></option>
                                    </select><input id="country" name="country" type="text" style="display: none; width: 120px;"
                                        class="txtbu01" />
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    移动电话：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.mobilePhone, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    城市：
                                </td>
                                <td>
                                    <select id="s2" class="txtbu01">
                                        <option>
                                            <%=Resources.SunResource.AUTH_REG_SELECT_CITY %></option>
                                    </select><input id="city" name="city" type="text" style="display: none;" class="txtbu01" />
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    传真：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.faxPhone, new { @class = "txtbu01",@onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    公司：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.organize, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    性别：
                                </td>
                                <td>
                                    <%= Html.DropDownList("sex", new List<SelectListItem>
                                    {
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_MALE, Value = "0", Selected = true}),
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_FEMALE, Value = "1", Selected = false}),
                                    }, new { @class = "txtbu01" })%>
                                </td>
                                <td class="pr_10">
                                    温度单位：
                                </td>
                                <td>
                                    <%=Html.DropDownList("currencies", ViewData["currencies"] as IList<SelectListItem>, new { @class = "txtbu01" })%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="pr_10">
                                    货币单位：
                                </td>
                                <td>
                                    <%=Html.DropDownList("temperaturetype", new List<SelectListItem>(){
                                new SelectListItem(){ Text="°C", Value="C"},
                                new SelectListItem(){ Text="°F", Value="F"}



                                }, new { @class = "txtbu01" })%>
                                </td>
                            </tr>
                        </table>
                        <div class="ok_box">
                            <input type="submit" name="Submit" class="ok_greenbtu" value="下一步" />
                        </div>
                    </td>
                    <td background="images/tc/tc05.gif">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="9" height="9">
                        <img src="images/tc/tc06.gif" width="9" height="9" />
                    </td>
                    <td background="images/tc/tc07.gif">
                    </td>
                    <td>
                        <img src="images/tc/tc08.gif" width="9" height="9" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript">           setup();</script>

    <script type="text/javascript">        $.trim($('#tel').val())</script>

    </form>
</body>
</html>
