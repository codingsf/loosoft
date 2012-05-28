<%@ Page Language="C#" %>
<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $('#RunReportChart').click(displayRunReportChart);
        $('#EventReportChart').click(displayEventReportChart);

        if ($("#eventreport").val() == "0") {
            alert('<%=Resources.SunResource.SAVE_SUCCESS%>');
            displayEventReportChart();
        } else {
            displayRunReportChart();
            hiddenEventReport();
        }
    });
    
    
    // 事件报表页面单击取消返回运行报表
    function backRunReport() {
        displayRunReportChart();
    }
    
    //弹出层查看报表
    function jumpviewReport(reportId, typeId) {
        setChoiseTime(reportId, typeId);
        viewReports("large_container", reportId, typeId);
    }

    function viewReports(curContainer, reportId, typeId) {
        $("#cTime").val($("#time").val());
        $("#tId").val(typeId);
        $("#pId").val($("#plantId").val());
        $("#rId").val(reportId);
        $("#viewReportForm").submit();
    }

   function displayRunReportChart() {
       RunReportChart();
   }
   
   function displayEventReportChart() {
       EventReportChart();
   }
  
   function RunReportChart() {
       changeTopStyle("RunReportChart");
       $.ajax({
           type: "POST",
           url: "/Reports/RunReport/?&userId=<%=ViewData["userId"]%>&plantId="+$("#plantId").val(),
           success: function(result) {
                $("#container").html(result) ;
                parent.iFrameHeight();
           },
           beforeSend: function() {
               $('#container').empty();
               $('#container').append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + 50 + "px; margin-bottom:"+50+"px;\" /></center>");
           }
       });
   }
   function EventReportChart() {
       changeTopStyle("EventReportChart");
       $.ajax({
           type: "POST",
           url: "/Reports/EventReport/" + $("#plantId").val(),
           success: function(result) {
                $("#container").html(result);
                parent.iFrameHeight();
           },
           beforeSend: function() {
//               $('#container').empty();
//               $('#container').append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + 50 + "px; margin-bottom:" + 50 + "px;\" /></center>");
               }
       });
   }
   
   function changeTopStyle(curId) {
       $("#RunReportChart").attr("class", "noclick");
       $("#EventReportChart").attr("class", "noclick");
       $("#" + curId).attr("class", "onclick");
   }
   
   function hiddenEventReport() {
       if ($("#plantId").val() == null || $("#plantId").val() == "") {
           $("#EventReportChart").hide();
       }
   }
   
   function changePage(page) {
       window.location.href = '/Reports/RunReport/' + page;
   }
   
   //切换天
   function changeDay(obj) {
       var aimDay = obj.value;
       if (aimDay) {
           aimDay = aimDay.replace("-", "").replace("-", "");
       }
       $("#time").val(aimDay);
   }
   
   //切换周
   function changeWeek(obj) {
       var aimDay = obj.value;
       if (aimDay) {
           aimDay = aimDay.replace("-", "").replace("-", "");
       }
       $("#time").val(aimDay);
   }
   
   //切换年
   function changeYear(obj) {
       $("#selectyear").val(obj.value);
   }
   
   //切换月,预览div使用
   function changeMonth(obj) {
       var selectyear = $("#selectYear1").val();
       var selectmonth = $("#selectmonth").val();
       $("#time").val(selectyear + selectmonth);
   }
   
   function OpenCreateReport(plantId) {
       if (plantId == "" || plantId == null) {
           window.location.href = "/user/AllPlantsReport/" + null + "?reportId=''" + "&type=add";
       } else {
           window.location.href = "/plant/PlantReport/" + plantId + "?reportId=''" + "&type=add";
       }
   }
   
   function del(id,plantId) {
       if (confirm("<%=Resources.SunResource.TRUE_DELETE %>")) {
           window.location.href = "/Reports/DeleteReport/" + id+"/?&plantId="+plantId;
       }
   }
   
   function choisePlantByPlantId(reportId,plantId) { 
       if(plantId==""||plantId==null) {
            window.location.href = "/user/AllPlantsReport/" +null+"?reportId="+reportId+"&type=edit";
       }else {
            window.location.href = "/plant/PlantReport/" + plantId + "?reportId="+reportId+"&type=edit";
        }
   }
   
   //取得改行当前选择的时间，用于列表行的查看和导出操作
   function setChoiseTime(reportId, typeId) {
       if (typeId == 1) {
           $("#time").val($("#d_" + reportId).val());
       } else if (typeId == 2) {
           $("#time").val($("#w_" + reportId).val());
       } else if (typeId == 3) {
           var selectyear = $("#selectYear1_" + reportId).val();
           var selectmonth = $("#selectmonth_" + reportId).val();
           $("#time").val(selectyear + "-" + selectmonth);
       } else if (typeId == 4) {
           $("#time").val($("#selectyear_"+reportId).val());
       }
   }

   function downLoadReport(reportId, typeId) {
       setChoiseTime(reportId, typeId);
       window.open("/DataDownLoad/DownLoadReport/?id=" + $("#plantId").val() + "&reportId=" + reportId + "&cTime=" + $("#time").val());
   }
  
</script>
    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
 <td width="793" valign="top" background="../../images/kj/kjbg01.jpg">
  <%=Html.Hidden("plantId",ViewData["id"]) %> 
  <%=Html.Hidden("time","") %>
  <%=Html.Hidden("typeId",Request.QueryString["tId"]) %>
  <%=Html.Hidden("eventreport", TempData["eventreport"])%>
 <form action="/reports/ViewReport" method="get" id="viewReportForm" target="_blank">
 <input name="rId" id="rId" type="hidden" value=""/>
 <input name="cTime" id="cTime" type="hidden" value=""/>
 <input name="tId" id="tId"  type="hidden" value=""/>
 <input name="pId" id="pId"  type="hidden" value=""/>
 </form>

		<table width="793"  border="0" cellpadding="0" cellspacing="0" background="../../Images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="../../Images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="../../Images/kj/kjiico01.gif"width="31" height="41" /></td>
                  <td width="93%" class="pv0216">
                  <% if (ViewData["id"] == null)
                     {%>
                  <%=Resources.SunResource.RUN_REPORTS%>
                  <%}
                     else
                     { %>
                  <%=Resources.SunResource.REPORTS%>
                  <%} %>
                  </td>
                </tr>
                <tr>
                  <td class="pv0212">&nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="../../Images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div class="bitab" >
              <ul id="bitab">
                <li><a id="RunReportChart" class="onclick"  href="javascript: void(0);"><%=Resources.SunResource.RUN_REPORTS%></a></li>
                 
                <li><a id="EventReportChart" class="noclick"  href="javascript: void(0);"><%=Resources.SunResource.EVENT_REPORTS%> </a></li>
            
                </ul>
            </div>
            <div class="sb_mid">
             
             
            <div id='container' style='width: 100%; margin-left: 2px;  margin-right: 2px;'>
            </div>
              
            </div>
            <div class="sb_down">
            </div>
            
          </div>
          
        <div style="display: none">
            <center>
                <div id='large_container' style="width: 95%; height: 550px; margin-left: 40px; margin-right: 40px;">
                </div>
            </center>
        </div>
 </td>
	</tr>
</table>