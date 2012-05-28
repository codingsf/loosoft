<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
                <div style="margin:0 auto; width:730px; overflow-x:scroll;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="width:1000px; margin-right:10px; ">
                    <tr>
                        <td>
                            <table width="1280" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr >
                                <td width="120px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_STATUS %></strong>
                                         <br />
                                        
                                        <span class="f11">&nbsp;</span>
                                    </td>
                                <td width="200px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_DATA_SOURCE_CODE%></strong> <br />
                                        
                                        <span class="f11">&nbsp;</span>
                                    </td>
                                    
                                    <td width="200px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_UNIT_NAME %></strong>
                                         <br />
                                        
                                        <span class="f11">&nbsp;</span>
                                    </td>
                                    <td width="120px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_POWER %></strong>
                                        <br />
                                        <span class="f11">(kW)</span>
                                    </td>
                                    
                                      <td width="120px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_YEAR_ENERGY%></strong>
                                        <br />
                                        <span class="f11">(kWh)</span>
                                    </td>
                                    <td width="120px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_ENERGY %></strong>
                                        <br />
                                        <span class="f11">(kWh)</span>
                                    </td>
                                     
                                     
                                      <td width="120px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY%></strong>
                                        <br />
                                        <span class="f11">(kWh)</span>
                                    </td>
                                      <td width="135px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY_KWP%></strong>
                                        <br />
                                        <span class="f11">(kWh/kWp)</span>
                                    </td>
                                    
                                    <td width="135px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_YEAR_ENERGY_KWP%></strong>
                                       <br />
                                       <span class="f11">(kWh/kWp)</span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                                    if (ViewData["plantUnits"] != null)
                                    {
                                        int i = 1;

                                        CollectorMonthDayData cmData = null;
                                        CollectorYearData cyData = null;
                                        float designPower = 1;
                                        foreach (PlantUnit plantUnit in ViewData["plantUnits"] as IList<PlantUnit>)
                                        {
                                            float currentMonthEnergy = 0;
                                            float currentYearEnergy = 0;
                                            cmData  = CollectorMonthDayDataService.GetInstance().GetCollectorMonthDayData(DateTime.Now.Year, plantUnit.collector.id, DateTime.Now.Month);
                                            currentMonthEnergy = cmData == null ? 0 : cmData.count();
                                                cyData=CollectorYearDataService.GetInstance().GetCollectorYearData(plantUnit.collector.id,DateTime.Now.Year);
                                                currentYearEnergy = cyData == null ? 0 : cyData.dataValue;
                                                designPower = Model.unitPower(plantUnit.id);
                                            i++;
                                            
                    %>
                 <tr>
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                <td align="center" width="120px">
                                    
                                       <%
                                        if (plantUnit.collector.runData != null)
                                        {
                                            if (!plantUnit.isWork(Model.timezone))
                                            {%>
                                            <img src="/images/sub/line_off01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>" title="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                />
                                            <% }
                                            else
                                            {%>
                                            <img src="/images/sub/line_on01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>" title="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                                />
                                            <%}
                                        }
                                        else
                                        {%>
                                            <img src="/images/sub/line_off01.gif" width="18" height="27" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>" title="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                />
                                        <%
                                        } 
                                        %>
                                    </td>
                                    <td align="center" height="35" width="200px">
                                    <div title="<%=plantUnit.collector.code%>"><%=plantUnit.collector.code%></div>
                                    </td>
                                    <td align="center" width="200px">
                                       <%= Html.HiddenFor(model => model.id) %>
                                       <%=plantUnit.displayname%>
                                    </td>
                                    <td align="center" width="120px">
                                    <%=plantUnit.TodayPower(Model.timezone) %>
                                    </td>
                                    <td width="120px" align="center">
                                      <%= currentYearEnergy%>
                                    </td>
                                    <td align="center" width="120px">
                                    <%=plantUnit.displayTotalEnergy%>
                                    </td>
                                    <td width="120px" align="center">
                                        <%=currentMonthEnergy%>
                                    </td>
                                    <td width="135px" align="center">
                                       <%=Math.Round(currentMonthEnergy / designPower, 2).Equals(double.NaN) ? 0 : Math.Round(currentMonthEnergy / designPower, 2)%>
                                    </td>
                                    <td width="135px" align="center">
                                        <%=Math.Round(currentYearEnergy / designPower, 2).Equals(double.NaN) ? 0 : Math.Round(currentYearEnergy / designPower, 2)%>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <%}
                       }%>
                </table>
                </div>
            