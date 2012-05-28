<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title> 
</head>

<body style="background:#F5F5F5 url(/m_img/index_bg.jpg) top repeat-x;">
<div style="width:320px; margin:0px auto;">
<div style="padding:30px 0px 10px 0px;"><img src="/m_img/logo.gif" width="244" height="54" /></div>
<div style="padding:25px 0px 10px 0; font-size:14px;">
      
        <% using (Html.BeginForm("login", "wap", FormMethod.Post))
           {%>
  <table width="258" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2">
    <font color="red" size="2"><%=ViewData["error"]==null?string.Empty:ViewData["error"] %></font>
</td>
</tr>
    <tr>
      <td width="33%" height="40">Username</td>
      <td width="67%" align="right"><%=Html.TextBox("username", string.Empty, new { @class="syy"})%></td>
    </tr>
    <tr>
      <td height="40">Password</td>
      <td align="right"><%=Html.Password("password", string.Empty, new { @class = "syy" })%></td>
    </tr>
    <tr>
      <td height="40" colspan="2"><table width="258" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="66%"> </td>
          <td width="34%" align="right">
          
          <input type="image" value="" src="/m_img/loginbu.gif"  width="65" height="21" />
          
          
          
          
          </td>
        </tr>
      </table></td>
      </tr>
  </table>
  <%} %>
</div>
<div style="height:95px; padding:40px 0 0 0px;">
<div style="width:70px;float:left;"><img src="/m_img/ico01.gif" width="59" height="64" /></div>
<div style="float:left;">
<span style="font-size:24px; font-weight:bold; line-height:35px;">Example Plants </span>
<div style="background:url(/m_img/ico02.gif) no-repeat; padding-left:15px;"><a href="/wap/example/" style="font-size:14px; color:#2D6922;">Click view</a></div>
</div>
</div>
</div>
<div style="clear:both;"> </div>
<div style="font-size:12px;color:#ADDCA0; text-align:center; background:url(/m_img/footerbg.jpg); height:22px; line-height:20px;">Copyright @ 2011 SolarInfo Bank</div>
</body>
</html>
