
<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/EmptyInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.plant.name%> <%=Model.ReportName%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">   

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/script/jquery.min.js" type="text/javascript"></script>
    <script src="/script/SetChart.js" type="text/javascript"></script>        
    <script src="/script/SetDateTime.js" type="text/javascript"></script>
    
 
    <div style=" width:98%; padding:10px 10px 10px 10px;font-family: Verdana, Arial, Helvetica, sans-serif;font-size:12px;"  >
	<input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
	<input type="hidden" value="<%=ViewData["preview"]%>" id="pre" />
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
   
        <div>
      
          <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="5%" align="center"><img src="../../Images/sub/subico010.gif" width="18" height="19" /></td>
              <td width="15%" class="f_14"><strong><%=Resources.SunResource.REPORT_VIEW%></strong></td>
              <td width="50%" class="f_14">
              <div class="date_sel" id="Div1" style="padding-right:160px; padding-bottom:15px;">
       <div id="Div2" style="margin-top: 20px; text-align: center;">
   <table border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="24">
                <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;" />
            </td>
            <td>
            
                 <div id="date_weekChart1" style="display: none;">
                    <input name="t1" type="text" id="t1" size="12" class="indate"  onfocus="WdatePicker({onpicked:function(){changeWeek(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>'})"
                        readonly="readonly"   value="<%=ViewData["cTime"]%>" style="text-align:center;" /> 
                </div>
                <div id="date_YearMMChart1" style="display: none;">
                <%=Html.DropDownList("selectYear11", (IList<SelectListItem>)ViewData["plantYear"], new { id = "selectYear11", onchange = "changeYear(this)" })%>
                </div>
                <div id="date_MonthDDChart1" style="display: none;">
                    <div style="float: left;">
                    <%=Html.DropDownList("selectyear1", (IList<SelectListItem>)ViewData["plantYear"], new { style = "width:60px;", id = "selectyear1", onchange = "changeMonthYear(this)" })%>
                    </div>
                    <div style="float: right;">
                        <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth01">
                           <%
                                if (ViewData["tId"].ToString() .Equals( "3"))
                                {
                                    string monthDate = ViewData["cTime"].ToString();
                                    string[] monthTime = monthDate.Split('-');
                                    string temp = string.Empty;
                                    for (int p = 1; p <= 12; p++)
                                    {
                                        if (p < 10)
                                        {
                                            temp = "0" + p;
                                        }
                                        else
                                        {
                                            temp = p.ToString();
                                        }
                                        if (temp.Equals(monthTime[1]))
                                        {
                            %>
                                <option value="<%=Convert.ToInt32(temp).ToString("00")%>" selected="selected"><%=Convert.ToInt32(temp).ToString("00")%></option>
                                <%}
                                        else
                                        { %>
                                <option value="<%=Convert.ToInt32(temp).ToString("00")%>"><%=Convert.ToInt32(temp).ToString("00")%></option>
                                <%}
                                    }
                                }%>
                        </select>
                    </div>
                </div>
            </td>
            <td width="24">
                <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
            </td>
        </tr>
    </table>
    </div>
    </div>
              
              
              </td>             
              <td width="10%" class="f_14">
              <%if (AuthService.isAllow(AuthorizationCode.EDIT_UNIT) && ((int)ViewData["rId"]) != 0)
                { %>
                <input name="Submit" id="dload" type="button" onclick="downLoadReports()" class="subbu01"  value="<%=Resources.SunResource.RUN_REPORT_DOWNLOAD%>" />
              <%}
                else
                {%>
                &nbsp;
              <%} %>
              </td>                
            </tr>
          </table>
     
        </div>
            
     <% 
         if (Model != null)
         { 
     %>
             
    <table width="98%" border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0" style=" border-collapse:collapse; line-height:24px;text-align:center">
    <tr>
    <td colspan="10"><strong><%=Model.ReportName%></strong></td>
    </tr>
    <tr>
    <td colspan="10" align="right" style="padding-right:10px; "><%=Resources.SunResource.REPORT_VIEW_TIME%>：<%=ViewData["time"]%></td>
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
             if (i == 1)
             { 
         %>
         <tr>
         <%}

             int tmpcode = de;
             string keystr = "&nbsp;", keyvalue = "&nbsp;";
             if (tmpcode != 0)
             {
                 keystr = DataItem.getNameByCode(tmpcode);
                 keyvalue = plantHash[tmpcode].ToString();
             }
         %>
         <td align="right" style="padding-right:5px;"><%=keystr%></td>
         <td align="left" style="padding-left:5px; border-right:1.2,1,red"><%=keyvalue%></td>   
         <% 
         
         if (i == 3)
         {
             i = 1;   
         %>
         </tr>
         <%            
         }
         else
         {
             i++;
         }
         } %>
  </table>

  <table width="98%" border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:24px;text-align:center">
  <tr>
    <td colspan="40" align="left" style="padding-left:10px; "><%=Resources.SunResource.REPORT_DEVICE_COUNT_DATA%></td>
  </tr>
  <% 
         foreach (DictionaryEntry de in (ViewData["deviceHash"] as Hashtable))
         {
             i = 1;
             string tmpcode = de.Key.ToString();
             string keystr = "", unit = "";
             if (!tmpcode.StartsWith("&nbsp;"))
             {
                 keystr = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).name;
                 unit = MonitorType.getMonitorTypeByCode(MonitorType.PLANT_MONITORITEM_ENERGY_CODE).unit;
             }
             IList<string[]> dataArrList = (IList<string[]>)de.Value;
             int num = 0;
             if (dataArrList.Count > 0)
             {
                 string[] dataArr = dataArrList[0];
                 int realLen = (dataArr.Length - 2);
                 if (80 % realLen == 0)
                 {
                     num = 80 / realLen;
                 }
                 else
                 {
                     num = 80 / realLen + 1;
                 }
             }
                 
             for (int k = 0; k < dataArrList.Count; k++)
             {
                 string[] dataArr = dataArrList[k];
                 if (i == 1)//台头
                 {
                     i++;
  %>
    <tr>
    <%
         foreach (string v in dataArr)
         {
    %>
    <td><%=v%></td>
    <%} %>
  </tr>

  <%}
         else if (i == 2)//第一行
         {
             i++;
  %>
    <tr>
    <td rowspan="<%=dataArrList.Count-1 %>"><%=keystr%><br/><%=string.IsNullOrEmpty(unit)?"&nbsp;":("("+unit+")")%></td>
    <%
         for (int n = 1; n < dataArr.Length; n++)
         {
    %>
    <td width="<%=num%>%"><%=dataArr[n]%></td>
    <%} %>
  </tr>
  <%}
     else//数据行
     {   
  %>
   <tr>
        <%
         for (int m = 1; m < dataArr.Length; m++)
         {
        %>
        <td width="<%=num%>%"><%=dataArr[m] == null ? "&nbsp;" : dataArr[m]%></td>
        <%} %>
    </tr>
      <%
         }
             }
         } 
