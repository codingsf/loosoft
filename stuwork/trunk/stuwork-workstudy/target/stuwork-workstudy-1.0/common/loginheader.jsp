<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="org.springside.modules.security.springsecurity.SpringSecurityUtils"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="cn.loosoft.common.security.springsecurity.user.User"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.time.DateUtils"%>
<html>
<head>
	<link href="${ctx}/css/newpage.css" rel="stylesheet" type="text/css" />
	</head>
	<body style="background:url(${ctx}/images/login/header01.jpg) repeat-x;">
	<div class="header_mid01">
	  <div class="header_mid01l"><img src="${ctx}/images/login/logo05.jpg" width="640" height="90" /></div>
	  <div class="header_mid01r">
	    <table width="100%" height="21" border="0" cellpadding="0" cellspacing="0">
	      <tr>
	        <td width="45%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;hi,访客你好，欢迎登陆！</td>
	      </tr>
	    </table>
	  </div>
	</div>
	</body>
	</html>