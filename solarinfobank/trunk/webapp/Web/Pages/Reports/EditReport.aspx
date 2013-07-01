<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ReportConfig>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<script src="/Script/DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/Script/SetChart.js" type="text/javascript"></script>
<link media="screen" rel="stylesheet" href="/style/colorbox.css" />
<script src="/script/jquery.colorbox.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        showOptional($("#typeId").val());
        showMode();
        changeTime();
        setDataBaseTime();
        parent.iFrameHeight();
    });
    
    function checkWeek(week) {
        var cw;
      switch(week)
      {
          case 1:
              cw = "<%=Resources.SunResource.MONDAY %>";
              break;
          case 2:
              cw="<%=Resources.SunResource.TUESDAY %>";
              break;
          case 3:
              cw="<%=Resources.SunResource.WEDNESDAY %>";
              break;
          case 4:
              cw="<%=Resources.SunResource.THURSDAY %>";
              break;
          case 5:
              cw="<%=Resources.SunResource.FRIDAY %>";
              break;
          case 6:
              cw="<%=Resources.SunResource.SATURDAY %>";
              break;
          case 7:
              cw="<%=Resources.SunResource.SUNDAY %>";
              break;
      }
      return cw;
    }
    //取当前报表的上次保存时间
    function setDataBaseTime() {
        var dbTime = $("#dTime").val().split(',');
        var tId = $("#typeId").val();
        var ssMode = $("#sMode").val();
        
        if (dbTime != "" || dbTime != "null") {
            if (tId == "1") {
                $("#hour").val(Number(dbTime[0]));
                $("#minus").val(Number(dbTime[1]));
            } else if (tId == "2") {
                var ww = checkWeek(Number(dbTime[0]));
                $("#week").val(ww);
                $("#hour").val(Number(dbTime[1]));
            } else if (tId == "3") {
                $("#mday").val(Number(dbTime[0]));
                $("#hour").val(Number(dbTime[1]));
            } else if (tId == "4") {
                $("#month").val(Number(dbTime[0]));
                $("#mday").val(Number(dbTime[1]));
                $("#hour").val(Number(dbTime[2]));
            } else {
                $("#month").val(Number(dbTime[0]));
                $("#mday").val(Number(dbTime[1]));
                $("#hour").val(Number(dbTime[2]));
            }
        }
    }
    //设置选择的数据项
    function checkDataItem() {
        var dataItemList = $("#itemList").val().split(",");
        for (var i = 0; i < dataItemList.length; i++) {
            $("#" + dataItemList[i]).attr("checked", true);
        }
    }

    
    function showMode() {
         var modes = document.getElementsByName("sendMode");
         if (modes[0].checked) {
             $("#cirTime").show();
             $("#fixedTime1").hide();
         } else {
             $("#cirTime").hide();
             $("#fixedTime1").show();
         }
    }
    function showOptional(id) {
        if ($("#PlantId").val() == "" || $("#PlantId").val() == "null") {
            $.ajax({
                type: "POST",
                url: "/Reports/ShowUserDataItemByType/" + id,
                success: function(result) {
                    $("#dataContainer").html(result);
                    parent.iFrameHeight();
                    checkDataItem();
                },
                beforeSend: function() { }
            });
        } else {
            $.ajax({
                type: "POST",
                url: "/Reports/ShowDataItemByType/" + id,
                success: function(result) {
                    $("#dataContainer").html(result);
                    parent.iFrameHeight();
                    checkDataItem();
                    
                },
                beforeSend: function() { }
            });
        }
        changeTime();
    }
    function getChoiceTime() {
        var rt = document.getElementsByName("reportType");
        var mo = document.getElementsByName("sendMode");
        if (!checkForm()) {
            return false;
        } else {
            if (rt[0].checked && mo[1].checked) {

                $("#fixedTime").val($("#hour").val() + "," + $("#minus").val());
            }
            if (rt[1].checked) {
                $("#fixedTime").val($("#week").val() + "," + $("#hour").val());
            }
            if (rt[2].checked) {
                $("#fixedTime").val($("#mday").val() + "," + $("#hour").val());
            }
            if (rt[3].checked) {
                $("#fixedTime").val($("#month").val() + "," + $("#mday").val() + "," + $("#hour").val());
            }
            if (rt[4].checked) {
                $("#fixedTime").val($("#month").val() + "," + $("#mday").val() + "," + $("#hour").val());
            }
            getItemCode();
            return true;
        }
    }
    function changeTime() {
        var mode = document.getElementsByName("sendMode");
        var r = document.getElementsByName("reportType");
        if (r[0].checked) {
            $("#sendMode1").show();
            $("#sendMode2").show();
            $("#hour1").show();
            $("#minute1").show();
            $("#cirTime").hide();
            $("#textMode").hide();  
            $("#month1").hide();
            $("#week1").hide();
            $("#mday1").hide();
            $("#cirTime").hide();
        }
        if (r[0].checked && mode[0].checked) {
            $("#cirTime").show();
            $("#fixedTime1").hide();
            $("#hour1").hide();
            $("#minute1").hide();
            mode[1].checked = false;
        }
        if (r[0].checked && mode[1].checked) {
            $("#fixedTime1").show();
            $("#hour1").show();
            $("#minute1").show();
            $("#cirTime").hide();
            $("#month1").hide();
            $("#week1").hide();
            $("#mday1").hide();
        }
        if (r[1].checked) {
            $("#fixedTime1").show();
            $("#sendMode1").hide();
            $("#textMode").show();  
            $("#cirTime").hide();
            $("#sendMode2").show();
            $("#week1").show();
            $("#hour1").show();
            $("#month1").hide();
            $("#minute1").hide();
            $("#mday1").hide();
            mode[1].checked = true;
        }
        if (r[2].checked) {
            $("#fixedTime1").show();
            $("#textMode").show();  
            $("#sendMode1").hide();
            $("#cirTime").hide();
            $("#sendMode2").show();
            $("#month1").hide();
            $("#mday1").show();
            $("#hour1").show();
            mode[1].checked = true;
            $("#week1").hide();
            $("#minute1").hide();
        }
        if (r[3].checked) {
            $("#fixedTime1").show();
            $("#textMode").show();  
            $("#sendMode1").hide();
            $("#cirTime").hide();
            $("#sendMode2").show();
            $("#month1").show();
            $("#mday1").show();
            $("#hour1").show();
            $("#week1").hide();
            $("#minute1").hide();
            mode[1].checked = true;
        }
        if (r[4].checked) {
            $("#fixedTime1").show();
            $("#textMode").show();  
            $("#sendMode1").hide();
            $("#cirTime").hide();
            $("#sendMode2").show();
            $("#month1").show();
            $("#mday1").show();
            $("#hour1").show();
            $("#week1").hide();
            $("#minute1").hide();
            mode[1].checked = true;
        }

    }
    
    function changeDay(obj) {
        var aimDay = obj.value;
        if (aimDay) {
            aimDay = aimDay.replace("-", "").replace("-", "");
        }
        $("#startYYYYMMDDHH").val(aimDay + "06")
        $("#endYYYYMMDDHH").val(aimDay + "22")
    }
    
    //取得给定名称域的值
    function cbxvalueCheck(name) {
        var values = "";
        $("input[name='" + name + "']:checked").each(function() {
            values += "," + $(this).val();
        });
        return values.length > 0 ? values.substring(1, values.length) : values;
    }
    
    //预览
    function viewPreview(itemName, reportType, vTime) {
        //if (!checkForm()) {
        // return false;
        // } else {
        var dataitem = cbxvalueCheck(itemName).toString();
        var rName = $("#reportName").val();
        var rType = cbxvalueCheck(reportType).toString();
        //$("#previewreport").colorbox({ width: "100%", inline: true, href: "#large_container" });
        //previewReports("large_container", dataitem, rType, rName, vTime);
        //}
        parent.previewReports(<%=ViewData["userId"] %>,"large_container", dataitem, rType, rName, vTime,$("#PlantId").val());
    }
    
    ///废弃，调用父窗体的预览脚步
    function previewReports(curContainer, dataitems, repType, rName, vTime) {
        $.ajax({
            type: "POST",
            url: "/Reports/PreviewReport",
            data: "userId=<%=ViewData["userId"] %>&dataItem=" + dataitems + "&tId=" + repType + "&rName=" + rName + "&cTime=" + vTime + "&plantId=" + $("#PlantId").val(),
            success: function(result) {
                $("#" + curContainer).html(result);
                parent.iFrameHeight();
            },
            beforeSend: function() {
                $('#' + curContainer).empty();
                $('#' + curContainer).append("<center><img src=\"../../images/ajax_loading.gif\" style=\"margin-top: " + 130 + "px;\" /></center>");
            }
        });
    }

    function backHome() {
        if ($("#PlantId").val() == "" || $("#PlantId").val() == "null") {
            window.location.href = "/user/AllPlantsReport";
        } else {
            window.location.href = "/plant/PlantReport/" + $("#PlantId").val();
        }
    }

    function checkReportName() {
        $("#error_reportname").html("");
        $("#interval_error").html("");
        $("#error_reportname").val("");
        if ($("#reportName").val() == "" || $("#reportName").val() == "null") {
            $("#error_reportname").html("<em class='error'><span class='error'>&nbsp;<%=Resources.SunResource.REPORT_NAME_REQUIRED %></span></em>");
            return false;
        }
        if ((!($("#tinterval").val() > 0)) && $("#tinterval").val()!="") {
            $("#interval_error").html("<em class='error'><span class='error'>&nbsp;<%=Resources.SunResource.PLANT_ADDPLANT_LATITUDE_DIGITS %></span></em>");
            return false;
        }
        return true;
    }
    
    function checkDataItems() {
        var items = cbxvalueCheck("itemName");
        if (items == "") {
            alert("<%=Resources.SunResource.REPORT_OPTIONAL_REQUIRED %>");
            return false;
        } else {
            return true;
        }
    }
    function checkForm() {
        if (checkReportName() && checkDataItems()) {
            return true;
        } else {
            return false;
        }
    }
