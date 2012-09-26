<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.USER_APPLAY_COLLECTOR_NOTICE%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">

        <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

        <script>
            $(document).ready(function() {
                var msg = $("#msg").val();
                if (msg != "")
                    alert(msg);
                $(".create").click(function() {
                    $.ajax({
                        type: "GET",
                        url: "/user/regsource?t=create",
                        data: { random: Math.random() },
                        success: function(result) {
                            if (result == "true")
                                window.location.reload();
                            else
                                alert(result);
                        }
                    });
                });
            });

            function delitem(id) {
                if (confirm("<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>")) {
                    $.ajax({
                        type: "GET",
                        url: "/user/regsource?t=del&id=" + id,
                        data: {},
                        success: function(result) {
                            if (result == "true")
                                window.location.reload();
                        }
                    });
                }
            }
            
        </script>

        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
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
                                    <td class="pv0216">
                                        <%=Resources.SunResource.USER_APPLAY_COLLECTOR_NOTICE%>
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
                                        <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS_DETAIL%>&nbsp;
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
                        <table width="98%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <a class="create121" href="/user/regsource?t=create">
                                        <img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                                </td>
                                <td width="24%">
                                    <a class="create121" href="/user/regsource?t=create">
                                        <%=Resources.SunResource.USER_APPLAY_COLLECTOR_NOTICE%></a>
                                </td>
                                <td width="70%" align="right">
                                <input type="hidden" value="<%=TempData["message"] == null ? string.Empty : TempData["message"]%>" id="msg" /></span>
                                    <%=Resources.SunResource.TODAY_HAS_BEEN_CREATED%>:&nbsp;<%=ViewData["applyed"]%>&nbsp;;
                                    <%=Resources.SunResource.TODAY_ALSO_CAN_CREATE%>:&nbsp;<%=ViewData["available"]%>&nbsp;
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
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_ID%></strong>
                                            </td>
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ADDUSER_PASSWORD%></strong>
                                            </td>
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ADDUSER_SELECTED_PLANT%></strong>
                                            </td>
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.PLANT_REG_SOURCE_PLANTTIME%></strong>
                                            </td>
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.PLANT_REG_SOURCE_CREATETIME%></strong>
                                            </td>
                                            <td width="15%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.PLANT_REG_SOURCE_DEADLINE_TIME%></strong>
                                            </td>
                                            <td width="10%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <%
                                int i = 0;
                                foreach (var item in Model)
                                {
                                    i++;
                            %>
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                        <tr>
                                            <td width="15%" height="42" align="center">
                                                <%=item.code %>
                                            </td>
                                            <td width="15%" align="center">
                                                <%=item.password %>
                                            </td>
                                            <td width="15%" align="center">
                                                <%=item.plant == null ? Resources.SunResource.DISPLAY_NO_ASSIGNED_PLANT : item.plant.name%>
                                            </td>
                                            <td width="15%" align="center">
                                                <%=item.plant == null ? Resources.SunResource.DISPLAY_NO_ASSIGNED_PLANT : DateTime.Now.AddHours(item.plant.timezone).ToString("yyyy-MM-dd hh:mm")%>
                                            </td>
                                            <td width="15%" align="center">
                                                <%=item.importDate.ToString("yyyy-MM-dd hh:mm")%>
                                            </td>
                                            <td width="15%" align="center">
                                                <%=item.limitDate.ToString("yyyy-MM-dd hh:mm")%>
                                            </td>
                                            <td width="10%" align="center">
                                                <%if (item.plant == null)
                                                  { %>
                                                <a onclick="delitem('<%=item.id %>')" target="_parent" href="javascript:void(0)">
                                                    <img src="/images/sub/cross.gif" alt="Delete" title="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" border="0" height="16"
                                                        width="16"></a>
                                                <%}
                                                  else
                                                  { %>
                                                <img height="16" border="0" width="16" alt="Delete" title="<%=Resources.SunResource.PLANT_ADDPLANT_DELETE %>" src="/images/sub/cross00.gif" />
                                                <%} %>
                                            </td>
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
            </td>
        </tr>
    </table>
</asp:Content>
