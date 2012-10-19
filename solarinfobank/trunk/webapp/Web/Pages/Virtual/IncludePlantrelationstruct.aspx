<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        $(document).ready(function() {
            $("#btnsaveconfig").click(function() {
                $.get('/user/relationconfig/',
                  {
                      relationId: '<%=Model.id %>',
                      relationType: '<%=RelationConfig.VirtualPlant %>',
                      width: $("#config1").val(),
                      height: $("#config2").val(),
                      config3: $("#config3").val(),
                      config4: $("#config4").val()
                  },
                  function(data) {
                      if (data == "ok")
                          window.location.reload();
                  });
            });
        });
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
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
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td class="pv0216">
                                        电站结构图
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
                <%if (this.Model.childs.Count > 0)
                  { %>
                <div class="subrbox01">
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div style="width: 730px; overflow: scroll; overflow-y: hidden;">
                            <table width="150%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                            <tr>
                                                <td width="20%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_ALLPLANTS_NAME%></strong>
                                                </td>
                                                <td width="10%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_ALLPLANTS_COUNTRY%></strong>
                                                </td>
                                                <td width="10%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_ALLPLANTS_CITY%></strong>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_TODAYENERGY%></strong>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_ALLPLANTS_ENERGY%></strong>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_CURRENT_POWER%></strong>
                                                </td>
                                                <td width="15%" align="center">
                                                    <strong>
                                                        <%=Resources.SunResource.USER_ALLPLANTS_OPERATION%></strong>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <% int i = 0;
                                   foreach (Plant plant in Model.childs)
                                   {
                                       i++; %>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                            <tr>
                                                <td width="20%" height="35" align="center">
                                                    <%if (plant.hasFaultDevice)
                                                      { %>
                                                    <img src="/images/warning_16.gif" alt="" style="float: left">
                                                    <%} %>
                                                    <%if (plant.isVirtualPlant)
                                                      { %>
                                                    <img src="/images/lightning.gif" alt="" style="float: left">
                                                    <%} %>
                                                    <div style="width: 170px; float: right; text-align: center; line-height: 23px; overflow: hidden;"
                                                        title="<%=plant.name%>">
                                                        <%if (plant.isVirtualPlant)
                                                          { %>
                                                        <a target="_blank" href="/virtual/plantrelationstruct/<%=plant.id%>" class="dbl">
                                                            <%}
                                                          else
                                                          { %>
                                                            <a target="_blank" href="/plant/overview/<%=plant.id%>" class="dbl">
                                                                <%} %>
                                                                <%=plant.name%>
                                                            </a>
                                                    </div>
                                                </td>
                                                <td width="10%" align="center">
                                                    <div style="width: 100px; overflow: hidden;" title="<%=plant.country%>">
                                                        <%=plant.country%></div>
                                                </td>
                                                <td width="10%" align="center">
                                                    <div style="width: 100px; overflow: hidden;" title="<%=plant.city%>">
                                                        <%=plant.city%></div>
                                                </td>
                                                <td width="15%" align="center">
                                                    <div style="width: 100px; overflow: hidden;" title="<%=plant.DisplayTotalDayEnergy%>">
                                                        <%=plant.DisplayTotalDayEnergy + "(" + plant.TotalDayEnergyUnit + ")"%>
                                                    </div>
                                                </td>
                                                <td width="15%" align="center">
                                                    <div style="width: 100px; overflow: hidden;" title="<%=plant.DisplayTotalEnergy%>">
                                                        <%=plant.DisplayTotalEnergy + "(" + plant.TotalEnergyUnit + ")"%>
                                                    </div>
                                                </td>
                                                <td width="15%" align="center">
                                                    <div style="width: 100px; overflow: hidden;" title="<%=plant.DisplayTodayTotalPower%>">
                                                        <%=plant.DisplayTodayTotalPower + "(" + plant.TodayTotalPowerUnit + ")"%>
                                                    </div>
                                                </td>
                                                <td width="15%" align="center">
                                                    <%if (AuthService.isAllow(AuthorizationCode.EDIT_PLANT))
                                                      { %>
                                                    <a href="/plant/<%=plant.isVirtualPlant?"virtual":"" %>edit/<%=plant.id %>?fromurl=/virtual/includeplantrelationstruct/<%=Model.id %>">
                                                        <img src="/images/sub/pencil.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                            title="<%=Resources.SunResource.MONITORITEM_EDIT%>" /></a>
                                                    <%}
                                                      else
                                                      {
                                                    %>
                                                    <img src="/images/sub/pencil0.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_EDIT%>"
                                                        title="<%=Resources.SunResource.MONITORITEM_EDIT%>" />
                                                    <%} %>
                                                    <%if (AuthService.isAllow(AuthorizationCode.DELETE_PLANT))
                                                      { %>
                                                    <a onclick="return confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>')"
                                                        href="/user/detele/<%=plant.id%>?t=<%=plant.isVirtualPlant?1:0%>&fromurl=/virtual/plantrelationstruct/<%=Model.id %>"
                                                        target="_parent">
                                                        <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                            title="<%=Resources.SunResource.MONITORITEM_DELETE%>" /></a>
                                                    <%}
                                                      else
                                                      {
                                                    %>
                                                    <img src="/images/sub/cross00.gif" width="16" height="16" border="0" alt="<%=Resources.SunResource.MONITORITEM_DELETE%>"
                                                        title="<%=Resources.SunResource.MONITORITEM_DELETE%>" />
                                                    <%} %>
                                                    <%if (AuthService.isAllow(AuthorizationCode.ADD_UNIT) && !plant.isVirtualPlant)
                                                      { %>
                                                    <a href="/unit/bind/<%=plant.id%>?fromurl=/virtual/includeplantrelationstruct/<%=Model.id %>">
                                                        <img src="/images/sub/subico016.gif" alt="<%=Resources.SunResource.PLANT_UNIT_BIND_BIND%>"
                                                            title="<%=Resources.SunResource.PLANT_UNIT_BIND_BIND%>" /></a>
                                                    <%}
                                                      else
                                                      {
                                                    %>
                                                    <img src="/images/sub/subico0160.gif" alt="<%=Resources.SunResource.PLANT_UNIT_BIND_BIND%>"
                                                        title="<%=Resources.SunResource.PLANT_UNIT_BIND_BIND%>" />
                                                    <%} %>
                                                    <%if (plant.userID.Equals(UserUtil.getCurUser().id) && ProtalUtil.isBigCustomer())
                                                      { %>
                                                    <a href="/plant/share/<%=plant.id%>?t=<%=plant.isVirtualPlant?1:0 %>&fromurl=/user/includeallplants">
                                                        <img src="/images/sub/xs.gif" alt="分配电站" title="分配电站" /></a>
                                                    <%}
                                                      else if (ProtalUtil.isBigCustomer())
                                                      {%>
                                                    <img src="/images/sub/yc.gif" alt="分配电站" title="分配电站" />
                                                    <%} %>
                                                    <a href="/plant/structpic/<%=plant.id%>?fromurl=/user/includeallplants">
                                                        <img src="/images/sub/fbt.gif" alt=" <%=plant.isVirtualPlant?"电站分布图":"单元分布图" %>"
                                                            title=" <%=plant.isVirtualPlant?"电站分布图":"单元分布图" %>" /></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%}
                                %>
                            </table>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%} %>
                <table width="750" style="margin-left: 20px;">
                    <tr height="40">
                        <td>
                            宽度
                        </td>
                        <td>
                            <input id="config1" type="text" style="width: 100px" class="txtbu01" value="<%=(ViewData["config"] as RelationConfig).width %>" />
                            <input type="hidden" id="relationid" name="0" />
                        </td>
                        <td>
                            高度
                        </td>
                        <td>
                            <input id="config2" style="width: 100px" class="txtbu01" type="text" value="<%=(ViewData["config"] as RelationConfig).height %>" />
                        </td>
                        <td>
                            同胞间隔
                        </td>
                        <td>
                            <input id="config3" class="txtbu01" style="width: 100px" type="text" value="<%=(ViewData["config"] as RelationConfig).config3 %>" />
                        </td>
                        <td>
                            子树间隔
                        </td>
                        <td>
                            <input id="config4" class="txtbu01" style="width: 100px" type="text" value="<%=(ViewData["config"] as RelationConfig).config4 %>" />
                        </td>
                        <td>
                            <input type="button" id="btnsaveconfig" value="保存" class="subbu01" />
                        </td>
                    </tr>
                </table>
                <div class="subrbox01">
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <iframe src="/user/plantrelationstruct/" width="100%" scrolling="auto" frameborder="0"
                            height="500"></iframe>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <br />
            </td>
        </tr>
    </table>
</asp:Content>
