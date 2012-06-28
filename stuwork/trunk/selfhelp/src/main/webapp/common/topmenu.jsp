<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ include file="/common/js.jsp" %>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
      $('#tabs1 > ul > li > a').click(function(){ 
		 $('#tabs1 > ul > li > a').removeClass('menudw');   
		 $(this).addClass('menudw');  
 		});
});
</script>
</head>
<body style="background:url(../images/login/menu01.jpg) repeat-x;">
<div id="tabs1" class="header_mid02">
  <ul>
  	<li><a href="infomenu.jsp" target="nav" title="个人信息" class="menudw">个人信息</a></li>
    <li><a href="newsmenu.jsp" target="nav" title="通知公告" >通知公告</a></li>
    <li><a href="archivesinfomenu.jsp" target="nav" title="档案信息" >档案信息</a></li>
    <li><a href="jobsmenu.jsp" target="nav" title="勤工信息" >勤工信息</a></li>
    <li><a href="${ctx}/leave/leave.action" target="nav" title="离校管理" >离校管理</a></li>
  </ul>
</div>
</body>
</html>
