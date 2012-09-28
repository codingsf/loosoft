<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
    <tr>
        <td width="33%" height="25" class="subline02">
            <strong>补偿对象名称</strong>
        </td>
        <td width="15%" class="subline02">
            <strong>补偿类型</strong>
        </td>
        <td width="18%" class="subline02">
            <strong>补偿时间</strong>
        </td>
        <td width="22%" class="subline02">
            <strong>补偿值</strong>
        </td>
        <td width="12%" class="subline02">
            <strong>操作</strong>
        </td>
    </tr>
    <%foreach (var item in ViewData["compensations"] as IList<Compensation>)
      { %>
    <tr>
        <td class="down_line01">
            <%=item.displayName%>
        </td>
        <td class="down_line01">
            <%=item.typeStr %>
        </td>
        <td class="down_line01">
            <%=item.DateStr %>
        </td>
        <td class="down_line01">
            <%=item.dataValue %>
            kWh
        </td>
        <td class="down_line01">
            <%if (UserUtil.getCurUser().username != UserUtil.demousername)
              { %>
            <a href="javascript:edititem(<%=item.type %>,'<%=item.DateStr  %>','<%=item.dataValue %>',<%=item.id %>,'<%=item.isplant %>','<%=item.plantid %>')">
                <img src="/images/sub/pencil.gif" width="16" height="16" border="0" /></a> &nbsp;
            <a href="javascript:delitem(<%=item.id %>)">
                <img src="/images/sub/cross.gif" width="16" height="16" border="0" /></a>
            <%}
              else
              { %>
            <img src="/images/sub/pencil0.gif" width="16" height="16" border="0" />
            &nbsp;
            <img src="/images/sub/cross00.gif" width="16" height="16" border="0" />
            <%} %>
        </td>
    </tr>
    <%} %>
</table>
 <%Html.RenderPartial("page"); %>