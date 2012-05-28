<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
 <%
    int i=1;
    bool fault = false;
    int count = 0;
    float curMonthEnergy = 0L;
       %>
<div style="width:720px; max-height:420px; overflow-y:auto; overflow-x:scroll;">
<table width="720" border="0" cellpadding="0" cellspacing="0">
    <tbody>
    <tr>
        <td>
            <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0" height="25">
                <tbody>
                <tr>                              
                    <td width="150" align="center">
                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                    </td>
                    <td width="125" align="center">
                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                    </td>
                    <td width="125" align="center">
                        <strong><%=Resources.SunResource.DEVICE_MONITOR_SUNSHINE%></strong>
                    </td>
                    <td width="125" align="center">
                         <strong><%=Resources.SunResource.DEVICE_MONITOR_WIND_SPEED%> </strong>
                    </td>
                    <td width="125" align="center">
                        <strong><%=Resources.SunResource.DEVICE_MONITOR_TEMPERATURE%> </strong>
                    </td>
                  <%--  <td width="125" align="center">
                        <strong><%=Resources.SunResource.DEVICE_MONITOR_WIND_DIRECTION%></strong>
                    </td>--%>
                    <td width="125" align="center">
                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%></strong>
                    </td>
                </tr>
            </tbody></table>
        </td>
    </tr>
   
     <%
         PlantUnit plantUnit;
        foreach (Device device in (ViewData["data"]) as IEnumerable<Device>)
        {

            if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null)
                continue;
            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
            fault = device.runData.isFault();
            if (fault)
            {
                count++;
                i++;
           %>
           
    <tr class='<%=device.isHidden?"hidden_env":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
        <td>
            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody><tr>
                    <td align="center" height="35" width="70">

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
                      <td align="center" width="125">
                                 <div style="width:100; overflow:hidden; margin:0 auto;"  title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        </div>
                                        
                                        
                                    </td>
                    <td align="center" width="125">
                    
               <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT) %> 
                    </td>
                    <td align="center" width="125">
                         <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>  
                         
                    </td>
                    
                    <td width="125" align="center">
                    <%=device.getMonitor(MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE)%>  
                    </td> 
                    <%--<td width="125" align="center">
                     <%=device.getMonitor(MonitorType.PLANT_MONITORITEM_WINDDIRECTION)%>  
                    
                    
                    </td>--%>
                   
               
                    <td width="125" align="center">
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

            if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null)
                continue;
            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
            fault = device.runData.isFault();
            if (device.Over1Day(Model.timezone) && device.runData.isFault() == false)
            {
                i++;
                count++;
           %>
           
    
    <tr class='<%=device.isHidden?"hidden_env":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
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
                      <td align="center" width="125">
                                 <div style="width:100px; overflow:hidden; margin:0 auto;"  title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        </div>
                                        
                                        
                                    </td>
                    <td align="center" width="125">
                    <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT) %>  
                    </td>
                    <td align="center" width="125">
                         <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>  
                    </td>
                    <td width="125" align="center">
                    <%=device.getMonitor(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE)%>  
                    </td> 
                    <%--<td width="125" align="center">
                     <%=device.getMonitor(MonitorType.PLANT_MONITORITEM_WINDDIRECTION)%>  
                    
                    </td>--%>
               
                    <td width="125" align="center">
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

            if (!device.deviceTypeCode.Equals(DeviceData.ENVRIOMENTMONITOR_CODE) || device.runData == null)
                continue;
            plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(device.collectorID);
            curMonthEnergy = DeviceMonthDayDataService.GetInstance().GetDeviceMonthDayData(DateTime.Now.Year, device.id, DateTime.Now.Month).count();
            fault = device.runData.isFault();
            if (!device.Over1Day(Model.timezone) && device.runData.isFault() == false)
            {
                i++;
                count++;
           %>
           
    
    
    <tr class='<%=device.isHidden?"hidden_env":"" %>'id="<%=device.id %>" rof="<%=!device.isHidden %>">
        <td>
            <table class="down_line0<%= i%2 %>" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody><tr>
                    <td align="center" height="35" width="70">

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
                      <td align="center" width="125">
                                 <div style="width:110px; overflow:hidden; margin:0 auto"  title="<%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>">
                                    <%=string.IsNullOrEmpty( device.name)?device.fullName:device.name%>
                              
                                        </div>
                                        
                                        
                                    </td>
                    <td align="center" width="125">
                    
                <%=device.getMonitor(MonitorType.MIC_DETECTOR_SUNLINGHT) %>  
                    </td>
                    <td align="center" width="125">
                         <%=device.getMonitor(MonitorType.MIC_DETECTOR_WINDSPEED)%>  
                    </td>
                    
                    <td width="125" align="center">
                <%=device.getMonitor(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE)%>  
                
                    </td> 
                    <%--<td width="125" align="center">
                     <%=device.getMonitor(MonitorType.PLANT_MONITORITEM_WINDDIRECTION)%>  
                    
                    </td>--%>
                   
               
                    <td width="125" align="center">
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
                
           