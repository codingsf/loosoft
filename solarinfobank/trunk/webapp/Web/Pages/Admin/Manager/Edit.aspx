<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Manager>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Model != null ? "编辑管理员" : "添加管理员"%>
    - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    username: {
                        required: true,
                        remote: {
                            type: "POST",
                            url: "/admin/checkadminuser",
                            data: {
                                uname: function() {
                                    if ($("#id").val() > 0) {
                                        if ($("#prename").val() == $("#username").val()) {
                                            return "";
                                        }
                                        else {
                                            return $("#username").val();
                                        }
                                    }
                                    return $("#username").val();
                                }
                            }
                        }
                    },
                    password: {
                        required: true
                    },
                    confirm_password: {
                        required: true,
                        equalTo: "#password"
                    },
                    fullname: {
                        required: true
                    },
                    email: {
                        email: true,
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
                    if (element.attr("name") == "fullname") {
                        $("#error_fullname").text('');
                        error.appendTo("#error_fullname");
                    }
                    if (element.attr("name") == "email") {
                        $("#error_email").text('');
                        error.appendTo("#error_email");
                    }
                },

                messages: {
                    username: {
                        required: "<span class='error'>&nbsp;请输入用户名</span>",
                        remote: "<span class='error'>&nbsp;此用户名已存在</span>"
                    },
                    password: {
                        required: "<span class='error'>&nbsp;请输入密码</span>"
                    },
                    confirm_password: {
                        required: "<span class='error'>&nbsp;请再次输入密码</span>",
                        equalTo: "<span class='error'>&nbsp;确认密码必须与密码相同</span>"
                    },
                    fullname: {
                        required: "<span class='error'>&nbsp;请输入真实姓名</span>"
                    },
                    email: {
                        required: "<span class='error'>&nbsp;请输入邮箱</span>",
                        email: "<span class='error'>&nbsp;请输入正确的E-mail地址</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <% using (Html.BeginForm(Model == null ? "manager_add" : "manager_edit", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
           {%>
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
                            <td width="93%" class="pv0216">
                                <%= Model != null ? "编辑管理员" : "添加管理员"%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
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
                                <%= Model != null ? "编辑管理员" : "添加管理员"%></strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    提示:*为必填项</div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="29%" height="35" class="pr_10">
                            用户名：
                        </td>
                        <td width="36%">
                            <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu01", @size = "30" })%>
                            <%= Html.HiddenFor(model => model.username, new { @class = "txtbu01", @id = "prename", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_username"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            密码：
                        </td>
                        <td>
                            <%= Html.Password("password",this.Model==null?string.Empty: this.Model.password, new { @class = "txtbu01" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_password"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            确认密码：
                        </td>
                        <td>
                            <%= Html.Password("confirm_password", this.Model == null ? string.Empty : this.Model.password, new { @class = "txtbu01" })%><%= Html.HiddenFor(model => model.id)%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_confirm_password"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            真实姓名：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.fullname, new { @class = "txtbu01 ", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_fullname"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            部门：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.department, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            邮箱：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.email, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_email"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            是否锁定：
                        </td>
                        <td>
                            <%= Html.CheckBoxFor(model => model.locked)%>
                        </td>
                    </tr>
                    <tr xmlns="http://www.w3.org/1999/xhtml">
                        <td width="14%" valign="top" class="pr_10" style="padding-top: 10px;">
                            角色：
                        </td>
                        <td colspan="2">
                            <table cellspacing="0" cellpadding="0" border="0" width="70%">
                                <tbody>
                                    <tr>
                                        <% int i = 0;
                                           foreach (var item in ViewData["roles"] as IList<AdminRole>)
                                           {
                                               if ((i++ % 4 == 0) && i > 0)
                                                   Response.Write("</tr><tr>");
                                               bool ischecked = false;
                                               if (Model != null && Model.roles != null && Model.roles.Count(m => m.roleId.Equals(item.id)) > 0)
                                                   ischecked = true;
                                        %>
                                        <td height="35" width="25%">
                                            <%if (ischecked)
                                              { %>
                                            <input type="checkbox" value="<%=item.id %>" checked="checked" name="role" />
                                            <%}
                                              else
                                              { %>
                                            <input type="checkbox" value="<%=item.id %>" name="role" />
                                            <%} %>
                                            <%=item.name %>
                                        </td>
                                        <%} %>
                                    </tr>
                                </tbody>
                            </table>
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
                        <input name="Submit" type="submit" class="txtbu03" value=" 保存 " />
                    </td>
                    <td>
                        <input name="Submit2" type="button" onclick="window.location='/admin/managers/'"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
