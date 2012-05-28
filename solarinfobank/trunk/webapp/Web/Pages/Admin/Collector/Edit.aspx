<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Model != null ? "编辑采集器" : "添加采集器"%>
    - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    code: {
                        required: true,
                        maxlength: 16,
                        minlength: 9
                    },
//                    key: {
//                        required: true,
//                        minlength: 16
//                    },
                    password: {
                        required: true,
                        maxlength: 32,
                        minlength: 6
                    },
                    MAC:
                    {
                        required: true,
                        maxlength: 16,
                        minlength: 12
                    },
                    PNO:
                    {
                        required: true,
                        maxlength: 20,
                        minlength: 20
                    },
                    Encryption:
                    {
                        required: true,
                        maxlength: 32,
                        minlength: 3
                    }
                },
                errorPlacement: function(error, element) {
                
                    if (element.attr("name") == "Encryption") {
                        $("#error_encryption").text('');
                        error.appendTo("#error_encryption");
                    }
                    
                    if (element.attr("name") == "code") {
                        $("#error_code").text('');
                        error.appendTo("#error_code");
                    }
                    if (element.attr("name") == "password") {
                        $("#error_password").text('');
                        error.appendTo("#error_password");
                    }
                    if (element.attr("name") == "MAC") {
                        $("#error_mac").text('');
                        error.appendTo("#error_mac");
                    }
                    if (element.attr("name") == "PNO") {
                        $("#error_pno").text('');
                        error.appendTo("#error_pno");
                    }
                    if (element.attr("name") == "Date") {
                        $("#error_date").text('');
                        error.appendTo("#error_date");
                    }
                    if (element.attr("name") == "key") {
                        $("#error_key").text('');
                        error.appendTo("#error_key");
                    }
                },

                messages: {
                    code: {
                        required: "<span class='error'>&nbsp;请输入编号</span>",
                        maxlength: "<span class='error'>&nbsp;编号不能超过16位</span>",
                        minlength: "<span class='error'>&nbsp;编号不能低于9位</span>"

                    },
                    key: {
                        required: "<span class='error'>&nbsp;请输入加密密匙</span>",
                        minlength: "<span class='error'>&nbsp;加密密匙不能低于32位</span>"
                    },
                    password: {
                        required: "<span class='error'>&nbsp;请输入采集器密码</span>",
                        maxlength: "<span class='error'>&nbsp;密码不能超过32位</span>",
                        minlength: "<span class='error'>&nbsp;密码不能低于6位</span>"
                        
                    },
                     MAC: {
                        required: "<span class='error'>&nbsp;请输入MAC地址</span>",
                        maxlength: "<span class='error'>&nbsp;MAC地址不能超过16位</span>",
                        minlength: "<span class='error'>&nbsp;MAC地址不能低于12位</span>"
                        
                    },
                    PNO: {
                        required: "<span class='error'>&nbsp;请输入生产批号</span>",
                        maxlength: "<span class='error'>&nbsp;生产批号只能是20位</span>",
                        minlength: "<span class='error'>&nbsp;生产批号只能是20位</span>"
                        
                    },
                    Encryption: {
                        required: "<span class='error'>&nbsp;请输入加密方式号</span>",
                        maxlength: "<span class='error'>&nbsp;加密方式不能高于32位</span>",
                        minlength: "<span class='error'>&nbsp;加密方式不能低于3位</span>"
                        
                    },
                    Date: {
                        required: "<span class='error'>&nbsp;请输入生产日期</span>"
                        
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <% using (Html.BeginForm("collector_save", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
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
                                <%=Model != null ? "编辑采集器" : "添加采集器"%>
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
                                <%=Model != null ? "编辑采集器" : "添加采集器"%></strong>
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
                        <td width="20%" height="36" class="pr_10">
                            采集器编号：
                        </td>
                        <td width="50%">
                        <%if (Model != null)
                          { %>
                            <%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30", @readonly = "readonly" })%> 
                            <%}
                          else
                          { %>
                            <%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30" })%> 
                          <%} %>
                            <span class="red">*</span>采集器编号必须在9-16个字符
                        </td>
                        <td width="30%">
                            <span id="error_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            密码：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.password, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>密码必须在6-32个字符 
                        </td>
                        <td>
                            <span id="error_password"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            流水号：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.PNO, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>流水号必须20个字符 
                        </td>
                        <td>
                            <span id="error_pno"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            MAC地址：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.MAC, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>Mac地址必须在12-16个字符 
                        </td>
                        <td>
                            <span id="error_mac"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            加密方式：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.Encryption, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_encryption"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <td height="36" class="pr_10">
                            加密密钥：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.Key, new { @class = "txtbu01", @size = "30" })%>
                           <%-- <span class="red">*</span>加密密钥是16个字符--%>
                        </td>
                        <td>
                            <span id="error_key"></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <td height="36" class="pr_10">
                            生产日期：
                        </td>
                        <td>
                            <%=Html.TextBox("Date",Model==null?string.Empty:Model.Date, new { @class = "txtbu01 Wdate", @size = "30", @readonly = "readonly", onclick = "WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})" }) %>
                        </td>
                        <td>
                            <span id="error_date"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            导入说明：
                        </td>
                        <td>
                            <%= Html.TextAreaFor(model => model.Descr, new {style="width:300px; height:100px;" })%>
                        </td>
                        <td>
                            <span id="error_password"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            &nbsp;
                        </td>
                        <td>
                            <%= Html.HiddenFor(model => model.isUsed)%>
                            <%= Html.HiddenFor(model => model.id)%>
                            <font color="red">
                                <%=ViewData["error"] == null ? "" : ViewData["error"]%></font>
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
                        <input name="Submit2" onclick="window.location='/admin/collectors/'" type="button"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
