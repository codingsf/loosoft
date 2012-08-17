<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= Resources.SunResource.HOME_INDEX_REGISTER%></title>
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
                <%if (this.Model == null)
                             { %>
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

                    },<% }%>
                    password: {
                        required: true,
                        minlength: 6
                    },
                    agree:
                    {
                    //    required: true
                    
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
                       // required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (document.getElementById("error_" + element.attr("name"))) {
                        error.appendTo("#error_" + element.attr("name"));
                    }
                    else
                        error.insertAfter(element);
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
                       agree: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AGREE_BUTTON %></span>"
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


            $("#agree").click(function() {
                if ($(this).attr("checked") == false) {
                    $(".btn").attr("class", "no_greybtu btn");
                    $(".btn").attr("disabled", "disabled");
                } else {
                    $(".btn").attr("class", "ok_greenbtu btn");
                    $(".btn").attr("disabled", "");

                }
            });


            $("#change").click(function() {
                if ($("#unessential").is(":hidden")) {
                    $(this).text('<%=Resources.SunResource.OPTION_CLOSE%>');
                    $(this).parent().attr("class", "ss_zkico");
                    $("#btn1").hide();
                    $("#btn2").show();
                    $("#unessential").slideDown(0);
                } else {
                    $("#unessential").slideUp(0);
                    $(this).text('<%=Resources.SunResource.OPTION_OPEN%>');
                    $(this).parent().attr("class", "zk_zkico");
                    $("#btn2").hide();
                    $("#btn1").show();

                }
            });
        });
    </script>

