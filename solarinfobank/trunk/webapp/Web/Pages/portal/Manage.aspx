<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Protal>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>门户管理
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/countrycity.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            var error = '<%=TempData["error"] %>';
            if (error != "") alert(error);
            var items = $("#iids").val().split(',');
            $.each(items, function(key, value) {
                $("input[name='items']").each(function() {
                    if ($(this).val() == value) {
                        $(this).attr("checked", "true");
                    }
                });
            });

            $("#saveform").validate({
                errorElement: "em",
                rules: {
                    name: {
                        required: true
                    },
                    rate: {
                        required: true,
                        number: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "name") {
                        $("#error_name").text('');
                        error.appendTo("#error_name");
                    }
                    if (element.attr("name") == "rate") {
                        $("#error_rate").text('');
                        error.appendTo("#error_rate");
                    }
                },
                messages: {
                    name: {
                        required: "<span class='error'> 请输入门户名称 </span>"
                    },
                    rate: {
                        required: "<span class='error'> 请输入收益换算率 </span>",
                        number: "<span class='error'> 收益换算率只能是数字 </span>"
                    }
                }
            });
        });
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <form id="saveform" name="saveform" method="post" action="/portal/save" enctype="multipart/form-data">
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
                                    <td class="pv0216">
                                        门户管理
                                    </td>
                                    <td align="right" class="help_r">
                                        <a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf"
                                            target="_blank" style="color: #59903E; text-decoration: underline;">
                                            <%=Resources.SunResource.MONITORITEM_HELP%>
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="75%">
                                        <%=Resources.SunResource.USER_CHANGEPASSWORD_CHANGEPASSWORD_DETAIL%>&nbsp;
                                    </td>
                                    <td width="18%">
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
                                    <strong>门户管理</strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div class="note01">
                            <%=Resources.SunResource.MONITORITEM_NOTE %>:*<%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM %>
                        </div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                           <%if(ViewData["actionMessage"]!=null||ViewData["errorMessage"]!=null){ %>
                           <tr>
                                <td height="40" class="pr_10">
                                </td>
                                <td>
                                    <%= ViewData["actionMessage"] %>
                                    <%= ViewData["errorMessage"] %>
                                </td>
                                <td>
                                </td>
                            </tr>     
                            <%} %>                   
                            <tr>
                                <td width="35%" height="35" class="pr_10">
                                    门户名称：
                                </td>
                                <td width="27%">
                                    <%=Html.TextBoxFor(m=>m.name, new {@class="txtbu01" }) %>
                                    <input type="hidden" value="<%=Model.items %>" id="iids" />
                                    <span class="red">*</span>
                                </td>
                                <td width="44%">
                                    <span id="error_name"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    门户页面显示项目配置：
                                </td>
                                <td colspan="2">
                                    <table width="70%">
                                        <tr>
                                            <%=Html.HiddenFor(m => m.id) %>
                                            <% int i = 0;
                                               foreach (KeyValuePair<string, string> item in ProtalItems.items)
                                               {
                                                   i++;
                                                   if (i > 3)
                                                   {
                                                       Response.Write("</tr><tr>");
                                                       i = 1;
                                                   }
                                            %>
                                            <td height="30">
                                                <input type="checkbox" name="items" value="<%=item.Key %>" /> <span><%=item.Value %></span>
                                            </td>
                                            <%} %>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <span id="Span1"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    收益换算率：
                                </td>
                                <td>
                                    <%=Html.TextBoxFor(m=>m.rate, new { @class = "txtbu01" })%>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                    <span id="error_rate"></span>
                                </td>
                            </tr>
                            <tr style="display:none">
                                <td height="35" class="pr_10">
                                    地图图片：
                                </td>
                                <td>
                                    <input type="file" name="markpic" />
                                     <%if (Model != null && string.IsNullOrEmpty(Model.markPic) == false)
                                      { 
                                     %>
                                      <img src="/protalimg/<%=Model.markPic %>?<%=Guid.NewGuid() %>" width="120" height="130"  style="margin:10px; margin-left:0;"/>
                                     <%}%>
                                </td>
                                <td>
                                    <span id="Span3"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    门户logo：
                                </td>
                                <td>
                                    <input type="file" name="logo" />
                                    <%if (Model != null && string.IsNullOrEmpty(Model.logo) == false)
                                    {
                                    %>
                                      <img src="/protalimg/<%=Model.logo %>?<%=Guid.NewGuid() %>" style="margin:10px; margin-left:0; max-width:200px;" width="140" />
                                    <%}%>
                                </td>
                                <td>
                                    <span id="Span4"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    宣传语：
                                </td>
                                <td>
                                    <%=Html.TextAreaFor(m => m.footer, new { @rows = 4,@cols= 50})%>
                                </td>
                                <td>
                                    <span id="error_footer"></span>
                                </td>
                            </tr>

                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div>
                    <table width="244" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="111">
                                <%
                                    if (AuthService.isAllow(AuthorizationCode.USER_CHANGE_PASSWORD))
                                    { %>
                                <input name="Submit2" type="submit" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />
                                <%}
                                    else
                                    { %>
                                <input name="Submit2" type="button" class="txtbu06" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />
                                <%} %>
                            </td>
                            <td width="108">
                                <input id="cancel" type="button" onclick="reset();" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_RESET %> " />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </div>
                </form>
            </td>
        </tr>
    </table>
</asp:Content>
