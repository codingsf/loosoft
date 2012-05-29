<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--此处用于切换语言跳转到当前页面--%>
    <%if (Session["initurl"] != null && (string.IsNullOrEmpty(Session["initurl"].ToString()) == false))
      { %>

    <script>
        $('a[href="<%=Session["initurl"] %>"]', window.parent.document).addClass("lefttabclick");
        $("#current_uri", window.parent.document).val('<%=Session["initurl"] %>');
        parent.loadContent('content_ajax', '<%=Session["initurl"] %>', '<%=Session["loading_type"] %>', 'GET');
    </script>

    <%Session["initurl"] = null; Session["loading_type"] = null; Response.End();
      } %>

    <script>
        $(document).ready(function() {
            $("#btnsaveconfig").click(function() {
                $.get('/user/relationconfig/',
                  {
                      relationId: 0,
                      relationType: '<%=RelationConfig.AllPlant %>',
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
                                        <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS%>
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
                        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <%if (!AuthService.isAllow(AuthorizationCode.ADD_PLANT))
                                  { %>
                                <td width="6%" align="center">
                                    <img src="/images/sub/subico016.gif" width="15" height="16" />
                                </td>
                                <td width="94%">
                                    <%=Resources.SunResource.MONITORITEM_ADD%>
                                </td>
                                <% }
                                  else
                                  {%>
                                <td width="6%" align="center">
                                    <a href="/user/addplant/" class="dbl">
                                        <img src="/images/sub/subico016.gif" width="15" height="16" alt="<%=Resources.SunResource.MONITORITEM_ADD%>"
                                            title="<%=Resources.SunResource.MONITORITEM_ADD%>" /></a>
                                </td>
                                <td width="94%">
                                    <a href="/user/addplant/" class="dbl">
                                        <%=Resources.SunResource.MONITORITEM_ADD%></a> | <a href="/user/allplants_output/"
                                            class="dbl">
                                            <%=Resources.SunResource.DEVICE_MONITOR_EXPORT_CSV%></a>
                                    <%if (Cn.Loosoft.Zhisou.SunPower.Service.ProtalUtil.isBigCustomer())
                                      { %>
                                    | <a href="/user/shareplant">分配电站 </a>
                                    <%} %>
                                </td>
                                <%} %>
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
                                            <td width="28%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ALLPLANTS_NAME  %></strong>
                                            </td>
                                            <td width="20%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ALLPLANTS_COUNTRY  %></strong>
                                            </td>
                                            <td width="14%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ALLPLANTS_CITY  %></strong>
                                            </td>
                                            <td width="14%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ALLPLANTS_ENERGY  %></strong>
                                            </td>
                                            <td width="20%" align="center">
                                                <strong>
                                                    <%=Resources.SunResource.USER_ALLPLANTS_OPERATION  %></strong>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <% int i = 0;
                               foreach (Plant plant in Model.displayPlants)
                               {
                                   i++; %>
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                        <tr>
                                            <td width="28%" height="35" align="center">
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
                                            <td width="20%" align="center">
                                                <div style="width: 100px; overflow: hidden;" title="<%=plant.country%>">
                                                    <%=plant.country%></div>
                                            </td>
                                            <td width="14%" align="center">
                                                <div style="width: 100px; overflow: hidden;" title="<%=plant.city%>">
                                                    <%=plant.city%></div>
                                            </td>
                                            <td width="14%" align="center">
                                                <div style="width: 100px; overflow: hidden;" title="<%=StringUtil.formatDouble(plant.DisplayTotalEnergy)%>">
                                                    <%=StringUtil.formatDouble(plant.DisplayTotalEnergy) + "(" + plant.TotalEnergyUnit + ")"%>
                                                </div>
                                            </td>
                                            <td width="20%" align="center">
                                                <%if (AuthService.isAllow(AuthorizationCode.EDIT_PLANT))
                                                  { %>
                                                <a href="/plant/<%=plant.isVirtualPlant?"virtual":"" %>edit/<%=plant.id %>?fromurl=/user/includeallplants">
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
                                                    href="/user/detele/<%=plant.id%>?t=<%=plant.isVirtualPlant?1:0%>?&fromurl=/user/allplants" target="_parent">
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
                                                <a href="/unit/bind/<%=plant.id%>?fromurl=/user/includeallplants">
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
                                                    <img src="/images/sub/fbt.gif" alt=" <%=plant.isVirtualPlant?"电站分布图":"单元分布图" %>" title=" <%=plant.isVirtualPlant?"电站分布图":"单元分布图" %>" /></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <%}
                            %>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <%if (Cn.Loosoft.Zhisou.SunPower.Service.ProtalUtil.isBigCustomer())
                  { %>
                <div style="margin-top: 10px; margin-left: 25px;">
                    <input type="button" value="电站结构图" class="jdbu" />
                </div>
                <table width="750" style="margin-left: 20px;">
                    <tr height="30">
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
                <%}%>
            </td>
        </tr>
    </table>
</asp:Content>
