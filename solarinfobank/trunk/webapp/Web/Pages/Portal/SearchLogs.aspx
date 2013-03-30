<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Fault>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
        </td>
        <td background="/images/gf/tci/tc02.gif">
        </td>
        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
        </td>
    </tr>
    <tr>
        <td background="/images/gf/tci/tc04.gif">
            &nbsp;
        </td>
        <td bgcolor="#FFFFFF">
            <table width="98%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                <tr>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                    </td>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.USER_LOG_DEVICE %></strong>
                    </td>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.USER_LOG_SEND_DATE %></strong>
                    </td>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.USER_LOG_ERROR_TYPE %></strong>
                    </td>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.USER_LOG_DESCRIPTION %></strong>
                    </td>
                    <td align="center" class="lbtt">
                        <strong>
                            <%=Resources.SunResource.USER_LOG_STATE%></strong>
                    </td>
                </tr>
                <%
                    int i = 0;
                   // Plant plant;
                   // PlantUnit plantUnit;

                    foreach (Fault log in Model)
                    {
                        i++;
                       // plantUnit = Cn.Loosoft.Zhisou.SunPower.Service.PlantUnitService.GetInstance().GetPlantUnitByCollectorId(log.collectorID);
                       // plant = Cn.Loosoft.Zhisou.SunPower.Service.PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
                %>
                <tr>
                    <td align="center" class="down_line0<%=i%2 %>">
                       <%-- <%=(plant.name + " - " + plantUnit.displayname)%>--%>
                        <%=(log.plantName+ " - " + log.unitName)%>
                    </td>
                    <td align="center" class="down_line0<%=i%2 %>">
                        <%=log.deviceName %>
                    </td>
                    <td align="center" class="down_line0<%=i%2 %>">
                        <%=log.sendTime.ToString("yyyy-MM-dd HH:mm:ss")%>
                    </td>
                    <td align="center" class="down_line0<%=i%2 %>">
                        <%=log.errorTypeName %>
                    </td>
                    <td align="center" class="down_line0<%=i%2 %>">
                        <%=log.content %>
                    </td>
                    <td align="center" class="down_line0<%=i%2 %>">
                        <% if (log.confirm)
                           { %>
                        <%=Resources.SunResource.USER_LOG_CONFIRM%>
                        <%}
                           else
                           { %>
                        <%=Resources.SunResource.USER_LOG_NO_CONFIRM%>
                        <%} %>
                    </td>
                </tr>
                <%} %>
            </table>
            <table width="98%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
            </table>
        </td>
        <td background="/images/gf/tci/tc05.gif">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td width="9" height="9">
            <img src="/images/gf/tci/tc06.gif" width="9" height="9" />
        </td>
        <td background="/images/gf/tci/tc07.gif">
        </td>
        <td>
            <img src="/images/gf/tci/tc08.gif" width="9" height="9" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <%Html.RenderPartial("page"); %>
        </td>
    </tr>
</table>
