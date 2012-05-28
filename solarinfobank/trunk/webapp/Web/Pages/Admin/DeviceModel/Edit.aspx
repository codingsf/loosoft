<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.DeviceModel>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    添加设备型号 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#aspnetForm").validate({
                errorElement: "em",
                rules: {
                    code: {
                        required: true,
                        maxlength: 5
                    },
                    name: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "code") {
                        $("#error_code").text('');
                        error.appendTo("#error_code");
                    }
                    if (element.attr("name") == "name") {
                        $("#error_name").text('');
                        error.appendTo("#error_name");
                    }
                },

                messages: {
                    code: {
                    required: "<span class='error'>&nbsp;请输入编号</span>",
                    maxlength: "<span class='error'>&nbsp;输入的字符不能超过5个</span>"
                    },
                    name: {
                    required: "<span class='error'>&nbsp;请输入名称</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form id="aspnetForm" runat="server" method="post" action="/devicemodel/save">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">添加设备型号</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>                </tr>
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
                            <strong>添加设备型号</strong>
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
                            型号编码：
                        </td>
                        <td width="36%">
                        <%if (Model!=null)
                          { %>
                            <%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30", @readonly = "true" })%><%}
                          else
                          { %>
                          <%= Html.TextBoxFor(model => model.code, new { @class = "txtbu01", @size = "30"})%>
                      <%} %>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            型号名称：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.name, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td>
                            <span id="error_name"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            型号功率：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.designPower, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="pr_10">
                            所属类型：
                        </td>
                        <td>
                            <%=Html.DropDownListFor(model => model.modelTypeCode, ViewData["selectDeviceTypes"] as IList<SelectListItem>, new { @class = "select200" })%>
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
                        <input name="Submit2" onclick="window.location='/devicemodel/list/'" type="button"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </td>
</asp:Content>
