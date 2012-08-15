<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
                <div style="width:720px; max-height:420px; overflow:scroll;">
                
                <table width="1150" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td>
                            <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0" height="25">
                                <tbody>
                                <tr>                 
                                  <td width="150" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong> <br />
                                          <span class="f11">&nbsp;</span>
                                    </td>
                                    <td width="100" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong> <br /> <span class="f11">&nbsp;</span>
                                    </td>
                                    <td width="150" align="center" valign="top">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_INSTAL_POWER%></strong>
                                        <br />
                                        <span class="f11">(kW)</span>
                                    </td>
                                    <td width="100" align="center">
                                         <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_CURRENT_POWER%> </strong>
                                        <br />
                                         <span class="f11">(W)</span>
                                    </td>
                                    <td width="100" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_STATUS%></strong> <br /> <span class="f11">&nbsp;</span>
                                    </td>
                                      <td width="100" align="center">
                                        <strong><%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY1%></strong>
                                        <br />
                                        
                                        <span class="f11">(kWh)</span>
                                    </td>
                                      <td width="150" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY%> </strong>
                                        <br />
                                        
                                        <span class="f11">(kWh)</span>
                                    </td>
                                      <td width="100" align="center">
                                        <strong><%=Resources.SunResource.PLANT_UNIT_LIST_MONTH_ENERGY_KWP%></strong>
                                        <br />
                                        
                                        <span class="f11">(kWh/kWp)</span>
                                    </td>
                                      <td width="100" align="center">
                                        <strong> <%=Resources.SunResource.PLANT_UNIT_LIST_TOTAL_ENERGY%></strong>
                                        <br />
                                        
                                        <span class="f11">(kWh)</span>
                                    </td>
                                      <td width="100" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong><br /> <span class="f11">&nbsp;</span>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <%
                        int i=1;
                        bool fault = false;
                        int count = 0;
                        float curMonthEnergy = 0L;
                        PlantUnit plantUnit;
                        foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                        {

                            if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE))
                                continue;
                            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                            if (device.runData == null)
                                fault = true;else
                            fault = device.runData.isFault();
                            if (fault)
                            {
                                count++;
                                i++;
                           %>
                           
                    <tr class='<%=device.isHidden?"hidden_inv":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                              
                                    <td align="center" height="35" width="150">
                                    
                                    <div style="width:150px; overflow:hidden;float:left; text-align:center" title="<%=plantUnit.displayname%>">
                                     <%if (fault)
                                      { %>
                                     <img src="/images/bni.gif"  alt="" class="img_list"/>
                                     <%}
                                      else
                                      {%>
                                     <img src="/images/accept.gif"  alt="" class="img_list"/>
                                     <% }%>
                                    <%=plantUnit.displayname%></div>
                                    </td>
                                    <td align="center" width="100">
                                 <div style="width:100px; overflow:hidden; margin:0 auto;"  title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                    <%=string.IsNullOrEmpty(device.name)?device.fullName:device.name%>
                              
                                        </div>
                                        
                                        
                                    </td>
                                    <td align="center" width="150">
                                    <%=device.designPower%>
                                    </td>
                                    <td align="center" width="100">
                                         <%=fault ? "0" : StringUtil.formatDouble(device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER),"0.00")%>
                                    </td>
                                    <td align="center" width="100">
                                         
                                    <%
                                    if (fault)
                                    {
                                           %>
                                          <font color="red"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font> 
                                           <%
                                    }
                                    else
                                        if (device.Over1Hour(Model.timezone))
                                    { %>
                                        <font color="#FF9912"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                                       
                                      <%}
                                    else
                                    {%>
                                    <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                    <%} %>
                                    </td>
                                    <td width="100" align="center">
                                    <% object data = ReflectionUtil.getProperty(DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month), string.Format("d_{0}", DateTime.Now.Day));%>
                                    <%=data==null ? "0" : data %>
                                  
                                    </td> 
                                    <td width="150" align="center">
                                    <%=StringUtil.formatFloat(curMonthEnergy,"0.00")%>   
                                    </td>
                                    <td width="100" align="center">
                                    <%=StringUtil.formatDouble(Math.Round(curMonthEnergy/device.chartPower,2),"0.00") %>
                                    </td>
                                    <td width="100" align="center">
                                    <%=StringUtil.formatFloat(device.TotalEnergy,"0.00") %>
                                    </td>
                                    <td width="100" align="center">
                                     <%if (fault)
                                      { %>
                                     <font color="red"> <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                      else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
                                  <%} %>
                                    </td>
                                    
                                </tr>

                            </tbody></table>
                        </td>
                    </tr>
                           
                           <%}
                        } %>    

  <%
                        foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                        {

                            if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE) )
                                continue;
                            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                            if (device.runData == null)
                                fault = true;else
                            fault = device.runData.isFault();
                            if (device.Over1Day(Model.timezone) && fault == false)
                            {
                                i++;
                                count++;
                           %>
                        
                    <tr class='<%=device.isHidden?"hidden_inv":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td align="center" height="35" width="150">
                                    <div style="width:150px; overflow:hidden;float:right; text-align:center" title="<%=plantUnit.displayname%>">
                                    <%if (fault)
                                      { %>
                                     <img src="/images/bni.gif"  alt="" class="img_list"/>
                                     <%}
                                      else
                                      {%>
                                     <img src="/images/accept.gif"  alt="" class="img_list"/>
                                     <% }%>
                                    <%=plantUnit.displayname%></div>
                                    </td>
                                    <td align="center" width="100">
                                 <div style="width:100px; overflow:hidden;  margin:0 auto;"  title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        </div>
                                        
                                    </td>
                                    <td align="center" width="150">
                                    <%=device.designPower%>
                                    </td>
                                    <td align="center" width="100">
                                         <%=fault ? "0" : StringUtil.formatDouble(device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER),"0.00")%>
                                    </td>
                                    <td align="center" width="100">
                                         
                                    <%
                        if (fault)
                        {
                               %>
                              <font color="red"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font> 
                               <%
                        }
                        else
                            if (device.Over1Hour(Model.timezone))
                            { %>
                                <font color="#FF9912"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                               
                              <%}
                            else
                            {%>
                                    <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                    <%} %>
                                    </td>
                                    <td width="100" align="center">
                                        <%=StringUtil.formatDouble(device.TodayEnergy(Model.timezone),"0.00")%>
                                    </td> 
                                    <td width="150" align="center">
                                    <%=StringUtil.formatDouble(curMonthEnergy,"0.00")%>
                                    
                                    </td>
                                    <td width="100" align="center">
                                    
                                    <%=StringUtil.formatDouble(Math.Round(curMonthEnergy/device.chartPower,2),"0.00") %>
                                    
                                    </td>
                                    <td width="100" align="center">
                                    <%=StringUtil.formatDouble(device.TotalEnergy,"0.00") %>
                                    </td>
                                    <td width="100" align="center">
                                     <%if (fault)
                                      { %>
                                  <font color="red"> <%=device.runData == null ? "-" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                      else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData == null ? "-" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData == null ? "N/A" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
                                  <%} %>
                                    </td>
                                    
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                           
                           <%}
                        } %> 

  <%
                        foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
                        {

                            if (!device.deviceTypeCode.Equals(DeviceData.INVERTER_CODE))
                                continue;
                            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
                            if (device.runData == null)
                                fault = true;
                            else
                            fault = device.runData.isFault();
                            if (!device.Over1Day(Model.timezone) && fault == false)
                            {
                                i++;
                                count++;
                           %>
                           
                    <tr class='<%=device.isHidden?"hidden_inv":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td align="center" height="35" width="150">
                                    <div style="width:150px; overflow:hidden;float:right; text-align:center" title="<%=plantUnit.displayname%>">
                                    <%if (fault)
                                      { %>
                                     <img src="/images/bni.gif"  alt="" class="img_list"/>
                                     <%}
                                      else
                                      {%>
                                     <img src="/images/accept.gif"  alt="" class="img_list"/>
                                     <% }%>
                                    <%=plantUnit.displayname%></div>
                                    </td>
                                    <td align="center" width="100">
                                    <div style="width:100px; overflow:hidden; margin:0 auto;"  title="<%=device.fullName%>">
                                        <%=device.fullName%>
                              
                                        </div>
                                        
                                    </td>
                                    <td align="center" width="150">
                                    
                                    <%=device.designPower%>
                                    </td>
                                    <td align="center" width="100">
                                         <%=fault ? "0" :  StringUtil.formatDouble(device.getMonitorValue(MonitorType.MIC_INVERTER_TOTALYGPOWER),"0.00")%>
                                    </td>
                                    <td align="center" width="100">
                                         
                                    <%
                        if (fault)
                        {
                               %>
                              <font color="red"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font> 
                               <%
                        }
                        else
                            if (device.Over1Hour(Model.timezone))
                            { %>
                                <font color="#FF9912"><%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%></font>
                               
                              <%}
                            else
                            {%>
                                    <%=device.getMonitorValueWithStatus(MonitorType.MIC_INVERTER_DEVICESTATUS)%>
                                    <%} %>
                                    </td>
                                    <td width="100" align="center">
                                    <%=StringUtil.formatDouble(device.TodayEnergy(Model.timezone),"0.00")%>
                                    </td> 
                                    <td width="150" align="center">
                                    <%=StringUtil.formatDouble(curMonthEnergy,"0.00")%>
                                    
                                    </td>
                                    <td width="100" align="center">
                                    
                                    <%=StringUtil.formatDouble(Math.Round(curMonthEnergy/device.chartPower,2),"0.00") %>
                                    
                                    </td>
                                    <td width="100" align="center">
                                    <%=StringUtil.formatDouble(device.TotalEnergy,"0.00") %>
                                    </td>
                                    <td width="100" align="center">
                                     <%if (fault)
                                      { %>
                                    <font color="red"> <%=device.runData == null ? "-" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                      else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData == null ? "-" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData == null ? "-" : device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
                                  <%} %>
                                    </td>
                                    
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                           
                           <%}
                        } %>

                </tbody></table>
                
                </div>
           