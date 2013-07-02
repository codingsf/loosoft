<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ItemConfig>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    到期提醒设置 - SolarInfoBank
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
                    value: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "value") {
                        $("#error_value").text('');
                        error.appendTo("#error_value");
                    }
                },

                messages: {
                    value: {
                        required: "<span class='error'>&nbsp;请输入值</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.ADMIN_DBCONFIG_EDIT_SUCCESS_EM %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <form id="aspnetForm" runat="server" method="post" action="/saler/savepaymentconfig">
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
                                到期提醒设置
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
                            <strong>到期提醒配置</strong>
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
                            提前天数：
                        </td>
                        <td width="36%">
                        <%=Html.HiddenFor(m=>m.id) %>
                        <%=Html.HiddenFor(m=>m.name) %>
                        <%=Html.HiddenFor(m=>m.type) %>
                        <%=Html.TextBoxFor(m=>m.value, new { @class = "txtbu01 "}) %> 天
                        </td>
                        <td width="35%">
                        <span id="error_value"></span>
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
                   
                </tr>
            </table>
        </div>
        </form>
    </td>
</asp:Content>
