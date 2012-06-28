<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ include file="/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>勤工助学系统_前台</title>
</head>
<frameset rows="78,40,*,10" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame name="top" id="top" scrolling="no" noresize
		src="common/header.jsp" frameborder="0"></frame>
	<frame name="subnav" id="subnav" scrolling="no" noresize
		src="common/topmenu.jsp" frameborder="0"></frame>
	<frameset rows="*" cols="180,*" frameborder="no" border="0"
		framespacing="0" id="frame2">
		<frame name="nav" id="nav" scrolling="auto" noresize
			src="common/jobsapplymenu.jsp" frameborder="0"></frame>
		<frame name="index" id="index" scrolling="yes" src="jobs/jobs-apply.action"
			frameborder="0"></frame>
	</frameset>
</frameset>
<body>
</body>
</html>

