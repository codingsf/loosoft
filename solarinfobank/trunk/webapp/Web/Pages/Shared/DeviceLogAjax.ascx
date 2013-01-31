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
                url: "/device/confirm",
                data: { unitId: $("#id").attr("value"), type: $("#ctype").attr("value"), logList: cbxvalue('cbx') },
                success: function(result) {
                    $("#error").html(result);
                    if (result == "success") {
                        loadLog(pageNo);
                    }
                }
            });
        });
    });


</script>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr>
                  <td width="5%" align="center"><strong>
                   <input type="checkbox" id="checkall" name="checkall" />
                 
                 </strong></td>
                  <td width="20%" align="center"><strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong> </td>
                  <td width="20%" align="center"><strong><%=Resources.SunResource.USER_LOG_SEND_DATE %></strong></td>
                  <td width="15%" align="center"><strong><%=Resources.SunResource.USER_LOG_ERROR_TYPE %></strong></td>
                  <td width="15%" align="center"><strong><%=Resources.SunResource.USER_LOG_DESCRIPTION %></strong></td>
                  <td width="15%" align="center"><strong><%=Resources.SunResource.USER_LOG_STATE%></strong></td>
                  </tr>
              </table></td>
            </tr>
            
             <%
                 int i = 1;
                 
                 PlantUnit plantUnit;
                 foreach (Fault log in Model)
                 {
                     //plantUnit = PlantUnitService.GetInstance().GetPlantUnitByCollectorId(log.collectorID);
                     plantUnit = PlantUnitService.GetInstance().GetPlantUnitById(log.device.plantUnitId);
                     i++;
                        %>        
             <tr>
              <td>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr>
                  <td width="5%" height="35" align="center">
                  <input type="checkbox" name="cbx" id="checkbox5" value="<%=log.id %>" />
                  </td>
                   <td width="20%" align="center">
                       <div style="overflow:hidden;" title="<%=plantUnit.displayname %>">
                        <%=plantUnit.displayname %>
                       </div>                  
                  </td>
                  <td width="20%" align="center"><%=log.sendTime.ToString("yyyy-MM-dd HH:mm:ss")%></td>
                  <td width="15%" align="center"><%=log.errorTypeName %></td>                  
                  <td width="15%" align="center"><div style=" width:90px; overflow:hidden;"><%=log.content %></div></td>
                  
                  <td width="15%" align="center">
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
             if (i == 0)
             {
             %>    
             <tr>
             
             <td>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                <tr>
                <td height="35" align="center" colspan="6">
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
                            <%=Resources.SunResource.PLANT_LOG_CONFIRMED%>: <select name="ctype" id="ctype">
                                <option value="1"><%=Resources.SunResource.USER_LOG_SELECTED%></option>
                                <option value="2"><%=Resources.SunResource.USER_LOG_ALL%></option>
                            </select>
                        </td>
                        <td align="left">
                        <%if ((ViewData["user"] as User).username == UserUtil.demousername)
                          { %>
                            <input type="button" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" class="subbu09" />
                            <%}
                          else
                          { %>
                            <input type="button" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" class="subbu01"id="check" name="check" />
                            <%} %>
                        </td>
                        <td id="error" style="width:300px; color:Red;"> </td>
                        
                    </tr>
                </table>
                  </td>
         
                  <td width="50%" align="center" colspan="3">
                  
                  </td>
             
                  </tr>
              </table></td>
            </tr>
               <%Html.RenderPartial("page"); %>
          </table>
