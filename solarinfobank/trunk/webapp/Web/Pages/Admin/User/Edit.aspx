<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    自动刷新配置 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">

        $().ready(function() {
            $("#aspnetForm").validate({
                errorElement: "em",
                rules: {
                    refreshInterval: {
                        required: true,
                        digits: true,
                        max: 65535
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "refreshInterval") {
                        $("#error_refreshInterval").text('');
                        error.appendTo("#error_refreshInterval");
                    }
                },

                messages: {
                    refreshInterval: {
                        required: "<span class='error'>&nbsp;请输入刷新间隔</span>",
                        digits: "<span class='error'>&nbsp;刷新间隔只能是数字</span>",
                        max: "<span class='error'>&nbsp;请输入小于{0}的数字</span>"
                    }
                },
                success: function(em) {
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form id="aspnetForm" runat="server" method="post" action="/admin/usersave">
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
                                自动刷新配置
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
                            <strong>自动刷新配置</strong>
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
                        <td height="36" class="pr_10" width="29%">
                            用户名称：
                        </td>
                        <td width="36%">
                            <%= Html.DisplayFor(model => model.username)%>
                            <%= Html.HiddenFor(model => model.id)%>
                        </td>
                        <td width="35%">
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            是否启用自动刷新：
                        </td>
                        <td>
                            <%=Html.DropDownList("autoRefresh", new List<SelectListItem> {
                            new SelectListItem { Text = "启用", Value = "true", Selected=Model.autoRefresh},
                            new SelectListItem { Text = "禁用", Value = "false", Selected=Model.autoRefresh}
                        }) %>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            刷新间隔：
                        </td>
                        <td>
                            <%=Html.TextBoxFor(model => model.refreshInterval, new { @class = "txtbu01" })%>s
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_refreshInterval"></span>
                        </td>
                    </tr>
                       <tr>
                        <td height="36" class="pr_10">
                            功能启用时间：
                        </td>
                        <td>
                            <%=Html.TextBox("refreshStartDate",Model.refreshStartDateFormat, new { @class = "txtbu01 Wdate", onclick = "WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false})" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_refreshInterval"></span>
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
                        <input name="Submit2" onclick="window.location='/admin/users'" type="button" class="txtbu03"
                            value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </td>
</asp:Content>
