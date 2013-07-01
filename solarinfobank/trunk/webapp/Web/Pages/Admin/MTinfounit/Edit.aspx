<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.MTinfounit>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= Model != null ? "编辑" : "添加"%>信息单元地址 - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#mainForm").validate({
                errorElement: "em",
                rules: {
                    addressCode: {
                        required: true
                    },
                    defaultName: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "addressCode") {
                        $("#error_addresscode").text('');
                        error.appendTo("#error_addresscode");
                    }
                    if (element.attr("name") == "defaultName") {
                        $("#error_defaultname").text('');
                        error.appendTo("#error_defaultname");
                    }

                },

                messages: {
                    addressCode: {
                        required: "<span class='error'>&nbsp;请输入信息地址</span>"
                    },
                    defaultName: {
                        required: "<span class='error'>&nbsp;请输入默认名称</span>"
                    }
                },
                success: function(em) {
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <% using (Html.BeginForm("save", "mtinfounit", FormMethod.Post, new { id = "mainForm" }))
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
                                <%= Model != null ? "编辑信息单元地址" : "添加信息单元地址"%>
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
                                <%= Model != null ? "编辑" : "添加"%>信息单元地址</strong>
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
                            设备类型：
                        </td>
                        <td width="36%">
                            <%=Html.DropDownList("devicetypecode", ViewData["mtTypeItems"] as List<SelectListItem>, new { @class = "txtbu01" })%>
                        </td>
                        <td width="35%">
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="35" class="pr_10">
                            信息地址：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(m => m.addressCode, new { @class = "txtbu01", @size = "30" })%>
                            <%=Html.HiddenFor(m => m.id, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td width="35%">
                            <span id="error_addresscode"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            默认名称：
                        </td>
                        <td>
                            <%=Html.TextBoxFor(m => m.defaultName, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td>
                            <span id="error_defaultname"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            数据类型：
                        </td>
                        <td>
                            <%=Html.DropDownList("valueDataType.typeValue", ViewData["mtDataType"] as List<SelectListItem>, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            单位：
                        </td>
                        <td>
                            <%=Html.DropDownList("unit.unitValue", ViewData["mtUnit"] as List<SelectListItem>, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            测点类型：
                        </td>
                        <td>
                            <%=Html.DropDownList("monitroType.monitorTypeValue", ViewData["mtMonitorType"] as List<SelectListItem>, new { @class = "txtbu01" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            精度：
                        </td>
                        <td>
                            <%=Html.TextBoxFor(m => m.precision, new { @class = "txtbu01", @size = "30" })%>
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
                        <input name="Submit2" type="button" onclick="window.location='/mtinfounit/list/'"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
