<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">

        <script>
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "/admin/load_enable_items",
                    data: { t: $("#code").val() },
                    success: function(result) {
                        $('#container').empty();
                        $('#container').html(result);
                    }
                });

                $('#code').change(function() {
                    $.ajax({
                        type: "POST",
                        url: "/admin/load_enable_items",
                        data: { t: $("#code").val() },
                        success: function(result) {
                            $('#container').empty();
                            $('#container').html(result);
                        }
                    });
                });

                $('#btnsubmit').click(function() {
                    $.ajax({
                        type: "POST",
                        url: "/admin/save_mge_items",
                        data: { t: $("#code").val(), items: cbxvalue("items") },
                        success: function(result) {
                            alert(result);
                            $('#code').change();
                        }
                    });
                });

            });
            function cbxvalue(name) {
                var values = "";
                $("input[name='" + name + "']:checked").each(function() {
                    values += $(this).attr("ref") + ",";
                });
                return values == "" ? '-1,' : values;
            }
      
        </script>

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
                                电站/逆变器配置
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
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="29%" height="35" class="pr_10">
                            选择类别：
                        </td>
                        <td width="36%">
                            <%=Html.DropDownList("code", new List<SelectListItem> {
                                                new SelectListItem { Text = "电站显示项", Value = "0"},
                                                new SelectListItem { Text = "逆变器显示项", Value = "1"},
                                                }) %>
                        </td>
                        <td width="35%">
                            <span id="error_username"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="35" class="pr_10">
                            显示项：
                        </td>
                        <td width="71%" colspan="2">
                            <ul style="float: left; margin:0px;  padding: 0px;" id="container">
                            </ul>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <input name="Submit" id="btnsubmit" type="submit" class="txtbu03" value=" 保存 " />
                </td>
                <td>
                    <input name="Submit2" type="button" onclick="window.location='/admin/managers/'"
                        class="txtbu03" value=" 取消 " />
                </td>
            </tr>
        </table>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    电站/逆变器配置- SolarInfoBank
</asp:Content>
