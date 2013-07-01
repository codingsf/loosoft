<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Plant>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    添加组合电站
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td background="/images/kj/kjbg01.gif" valign="top" width="793">

                <script src="/script/jquery.js" type="text/javascript"></script>

                <script src="/script/jquery.validate.js" type="text/javascript"></script>

                <script language="javascript" type="text/javascript">

                    function getradio(name) {
                        return $("input[name='" + name + "']:checked").val();
                    }

                    function checkform() {
                        if ($("#uname").val() == "") {
                            $("#error_uname").html('<em class="error" ><span class="error">&nbsp;请输入用户名</span></em>');
                            $("#uname").get(0).focus();
                            return false;
                        }
                        if ($("#upwd").val() == "") {
                            $("#error_upwd").html('<em class="error" ><span class="error">&nbsp;请输入密码</span></em>');
                            $("#upwd").get(0).focus();
                            return false;
                        }
                        return true;
                    }

                    function getcheckboxes(name, attr) {
                        var values = "";
                        $("input[name='" + name + "']:checked").each(function() {
                            values += $(this).attr(attr) + ",";
                        });
                        values == "" ? '-1,' : values;
                        return values;
                    }

                    function cando() {
                        if ('<%=ViewData["cando"] %>' == 'false') {
                            alert('您没有创建门户请先创建门户');
                            return false;
                        }
                        return true;
                    }

                    $().ready(function() {
                        $(".ut").click(function() {
                            if ($(this).val() == 1) {
                                $(".sing").hide();
                            } else
                                $(".sing").show();
                            parent.iFrameHeight()
                        });

                        cando();
                        $("#btnSave").click(function() {

                            if (checkform() && cando()) {
                                $.ajax({
                                    type: "POST",
                                    url: "/user/saveshareplant",
                                    data: { singlemark: '0', pids: getcheckboxes('plant', 'ref'), ut: getradio('ut'), role: getradio('role'), uname: $("#uname").val(), upwd: $("#upwd").val(), email: $("#email").val(), sendmail: $("#sendmail").attr("checked") },
                                    success: function(result) {
                                        if (result == "ok")
                                            window.location.href = "/user/includeallplants";
                                        else
                                            alert(result.substring(6));
                                    }
                                });
                            }
                        });
                    });
                </script>

                <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0"
                    width="793" height="63">
                    <tbody>
                        <tr>
                            <td width="8">
                                <img src="/images/kj/kjico02.jpg" width="8" height="63">
                            </td>
                            <td width="777">
                                <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="7%" rowspan="2" align="center">
                                            <img src="/images/kj/kjiico01.gif" />
                                        </td>
                                        <td class="pv0216">
                                            给门户用户分配电站
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
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;
                                        </td>
                                        <td width="18%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" width="6">
                                <img src="/images/kj/kjico03.jpg" width="6" height="63">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="subrbox01">
                    <div>
                        <table width="98%" height="25" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="3%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="97%" align="left">
                                    给门户用户分配电站
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px;">
                            <tr>
                                <td width="19%" align="right" valign="top" style="padding-right: 5px;">
                                    待分配电站：
                                </td>
                                <td width="81%">
                                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <%int i = 0;
                                              foreach (Plant item in Model as IList<Plant>)
                                              {
                                                  if (i++ % 2 == 0 && i > 1)
                                                      Response.Write("<td width=\"33%\" style=\"padding-left: 5px;\">&nbsp;</td></tr><tr>");
                                            %>
                                            <td width="33%" style="padding-left: 5px;">
                                                <strong>
                                                    <input type="checkbox" name="plant" value="checkbox" ref="<%=item.id %> " />
                                                </strong>
                                                <%=item.name%>
                                            </td>
                                            <%} %>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="40" align="right" class="down_line02" style="padding-right: 5px;">
                                    用户类型：
                                </td>
                                <td class="down_line02" style="padding-left: 5px;">
                                    <table width="70%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="33%">
                                                <input type="radio" name="ut" id="ut" value="1" class="ut" />
                                                已有用户
                                            </td>
                                            <td width="33%">
                                                <input type="radio" name="ut" id="ut" value="2" checked="checked" class="ut" />
                                                新建用户
                                            </td>
                                            <td width="33%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td style="padding-right: 5px;" height="40" align="right">
                                    用户角色：
                                </td>
                                <td style="padding-left: 5px;">
                                    <table border="0" cellpadding="0" cellspacing="0" width="70%">
                                        <tr>
                                            <%i = 0;
                                              foreach (var item in ViewData["roles"] as IList<Role>)
                                              {
                                                  if (i++ % 2 == 0 && i > 1)
                                                      Response.Write("<td width=\"33%\" bgcolor=\"#F3F3F3\" style=\"padding-left: 5px;\">&nbsp;</td></tr><tr>");
                                            %>
                                            <td width="33%" bgcolor="#F3F3F3">
                                                <strong>
                                                    <input checked="checked" type="radio" name="role" value="<%=item.id %>" />
                                                </strong>
                                                <%=item.name%>
                                            </td>
                                            <%}
                                              while ((i++ % 3) != 0)
                                                  Response.Write("<td width=\"33%\" bgcolor=\"#F3F3F3\" style=\"padding-left: 5px;\">&nbsp;</td>");
                                            %>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="40" align="right" style="padding-right: 5px;">
                                    用户名称：
                                </td>
                                <td style="padding-left: 5px;">
                                    <input id="uname" type="text" class="txtbu01" style="width: 250px;" />
                                    <span class="red">*</span> <span id="error_uname"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="40" align="right" class="down_line02" style="padding-right: 5px;">
                                    密码：
                                </td>
                                <td class="down_line02" style="padding-left: 5px;">
                                    <input id="upwd" type="text" class="txtbu01" style="width: 250px;" />
                                    <span class="red">*</span> <span id="error_upwd"></span>
                                </td>
                            </tr>
                            <tr class="sing">
                                <td height="40" align="right" style="padding-right: 5px;">
                                    邮箱：
                                </td>
                                <td style="padding-left: 5px;">
                                    <input id="email" type="text" class="txtbu01" style="width: 250px;" />
                                </td>
                            </tr>
                            <tr class="sing">
                                <td height="40" align="right" class="down_line02" style="padding-right: 5px;">
                                    &nbsp;
                                </td>
                                <td class="down_line02" style="padding-left: 5px;">
                                    <input type="checkbox" id="sendmail" value="checkbox" />
                                    发送账号密码到邮箱
                                </td>
                            </tr>
                            <tr>
                                <td height="40" align="right" valign="top" class="down_line02" style="padding-right: 5px;">
                                    &nbsp;
                                </td>
                                <td class="down_line02" style="padding-right: 25px;" align="right">
                                    <input id="btnSave" name="btnSave" type="button" class="subbu01" value="保存" />
                                    <input name="Submit23" type="button" class="subbu01" value="取消" style="margin-left: 50px;"
                                        onclick="window.location.href='/user/includeallplants'" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
