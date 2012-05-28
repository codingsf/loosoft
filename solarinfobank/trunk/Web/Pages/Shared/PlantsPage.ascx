<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <% int j = 0;
                       IList<Plant> pnts = Model;
                       foreach (Plant plant in pnts)
                       {
                           ++j;%>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                            <tr>
                                <td width="12%" height="60" align="center">
                                    <% 
                                    %>
                                    <%if (plant.isWork)
                                      { %>
                                    <img src="/images/sub/line_on.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                        title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                    <%}
                                      else
                                      { %>
                                    <img src="/images/sub/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                    <%} %>
                                </td>
                                <td width="18%" align="center">
                                    <%if (!string.IsNullOrEmpty(plant.pic))
                                      {
                                    %>
                                    <img src="/ufile/small/<%=plant.onePic%>" width="48" height="48" />
                                    <%}
                                      else
                                      { %>
                                    <img src="/ufile/Nopic/nopico02.gif" width="48" height="48" />
                                    <%} %>
                                </td>
                                <td width="70%">
                                    <span class="xxbox_tt" style="overflow: hidden; width: 220px; float: left;"><a title="<%=plant.name %>"
                                        href="/plant/overview/<%=plant.id %>" class="dbl">
                                        <%=StringUtil.cutStr(plant.name,22,"...")%></a> </span>
                                    <br />
                                    <span class="lbl">
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_TODAYENERGY%>:&nbsp;<%=plant.DisplayTotalDayEnergy + " " + plant.TotalDayEnergyUnit%>
                                        <br />
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:&nbsp;<%=plant.TodayTotalPower%>&nbsp;kW<br />
                                        <%=Resources.SunResource.USER_OVERVIEW_PLANT_INSTALL_POWER%>:&nbsp;<%=plant.design_power %>&nbsp;kW
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <% 
                        if (j % 2 == 0)
                        {
                    %>
                </tr>
                <tr>
                    <%}

                       }
                       if (j % 2 != 0)
                       {
                    %>
                    <td width="50%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                            <tr>
                                <td align="center" height="70" width="17%">
                                </td>
                                <td align="center" width="20%">
                                </td>
                                <td width="63%">
                                    <span class="xxbox_tt" style="overflow: hidden; width: 200px; float: left;"></span>
                                    <br>
                                    <span class="lbl">&nbsp;<br>
                                        &nbsp;<br>
                                        &nbsp; </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%} %>
                </tr>
                <%Html.RenderPartial("page"); %>
            </table>