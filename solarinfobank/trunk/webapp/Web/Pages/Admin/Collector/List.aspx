<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    采集器列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
<style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <script>
            function changePage(page) {
                window.location.href = '/admin/collectors/' + page + "?sd=" + $("#estartdate").val() + "&ed=" + $("#eenddate").val();
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
                                采集器列表
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
                            <%if (AuthService.isAllow("admin", "collector_add"))
                              { %>
                            <a href="/admin/collector_add/" class="dbl">
                                <img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                            <%} %>
                        </td>
                        <td width="94%">
                            <%if (AuthService.isAllow("admin", "collector_add"))
                              { %>
                            <a href="/admin/collector_add/" class="dbl">添加</a>
                            <%} %>
                            <%if (AuthService.isAllow("admin", "collector_excel"))
                              { %>
                            | <a href="/admin/collector_excel/" class="dbl">导入采集器 </a>
                            <%} %>
                            <%if (AuthService.isAllow("admin", "collector_output"))
                              { %>
                            | <a href="/admin/collector_output/<%=(ViewData["page"] as Pager).PageIndex %>?sd=<%=Request.QueryString["sd"] %>&ed=<%=Request.QueryString["ed"] %>"
                                class="dbl">导出Excel文件 </a>
                            <%} %>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="10%" height="40">
                            导入时间
                        </td>
                        <td width="20%">
                           从: <input id="estartdate" name="estartdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["sd"]==null? DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd"):Request.QueryString["sd"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                        <td width="20%" id="country_ctl">
                            到:  <input id="eenddate" name="eenddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["ed"]==null?DateTime.Now.ToString("yyyy-MM-dd"):Request.QueryString["ed"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                        <td width="20%" rowspan="2" align="center" valign="bottom" style="padding-bottom: 5px;">
                            <input name="Submit" id="checking" type="button" class="subbu01" value="查询" onclick="changePage(1);" />
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="20%" align="center">
                                        <strong>采集器编号</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>密码</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>分配电站</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>电站时间</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>导入时间</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>是否启用</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>工作状态</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <% 
                        int i = 1;
                        foreach (var item in Model)
                        {
                            i++;
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20%" align="center" class="am_line0<%=i%2 %>">
                                        <%= Html.Encode(item.code)%>
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="10%" align="center" style=" word-wrap:break-word; overflow: hidden;" valign="middle">
                                       <div style="width:80px; word-break:break-all; "><%= Html.Encode(item.password)%></div> 
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="10%" align="center">
                                        <%=(item.plant == null ? "<font color='green'>未分配电站</font>" : item.plant.name)%>
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="15%" align="center">
                                        <% =(item.plant == null ? "<font color='green'>未分配电站</font>" : DateTime.Now.AddHours(item.plant.timezone).ToString("yy/MM/dd HH:mm"))%>
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="15%" align="center">
                                        <% =Html.Encode(item.importDate.ToString("yyyy-MM-dd HH:mm")) %>
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="10%" align="center">
                                        <% =Html.Encode(item.isUsed==true?"Yes":"No") %>
                                    </td>
                                    <td class="am_line0<%=i%2 %>" width="10%" align="center">
                                        <% =Html.Encode(item.plant == null ? "停止" : (item.plant.isWork ? "工作" : "停止"))%>
                                    </td>
                                    <td width="10%" align="center" class="am_line0<%=i%2 %>">
                                        <%if (AuthService.isAllow("admin", "collector_edit"))
                                          { %>
                                        <a href="/admin/collector_edit/<%=item.id%>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="编辑" title="编辑" /></a>&nbsp;&nbsp;
                                        <%} %>
                                        <%if (item.isUsed == true)
                                          { %>
                                        <img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="不能删除"
                                            title="不能删除" />
                                        <%}
                                          else
                                          {
                                              if (AuthService.isAllow("admin", "collector_delete"))
                                              { %>
                                        <a onclick="return confirm('是否确认删除?')" href="/admin/collector_delete/<%=item.id%>">
                                            <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="删除" title="删除" /></a>
                                        <%}
                                              else
                                              {%><img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="删除"
                                                  title="删除" />
                                        <%}
                                          } %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    </td>
                    <td width="70%">
                    <%Html.RenderPartial("mpage"); %>
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
