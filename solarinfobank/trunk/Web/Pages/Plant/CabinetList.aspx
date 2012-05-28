<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
 
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>


                <div style="width:720px; max-height:420px; overflow-y:auto; overflow-x:scroll;">
                
                
                <table width="1280" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td>
                            <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0" height="25">
                                <tbody>
                                <tr>                              
                                  <td width="150" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                    </td>
                                    <td width="130" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                    <td width="160" align="center">
                                        <strong><%=Resources.SunResource.DEVICEMONITORITEM_321%></strong>
                                    </td>
                                    <td width="160" align="center">
                                         <strong><%=Resources.SunResource.DEVICEMONITORITEM_325%> </strong>
                                    </td>
                            
                                    <td width="160" align="center">
                                        <strong>  <%=Resources.SunResource.DEVICEMONITORITEM_326%> </strong>
                                    </td>
                                      <td width="160" align="center">
                                        <strong> <%=Resources.SunResource.MONITORITEM_TEMPERATURE%></strong>
                                    </td>
                                     
                                      <td width="160" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                   
                     <%
                         int i = 1;
                         bool fault = false;
                         int count = 0;
                         PlantUnit plantUnit;
            foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
            {

                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                fault = device.runData.isFault();
                if (fault)
                {
                    count++;
                    i++;
                           %>
                           
                    <tr class='<%=device.isHidden?"hidden":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td align="center" height="35" width="150">
                                     <%if (fault)
                                       { %>
                             <img src="/images/bni.gif"  alt="" class="img_list"/>
                             <%}
                                       else
                                       {%>
                             <img src="/images/accept.gif"  alt="" class="img_list"/>
                                  <% }%>
                                    <%=plantUnit.displayname%>
                                    </td>
                                      <td align="center" width="130">
                                 
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        
                                    </td>
                                    <td align="center" width="160">
                                    
                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM)%> 
                                    </td>
                                    <td align="center" width="160">
                                          <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%> 
                                          
                                    </td>
                                    
                                    <td width="160" align="center">
                                
                                    <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%> 
                                    </td> 
                                    <td width="160" align="center">
                                    <%=device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE)%>
                                    
                                    </td>
                                   
                               
                                    <td width="160" align="center">
                                     <%if (fault)
                                       { %>
                                  <font color="red"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                       else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
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

                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                fault = device.runData.isFault();
                if (device.Over1Day(Model.timezone) && device.runData.isFault() == false)
                {
                    i++;
                    count++;
                           %>
                           
                    
                    <tr class='<%=device.isHidden?"hidden":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td align="center" height="35" width="150">
                                     <%if (fault)
                                       { %>
                             <img src="/images/bni.gif"  alt="" class="img_list"/>
                             <%}
                                       else
                                       {%>
                             <img src="/images/accept.gif"  alt="" class="img_list"/>
                                  <% }%>
                                    <%=plantUnit.displayname%>
                                    </td>
                                      <td align="center" width="130">
                                 
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        
                                        
                                    </td>
                                    <td align="center" width="160">
                                    
                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM)%> 
                                 
                                    </td>
                                    <td align="center" width="160">
                                          <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%> 
                                          
                                    </td>
                                    
                                    <td width="160" align="center">
                               <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>  
                                    </td> 
                                    <td width="160" align="center">
                                    <%=device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE)%>
                                    
                                    </td>
                                   
                               
                                    <td width="160" align="center">
                                     <%if (fault)
                                       { %>
                                  <font color="red"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                       else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
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

                if (!device.deviceTypeCode.Equals(DeviceData.CABINET_CODE) || device.runData == null)
                    continue;
                plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
                fault = device.runData.isFault();
                if (!device.Over1Day(Model.timezone) && device.runData.isFault() == false)
                {
                    i++;
                    count++;
                           %>
                           
                    
                    
                    <tr class='<%=device.isHidden?"hidden":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
                        <td>
                            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tbody><tr>
                                    <td align="center" height="35" width="150">
                                     <%if (fault)
                                       { %>
                             <img src="/images/bni.gif"  alt="" class="img_list"/>
                             <%}
                                       else
                                       {%>
                             <img src="/images/accept.gif"  alt="" class="img_list"/>
                                  <% }%>
                                    <%=plantUnit.displayname%>
                                    </td>
                                      <td align="center" width="130">
                                 
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                  
                                        
                                        
                                    </td>
                                    <td align="center" width="160">
                                    
                                <%=device.getMonitor(MonitorType.MIC_BUSBAR_CGQLINENUM)%> 
                                 
                                    </td>
                                    <td align="center" width="160">
                                          <%=device.getMonitor(MonitorType.MIC_BUSBAR_DCUXVOLT)%> 
                                    </td>
                                    
                                    <td width="160" align="center">
                               <%=device.getMonitor(MonitorType.MIC_BUSBAR_TOTALCURRENT)%>  
                                    </td> 
                                    <td width="160" align="center">
                                    <%=device.getMonitor(MonitorType.MIC_BUSBAR_JNTEMPRATURE)%>
                                    </td>
                                   
                               
                                    <td width="160" align="center">
                                     <%if (fault)
                                       { %>
                                  <font color="red"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                      
                                      <%}
                                       else
                                           %>
                                    <%if (device.Over1Hour(Model.timezone))
                                      { %>
                                  <font color="#FF9912"> <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%></font> 
                                   <%}
                                      else
                                      { %>
                                   <%=device.runData.updateTime.ToString("MM-dd HH:mm:ss")%>
                                      
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
                
                
    