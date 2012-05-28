<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<table width="100%" height="30" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #E8E8E8">
    <tr>
        <td width="6%" align="center">
            <%if (AuthService.isAllow(AuthorizationCode.ADD_REPORT))
              {%>
            <a href="javascript:OpenCreateReport(<%=ViewData["id"] %>)" title="<%=Resources.SunResource.REPORT_BUTTON_ADD %>">
                <img src="../../Images/sub/subico016.gif" width="15" height="16" /></a>
            <%}
              else
              { %>
            <img src="../../Images/sub/subico016.gif" width="15" height="16" />
            <%} %>
        </td>
        <td width="94%">
            <%if (AuthService.isAllow(AuthorizationCode.ADD_REPORT))
              { %>
            <a href="javascript:OpenCreateReport(<%=ViewData["id"] %>)" class="dbl" title="<%=Resources.SunResource.REPORT_BUTTON_ADD %>">
                <%=Resources.SunResource.REPORT_ADD%>
            </a>
            <%}
              else
              { %>
            <a class="dbl" title="<%=Resources.SunResource.REPORT_BUTTON_ADD %>">
                <%=Resources.SunResource.REPORT_ADD%>
            </a>
            <%} %>
        </td>
    </tr>
</table>
<table id="runr" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr>
                    <td width="30%" align="center">
                        <strong>
                            <%=Resources.SunResource.REPORT_NAME%></strong>
                    </td>
                    <td width="18%" align="center">
                        <strong>
                            <%=Resources.SunResource.REPORT_TYPE%>
                        </strong>
                    </td>
                    <td width="34%" align="center">
                        <strong>
                            <%=Resources.SunResource.REPORT_TIME_CHOICE%></strong>
                    </td>
                    <td width="16%" align="center">
                        <strong>
                            <%=Resources.SunResource.REPORT_OPERATION%></strong>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <% 
            int i = 1;
            foreach (DefineReport item in Model)
            {
                i++;
        %>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr>
                    <td width="30%" height="42" align="center">
                        <div style="width: 220px; overflow: hidden;">
                            <%=item.ReportName%>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <%
                            switch (item.ReportType)
                            {
                                case 1:
                        %>
                        <%=Resources.SunResource.REPORT_DAY_REPORT%>
                        <%break;
                        case 2: %>
                        <%=Resources.SunResource.REPORT_WEEK_REPORT%>
                        <%break;
                        case 3: %>
                        <%=Resources.SunResource.REPORT_MONTH_REPORT%>
                        <%break;
                        case 4: %>
                        <%=Resources.SunResource.REPORT_YEAR_REPORT%>
                        <%break;
                        case 5: %>
                        <%=Resources.SunResource.REPORT_TOTAL_REPORT%>
                        <%break;
                    } %>
                    </td>
                    <td width="34%" align="center">
                        <%
                            if (item.ReportType == 1)
                            {
                        %>
                        <input name="t" type="text" id="d_<%=item.Id%>" size="12" class="indate" onfocus="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (ViewData["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone((ViewData["user"] as User).timezone,"yyyy-MM-dd")%>'})"
                            readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone((ViewData["user"] as User).timezone,"yyyy-MM-dd")%>"
                            style="text-align: center;" />
                        <%}
                    else if (item.ReportType == 2)
                    {%>
                        <input name="t" type="text" id="w_<%=item.Id%>" size="12" class="indate" onfocus="WdatePicker({onpicked:function(){changeWeek(this);},skin:'whyGreen',lang:'<%= (ViewData["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone((ViewData["user"] as User).timezone,"yyyy-MM-dd")%>'})"
                            readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone((ViewData["user"] as User).timezone,"yyyy-MM-dd")%>"
                            style="text-align: center;" />
                        <% }
                    else if (item.ReportType == 3)
                    { %>
                        <div id="date_YearMMChart" style="text-align: center;">
                            <%=Html.DropDownList("selectYear1", (IList<SelectListItem>)ViewData["plantYear"], new { id = "selectYear1_"+item.Id })%>
                            <%=Html.DropDownList("selectmonth", Currencies.MonthList, new { id = "selectmonth_"+item.Id, style = "width:50px;margin-left:-2px;" })%>
                        </div>
                        <%}
                    else if (item.ReportType == 4)
                    { %>
                        <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style = "width:60px;", id = "selectyear_" + item.Id })%>
                        <%}
                    else if (item.ReportType == 5)
                    { %>
                        &nbsp;<%} %>
                    </td>
                    <td width="16%" align="center">
                        <a id="viewReportA_<%=item.Id%>" href="javascript:void(0)" onclick="jumpviewReport(<%=item.Id%>,<%=item.ReportType%>)"
                            title="<%=Resources.SunResource.RUN_REPORT_VIEW%>">
                            <img src="../../Images/sub/ck.gif" width="16" height="16" border="0" /></a>
                        <%  if (!string.IsNullOrEmpty(ViewData["id"].ToString()))
                            {
                                if (AuthService.isAllow(AuthorizationCode.REPORT_CONFIG))
                                {
                        %>
                        <a href="javascript:choisePlantByPlantId(<%=item.Id%>,<%=ViewData["id"]%>)" title="<%=Resources.SunResource.RUN_REPORT_EDIT%>">
                            <img src="../../Images/sub/pencil.gif" width="16" height="16" border="0" /></a>
                        <%}
                                else
                                {%>
                        <img src="../../Images/sub/pencil0.gif" width="16" height="16" border="0" />
                        <%}
                            }
                            else
                            {
                                if (AuthService.isAllow(AuthorizationCode.REPORT_CONFIG))
                                {
                                    
                        %>
                        <a href="javascript:choisePlantByPlantId(<%=item.Id%>,'')" title="<%=Resources.SunResource.RUN_REPORT_EDIT%>">
                            <img src="../../Images/sub/pencil.gif" width="16" height="16" border="0" /></a>
                        <%}
                                else
                                {
                        %>
                        <img src="../../Images/sub/pencil0.gif" width="16" height="16" border="0" />
                        <%}
                            } %>
                        <% if (!string.IsNullOrEmpty(ViewData["id"].ToString()))
                           {
                               if (AuthService.isAllow(AuthorizationCode.DELETE_REPORT))
                               {
                              
                              
                        %>
                        <a href="javascript:del(<%=item.Id%>,<%=ViewData["id"]%>)" title="<%=Resources.SunResource.RUN_REPORT_DELETE%>">
                            <img src="../../Images/sub/cross.gif" width="16" height="16" border="0" /></a>
                        <%}
                              else
                              {
                        %>
                        <img src="../../Images/sub/cross00.gif" width="16" height="16" border="0" />
                        <%}
                          }
                           else
                           {
                               if (AuthService.isAllow(AuthorizationCode.DELETE_REPORT))
                               {
                              
                              
                        %>
                        <a href="javascript:del(<%=item.Id%>,'')" title="<%=Resources.SunResource.RUN_REPORT_DELETE%>">
                            <img src="../../Images/sub/cross.gif" width="16" height="16" border="0" /></a>
                        <%}
                              else
                              {
                        %>
                        <img src="../../Images/sub/cross00.gif" width="16" height="16" border="0" />
                        <% 
                            }
                          } %>
                        <%if (AuthService.isAllow(AuthorizationCode.SHOW_REPORT))
                          { %>
                        <a href="javascript:downLoadReport(<%=item.Id%>,<%=item.ReportType%>)" title="<%=Resources.SunResource.RUN_REPORT_DOWNLOAD%>">
                            <img src="../../Images/sub/dw.gif" width="16" height="16" border="0" />
                        </a>
                        <%}
                          else
                          { %>
                        <img src="../../Images/sub/dw0.gif" width="16" height="16" border="0" />
                        <%} %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <% 
        }
    %>
</table>
