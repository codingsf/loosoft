<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>

<table width="380" border="0" align="right" cellpadding="0" cellspacing="0">
    <tr>
        <td width="30">
            <%if (!(ViewData["page"] as Pager).IsFirst)
              { %>
            <a href="javascript:changePage(1)" class="green">
                <img src="/images/am/bu_f.gif" width="12" height="13" /></a>
            <%} %>
        </td>
        <td width="20">
            <%if ((ViewData["page"] as Pager).IsPre)
              { %>
            <a href="javascript:changePage(<%=(ViewData["page"] as Pager).PreNo%>)">
                <img src="/images/am/bu_l.gif" width="8" height="13" /></a>
            <%} %>
        </td>
        <td width="71">
            第
            <input name="textfield" type="text" value="<%=(ViewData["page"] as Pager).PageIndex%>"
                style="width: 30px; text-align: center;" />
            页
        </td>
        <td width="100" align="center">
            <%=(ViewData["page"] as Pager).PageIndex%>/<%=(ViewData["page"] as Pager).PageCount%>页
        </td>
        <td width="23">
            <%if ((ViewData["page"] as Pager).IsNext)
              { %>
            <a href="javascript:changePage(<%=(ViewData["page"] as Pager).NextNo%>)">
                <img src="/images/am/bu_n.gif" width="8" height="13" /></a>
            <%} %>
        </td>
        <td width="24">
            <%if (!(ViewData["page"] as Pager).IsLast)
              { %>
            <a href="javascript:changePage(<%=(ViewData["page"] as Pager).PageCount%>)">
                <img src="/images/am/bu_ll.gif" width="12" height="13" /></a>
            <%} %>
        </td>
        <td width="112" align="right">
            跳转
            <select name="select" onchange="javascript:changePage(this.value)">
            <% int index = 0;
               while (index++ < (ViewData["page"] as Pager).PageCount)
               {
                   if (index== (ViewData["page"] as Pager).PageIndex)
                   {
                       Response.Write(string.Format("<option value='{0}' selected=\"selected\">第{0}页</option>", index));
                   }
                   else
                   { %>
                <option value=<%=index %>>第<%=index%>页</option>
                <%}
               } %>
            </select>
        </td>
    </tr>
</table>
