<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
    <tr>
        <td width="35%" height="25" class="subline02">
            <strong>日期</strong>
        </td>
        <td width="35%" class="subline02">
            <strong>预测值</strong>
        </td>
        <td width="30%" class="subline02">
            <strong>
                <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
        </td>
    </tr>
    <%foreach (var item in ViewData["list"] as IList<EnergyYearMonthForecast>)
      { %>
    <tr>
        <td class="down_line01">
            <%=item.dataKey %>
        </td>
        <td class="down_line01">
            <%=item.dataValue %>
            kWh
        </td>
        <td class="down_line01">
            <a href="javascript:delitem(<%=item.id %>)">
                <img src="/images/sub/cross.gif" width="16" height="16" border="0" /></a>
        </td>
    </tr>
    <%} %>
</table>
<%Html.RenderPartial("page"); %>
