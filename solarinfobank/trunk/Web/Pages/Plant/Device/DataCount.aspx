<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Resources.SunResource.PLANT_POWER_COUNT_DATA %> </title>
</head>
<body>			   
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="color:#525252">
    <tr>
      <td width="8%" height="24" bgcolor="#F2F4E1" class="line_b">&nbsp;</td>
      <td width="7%" height="24" bgcolor="#F2F4E1" class="line_b"><%=Resources.SunResource.PLANT_POWERCOUNT_MAX %></td>
      <td width="7%" height="24" bgcolor="#F2F4E1" class="line_b"><%=Resources.SunResource.PLANT_POWERCOUNT_DATA_TIME %></td>
    </tr>
    <tr>
      <td height="22" class="line_b"><%=Resources.SunResource.PLANT_OVERVIEW_DAY%></td>
      <td class="line_b"><%=ViewData["dayddc"] ==null?0:(ViewData["dayddc"] as DeviceDataCount).maxValue%></td>
      <td class="line_b"><%=ViewData["dayddc"] == null ? "" : (ViewData["dayddc"] as DeviceDataCount).maxTime.ToString()%></td>
    </tr>
    <tr>
      <td height="22" class="line_b"><%=Resources.SunResource.PLANT_OVERVIEW_MONTH%></td>
      <td class="line_b"><%=ViewData["monthddc"] == null ? 0 : (ViewData["monthddc"] as DeviceDataCount).maxValue%></td>
      <td class="line_b"><%=ViewData["monthddc"] == null ? "" : (ViewData["monthddc"] as DeviceDataCount).maxTime.ToString()%></td>
    </tr>
    <tr>
      <td height="22" class="line_b"><%=Resources.SunResource.PLANT_OVERVIEW_YEAR%></td>
      <td class="line_b"><%=ViewData["yearddc"] == null ? 0 : (ViewData["yearddc"] as DeviceDataCount).maxValue%></td>
      <td class="line_b"><%=ViewData["yearddc"] == null ? "": (ViewData["yearddc"] as DeviceDataCount).maxTime.ToString()%></td>
    </tr>                   
  </table>
</body>
</html>
