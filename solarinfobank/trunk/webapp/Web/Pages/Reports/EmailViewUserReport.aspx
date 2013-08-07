<div style=" width:98%; padding:10px 10px 10px 10px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;" >
    <%=Html.Hidden("reportId", ViewData["rId"])%>
    <%=Html.Hidden("tId", ViewData["tId"])%>
    <%=Html.Hidden("plantId", ViewData["pId"])%>
    <%=Html.Hidden("time",ViewData["cTime"]) %>
	<input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
    <input type="hidden" value="5" id="intervalMins" />
    <input type="hidden" value="column" id="chartType" />
    <input type="hidden" value="<%=MonitorType.PLANT_MONITORITEM_POWER_CODE%>" id="mts" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>00" id="startYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23" id="endYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01" id="startYYYYMMDD" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays() %>" id="endYYYYMMDD" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>" id="month" />
    <input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM"/>
    <input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM"/> 
       
     <% 
        if (Model != null)
        { 
     %>
             
    <table width="98%" border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0" style=" border-collapse:collapse; line-height:24px;text-align:center">
    <tr>
    <td colspan="10"><strong><%=Model.ReportName%></strong></td>
    </tr>
    <tr>
    <td colspan="10" align="right" style="padding-right:10px; "><%=Resources.SunResource.REPORT_VIEW_TIME %>：<%=ViewData["time"]%></td>
    </tr>
    <tr>
    <td colspan="20" align="left" style="padding-left:10px; "><%=Resources.SunResource.REPORT_PLANT_COUNT_DATA%></td>
    </tr>  
    <!--no device data-->
     <% 
     int i = 1;
     Hashtable plantHash = ViewData["plantHash"] as Hashtable;
     foreach (int de in ViewData["plantItemCodes"] as IList)
     {
         if (i == 1) { 
         %>
         <tr>
         <%}

         int tmpcode = de;
         string keystr = "&nbsp;", keyvalue = "&nbsp;";
         if(tmpcode!=0){
             keystr = DataItem.getNameByCode(tmpcode);
             keyvalue = plantHash[tmpcode].ToString();
         }
         %>
         <td align="right" style="padding-right:5px;"><%=keystr%></td>
         <td align="left" style="padding-left:5px; border-right:1.2,1,red"><%=keyvalue%></td>   
         <% 
         
         if (i == 3) {
             i = 1;   
         %>
         </tr>
         <%            
         }else {        
            i++;
         }
    } %>
   
    <%=Html.Hidden("typeId",Model.ReportType) %>
    
  
  </table>
   <%}%>
    
</div>
<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>


