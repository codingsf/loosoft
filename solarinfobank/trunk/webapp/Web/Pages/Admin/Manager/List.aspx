<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Manager>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    管理员列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script>
        function changePage(index) {
            window.location.href = "/admin/managers/?type=" + $("#type").val() + "&sd=" + $("#estartdate").val() + "&ed=" + $("#eenddate").val();
        }
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
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
                                管理员列表
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
                <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="10%" height="40">
                            创建时间
                        </td>
                        <td width="15%">
                          从:  <input id="estartdate" name="estartdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["sd"]==null? DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd"):Request.QueryString["sd"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                    
                        <td width="15%" id="country_ctl">
                           到 : <input id="eenddate" name="eenddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["ed"]==null? DateTime.Now.ToString("yyyy-MM-dd"):Request.QueryString["ed"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                       <%-- <td width="10%" align="center">
                            用户类型:
                        </td>
                        <td width="10%" id="city_ctl">
                            <%= Html.DropDownList("type", new List<SelectListItem>
                                    {
                                        (new SelectListItem() {Text = "所有用户", Value = ""}),
                                        (new SelectListItem() {Text = "后台用户", Value = "0"}),
                                        (new SelectListItem() {Text ="生产用户", Value = "1"}),
                                    }, new { @class="txtbu01" ,style="width:180px" })%>
                        </td>--%>
                        <td width="14%" rowspan="2" align="center" valign="bottom" style="padding-bottom: 5px;">
                            <input name="Submit" id="checking" type="button" class="subbu01" value="查询" onclick="changePage(1);" />
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="12%" align="center">
                                        <strong>用户名</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>角色</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>是否锁定</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>真实姓名</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>部门</strong>
                                    </td>
                                    <td width="18%" align="center">
                                        <strong>邮箱</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>创建时间</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                int i = 1;
                                foreach (var item in Model)
                                {
                                    i++;
                                            
                            %>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            
                                <tr onmouseout="this.style.backgroundColor=''">
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <div style="width: 80px; overflow: hidden;" title="<%= Html.Encode(item.username)%> ">
                                            <%= Html.Encode(item.username)%>
                                        </div>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%string roleNames = string.Empty;
                                          if (item.roles != null)
                                              foreach (var m in item.roles)
                                                  if (m.role != null)
                                                      roleNames += m.role.name + " "; %>
                                        <%= roleNames%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <% =Html.Encode(item.locked == true ? "Yes" : "No")%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.HiddenFor(model => item.id) %>
                                        <%= Html.Encode(item.fullname)%>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.department)%>
                                    </td>
                                    <td width="18%" align="center" class="am_line0<%=i%2 %>">
                                        <div style="width: 120px; overflow: hidden;" title="<%= Html.Encode(item.email)%> ">
                                            <%= Html.Encode(item.email)%>
                                        </div>
                                    </td>
                                    <td width="12%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.create_date.ToString("yyyy-MM-dd"))%>
                                    </td>
                                    <td width="10%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "manager_edit"))
                                          { %>
                                        <a href="/admin/manager_edit/<%=item.id%>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="编辑" title="编辑" /></a>
                                        <%} %>
                                        <%if (AuthService.isAllow("admin", "manager_delete"))
                                          { %>
                                        <a href="/admin/manager_delete/<%=item.id%>" onclick="return(confirm( '确定删除 ？ '))">
                                            <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                title="删除" /></a>
                                        <%}
                                          else
                                          { %>
                                          <img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                title="删除" />
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                            <%}
                            %>
                        </td>
                    </tr>
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="30%">
                    <%if (AuthService.isAllow("admin", "manager_add"))
              { %>
                    <a href="/admin/manager_add/"> <img src="/images/am/ad_bu10.gif" width="131" height="28" /></a>
              
                    <%} %>
                    </td>
                    <td width="70%">
                    </td>
                  </tr>
                </table></td>
              </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
