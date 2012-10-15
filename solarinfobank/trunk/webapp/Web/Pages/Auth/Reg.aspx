<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
     <%=Resources.SunResource.AUTH_REG_REGISTER_USER %>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
    
    <style type="text/css">
<!--
.STYLE1 {color: #787878}
.rebu{ padding:0 10px; font-family:Arial, Helvetica, sans-serif; background:url(/images/rebubg.jpg); color:#FFFFFF; font-size:14px; font-weight:bold; border:none;cursor:pointer; height:36px;}
-->
</style>


    <form id="regform" name="regform" method="post" action="/auth/reg">
    <div class="mainbox">
        <div>
            <div class="subrbox01">
                <div class="sb_top">
                </div>
                <div class="sb_mid">
                    <div>
                        <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="9%">
                                    <img src="/images/qimg/qico03.gif" width="57" height="75" />
                                </td>
                                <td width="91%">
                                    <span class="pv0216">
                                        <%=Resources.SunResource.AUTH_REG_USER_REGISTRATION%></span><br />
                                    <span class="pv0212">
                                        <%=Resources.SunResource.AUTH_REG_USER_REGISTRATION_DETAIL%>&nbsp;
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                     <div>
                    <div class="note01" style="margin-bottom: 10px;">
                        <%=Resources.SunResource.AUTH_REG_NOTE %>：*
                        <%=Resources.SunResource.AUTH_REG_FOR_MUST_FILL_IN_THE_ITEM %></div>
                        <table width="100%" border="0"  cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="25%" height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_USERNAME %>：
                            </td>
                            <td width="30%">
                                <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01", @onmousedown = "clearMessage()", onblur = "fillEmail()" })%>
                                <span class="red">*</span>
                            </td>
                            <td width="45%">
                                <span id="error_username"><span class="tip"><%=Resources.SunResource.AUTH_REG_TIP_USERNAME %></span></span>
                                <%= Html.ValidationMessage("UserName", "", new { id = "errormessage", @class="redzi" })%>
                                <input type="hidden" id="localZone" name="localZone" />
                            </td>
                        </tr>
                       
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_PASSWORD %>：
                            </td>
                            <td>
                                <%= Html.PasswordFor(model => model.password, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_password"><span class="tip"><%=Resources.SunResource.AUTH_REG_TIP_PASSWORD %></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_CONFIRM_PASSWORD %>：
                            </td>
                            <td>
                                <input type="password" class="txtbu01" id="confirm_password" name="confirm_password" />
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_confirm_password"><span class="tip"><%=Resources.SunResource.AUTH_REG_TIP_CONFIRM_PASSWORD %></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_REVENUE%>：
                            </td>
                            <td><%=Html.DropDownList("currencies", ViewData["currencies"] as IList<SelectListItem>, new { @class = "txtbu01" })%>
                              
                                <span class="red" style=" padding-left:2px;">*</span>
                            </td>
                            <td>
                                <span id="error_revenueRate"><span class="tip"></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_EMAIL %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", @onmousedown ="clearMessage()"})%>   <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_email"></span>
                            </td>
                        </tr>
                         <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_FAX %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.faxPhone, new { @class = "txtbu01",@onmousedown = "clearMessage()"})%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span class="red"><span id="error_fax"></span></span>
                            </td>
                        </tr>
                        </table>
                        <div class="note01" style="margin-bottom: 10px;  margin-top:10px;"> 
                        <%=Resources.SunResource.AUTH_REG_CHOICE_OPTIONAL%></div>
                        <table  width="100%" border="0"  cellpadding="0" cellspacing="0">
                        <tr>
                            <td height="35" class="pr_10" width="25%">
                                <%=Resources.SunResource.AUTH_REG_FIRSTNAME %>：
                            </td>
                            <td width="30%">
                                <%= Html.TextBoxFor(model => model.FirstName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                
                            </td>
                            <td width="45%">
                               &nbsp;
                            </td>
                        </tr>
                            <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_LASTNAME %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.LastName, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                
                            </td>
                            <td>
                               &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_TEL %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.tel, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                                
                            </td>
                            <td>
                               &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_MOBILE_PHONE %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.mobilePhone, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                               
                            </td>
                            <td>
                                <span id="error_mobilePhone"></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_ADDRESS %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.address, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_POSTAL_CODE %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.postalcode, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_COUNTRIES %>：
                            </td>
                            <td>
                                <select id="s1" class="textsy02"  style="width: 180px">
                                    <option>
                                        <%=Resources.SunResource.AUTH_REG_SELECT_COUNTRY %></option>
                                </select><input id="country" name="country" type="text" style="display:none; width:120px;" class="txtbu01"/>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_CITYCODE %>：
                            </td>
                              <td>
                                <select  id="s2" class="textsy02" style="width: 180px">
                                    <option>
                                        <%=Resources.SunResource.AUTH_REG_SELECT_CITY %></option>
                                </select><input id="city" name="city" type="text" style="display:none;" class="txtbu01"/>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_ORGANIZATION %>：
                            </td>
                            <td>
                                <%= Html.TextBoxFor(model => model.organize, new { @class = "txtbu01", @onmousedown = "clearMessage()"})%>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_SEX %>：
                            </td>
                            <td>
                                <%= Html.DropDownList("sex", new List<SelectListItem>
                                    {
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_MALE, Value = "0", Selected = true}),
                                        (new SelectListItem() {Text = Resources.SunResource.AUTH_REG_FEMALE, Value = "1", Selected = false}),
                                    }, new { @class="textsy02" ,style="width:180px" })%>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <%--<tr>
                            <td height="35" class="pr_10">
                                <%=Resources.SunResource.AUTH_REG_LANGUAGE %>：
                            </td>
                            <td>
                                <select id="languageId" class="textsy02" name="languageId" style="width: 180px">
                                    <%foreach (var item in ViewData["languages"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.Language>)
                                      { %>
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
                                <%=Resources.SunResource.AUTH_REG_TEMPERATE_UNIT %>：
                            </td>
                            <td>
                                <%=Html.DropDownList("temperaturetype", new List<SelectListItem>(){
                                new SelectListItem(){ Text="°C", Value="C"},
                                new SelectListItem(){ Text="°F", Value="F"}

                                }, new { @class = "textsy02", style = "width: 180px" })%>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        
                        
                             <tr>
            <td rowspan="2" class="pr_10" height="60">&nbsp;</td>
            <td colspan="2" height="60"><input name="Submit22" class="rebu" value="<%=Resources.SunResource.AGREE_BUTTON%>" type="submit"></td>
            </tr>
		            <tr>
		              <td colspan="2" height="30"><a href="/public/agree" target="_blank" class="green">《<%=Resources.SunResource.USER_AGREE_LINK%>》</a></td>

            </tr>
                    </table>
                   </div>
                </div>
                <div class="sb_down">
                </div>
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">setup();</script>
    <script type="text/javascript">$.trim($('#tel').val())</script>
    <br/>
</asp:Content>
