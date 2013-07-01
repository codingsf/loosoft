<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Errorcode>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Model != null ? "编辑" : "添加"%>错误代码 - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#mainForm").validate({
                errorElement: "em",
                rules: {
                    code: {
                        required: true,
                        remote: {
                            type: "POST",
                            url: "/admin/checkerrorcode",
                            data: {
                                code: function() {
                                    if ($("#id").val() > 0) {
                                        if ($("#precode").val() == $("#code").val()) {
                                            return "";
                                        }
                                        else {
                                            return $("#code").val();
                                        }
                                    }
                                    return $("#code").val();
                                }
                            }
                        }
                    },
                    defaultName: {
                        required: true
                    },
                    errorType: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "code") {
                        $("#error_code").text('');
                        error.appendTo("#error_code");
                    }
                    if (element.attr("name") == "defaultName") {
                        $("#error_defaultname").text('');
                        error.appendTo("#error_defaultname");
                    }

                },

                messages: {
                    code: {
                        required: "<span class='error'>&nbsp;请输入故障码</span>",
                        remote: "<span class='error'>&nbsp;此故障码已存在</span>"
                    },
                    defaultName: {
                        required: "<span class='error'>&nbsp;请输入默认故障名称</span>"
                    },
                    errorType: {
                        required: "<span class='error'>&nbsp;请输入故障类型</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <% using (Html.BeginForm("errorcode_save", "admin", FormMethod.Post, new { id = "mainForm" }))
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
                                <img src="/images/kj/kjiico01.gif" />
                            </td>
                            <td width="93%" class="pv0216">
                                <%= Model != null ? "编辑故障码" : "添加故障码"%>
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
                                <%= Model != null ? "编辑" : "添加"%>故障码</strong>
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
                            故障码：
                        </td>
                        <td width="36%">
                            <%= Html.Hidden("precode",Model==null?"": Model.code, new { @id = "precode"})%>
                            <%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30" })%><span class="red">*</span>
                            <%= Html.HiddenFor(model => model.id, new { @id = "id"})%>
                        </td>
                        <td width="35%">
                            <span id="error_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            默认名称：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.defaultName, new { @class = "txtbu01", @size = "30" })%><span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_defaultname"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            所属类型：
                        </td>
                        <td>
                            <%=Html.DropDownListFor(model => model.errorType, ViewData["selectDeviceTypes"] as IList<SelectListItem>, new { @class = "select200" })%>
                        </td>
                    </tr>                      
                    <%foreach (Hashtable table in (ViewData["list"] as List<Hashtable>))
                      {%>
                    <tr>
                        <td height="36" class="pr_10">
                            <%=table["langName"] %>：
                        </td>
                        <td>
                            <%= Html.Hidden("lang", table["langcode"], new { @class = "txtbu01", @size = "30" })%>
                            <%= Html.TextBox("langValue",table["langValue"], new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td>
                            <span id="Span1"></span>
                        </td>
                    </tr>
                    <%} %>
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
                        <input name="Submit2" type="button" onclick="window.location='/admin/errorcode/'"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
