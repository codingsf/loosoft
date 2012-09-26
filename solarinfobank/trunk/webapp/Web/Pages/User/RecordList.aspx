<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.LoginRecord>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%" style="overflow:hidden; float:left;">
    <%
        int i = 0;
        foreach (var item in Model)
        {
            i++;
    %>
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" style="overflow:hidden; float:left;" cellspacing="0" class="down_line0<%=i%2 %>">
                <tr>
                    <td width="70%" height="30" align="center">
                        <%=item.loginTime.ToString("yyyy-MM-dd HH:mm:ss") %>
                    </td>
                    <td width="30%" align="center">
                        <%=item.ip %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%} %>
     <%Html.RenderPartial("page"); %>
</table>
