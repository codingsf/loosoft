<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ItemConfig>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    申请数据源配置 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#editForm").validate({
                errorElement: "em",
                rules: {
                    days: {
                        required: true
                    },
                    count: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "days") {
                        $("#days_value").text('');
                        error.appendTo("#days_value");
                    }
                    if (element.attr("name") == "count") {
                        $("#count_value").text('');
                        error.appendTo("#count_value");
                    }
                },

                messages: {
                    days: {
                        required: "<span class='error'>&nbsp;请输入值</span>"
                    },
                    count: {
                        required: "<span class='error'>&nbsp;请输入值</span>"
                    }
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
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
                                申请数据源配置
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
        <div class="find_yqi">
            <% using (Html.BeginForm("reg_collector", "itemconfig", FormMethod.Post, new { @id = "editForm", name = "editForm" }))
               {%>
            <div class="subrbox01">
                <div>
                    <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td width="94%" class="f_14">
                                <strong>申请数据源配置</strong>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sb_top">
                </div>
                <div class="sb_mid">
                    <div class="note01">
                        提示:* 为必填项目</div>
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                        <tr>
                            <td width="29%" height="35" class="pl20">
                                数据源绑定期限：
                            </td>
                            <td width="36%">
                                <%=Html.TextBox("days", ViewData["days"] == null ? string.Empty : ViewData["days"])%>
                                <span class="redzi">*</span> &nbsp;日
                            </td>
                            <td width='35%'>
                                <span id="days_value"></span>
                            </td>
                        </tr>
                        <tr>
                            <td width="29%" height="35" class="pl20">
                                每日可生成数据源：
                            </td>
                            <td width="36%">
                                <%=Html.TextBox("count", ViewData["count"] == null ? string.Empty : ViewData["count"])%>
                                <span class="redzi">*</span> &nbsp;个
                            </td>
                            <td width='35%'>
                                <span id="count_value"></span>
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
                            <input name="button2" type="submit" class="txtbu03" id="Submit1" value=" 保存 " />
                            <font color="red">
                                <%=TempData["return"] == null ? "" : TempData["return"]%></font>
                        </td>
                    </tr>
                </table>
            </div>
            <%} %>
        </div>
    </td>
</asp:Content>
