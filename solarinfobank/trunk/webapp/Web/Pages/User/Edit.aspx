<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SUNGROW
    <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_USER_INFORMATION  %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/country/city?" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
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
                var length = value.length;
                var tel = /^\+86-\d{3,4}-\d{7,9}$/;
                return this.optional(element) || (tel.test(value));
            })


            $("#regform").validate({
                errorElement: "em",
                rules: {
                    username: {
                        required: true,
                        minlength: 2,
                        maxlength: 30

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
                    //                    tel: {
                    //                        required: true
                    //                     
                    //                    },
                    //                    mobilePhone: {
                    //                        required: true,
                    //                        number: true,
                    //                        maxlength: 11,
                    //                        minlength: 11
                    //                    },
                    //                    fullname: {
                    //                        required: true
                    //                    },
                    revenueRate: {
                        required: true
                        //                        number: true
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
                    //                    if (element.attr("name") == "tel") {
                    //                        $("#error_tel").text('');
                    //                        error.appendTo("#error_tel");
                    //                    }
                    //                    if (element.attr("name") == "mobilePhone") {
                    //                        $("#error_mobilePhone").text('');
                    //                        error.appendTo("#error_mobilePhone");
                    //                    }
                    //                    if (element.attr("name") == "fullname") {
                    //                        $("#error_fullname").text('');
                    //                        error.appendTo("#error_fullname");
                    //                    }
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
                        maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_USERNAME_MAXLENGTH %></span>"
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
                    ////                    tel: {
                    ////                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_TEL_REQUIRED %></span>",
                    ////                        tel: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_TEL_TEL %></span>",
                    ////                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_MOBILE_PHONE_NUMBER %></span>"
                    ////                    },
                    ////                    mobilePhone: {
                    ////                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_MOBILE_PHONE_REQUIRED %></span>",
                    ////                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_MOBILE_PHONE_NUMBER %></span>",
                    ////                        maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_MOBILE_PHONE_MAXLENGTH %></span>",
                    ////                        minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_MOBILE_PHONE_MINLENGTH %></span>"
                    ////                    },
                    ////                    
                    revenueRate: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_REQUIRED %></span>"
                        //                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>"
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
    </script>

    <script type="text/javascript">
        function clearMessage() {
            $("#errormessage").hide();
        }
    </script>

    <style type="text/css">
        .name01
        {
            font-weight: bold;
            text-align: right;
            padding-right: 20px;
            color: #5C5B5B;
        }
        .subtxtsy
        {
            border: 1px solid #405432;
            height: 24px;
            color: #5C5B5B;
        }
        .subtxtxl
        {
            width: 150px;
            height: 26px;
            color: #5C5B5B;
        }
        .reg01
        {
            background: url(/images/Registerbg.png) no-repeat;
            width: 952px;
            margin: 20px auto;
            height: 58px;
        }
        .reg01_abu
        {
            margin: 8px 0px 0px 120px;
            font-size: 15px;
            color: #8A8784;
        }
        .reg02
        {
            width: 952px;
            margin: 0px auto;
        }
        .notered
        {
            color: #FF0000;
        }
        .ll
        {
            color: #BBBBBB;
        }
        .style3
        {
            height: 20px;
        }
    </style>
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.gif">
                <form id="regform" name="regform" method="post" action="/user/edit">
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
                                        <%=Resources.SunResource.USER_EDIT_EDIT_USER %>
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
                                        <%=Resources.SunResource.USER_EDIT_EDIT_USER_DETAIL %>&nbsp;
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
                    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td class="f_14">
                                <strong>
                                    <%=Resources.SunResource.MONITORITEM_NOTE %>:<span class="red">*</span><%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM %></strong>
                            </td>
                        </tr>
                    </table>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <%if (ViewData["error"] != null)
                              { %>
                            <tr>
                                <td height="35" class="pr_10">
                                </td>
                                <td>
                                    <%= ViewData["error"]%>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <%}%>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_EMAIL %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", onmousedown ="clearMessage()"})%>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                    <span id="error_email"></span>
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_FAX %>:
                                </td>
                                <td width="29%">
                                    <%= Html.HiddenFor(model => model.username)%>
                                    <%= Html.HiddenFor(model => model.menuDisplayCount)%>
                                    <%= Html.HiddenFor(model => model.overviewDisplayCount)%>
                                    <%= Html.TextBoxFor(model => model.faxPhone, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                    <span class="red">*</span>
                                </td>
                                <td width="42%">
                                    <span id="error_fax"></span>
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_REVENUE%>:
                                </td>
                                <td>
                                    <%--  <%=Html.DropDownList("currencies", Currencies.CurrentList, new { @class = "txtbu01", style = "width: 181px; height: 23px; line-height:23px;float:left;" })%>--%>
                                    <input type="hidden" value="<%=this.Model.currencies %>" />
                                    <select class="txtbu01" id="currencies" name="currencies" style="width: 181px; height: 23px;
                                        line-height: 23px; float: left;">
                                        <%foreach (SelectListItem item in ViewData["currencies"] as IList<SelectListItem>)
                                          {
                                              if (item.Value.Equals(this.Model.currencies))
                                              {%>
                                        <option selected="selected" value="<%=item.Value %>">
                                            <%=item.Text %></option>
                                        <%}
                                              else
                                              {%>
                                        <option value="<%=item.Value %>">
                                            <%=item.Text %></option>
                                        <%}
                                          }%>
                                    </select>
                                    <span class="red" style="line-height: 23px; margin-left: 2PX; height: 23px; text-align: left;
                                        float: left; text-indent: 2px;">*</span>
                                </td>
                                <td class="redzi">
                                    <span id="error_revenueRate"></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div class="subrbox01">
                    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td class="f_14">
                                <strong>
                                    <%=Resources.SunResource.USER_EDIT_OPTIONAL %></strong>
                            </td>
                        </tr>
                    </table>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_FIRSTNAME %>:
                                </td>
                                <td width="29%">
                                    <%= Html.TextBoxFor(model => model.FirstName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td width="42%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_LASTNAME %>:
                                </td>
                                <td width="29%">
                                    <%= Html.TextBoxFor(model => model.LastName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td width="42%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_TEL %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.tel, new { @class = "txtbu01", @size = "25", @style = "width:180px;" })%>
                                </td>
                                <td class="ddgr">
                                    <span id="error_tel"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_MOBILE_PHONE %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.mobilePhone, new { @class = "txtbu01", @size = "25", @style = "width:180px;" })%>
                                </td>
                                <td>
                                    <span id="error_mobilePhone"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_ADDRESS %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.address, new { @class = "txtbu01", @size = "25", @style = "width:180px;" })%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_POSTAL_CODE %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(model => model.postalcode, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_COUNTRIES %>:
                                </td>
                                <td>
                                    <select id="s1" class="txtbu01" style="width: 181px; height: 23px; float: left;">
                                        <option>
                                            <%=Resources.SunResource.AUTH_REG_COUNTRIES %></option>
                                    </select>
                                    <%=Html.TextBoxFor(model=>model.country,new {@style="display: none; width: 120px;float: left;", @class="txtbu01"}) %>
                                </td>
                                <td>
                                    &nbsp;<input type="hidden" value="<%=Model.country %>" id="cy" name="cy" />
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_CITYCODE %>:
                                </td>
                                <td>
                                    <select id="s2" class="txtbu01" style="width: 181px; float: left;">
                                        <option>
                                            <%=Resources.SunResource.AUTH_REG_CITYCODE %></option>
                                    </select>
                                    <%=Html.TextBoxFor(model => model.city, new { @style="display: none; float: left;", @class="txtbu01"})%>
                                </td>
                                <td>
                                    &nbsp;<input type="hidden" value="<%=Model.city %>" id="cty" name="cty" />
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_ORGANIZATION %>:
                                </td>
                                <td>
                                    <%= Html.HiddenFor(model => model.id)%>
                                    <%= Html.TextBoxFor(model => model.organize, new { @class = "txtbu01", @size = "25", @style = "width:180px;" })%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_SEX %>:
                                </td>
                                <td>
                                    <%= Html.DropDownList("sex", new List<SelectListItem>
                                    {
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_MALE, Value = "0", Selected = true}),
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_FEMALE, Value = "1", Selected = false}),
                                    }, new { @class="txtbu01" ,style="width:180px" })%>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <%--<tr>
                        <td height="35" class="pr_10">
                            <%=Resources.SunResource.AUTH_REG_LANGUAGE %>:
                        </td>
                        <td>
                        
                            <select name="languageId" id="languageId" class="txtbu01" style="width: 180px">
                                <%
                                    Language languages = ViewData["lang"] as Language;
                                %>
                                <option value="<%=languages.id %>">
                                    <%=languages.name %></option>
                                <%                                  
                                    foreach (var item in ViewData["languages"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.Language>)
                                    {
                                        if (item.id.Equals(languages.id))
                                            continue;
                                        %>
                                <option value="<%=item.id %>">
                                    <%=item.name %>
                                </option>
                                <%} %>
                            </select>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>--%>
                            <tr>
                                <td height="35" class="pr_10">
                                    <%=Resources.SunResource.AUTH_REG_TEMPERATE_UNIT %>:
                                </td>
                                <td>
                                    <%=Html.DropDownList("temperaturetype", new List<SelectListItem>(){
                                        new SelectListItem(){ Text="°C", Value="C" , Selected=Model.TemperatureType.Equals("C")},
                                        new SelectListItem(){ Text="°F", Value="F", Selected=Model.TemperatureType.Equals("F")}

                                        }, new { @class = "textsy02", style = "width: 180px" })%>
                                    <%=Html.HiddenFor(m=>m.template.id) %>
                                    <%=Html.HiddenFor(m=>m.logo) %>
                                    <%=Html.HiddenFor(m=>m.sysName) %>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div>
                    <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <%if (!AuthService.isAllow(AuthorizationCode.EDIT_USER) || UserUtil.isDemoUser)
                                  { %>
                                <input name="Submit" type="button" class="txtbu06" value="<%=Resources.SunResource.MONITORITEM_SAVE %>" />
                                <%}
                                  else
                                  { %>
                                <input name="Submit" type="submit" class="txtbu03" onmousedown="clearMessage()" value="<%=Resources.SunResource.MONITORITEM_SAVE %>" />
                                <%} %>
                            </td>
                            <td>
                                <input name="Submit2" type="reset" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_RESET %>" />
                            </td>
                        </tr>
                    </table>
                </div>
                </form>
            </td>
        </tr>
    </table>

    <script>setup();</script>

    <script>
        var count = $("#s1 option").length;
        for (var i = 0; i < count; i++) {
            if ($("#s1 ").get(0).options[i].value == $("#cy").val()) {
                $("#s1 ").get(0).options[i].selected = true;
                change(1);
                break;
            }
            if (i == (count - 1)) {
                $("#s1 ").get(0).options[count - 1].selected = true;
                $("#s1").css("width", "60px");
                $("#country").show();
                $("#city").show();
                $("#s2").hide();
                $("#country").attr("value", $("#cy").val());
                $("#city").attr("value", $("#cty").val());
            }
        }
        count = $("#s2 option").length;
        for (var i = 0; i < count; i++) {
            if ($("#s2 ").get(0).options[i].value == $("#cty").val()) {
                $("#s2 ").get(0).options[i].selected = true;
                break;
            }
        }
                                   
    </script>

</asp:Content>
