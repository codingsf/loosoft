<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.LoginRecord>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%">
    <%if (Model == null || Model.Count == 0)
      { %>
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3" height="35" align="center">
                        无数据
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%Response.End();
  } %>
    <% int i = 0;
       foreach (var item in Model)
       {
           i++;
    %>
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="33%" align="center" class="am_line0<%=i%2 %>">
                        <%=item.username %>
                    </td>
                    <td width="33%" align="center" class="am_line0<%=i%2 %>">
                        <%=item.loginTime.ToString("yyyy-MM-dd HH:mm:ss") %>
                    </td>
                    <td width="33%" align="center" class="am_line0<%=i%2 %>">
                        <%=item.ip %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%} %>
    <tr>
        <td height="36" colspan="5" background="/images/am/am_bg02.jpg">
            <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="30%">
                    </td>
                    <td width="70%">
                        <%Html.RenderPartial("mpage"); %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
