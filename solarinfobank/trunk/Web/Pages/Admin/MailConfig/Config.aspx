<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.MailConfig>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    邮箱配置 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    serverName: {
                        required: true
                    },
                    emailName: {
                        required: true
                    },
                    emailPwd: {
                        required: true
                    },
                    port: {
                        required: true,
                        digits: true,
                        max: 65535
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "serverName") {
                        $("#error_serverName").text('');
                        error.appendTo("#error_serverName");
                    }
                    if (element.attr("name") == "emailName") {
                        $("#error_emailName").text('');
                        error.appendTo("#error_emailName");
                    }
                    if (element.attr("name") == "emailPwd") {
                        $("#error_emailPwd").text('');
                        error.appendTo("#error_emailPwd");
                    }
                    if (element.attr("name") == "port") {
                        $("#error_port").text('');
                        error.appendTo("#error_port");
                    }
                },

                messages: {
                    serverName: {
                        required: "<span class='error'>&nbsp;请输入服务器名称</span>"
                    },
                    emailName: {
                        required: "<span class='error'>&nbsp;请输入邮箱名称</span>"
                    },
                    emailPwd: {
                        required: "<span class='error'>&nbsp;请输入邮箱密码</span>"
                    },
                    port: {
                        required: "<span class='error'>&nbsp;请输入端口号</span>",
                        digits: "<span class='error'>&nbsp;请输入一个数字</span>",
                        max: "<span class='error'>&nbsp;请输入范围在 1-65535之间的数字</span>"
                    }
                },
                success: function(em) {
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
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
                                邮箱配置
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
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    提示:*为必填项</div>
                <form method="post" action="/admin/addmail" id="addForm">
                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                        <tr>
                            <td class="pr_10" height="35" width="29%">
                                服务器名：
                            </td>
                            <td width="36%">
                                <%=Html.TextBox("serverName", string.Empty, new { @class = "txtbu01 " })%>
                                <span class="red">*</span>
                            </td>
                            <td width="35%">
                                <span id="error_serverName"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="pr_10" height="36">
                                邮箱：
                            </td>
                            <td>
                                <%=Html.TextBox("emailName", string.Empty, new {  @class="txtbu01 " })%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_emailName"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="pr_10" height="36">
                                邮箱密码：
                            </td>
                            <td>
                                <%=Html.TextBox("emailPwd", string.Empty, new { @class = "txtbu01 " })%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_emailPwd"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="pr_10" height="36">
                                端口：
                            </td>
                            <td>
                                <%=Html.TextBox("port", string.Empty, new { @class = "txtbu01 " })%>
                                <span class="red">*</span>
                            </td>
                            <td>
                                <span id="error_port"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table align="center" border="0" cellpadding="0" cellspacing="0" height="60" width="350">
                    <tbody>
                        <tr>
                            <td>
                                <input name="Submit" class="txtbu03" value=" 保存 " type="submit">
                            </td>
                            <td>
                                <input name="Submit2" onclick="window.location='/admin/managers/'" class="txtbu03"
                                    value=" 取消 " type="button">
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form>
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="9%" align="center">
                                        <strong>编号</strong>
                                    </td>
                                    <td width="16%" align="center">
                                        <strong>服务器</strong>
                                    </td>
                                    <td width="35%" align="center">
                                        <strong>邮箱</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>密码</strong>
                                    </td>
                                    <td width="14%" align="center">
                                        <strong>端口</strong>
                                    </td>
                                    <td width="6%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <% int i = 0;
                       foreach (var item in Model)
                       {
                           i++;%>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            
                                <tr>
                                    <td width="9%" align="center" class="am_line0<%=i%2 %>">
                                        <%=i %>
                                    </td>
                                    <td width="16%" align="center" class="am_line0<%=i%2 %>">
                                        <%=item.serverName %>
                                    </td>
                                    <td width="35%" align="center" class="am_line0<%=i%2 %>">
                                        <div style="width: 270px; overflow: hidden;" title="china ">
                                            <%=item.emailName %>
                                        </div>
                                    </td>
                                    <td width="20%" align="center" class="am_line0<%=i%2 %>">
                                        <%=item.emailPwd %>
                                    </td>
                                    <td width="14%" align="center" class="am_line0<%=i%2 %>">
                                        <%=item.port %>
                                    </td>
                                    <td width="6%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "removemail"))
                                          { %>
                                        <a onclick="return confirm('确定删除吗?')" href="/admin/removemail/<%=item.id %>">删除</a>
                                        <%}
                                          else
                                          { %>
                                          删除
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
