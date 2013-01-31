<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Fault>>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<script>


    function change(index) {
        $.ajax({
            type: "POST",
            url: "/plant/log",
            data: { t: $("#t").attr("value"), state: $("#state").val(), plant: $("#plant").val(), pindex: index, errorcode: cbxvalue('errorCode'), logList: cbxvalue('cbx'), ctype: $("#ctype").val() },
            success: function(result) {
                $('#loading').hide();
                $('#result').append(result);
            },
            beforeSend: function() {
                $('#result').empty();
                $('#loading').show();
            }
        });
    }

    $(function() {
        $('#checkall').click(function() {
            $("input[name='cbx']").attr("checked", $(this).attr("checked")); //注意此处
        });
    });


    $(document).ready(function() {
        $('#check').click(function() {
            $.ajax({
                type: "POST",
                url: "/plant/logconfirm",
                data: { plantId: plantId, type: $("#ctype").attr("value"), logList: cbxvalue('cbx'), startDate: $("#startDate").val(), endDate: $("#endDate").val() },
                success: function(result) {
                if (result == "successed") {
                    
                        changePage(pageNo);
                    }
                    else {
                        $("#error").html(result);
                    }
                }
            });
        });
    });

</script>
	<div class="subrbox01">
		  <div class="sb_top"></div>
		<div class="sb_mid">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr>
                  <td width="20" align="center"><strong>
                   <input type="checkbox" id="checkall" name="checkall" />
                 
                 </strong></td>
                  <td width="140" align="center"><strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong> </td>
                  <td width="100" align="center"><strong><%=Resources.SunResource.USER_LOG_DEVICE %></strong> </td>
                  <td width="90" align="center"><strong><%=Resources.SunResource.USER_LOG_SEND_DATE %></strong></td>
                  <td width="70" align="center"><strong><%=Resources.SunResource.USER_LOG_ERROR_TYPE %></strong></td>
                  <td width="90" align="center"><strong><%=Resources.SunResource.USER_LOG_DESCRIPTION %></strong></td>
                  <td width="70" align="center"><strong><%=Resources.SunResource.DEVICEMONITORITEM_132%></strong></td>
                  <td width="70" align="center"><strong><%=Resources.SunResource.DEVICEMONITORITEM_133%></strong></td>
                  <td width="75" align="center"><strong> <%=Resources.SunResource.USER_LOG_STATE%></strong></td>
                  </tr>
              </table></td>
            </tr>
            
             <%
                 int i = 1;
                 //Plant plant;
                // PlantUnit plantUnit;
                 foreach (Fault log in Model)
                 {
                     //改为根据plantunitid获取电站名称 不是原来的采集器id
                     //plantUnit = PlantUnitService.GetInstance().GetPlantUnitById(log.device.plantUnitId);
                    // plant = PlantService.GetInstance().GetPlantInfoById(plantUnit.plantID);
                     i++;
                        %>        
             <tr>
              <td>
              <table width="730" style="word-break:break-all;word-wrap:break-word; " border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr>
                  <td width="20" height="35" align="center">
                  <input type="checkbox" name="cbx" id="checkbox5" value="<%=log.id %>" />
                  </td>
                   <td width="140" align="center" style="width:140px; overflow:hidden; white-space:normal;">
                  <%-- <%if(Request["plant"].Equals("-1")) {%>--%>
                       <%-- <%=(plant.name + " -<span style='white-space:nowrap;'> " + plantUnit.displayname)%>--%><%=(log.plantName + " -<span style='white-space:nowrap;'> " +log.unitName)%></span>
                        
                        <%--<%}else{ %>
                        <%=plantUnit.displayname%>
                        <%} %>--%>
                 <%--        <style>
                td{word-break:break-all;word-wrap:break-word; white-space:normal;}
                </style>--%>
                  </td>
               
                  <td width="100" align="center">
                        <%=log.deviceName %>
                  </td>
                  <td width="90" align="center"><%=log.sendTime.ToString("yyyy-MM-dd")%>
                  <br /><%=log.sendTime.ToString("HH:mm:ss")%>
                  </td>
                  <td width="70" align="center"><%=log.errorTypeName %></td>                  
                  <td width="90" align="center"><div style=" width:90px; overflow:hidden;"><%=log.content %></div> </td>
                  <td width="70" align="center"><div style=" width:70px; overflow:hidden;"><%=log.data1Desc%></div> </td>
                  <td width="70" align="center"><div style=" width:60px; overflow:hidden;"><%=log.data2Desc%></div> </td>
                  <td width="75" align="center">
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
              </table>
              </td>
            </tr>
                        <%}
                             if (i == 1)
                             {
                             %>    
                             <tr>
                             
                             <td>
                              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr>
                                <td height="35" align="center" colspan="7">
                                <%=Resources.SunResource.USER_LOG_NO_DATA%>
                                </td>
                                </tr>
                                </table>
                             </td>
                             </tr>
                             <%} %>
                        
                                
              <tr align="left">
              <td align="left"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr align="left">
                  <td width="50%" align="left">
                  <table style="width: 700px; float: left; margin-left:10px; ">
                    <tr align="left">
                        <td align="left" width="200">
                        <%=Resources.SunResource.USER_LOG_CONFIRM%>: 
                        <select name="ctype" id="ctype">
                            <option value="1"><%=Resources.SunResource.USER_LOG_SELECTED%></option>
                            <option value="2"><%=Resources.SunResource.USER_LOG_ALL%></option>
                        </select>
                        </td>
                        <td align="left">
                        <%if (!AuthService.isAllow(AuthorizationCode.LOGS_CONFIRM))
                          { %>
                            <input type="button" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" class="subbu09" />
                            <%}
                          else
                          { %>
                            <input type="button" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" class="subbu01"id="check" name="check" />
                            <%} %>
                        </td>
                        <td id="error" style="width:400px; float:left; color:Red;"> </td>
                    </tr>
                </table>
                  </td>
         
                  <td width="50%" align="center" colspan="3">
          
                  
                  </td>
             
                  </tr>
              </table></td>
            </tr>
                     
              
          </table>
		</div>
		<div class="sb_down"></div><%Html.RenderPartial("page"); %>
		</div>
