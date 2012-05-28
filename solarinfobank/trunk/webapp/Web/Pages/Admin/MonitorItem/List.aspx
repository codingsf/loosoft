<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.MonitorItem>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <script>
    function changePage(page) {
        window.location.href = '/monitoritem/list/' + page;
    }
    </script>
    
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
    <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">MonitorItem List</td>
                </tr>
                <tr>
                  <td> Here you can display visual configuration. By clicking on the elements in the tree </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                             <a href="/monitoritem/add"><img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                        </td>
                        <td width="94%">
                            <a href="/monitoritem/add">Add</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr>
                                    <td width="10%" align="center">
                                        <strong>测点编码</strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>备忘名称</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>单位</strong>
                                    </td>
                                    <td width="30%" align="center">
                                        <strong>所属协议类型 </strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>是否统计</strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>是否显示给用户</strong>
                                    </td>
                                    <td width="13%" align="center">
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
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                <tr  >
                                    <td width="10%" height="42" align="center">
                                        <%= Html.Encode(item.code)%>
                                    </td>
                                    <td width="12%" align="center">
                                        <%= Html.Encode(item.noteName)%>
                                    </td>
                                    <td width="10%" align="center">
                                        <%= Html.Encode(item.unit)%>
                                    </td>
                                    <td width="30%" align="center">
                                        <%= Html.Encode(item.protocolType.name)%>
                                    </td>
                                    <td width="10%" align="center">
                                        <%= Html.Encode(item.isCount)%>
                                    </td>
                                    <td width="15%" align="center">
                                        <%= Html.Encode(item.isDisplay)%>
                                    </td>
                                    <td width="13%" align="center">
                                        <a href="/monitoritem/edit/<%=item.code%>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                title="<%=Resources.SunResource.MONITORITEM_EDIT%>" /></a> <a href="/monitoritem/delete/<%=item.code%>"
                                                    onclick="return(confirm( 'Are you sure you want to delete？ '))">
                                                    <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                        title="<%=Resources.SunResource.MONITORITEM_DELETE%>" /></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    
                     
                </table>
            </div>
            <div class="sb_down">
            </div><%Html.RenderPartial("page"); %>
        </div>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    MonitorItem List - SolarInfoBank
</asp:Content>
