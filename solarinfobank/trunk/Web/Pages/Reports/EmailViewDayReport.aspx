
<%@ Page Title="" Language="C#"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>

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
             
    <table width="98%" border="1" cellpadding="0" bordercolor="#A8A8A8" cellspacing="0" style=" border-collapse:collapse; line-height:24px;text-align:center">
    <tr>
    <td colspan="10"><strong><%=Model.ReportName%></strong></td>
    </tr>
    <tr>
    <td colspan="10" align="right" style="padding-right:10px;"><%=Resources.SunResource.REPORT_VIEW_TIME %>：<%=ViewData["time"]%></td>
    </tr>
    <tr>
    <td colspan="20" align="left" style="padding-left:10px;"><%=Resources.SunResource.REPORT_PLANT_COUNT_DATA%></td>
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
  </table>

  <table width="98%" border="1" bordercolor="#A8A8A8"  cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:24px;text-align:center">
  <tr>
    <td colspan="20" align="left" style="padding-left:10px; "><%=Resources.SunResource.REPORT_DEVICE_COUNT_DATA%></td>
  </tr>
  <tr>
    <td width="10%"><%=Resources.SunResource.REPORT_COUNT_ITEM%></td>
    <td width="10%"><%=Resources.SunResource.REPORT_COUNT_DEVICE%></td>
    <td width="5%">7:00</td>
    <td width="5%">8:00</td>
    <td width="5%">9:00</td>
    <td width="5%">10:00</td>
    <td width="5%">11:00</td>
    <td width="5%">12:00</td>
    <td width="5%">13:00</td>
    <td width="5%">14:00</td>
    <td width="5%">15:00</td>
    <td width="5%">16:00</td>
    <td width="5%">17:00</td>
    <td width="5%">18:00</td>
    <td width="5%">19:00</td>
    <td width="20%" style=" border-right-style:"10"><%=Resources.SunResource.REPORT_COUNT_TODAYSUN%></td>
  </tr>
  <% 
  
  Hashtable deviceHash = ViewData["deviceHash"] as Hashtable;
  foreach (int tmpcode in ViewData["deviceItemCodes"] as IList)
  {
      i = 1;
      string keystr = "", unit = "";
      //if (!tmpcode.StartsWith("&nbsp;"))
      //{
      keystr = DataItem.getNameByCode(tmpcode);
      unit = MonitorType.getMonitorTypeByCode(tmpcode).unit;
      // }
      IList<string[]> dataArrList = (IList<string[]>)deviceHash[tmpcode];
      for (int k=1;k<dataArrList.Count;k++)
      {
          string[] dataArr = dataArrList[k];
          if (i == 1)
          {
              i++;
  %>
    <tr>
    <td rowspan="<%=dataArrList.Count-1 %>"><%=keystr%><br/><%=string.IsNullOrEmpty(unit)?"&nbsp;":("("+unit+")")%></td>
    <td><%=dataArr[1]%></td><!--设备名称-->
    <td><%=dataArr[2]%></td>
    <td><%=dataArr[3]%></td>
    <td><%=dataArr[4]%></td>
    <td><%=dataArr[5]%></td>
    <td><%=dataArr[6]%></td>
    <td><%=dataArr[7]%></td>
    <td><%=dataArr[8]%></td>
    <td><%=dataArr[9]%></td>
    <td><%=dataArr[10]%></td>
    <td><%=dataArr[11]%></td>        
    <td><%=dataArr[12]%></td>   
    <td><%=dataArr[13]%></td>    <!--19-->       
    <td><%=dataArr[14]%></td>
    <td><%=dataArr[15]%></td>      <!--总计-->  
  </tr>
  <%}
          else
          {   
      %>
      <tr>
    <td><%=dataArr[1]%></td><!--设备名称-->
    <td><%=dataArr[2]%></td>
    <td><%=dataArr[3]%></td>
    <td><%=dataArr[4]%></td>
    <td><%=dataArr[5]%></td>
    <td><%=dataArr[6]%></td>
    <td><%=dataArr[7]%></td>
    <td><%=dataArr[8]%></td>
    <td><%=dataArr[9]%></td>
    <td><%=dataArr[10]%></td>
    <td><%=dataArr[11]%></td>        
    <td><%=dataArr[12]%></td>   
    <td><%=dataArr[13]%></td>    <!--19-->       
    <td><%=dataArr[14]%></td>
    <td><%=dataArr[15]%></td>      <!--总计-->  
  </tr>
      <%
      }
      }
  } %> 
</table>
    <%}%>

    </div>