%> 
</table>
   <% }%>
    <%=Html.Hidden("reportId", ViewData["rId"])%>
    <%=Html.Hidden("tId", ViewData["tId"])%>
    <%=Html.Hidden("cTime", ViewData["cTime"])%>   
    <%=Html.Hidden("plantId", ViewData["pId"])%>
    <%=Html.Hidden("time",ViewData["cTime"]) %>
      
   <div class="date_sel" id="date_select_div">
       <div id="selectTable" style="margin-top: 20px; text-align: center;">
   <table border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="24">
                <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')" style="cursor:pointer;" />
            </td>
            <td>
            
                 <div id="date_weekChart" style="display: none;">
                    <input name="t01" type="text" id="t01" size="12" class="indate"  onfocus="WdatePicker({onpicked:function(){changeWeek(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>'})"
                        readonly="readonly"   value="<%=ViewData["cTime"]%>" style="text-align:center;" />
                     <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                     <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().timezone,"yyyy-MM-dd")%>" /> 

                </div>
                <div id="date_YearMMChart" style="display: none;">
                <%=Html.DropDownList("selectYear1", (IList<SelectListItem>)ViewData["plantYear"], new { id = "selectYear1", onchange = "changeYear(this)" })%>
                </div>
                <div id="date_MonthDDChart" style="display: none;">
                    <div style="float: left;">
                    <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style = "width:60px;", id = "selectyear", onchange = "changeMonthYear(this)" })%>
                    </div>
                    <div style="float: right;">
                        <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth">
                           <%
                                if (ViewData["tId"].ToString() .Equals( "3"))
                                {
                                    string monthDate = ViewData["cTime"].ToString();
                                    string[] monthTime = monthDate.Split('-');
                                    string temp = string.Empty;
                                    for (int p = 1; p <= 12; p++)
                                    {
                                        if (p < 10)
                                        {
                                            temp = "0" + p;
                                        }
                                        else
                                        {
                                            temp = p.ToString();
                                        }
                                        if (temp.Equals(monthTime[1]))
                                        {
                            %>
                                <option value="<%=Convert.ToInt32(temp).ToString("00")%>" selected="selected"><%=Convert.ToInt32(temp).ToString("00")%></option>
                                <%}
                                        else
                                        { %>
                                <option value="<%=Convert.ToInt32(temp).ToString("00")%>"><%=Convert.ToInt32(temp).ToString("00")%></option>
                                <%}
                                    }
                                }%>
                        </select>
                    </div>
                </div>
            </td>
            <td width="24">
                <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')" style="cursor:pointer;"/>
            </td>
        </tr>
    </table>
    </div>
    </div>
</div>
           <script src="/script/jquery.colorbox.js" type="text/javascript"></script>
       <script>
           showTimeDIV();
     </script>
</asp:Content>

