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
<div class="mainbox01">
<div class="top">
<div class="fl02">Energy Chart</div>
<div class="fr02"><a href="/wap/overview/?sid=<%=Session.SessionID %>" class="fra"><%=Resources.SunResource.MOBILE_BUTTON_BACK%></a></div>

</div>
<div class="chart">
<div class="chart01"></div>
<div class="chart02">
<div>
<div class="charttab">
<ul>
<li class="tab01"><a href="#">Month</a></li>
<li class="tab02"><a href="#">Year</a></li>
<li class="tab02"><a href="#">Total</a></li>
</ul>
</div>
</div>
<div class="chart02_m">

  <table width="150" border="0" align="center" cellpadding="0" cellspacing="0" class="dateb">
    <tr>
      <td width="19"><a href="#"><img src="/m_img/ico05.jpg" border="0" /></a></td>
      <td width="107"><input name="textfield" type="text" class="xsy" value="20110624" /></td>
      <td width="51"><a href="#"><img src="/m_img/ico06.jpg" width="30" height="19" border="0" /></a></td>
      <td width="21"><a href="#"><img src="/m_img/ico07.jpg" border="0" /></a></td>
    </tr>
  </table>
</div>

<div class="chart02_img"><img src="/m_img/img/img02.gif" width="275" height="210" /></div>
</div>
<div class="chart03"></div>
</div>
</div>
<%--<div class="lbgtop">
<div class="logslbg">
<div class="logslist">
<div class="logslist_l">
<span class="fl">All logs:</span>
<span class="fr">18</span></div>
<div class="logslist_r"><a href="#"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></div>
</div>
</div>
<div class="logslbg">

  <div class="logslist">
    <div class="logslist_l"> <span class="fl">All logs:</span> <span class="fr">18</span></div>
    <div class="logslist_r"><a href="#"><img src="/m_img/ico03.gif" width="9" height="13" border="0" /></a></div>
  </div>
</div>
</div>--%>
</body>
</html>
