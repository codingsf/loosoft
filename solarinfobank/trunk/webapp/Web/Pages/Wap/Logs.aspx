<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.Fault>>" %>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
<title></title> 
<link href="/css/wap.css" rel="stylesheet" type="text/css" />
</head>


<body>
<div>
<div class="mainbox01">
  <div class="top">
    <div class="fl02"><%=Resources.SunResource.SHARED_USERMASTERPAGE_LOGS%></div>
    <div class="fr02"><a class="fra" href="/wap/poverview/?sid=<%=Session.SessionID %>&pid=<%=Request.QueryString["pid"] %>&t=d&date=<%=DateTime.Now.ToString("yyyy-MM-dd") %>"><%=Resources.SunResource.MOBILE_BUTTON_BACK%> </a></div>
  </div>
</div>
</div>
<div>


     <%if (Model != null && Model.Count > 0)
         { %>
<% foreach (var item in Model)
   { %>
   <div class="loglist">
  <div class="loglist01">
    <div class="loglist01_l"><img src="/m_img/ico09.png" width="25" height="25" /></div>
    <div class="loglist01_r">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="f16"><strong><%=item.device.typeName%></strong></td>
          <td class="f16"><%=item.content%></td>
        </tr>
        <tr>
          <td class="fli12"><%=item.device.xinhaoName%></td>
          <td class="fli12"><%=item.address%></td>
        </tr>
        <tr>
          <td colspan="2" class="fli12"><%=item.sendTime%></td>
        </tr>
      </table>
    </div>
  </div>
</div>
                  
    <%} %>
    <%}
         else
         { %>
<div style="text-align:center; padding:60px 0; margin:0 auto; font-size:18px; font-weight:bold;"><%=Resources.SunResource.NODATA%></div>
        
         <%} %>
         
         
      
</div>
</body>
</html>

