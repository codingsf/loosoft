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
	<link href="../css/main.css" rel="stylesheet" type="text/css" />
	</head>
	<body id="head">
	<div id="headrt">
	  <div id="headlf"></div>
	  <div style="float:left; padding-top: 30px;padding-right: 10px;">
	  &nbsp;
	  <%if(!"anonymousUser".equals(SpringSecurityUtils.getCurrentUserName())&&!"".equals(SpringSecurityUtils.getCurrentUserName())){%>
		<span class="status">
		欢迎：
		<%
		User user = (User)SpringSecurityUtils.getCurrentUser();
		request.setAttribute("name",user.getName());
		%>
		${name}
		&nbsp;&nbsp;
		<a href="${ctx }/logout" target="_parent">注销</a>&nbsp;&nbsp;
		</span>
	  <%}%>
	  </div>
	  </div>
	</body>
</html>
