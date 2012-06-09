<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ include file="/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>欢迎进入智搜学生综合管理平台</title>
<link href="css/landt.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/png" href="images/stuworkico.ico"/>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onload="MM_preloadImages('images/login/l/sy01.gif','images/login/l/sy02.gif','images/login/l/sy03.gif','images/login/l/sy04.gif','images/login/l/sy05.gif','images/login/l/sy06.gif','images/login/l/sy07.gif','images/login/l/sy08.gif','images/login/l/sy09.gif','images/login/l/sy010.gif')">
<div id="total_box">
<div id="total_box01"></div>
<div id="total_box02">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="100"><a href="<common:prop name="cas.securityContext.casProcessingFilterEntryPoint.loginUrl" propfilename="application.properties"/>?service=<common:prop name="stuwork-welnew.service" propfilename="application.properties"/>"" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','images/login/l/sy01.gif',1)"><img src="images/login/l/sy1.gif" name="Image1" width="148" height="89" border="0" id="Image1" /></a></td>
      <td><a href="<common:prop name="cas.securityContext.casProcessingFilterEntryPoint.loginUrl" propfilename="application.properties"/>?service=<common:prop name="stuwork-archives.service" propfilename="application.properties"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','images/login/l/sy02.gif',1)">
      <img src="images/login/l/sy2.gif" name="Image2" width="148" height="89" border="0" id="Image2" /></a></td>
      <td><a href="<common:prop name="cas.securityContext.casProcessingFilterEntryPoint.loginUrl" propfilename="application.properties"/>?service=<common:prop name="stuwork-stuinfo.service" propfilename="application.properties"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','images/login/l/sy03.gif',1)"><img src="images/login/l/sy3.gif" name="Image3" width="178" height="87" border="0" id="Image3" /></a></td>
      <td><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','images/login/l/sy04.gif',1)"><img src="images/login/l/sy4.gif" name="Image4" width="178" height="89" border="0" id="Image4" /></a></td>
      <td><a href="<common:prop name="leave" propfilename="application.properties"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image5','','images/login/l/sy05.gif',1)"><img src="images/login/l/sy5.gif" name="Image5" width="188" height="87" border="0" id="Image5" /></a></td>
    </tr>
    <tr>
      <td height="100"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image6','','images/login/l/sy06.gif',1)"><img src="images/login/l/sy6.gif" name="Image6" width="148" height="89" border="0" id="Image6" /></a></td>
      <td><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image7','','images/login/l/sy07.gif',1)"><img src="images/login/l/sy7.gif" name="Image7" width="148" height="89" border="0" id="Image7" /></a></td>
      <td><a href="<common:prop name="cas.securityContext.casProcessingFilterEntryPoint.loginUrl" propfilename="application.properties"/>?service=<common:prop name="stuwork-workstudy.service" propfilename="application.properties"/>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image8','','images/login/l/sy08.gif',1)"><img src="images/login/l/sy8.gif" name="Image8" width="178" height="89" border="0" id="Image8" /></a></td>
      <td><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image9','','images/login/l/sy09.gif',1)"><img src="images/login/l/sy9.gif" name="Image9" width="178" height="89" border="0" id="Image9" /></a></td>
      <td><a href="${ctx}/back.action" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image10','','images/login/l/sy010.gif',1)"><img src="images/login/l/sy10.gif" name="Image10" width="188" height="89" border="0" id="Image10" /></a></td>
    </tr>
  </table>
  
  <div style="padding-top:40px; text-align:center;"><a href="<common:prop name="cas.securityContext.logoutUrl" propfilename="application.properties"/>?from=<common:prop name="backmanage.webapp.url" propfilename=""/>/enter.action"><img src="images/outsy.jpg" border="0"/></a></div>
  <!--
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="100"><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','images/login/l/sy01.gif',1)"><img src="images/login/l/sy1.gif" name="Image1" width="148" height="89" border="0" id="Image1" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','images/login/l/sy02.gif',1)">
      <img src="images/login/l/sy2.gif" name="Image2" width="148" height="89" border="0" id="Image2" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image3','','images/login/l/sy03.gif',1)"><img src="images/login/l/sy3.gif" name="Image3" width="178" height="87" border="0" id="Image3" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','images/login/l/sy04.gif',1)"><img src="images/login/l/sy4.gif" name="Image4" width="178" height="89" border="0" id="Image4" /></a></td>
      <td><a href="<common:prop name="leave" propfilename="application.properties"/>" target="_blank" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image5','','images/login/l/sy05.gif',1)"><img src="images/login/l/sy5.gif" name="Image5" width="188" height="87" border="0" id="Image5" /></a></td>
    </tr>
    <tr>
      <td height="100"><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image6','','images/login/l/sy06.gif',1)"><img src="images/login/l/sy6.gif" name="Image6" width="148" height="89" border="0" id="Image6" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image7','','images/login/l/sy07.gif',1)"><img src="images/login/l/sy7.gif" name="Image7" width="148" height="89" border="0" id="Image7" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image8','','images/login/l/sy08.gif',1)"><img src="images/login/l/sy8.gif" name="Image8" width="178" height="89" border="0" id="Image8" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image9','','images/login/l/sy09.gif',1)"><img src="images/login/l/sy9.gif" name="Image9" width="178" height="89" border="0" id="Image9" /></a></td>
      <td><a href="javascript:void(0)" onclick="alert('改系统功能暂未开通,请联系软件提供商！')" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image10','','images/login/l/sy010.gif',1)"><img src="images/login/l/sy10.gif" name="Image10" width="188" height="89" border="0" id="Image10" /></a></td>
    </tr>
  </table>
  -->
</div>
</div>
</body>
</html>