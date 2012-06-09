<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ include file="/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="javascript">
window.onload = function(){
	
		var urlinfo=window.location.href;
		
		var len=urlinfo.length;//获取url的长度
		var offset=urlinfo.indexOf("?");//设置参数字符串开始的位置
		var newsidinfo=urlinfo.substr(offset,len);
		var newsids=newsidinfo.split("=");
		//document.getElementById("username").value=newsids[1];
		//document.getElementById("form1").submit();
	
}
</script>
<title>学工系统管理后台</title>
</head>
<frameset rows="90,34,*,60" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame name="top" id="top" scrolling="no" noresize
		src="common/header.jsp" frameborder="0"></frame>
	<frame name="subnav" id="subnav" scrolling="no" noresize
		src="common/topmenu.jsp" frameborder="0"></frame>

	
	<frameset rows="*" cols="26%,*" frameborder="no" border="0" framespacing="0" id="frame2"> 

        <frame name="nav" id="nav" scrolling="no" noresize src="common/batchmenu.jsp" frameborder="0"></frame>

		<frame name="index" id="index" scrolling="auto" src="batch/batch.action"	frameborder="0"></frame>

	</frameset>
	<frame name="footer" id="footer" scrolling="no" noresize src="common/footer.jsp" frameborder="0"></frame>
</frameset>
<body>
</body>
</html>

