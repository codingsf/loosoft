<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>报表列表 <%= ViewData["logoName"]%></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script>
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
                $("#time").val($("#selectyear_" + reportId).val());
            }

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
    
    </script>

</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <%=Html.Hidden("plantId",ViewData["id"]) %>
    <%=Html.Hidden("time","") %>
    <%=Html.Hidden("typeId",Request.QueryString["tId"]) %>
    <%=Html.Hidden("eventreport", TempData["eventreport"])%>
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=ViewData["logoName"]%>
                </div>
                <div class="gf_toptittlel"><a href="/portal/index"><img src="<%=ViewData["logo"] %>" border="0" /></a></div>                        
            </div>
        </div>
    </div>
    <form action="/portal/ViewReport" method="get" id="viewReportForm" target="_blank">
    <input name="rId" id="rId" type="hidden" value="" />
    <input name="cTime" id="cTime" type="hidden" value="" />
    <input name="tId" id="tId" type="hidden" value="" />
    <input name="pId" id="pId" type="hidden" value="" />
    </form>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>报表列表</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="62%">
                        </td>
                        <td width="23%" align="right" style="padding-right: 15px;">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                        </td>
                        <td background="/images/gf/tci/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/gf/tci/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="13%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.REPORT_NAME%>
                                        </strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.REPORT_TYPE%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.REPORT_TIME_CHOICE%></strong>
                                    </td>
                                    <td width="10%" bgcolor="#F3F3F3" class="lbtt">
                                        <strong>
                                            <%=Resources.SunResource.REPORT_OPERATION%></strong>
                                    </td>
                                </tr>
                                <% 
                                    int i = 1;
                                    foreach (DefineReport item in Model)
                                    {
                                        i++;
                                %>
                                <tr>
                                    <td width="13%" class="down_line02">
                                        <%=item.ReportName%>
                                    </td>
                                    <td width="10%" class="down_line02">
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
                                    <td width="10%" class="down_line02">
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
                                    <td width="10%" class="down_line02">
                                        <a id="viewReportA_<%=item.Id%>" href="javascript:void(0)" onclick="jumpviewReport(<%=item.Id%>,<%=item.ReportType%>)"
                                            title="<%=Resources.SunResource.RUN_REPORT_VIEW%>">
                                            <img src="../../Images/sub/ck.gif" width="16" height="16" border="0" /></a>
                                    </td>
                                </tr>
                                <%} %>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            </table>
                        </td>
                        <td background="/images/gf/tci/tc05.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif">
                        </td> <td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                    </tr>
                </table>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