</head>
<body>
    <form id="regform" name="regform" method="post" action="/newregister/save">
    <input type="hidden" id="localZone" name="localZone" />
    <div class="lcbox">
        <div class="lctab">
            <ul>
                <li class="lc_yellowbg">1、<%=Resources.SunResource.NEWREGISTER_USERINFO%> </li>
                <li>2、<%=Resources.SunResource.NEWREGISTER_PLANTINFO%></li>
                <li>3、<%=Resources.SunResource.NEWREGISTER_DEVICEINFO%></li>
            </ul>
        </div>
        <div class="lcabout">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="9" height="9" background="../images/tc/tc01.gif">
                    </td>
                    <td background="../images/tc/tc02.gif">
                    </td>
                    <td width="9" height="9" background="../images/tc/tc03.gif">
                    </td>
                </tr>
                <tr>
                    <td background="../images/tc/tc04.gif">
                        &nbsp;
                    </td>
                    <td bgcolor="#FFFFFF">
                        <span class="lcts01"><%=Resources.SunResource.AUTH_REG_NOTE%>：* <%=Resources.SunResource.AUTH_REG_FOR_MUST_FILL_IN_THE_ITEM%></span>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tlist">
                            <%if (this.Model == null)
                              { %>
                            <tr>
                                <td width="24%" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_USERNAME%>：
                                </td>
                                <td width="24%">
                                    <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td width="60%">
                                    <span class="redzi">*</span><span id="error_username"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.HOME_INDEX_PASSWORD%>：
                                </td>
                                <td>
                                    <%= Html.PasswordFor(model => model.password, new { @class = "txtbu01", @onmousedown = "clearMessage()" })%>
                                </td>
                                <td>
                                    <span class="redzi">* </span><span id="error_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.USER_CHANGEPASSWORD_CONFIRM_PASSWORD%>：
                                </td>
                                <td>
                                    <input type="password" class="txtbu01" id="confirm_password" name="confirm_password" />
                                </td>
                                <td>
                                    <span class="redzi">*</span> <span id="error_confirm_password"></span>
                                </td>
                            </tr>
                            <%}
                              else
                              {%>
                            <tr>
                                <td width="29%" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_USERNAME%>：
                                </td>
                                <td width="29%">
                                    <%= Html.HiddenFor(model => model.id)%>
                                    <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01", @onmousedown = "clearMessage()", @readonly="true" })%>                                    
                                </td>
                                <td width="42%">
                                </td>
                            </tr>
                            <%}
                            %>
                          
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.USER_FINDPASSWORD_EMAIL%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", @onmousedown ="clearMessage()"})%>
                                </td>
                                <td>
                                    <span class="redzi">*</span> <span id="error_email"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    &nbsp;
                                </td>
                                <td>
                                    <span style="white-space:nowrap"><input type="checkbox" id="agree" checked="checked" name="agree" value="checkbox" />
                                    <a href="/public/agree" target="_blank" class="green"><%=Resources.SunResource.REGISTER_AGREE%></a></span> 
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr id="btn1">
                                <td>
                                </td>
                                <td>
                                    <input type="submit" name="Submit" class="ok_greenbtu btn" value="<%=Resources.SunResource.NEXT_STEP%>" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                        <div class="ss_zk">
                            <span class="zk_zkico"><a href="#" class="sza" id="change"><%=Resources.SunResource.OPTION_OPEN%></a></span></div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="tlist"
                            id="unessential" style="display:none">
                            <tr>
                                <td width="19%" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_FIRSTNAME%>：
                                </td>
                                <td width="28%">
                                    <%= Html.TextBoxFor(model => model.FirstName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td width="17%" class="pr_10">
                                    <%=Resources.SunResource.USER_EDIT_ADDRESS%>：
                                </td>
                                <td width="36%">
                                    <%= Html.TextBoxFor(model => model.address, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_LASTNAME%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.LastName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_POSTAL_CODE%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.postalcode, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_TEL%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.tel, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    <%=Resources.SunResource.PLANT_ADDPLANT_COUNTRY%>：
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
                                    <%=Resources.SunResource.AUTH_REG_MOBILE_PHONE%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.mobilePhone, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    <%=Resources.SunResource.PLANT_ADDPLANT_CITY%>：
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
                                    <%=Resources.SunResource.AUTH_REG_FAX%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.faxPhone, new { @class = "txtbu01",@onmousedown = "clearMessage()"})%>
                                </td>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_ORGANIZATION%>：
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.organize, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_SEX%>：
                                </td>
                                <td>
                                    <%= Html.DropDownList("sex", new List<SelectListItem>
                                    {
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_MALE, Value = "0", Selected = true}),
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_FEMALE, Value = "1", Selected = false}),
                                    }, new { @class = "txtbu01" })%>
                                </td>
                                <td class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_REVENUE%>：
                                </td>
                                <td>
                                    <%=Html.DropDownList("currencies", ViewData["currencies"] as IList<SelectListItem>, new { @class = "txtbu01" })%>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10">
                                     <%=Resources.SunResource.AUTH_REG_TEMPERATE_UNIT%>：  
                                </td>
                                <td>
                                 <%=Html.DropDownList("temperaturetype", new List<SelectListItem>(){
                                new SelectListItem(){ Text="°C", Value="C"},
                                new SelectListItem(){ Text="°F", Value="F"}

                                }, new { @class = "txtbu01" })%>
                                </td>
                                <td class="pr_10">
                                                                     
                                </td>
                                <td>
                                   
                                </td>
                            </tr>
                        </table>
                        <div class="ok_box" id="btn2" style="display:none">
                            <input type="submit" name="Submit" class="ok_greenbtu btn" value="<%=Resources.SunResource.NEXT_STEP%>" />
                        </div>
                    </td>
                    <td background="../images/tc/tc05.gif">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="9" height="9">
                        <img src="../images/tc/tc06.gif" width="9" height="9" />
                    </td>
                    <td background="../images/tc/tc07.gif">
                    </td>
                    <td>
                        <img src="../images/tc/tc08.gif" width="9" height="9" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript"> setup();</script>

    <script type="text/javascript"> $.trim($('#tel').val())</script>

    </form>
</body>
</html>