</script>
<script src="/script/SetDateTime.js" type="text/javascript"></script>
<%=Html.Hidden("typeId", ViewData["reportTypeId"])%>
<%=Html.Hidden("tId", ViewData["reportTypeId"])%>
<%=Html.Hidden("itemList", ViewData["dataItems"])%>
<%=Html.Hidden("dTime",Model.fixedTime) %>
<%=Html.Hidden("sMode",Model.sendMode) %>
<%=Html.Hidden("prev", ViewData["preview"])%>
<%=Html.Hidden("time","") %>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td width="793" valign="top" background="../../images/kj/kjbg01.gif">
 <%using (Html.BeginForm("UpdateReport", "Reports", FormMethod.Post, new {name="form1" }))
               { %>
               <%=Html.Hidden("curTime", DateTime.Now.ToString("yyyy-MM-dd"))%>
               <%=Html.Hidden("fixedTime","") %>
               <%=Html.Hidden("id",ViewData["id"])%>
               <%=Html.Hidden("PlantId",ViewData["pId"]) %>
               <%=Html.Hidden("reportId",Request.QueryString["id"]) %>
               <%=Html.Hidden("UserId", ViewData["userId"])%>
  <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="../../Images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="../../Images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="../../Images/kj/kjiico01.gif"width="31" height="41" /></td>
                  <td width="93%" class="pv0216"><%=Resources.SunResource.EDIT_REPORT%></td>
                </tr>
                <tr>
                  <td class="pv0212">&nbsp; </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="../../Images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
            <div class="subrbox01">
            <div class="sb_top"></div>
            <div class="sb_mid">
            <div class="note01" style="margin-bottom: 10px;">
                        <%=Resources.SunResource.AUTH_REG_NOTE %>：*
                        <%=Resources.SunResource.AUTH_REG_FOR_MUST_FILL_IN_THE_ITEM %></div>
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td colspan="2" >
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #E8E8E8;">
                      <tr>
                        <td width="25%" height="35" class="pr_10"><%=Resources.SunResource.REPORT_NAME%>:</td>
                        <td width="75%" colspan="2">
                        <input name="reportName"  style="width:250px;" value="<%=Model.defineReport.ReportName%>" id="reportName" type="text" class="txtbu04" size="18" />
                        <span class="redzi">*</span>  &nbsp; <span id="error_reportname" style=" font-size:12px; color:Red;"></span>
                        </td>
                          
                      </tr>
                      <tr>
                        <td width="25%" height="35" class="pr_10"><%=Resources.SunResource.REPORT_TYPE%>:</td>
                        <td width="75%" colspan="2">
                        <table width="86%" border="0" cellspacing="0" cellpadding="0">
                            <% switch (Model.defineReport.ReportType)
                               {
                                   case 1: %>
                                     <tr>
                            <td width="20%">
                                <input type="radio" checked="checked" name="reportType"  id="reportType" value="1" onclick="showOptional('1')" />
                              <%=Resources.SunResource.REPORT_TYPE_DAY%></td>
                                <td width="20%"><input type="radio" name="reportType" id="reportType" value="2" onclick="showOptional('2')"  />
                               <%=Resources.SunResource.REPORT_TYPE_WEEK%></td>
                                <td width="20%"><input type="radio" name="reportType" id="reportType" value="3"onclick="showOptional('3')"  />
                               <%=Resources.SunResource.REPORT_TYPE_MONTH%></td>
                                 <td width="20%"><input type="radio" name="reportType"  id="reportType" value="4" onclick="showOptional('4')"  />
                               <%=Resources.SunResource.REPORT_TYPE_YEAR%></td>
                                <td width="20%"><input type="radio" name="reportType"  id="reportType" value="5" onclick="showOptional('5')" />
                               <%=Resources.SunResource.REPORT_TYPE_TOTAL%></td>
                               </tr>
                              <%break;
                                   case 2: %>
                                   <tr>
                                    <td width="20%">
                                <input type="radio"  name="reportType"  id="reportType" value="1" onclick="showOptional('1')" />
                              <%=Resources.SunResource.REPORT_TYPE_DAY%></td>
                            <td width="20%"><input type="radio" checked="checked" name="reportType" id="reportType" value="2" onclick="showOptional('2')"  />
                               <%=Resources.SunResource.REPORT_TYPE_WEEK%></td>
                                <td width="20%"><input type="radio" name="reportType" id="reportType" value="3"onclick="showOptional('3')"  />
                               <%=Resources.SunResource.REPORT_TYPE_MONTH%></td>
                                 <td width="20%"><input type="radio" name="reportType"  id="reportType" value="4" onclick="showOptional('4')"  />
                               <%=Resources.SunResource.REPORT_TYPE_YEAR%></td>
                                <td width="20%"><input type="radio" name="reportType"  id="reportType" value="5" onclick="showOptional('5')" />
                               <%=Resources.SunResource.REPORT_TYPE_TOTAL%></td>
                               </tr>
                               <%break;
                                   case 3: %><tr>
                                    <td width="20%">
                                <input type="radio"  name="reportType"  id="reportType" value="1" onclick="showOptional('1')" />
                              <%=Resources.SunResource.REPORT_TYPE_DAY%></td>
                                 <td width="20%"><input type="radio" checked="checked" name="reportType" id="reportType" value="2" onclick="showOptional('2')"  />
                               <%=Resources.SunResource.REPORT_TYPE_WEEK%></td>
                            <td width="20%"><input type="radio"checked="checked" name="reportType" id="reportType" value="3"onclick="showOptional('3')"  />
                               <%=Resources.SunResource.REPORT_TYPE_MONTH%></td>
                                <td width="20%"><input type="radio" name="reportType"  id="reportType" value="4" onclick="showOptional('4')"  />
                               <%=Resources.SunResource.REPORT_TYPE_YEAR%></td>
                                <td width="20%"><input type="radio" name="reportType"  id="reportType" value="5" onclick="showOptional('5')" />
                               <%=Resources.SunResource.REPORT_TYPE_TOTAL%></td>
                               </tr>
                               
                               <%break;
                                   case 4: %>
                                   <tr>
                                   <td><input type="radio"  name="reportType"  id="reportType" value="1" onclick="showOptional('1')" />
                              <%=Resources.SunResource.REPORT_TYPE_DAY%> </td>
                                 <td width="20%"><input type="radio"  name="reportType" id="reportType" value="2" onclick="showOptional('2')"  />
                               <%=Resources.SunResource.REPORT_TYPE_WEEK%></td>
                            <td width="20%"><input type="radio" name="reportType" id="reportType" value="3"onclick="showOptional('3')"  />
                               <%=Resources.SunResource.REPORT_TYPE_MONTH%></td>
                            <td width="20%"><input type="radio" name="reportType"checked="checked" id="reportType" value="4" onclick="showOptional('4')"  />
                               <%=Resources.SunResource.REPORT_TYPE_YEAR%></td>
                                  <td width="20%"><input type="radio" name="reportType"  id="reportType" value="5" onclick="showOptional('5')" />
                               <%=Resources.SunResource.REPORT_TYPE_TOTAL%></td>
                               </tr>
                               <%break;
                                   case 5: %>
                                   <tr>
                                  <td><input type="radio"  name="reportType"  id="reportType" value="1" onclick="showOptional('1')" />
                              <%=Resources.SunResource.REPORT_TYPE_DAY%></td>
                                 <td width="20%"><input type="radio"  name="reportType" id="reportType" value="2" onclick="showOptional('2')"  />
                               <%=Resources.SunResource.REPORT_TYPE_WEEK%></td>
                            <td width="20%"><input type="radio" name="reportType" id="reportType" value="3"onclick="showOptional('3')"  />
                               <%=Resources.SunResource.REPORT_TYPE_MONTH%></td>
                            <td width="20%"><input type="radio" name="reportType"  id="reportType" value="4" onclick="showOptional('4')"  />
                               <%=Resources.SunResource.REPORT_TYPE_YEAR%></td>
                            <td width="20%"><input type="radio" name="reportType" checked="checked" id="reportType" value="5" onclick="showOptional('5')" />
                               <%=Resources.SunResource.REPORT_TYPE_TOTAL%></td>
                               </tr>
                               <%break;
      
                         } %>
                          
                        </table></td>
                      </tr>
                    </table></td>
                  </tr>
                  
                  <tr>
                    <td valign="top" width="25%" class="pr_10" style="padding-top:20px;">
                    <%=Resources.SunResource.REPORT_ITEM_DATE_OPTIONAL%>:</td>
                    <td width=75%>   
                     <div id="dataContainer" style="margin-top:10px; margin-bottom:10px; margin-left: 0px;">
                     
                     </div>
                    </td>
                  </tr>
                  <tr height="40">
                    <td colspan="2" style="padding-top:10px; border-top:1px solid #e8e8e8;">
                    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                       <% switch (Model.sendFormat) 
                             {
                                 case "html":
                                  %>
                      <tr>
                      <td width="25%" class="pr_10"align="left"><%=Resources.SunResource.REPORT_SEND_FORMAT%>:</td>
                            <td width="75%" align="left" style="padding-left:3px;">
                          <input type="radio" checked="checked" name="sendFormat" id="sendFormat1" value="html" />
                          <%=Resources.SunResource.REPORT_SEND_FORMAT_HTML%>&nbsp;&nbsp;&nbsp;
                            <%--<input type="radio" name="sendFormat" id="sendFormat2" value="txt" />
                          <%=Resources.SunResource.REPORT_SEND_FORMAT_TXT%>--%>
                          </td>
                       </tr>
                          <%break;
                                 case "txt": %>
                          <tr>
                          <td width="25%" class="pr_10" align="left"><%=Resources.SunResource.REPORT_SEND_FORMAT%>:</td>
                            <td width="75%" align="left" style="padding-left:3px;">
                                   <input type="radio"  name="sendFormat" id="sendFormat1" value="html" />
                          <%=Resources.SunResource.REPORT_SEND_FORMAT_HTML%>&nbsp;&nbsp;&nbsp;
                            <input type="radio"  checked="checked" name="sendFormat" id="sendFormat2" value="txt" />
                          <%=Resources.SunResource.REPORT_SEND_FORMAT_TXT%>   </td>
                        </tr>
                         <%break;
                             } %> 
                    </table></td>
                  </tr>
               
                  <tr height="40">
                    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #E8E8E8;">
                    
                       <% switch (Model.sendMode)
                        {
                            case "1": %>
                      <tr id="sendMode1">
                        <td width="25%" class="pr_10" height="35" align="left"><%=Resources.SunResource.REPORT_SEND_MODE%>:</td>
                        <td width="75%" height="25" align="left" >&nbsp;<input onclick="changeTime()" checked="checked" type="radio"  name="sendMode" id="sendMode" value="1" />
                         <%=Resources.SunResource.REPORT_SEND_MODE_CIRCULATION%>               </td>
                      </tr>
                       <tr  id="sendMode2">
                        <td width="25%" class="pr_10" height="35" align="left" ><div id="textMode"><%=Resources.SunResource.REPORT_SEND_MODE%>:</div></td>
                        <td height="25" align="left" width="75%">&nbsp;<input type="radio"  name="sendMode" onclick="changeTime()"  value="2" />
                           <%=Resources.SunResource.REPORT_SEND_MODE_FIXED_TIME%> </td>
                      </tr>
                      <%break;
                            case "2": %>
                            <tr id="sendMode1">
                        <td width="25%" class="pr_10" height="35" align="left"><%=Resources.SunResource.REPORT_SEND_MODE%>:</td>
                        <td width="75%" height="25" align="left" >&nbsp;<input onclick="changeTime()" type="radio"  name="sendMode" id="sendMode" value="1" />
                         <%=Resources.SunResource.REPORT_SEND_MODE_CIRCULATION%>               </td>
                      </tr>
                      <tr id="sendMode2">
                        <td width="25%" class="pr_10" height="35" align="left"><div id="textMode"><%=Resources.SunResource.REPORT_SEND_MODE%>:</div></td>
                        <td height="25" align="left" width="75%">&nbsp;<input type="radio" checked="checked" onclick="changeTime()"  name="sendMode" value="2" />
                           <%=Resources.SunResource.REPORT_SEND_MODE_FIXED_TIME%> </td>
                      </tr>
                      
                     <% break;
                        } %> 
                     
                      <tr  height="40" id="fixedTime1">
                        <td width="25%" class="pr_10" height="35" align="left"><div> <%=Resources.SunResource.REPORT_TIME%>  :</div></td>
                        <td height="25" align="left" width="75%">
                       <div id="week1" style="display:none; float:left;">
                       <select id="week" >
                            <option value="1"><%=Resources.SunResource.MONDAY %></option>
                            <option value="2"><%=Resources.SunResource.TUESDAY%></option>
                            <option value="3"><%=Resources.SunResource.WEDNESDAY %></option>
                            <option value="4"><%=Resources.SunResource.THURSDAY %></option>
                            <option value="5"><%=Resources.SunResource.FRIDAY %></option>
                            <option value="6"><%=Resources.SunResource.SATURDAY %></option>
                            <option value="7"><%=Resources.SunResource.SUNDAY%></option>
                        </select>
                        </div>
                        
                        <div  id="month1" style="display:none; float:left ; margin-left:6px;" >
                            <%=Html.DropDownList("month", Currencies.MonthList, new { id = "month", style="width:50px"})%>                    
                            <%=Resources.SunResource.REPORT_SEND_MONTH%>
                        </div>
                        
                        <div id="mday1" style="display:none; float:left ; margin-left:6px;">
                         <select style="width: 50px;" id="mday" >
                          <%
                         for (int i = 1; i <= 31; i++)
                         {
                            
                              %>
                                <option value="<%=i.ToString("00")%>"><%=i.ToString()%></option>
                               
                         <% }%>
                        </select>
                            <%=Resources.SunResource.REPORT_SEND_DAY%>
                       </div>
                       
                        <div id="hour1" style="margin-left:6px;float:left;">
                            <%=Html.DropDownList("hour", Currencies.hourList, new { id = "hour", style="width:50px"})%>                           
                          <%=Resources.SunResource.REPORT_SEND_HOUR%>&nbsp;
                          </div>
                          
                          <div id="minute1" style="display:inline;">
                         <%=Html.DropDownList("minus", Currencies.minuteList, new { id = "minus", style = "width:50px" })%>                    
                         <%=Resources.SunResource.REPORT_SEND_MINUTE%>  
                           </div>                         
                       </td>
                     </tr>
                       <tr id="cirTime" style="display:none;">
                          <td width="25%" align="left" class="pr_10">   
                          <%=Resources.SunResource.REPORT_SEND_INTERVAL%>:</td>
                        <td align="left" width="75%">
                        <input name="tinterval" id="tinterval" type="text" onblur="checkReportName()" class="txtbu04" value="<%=Model.tinterval %>" size="18" />                        
                         <%=Resources.SunResource.REPORT_SEND_HOUR%>
                         <span id="interval_error"></span>
                        </td>
                     </tr>                     
                    </table>
                    </td>
                  </tr>
                  <tr>
                    <td width="25%" class="pr_10"  valign="top"  style="padding-top:10px;">
                    <%=Resources.SunResource.REPORT_EMAIL%>:
                    </td>
                    <td width="75%"  valign="top"  style="padding-top:10px;">
                        <textarea name="email" id="email"  class="txtbu05" style="width:400px; font-size:12px; color:#999999; text-align:left;" cols="20" 
                            rows="1"><%=Model.email %></textarea>
                        <div id="emailNote"><%=Resources.SunResource.REPROT_NOTE %>:<%=Resources.SunResource.REPORT_EMAIL_NOTE%></div>
                   </td>
                  </tr>
                  <tr>
                    <td width="80%" colspan="2" style="padding-top:10px;">&nbsp;</td>
                  </tr>
                </table>
              
           </div>
        <div class="sb_down"></div>

            <div style="display: none">
            <center>
                <div id='large_container' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px;">
                </div>
            </center>
            </div>
        </div>
          
            <table width="60%" height="80" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><input name="previewreport" id="previewreport" onclick="viewPreview('itemName','reportType','<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>')"  type="button" class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_PREVIEW%>" /></td>
                <td><input name="Submit3" type="submit"  class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_SAVE%>" onclick="return getChoiceTime()" /></td>
                <td><input name="Submit32" type="button" onclick="backHome()" class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_CANCLE%>" /></td>
              </tr>
            </table>           
          <%} %>       
          </td>
          	</tr>
</table>