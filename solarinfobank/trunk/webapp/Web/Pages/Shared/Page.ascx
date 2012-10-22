<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line00">
    <%if ((ViewData["page"] as Pager).RecordCount.Equals(0))
      {%>
    <tr>
        <td height="35" align="center" class="pagefy">
            <%=Resources.SunResource.CHART_ERROR_NODATA%>
        </td>
    </tr>
    <%
        }
      else
      { %>
    <tr>
        <td height="35" align="center" class="pagefy">
            <%if (!(ViewData["page"] as Pager).IsFirst)
              { %>
            <span><a href="javascript:changePage(1)" class="green"><<</a> </span>
            <%} %>
            <%if ((ViewData["page"] as Pager).IsPre)
              { %>
            <span><a href="javascript:changePage(<%=(ViewData["page"] as Pager).PreNo%>)" class="green">
                <%=Resources.SunResource.PAGE_PRE%></a> </span>
            <%} %>
            <span>
                <%=(ViewData["page"] as Pager).PageIndex%>/<%=(ViewData["page"] as Pager).PageCount%></span>
            <%if ((ViewData["page"] as Pager).IsNext)
              { %>
            <span><a href="javascript:changePage(<%=(ViewData["page"] as Pager).NextNo%>)" class="green">
                <%=Resources.SunResource.PAGE_NEXT%></a> </span>
            <%} %>
            <%if (!(ViewData["page"] as Pager).IsLast)
              { %>
            <span><a href="javascript:changePage(<%=(ViewData["page"] as Pager).PageCount%>)"
                class="green">>></a></span>
            <%} %>
        </td>
    </tr>
    <%} %>
</table>
