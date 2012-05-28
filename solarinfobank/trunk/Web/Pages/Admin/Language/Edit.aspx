<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Language>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    编辑语言 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#editLanguagefrm").validate({
                errorElement: "em",
                rules: {
                    name: {
                        required: true
                    },
                    codename: {
                        required: true
                    },
                    currencies: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "name") {
                        $("#error_name").text('');
                        error.appendTo("#error_name");
                    }
                    if (element.attr("name") == "codename") {
                        $("#error_codename").text('');
                        error.appendTo("#error_codename");
                    }
                    if (element.attr("name") == "currencies") {
                        $("#error_currencies").text('');
                        error.appendTo("#error_currencies");
                    }
                },

                messages: {
                    name: {
                    required: "<span class='error'>&nbsp;请输入语言名称</span>"
                    },
                    codename: {
                    required: "<span class='error'>&nbsp;请输入代码</span>"
                    },
                    currencies: {
                    required: "<span class='error'>&nbsp;请输入货币单位</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <% using (Html.BeginForm("language_edit", "admin", FormMethod.Post, new { @id = "editLanguagefrm", name = "editLanguagefrm" }))
           {%>
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">编辑语言</td>
                </tr>
                <tr>
                  <td>  &nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
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
                               编辑语言</strong>
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
                        <td width="29%" height="36" class="pr_10">
                            语言：
                        </td>
                        <td width="36%">
                            <%= Html.HiddenFor(model => model.id)%>
                            <%= Html.TextBoxFor(model => model.name, new { @class = "subtxtsy", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_name"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            代号：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.codename, new { @onpaste = "return false", @oncontextmenu = "return false", @oncopy = "return false", @oncut = "return false", @class = "subtxtsy", @size = "30" })%>
                            <span class="red">*</span><%= Html.HiddenFor(model => model.id)%>
                        </td>
                        <td>
                            <span id="error_codename"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            货币单位：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.currencies, new { @class = "subtxtsy", @size = "30" })%>
                            <span class="red">*</span><%= Html.HiddenFor(model => model.id)%>
                        </td>
                        <td>
                            <span id="error_currencies"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            是否启用：
                        </td>
                        <td>
                        <%if (Model.isEdited)
                          { %>
                            <%= Html.CheckBoxFor(model => model.isenabled, new { @class = "subtxtsy ", @size = "30" })%>
                            <%}else{ %>
                            <%= Html.CheckBoxFor(model => model.isenabled, new { @class = "subtxtsy ", @size = "30",@disabled="disabled" })%>
                            <%} %>
                            <span
                                id="error_fullname"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" class="pr_10">
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
            <div>
                <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <input name="Submit" type="submit" class="txtbu03" value=" 保存 " />
                        </td>
                        <td>
                            <input name="Submit2" onclick="window.location='/admin/language/'" type="button"
                                class="txtbu03" value=" 取消 " />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
        </div>
        <%} %>
    </td>
</asp:Content>
