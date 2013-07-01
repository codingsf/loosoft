<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.LoginRecord>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    权限配置
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script language="javascript" type="text/javascript">

        function getcheckboxes(name) {
            var values = "";
            $("input[name='" + name + "']").not("input:checked").each(function() {
                values += $(this).attr("ref") + ",";
            });
            values == "" ? '-1,' : values;
            return values;
        }

        $().ready(function() {
            $("#btnSave").click(function() {
                $.ajax({
                    type: "POST",
                    url: "/user/saveroles",
                    data: {id:$("#id").val(), roleName: $("#roleName").val(), roles: getcheckboxes('role') },
                    success: function(result) {
                        if (result == "ok")
                            window.location.href = "/user/roles";
                    }
                });
            });
            var ids = $("#rids").val();
                $("input[name='role']").attr("checked", "checked");
                ids = ids.split(',');
                $.each(ids, function(n, value) {
                    $("[ref='" + value + "']").attr("checked", false);
                });
        })
    </script>

    <table cellpadding="0" cellspacing="0" border="0">

        <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.gif">
                <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" /><%=Html.Hidden("rids", ViewData["rids"]) %><%=Html.Hidden("id", ViewData["id"]) %>
                        </td>
                        <td width="777">
                            <table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td width="93%" class="pv0216">
                                        Custom statements
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pv0212">
                                        Here you can display visual configuration. By clicking on the elements in the tree
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
                                <td height="40" class="down_line02 pr_10">
                                    角色名：
                                </td>
                                <td width="87%" class="down_line02">
                                    <input id="roleName" type="text" class="txtbu04" value="<%=ViewData["roleName"] %>"
                                        size="18" style="width: 400px;" />
                                </td>
                            </tr>
                            <% int i = 0;
                               foreach (KeyValuePair<string, Hashtable> item in ViewData["items"] as Dictionary<string, Hashtable>)
                               {
                                   i++; %>
                            <tr>
                                <td width="13%" valign="top" style="padding-top: 10px;" class="down_line0<%=i%2 %> pr_10">
                                    <p>
                                        <%=item.Key%>：</p>
                                </td>
                                <td class="down_line0<%=i%2 %>">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <% int clo = 0;
                                               foreach (DictionaryEntry subitem in item.Value as Hashtable)
                                               {
                                                   if (clo++.Equals(4))
                                                   {
                                                       Response.Write("</tr><tr>");
                                                   }
                                            %>
                                            <td width="25%" height="35">
                                                <input type="checkbox" name="role" ref="<%=subitem.Key  %>" />
                                                <%=subitem.Value  %>
                                            </td>
                                            <%} int j = 4 - (clo % 4); while (j-- > 0 && j < 4) Response.Write("<td width=\"25%\" height=\"35\"></td>"); %>
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
                <div>
                    <table width="280" height="80" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <input id="btnSave" type="submit" class="txtbu03" value="保存" />
                            </td>
                            <td>
                                <input name="Submit32" type="submit" class="txtbu03" value="取消" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
