<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CommonInfo>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">

        <script src="/script/jquery.js" type="text/javascript"></script>

        <script src="/script/jquery.validate.js" type="text/javascript"></script>

        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <script type="text/javascript">

            $().ready(function() {
                $("#addForm").validate({
                    errorElement: "em",
                    rules: {
                        name: {
                            required: true
                        },
                        code: {
                            required: true
                        }
                    },
                    errorPlacement: function(error, element) {
                        if (element.attr("name") == "name") {
                            $("#error_name").text('');
                            error.appendTo("#error_name");
                        }
                        if (element.attr("name") == "code") {
                            $("#error_code").text('');
                            error.appendTo("#error_code");
                        }

                    },

                    messages: {
                        name: {
                            required: "<span class='error'>&nbsp;请输入货币简称</span>"
                        },
                        code: {
                            required: "<span class='error'>&nbsp;请输入货币符号</span>"
                        }
                    },
                    success: function(em) {
                        //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                    }
                });

            });
        </script>

        <% using (Html.BeginForm((Model != null && Model.id > 0) ? "currency_edit" : "currency_add", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
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
                                <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>货币
                            </td>
                        </tr>
                        <tr>
                            <td>
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
                            <strong><%=(Model!=null&&Model.id>0)?"编辑":"添加" %>货币</strong>
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
                           货币符号：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model=>model.code, new { @class = "txtbu01", @size = "30"})%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_code"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            货币简称：
                        </td>
                        <td width="36%">
                            <%=Html.HiddenFor(model=>model.id) %>
                            <%=Html.Hidden("pid",1)%>
                            <%= Html.TextBoxFor(model => model.name, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_name"></span>
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
                        <input name="Submit" type="submit" class="txtbu03" value="保存 " />
                    </td>
                    <td>
                        <input name="Submit2" onclick="window.location='/admin/currencies/'" type="button"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>货币 - SolarInfoBank
</asp:Content>
