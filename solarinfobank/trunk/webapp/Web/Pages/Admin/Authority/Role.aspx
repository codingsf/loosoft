<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Hashtable>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#roleForm").validate({
                errorElement: "em",
                rules: {
                    name: {
                        required: true,
                        remote: {
                            type: "POST",
                            url: "/admin/checkrolename",
                            data: {
                                name: function() {
                                    if ($("#roleId").val() > 0) {
                                        if ($("#prename").val() == $("#name").val()) {
                                            return "";
                                        }
                                        else {
                                            return $("#name").val();
                                        }
                                    }
                                    return $("#name").val();
                                }
                            }
                        }
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "name") {
                        $("#error_name").text('');
                        error.appendTo("#error_name");
                    }
                },

                messages: {
                    name: {
                        required: "<span class='error'>&nbsp;请输入角色名</span>",
                        remote: "<span class='error'>&nbsp;此名称已存在</span>"
                    }
                }
            });

        });
    </script>

    <script>
        $(document).ready(function() {
            $('#saveChange').click(function() {
                //                $.ajax({
                //                    type: "POST",
                //                    url: "/admin/saverole",
                //                    data: { rid: $("#roleId").val(), name: $("#name").val(), caids: cbxvalue("caid") },
                //                    success: function(result) {
                //                        if (result == "true")
                //                            window.location.href = "/admin/roles";
                //                        else
                //                            alert("保存失败");
                //                    }
                //                });
                var caids = cbxvalue("caid");
                var rid = $("#roleId").val();
                $("#caids").val(caids);
                $("#rid").val(rid);
              // alert($("#caids").val());
            });

        });
        function cbxvalue(name) {
            var values = "";
            $("input[name='" + name + "']").not("input:checked").each(function() {
                values += $(this).attr("ref") + ",";
            });
            return values == "" ? '-1,' : values;
        }
      
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form method="post" id="roleForm" name="addForm" action="/admin/saverole">
        <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif" width="31" height="41" />
                            </td>
                            <td width="93%" class="pv0216">
                                <%=ViewData["role"] == null ? "添加角色" : "编辑角色"%>
                                <%=Html.Hidden("caids")%>
                                <%=Html.Hidden("rid")%>
                            </td>
                        </tr>
                        <tr>
                            <td class="pv0212">
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
                        <td heigtht="40" class="pr_10">
                            角色名：
                        </td>
                        <td>
                            <%=Html.Hidden("prename", ViewData["role"] == null ? string.Empty : (ViewData["role"] as AdminRole).name, new { @class = "txtbu04", style = "width: 400px;" })%>
                            <%=Html.Hidden("roleId", ViewData["role"] == null ? 0 : (ViewData["role"] as AdminRole).id, new { @class = "txtbu04", style = "width: 400px;" })%>
                            <%=Html.TextBox("name", ViewData["role"] == null ? string.Empty :( ViewData["role"] as AdminRole).name, new { @class = "txtbu04", style = "width: 400px;" })%>
                           <span class="red">*</span> <span id="error_name"></span>
                        </td>
                    </tr>
                    <%
                        foreach (var item in ViewData["keys"] as IList<string>)
                        { %>
                    <tr>
                        <td width="14%" valign="top" style="padding-top: 10px;" class="pr_10">
                            <%=item%>：
                        </td>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <%int i = 0;
                                      foreach (var m in (Model as Hashtable)[item] as IList<AdminControllerAction>)
                                      {
                                          if ((i++ % 4 == 0) && i > 1)
                                              Response.Write("</tr><tr>");
                                    %>
                                    <td width="25%" height="35">
                                        <%if (ViewData["role"] != null)
                                          {
                                              if ((ViewData["role"] as AdminRole).actions.Count(model => model.id == m.id) > 0)
                                              {
                                        %>
                                        <input type="checkbox" name="caid" value="checkbox" ref="<%=m.id %>" />
                                        <%=m.descr%>
                                        <%}
                                              else
                                              {%>
                                        <input type="checkbox" name="caid" checked="checked" value="checkbox" ref="<%=m.id %>" />
                                        <%=m.descr%>
                                        <%}
                                          }
                                          else
                                          { %>
                                        <input type="checkbox" name="caid" value="checkbox" ref="<%=m.id %>" />
                                        <%=m.descr%>
                                        <%} %>
                                    </td>
                                    <%
                                        }
                                      i = 4 - (i % 4);
                                      while (i-- > 0)
                                          Response.Write("<td width=\"25%\" height=\"35\"></td>");
                                    %>
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
                        <input name="Submit3" type="submit" class="txtbu03" value="保存" id="saveChange" />
                    </td>
                    <td>
                        <input name="Submit32" type="reset" class="txtbu03" value="重置" />
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </td>
</asp:Content>
