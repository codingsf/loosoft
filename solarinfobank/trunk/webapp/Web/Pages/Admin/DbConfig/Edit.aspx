﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Dbconfig>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Model != null ? "编辑数据分布配置" : "添加数据分布配置"%>
    - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    year: {
                        required: true
                    },
                    url: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "year") {
                        $("#error_year").text('');
                        error.appendTo("#error_year");
                    }
                    if (element.attr("name") == "url") {
                        $("#error_url").text('');
                        error.appendTo("#error_url");
                    }
                },

                messages: {
                    year: {
                    required: "<span class='error'>&nbsp;请输入年份</span>"
                    },
                    url: {
                    required: "<span class='error'>&nbsp;请输入链接地址</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.ADMIN_DBCONFIG_EDIT_SUCCESS_EM %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <% using (Html.BeginForm("dbconfig_save", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
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
                                <%=Model != null ? "编辑数据分布配置" : "添加数据分布配置"%>
                            </td>
                        </tr>
                        <tr>
                            <td>

                                <%=Model != null ? "": ""%>&nbsp;

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
                                <%=Model != null ? "编辑数据分布配置" : "添加数据分布配置"%></strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    提示:*为必填项</div>
                <table width="688" border="0" align="center" cellspacing="0">
                    <tr>
                        <td class="bzico_01">
                        </td>
                    </tr>
                    <tr>
                        <td class="bzptb">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="29%" height="35" class="pr_10">
                                        年：
                                    </td>
                                    <td width="36%">
                                        <%= Html.TextBoxFor(model => model.year, new { @class = "txtbu01", @size = "30" })%>
                                        <span class="red">*</span>
                                    </td>
                                    <td width="35%">
                                        <span id="error_year"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="36" class="pr_10">
                                        链接地址：
                                    </td>
                                    <td>
                                        <%= Html.TextBoxFor(model => model.url, new { @class = "txtbu01", @size = "30" })%>
                                        <span class="red">*</span><%= Html.HiddenFor(model => model.id)%>
                                    </td>
                                    <td>
                                        <span id="error_url"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="36" class="pr_10">
                                        是否启用：
                                    </td>
                                    <td>
                                        <%= Html.CheckBoxFor(model => model.isEnabled)%>
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
                        <input name="Submit2" onclick="window.location='/admin/dbconfig/'" type="button"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
