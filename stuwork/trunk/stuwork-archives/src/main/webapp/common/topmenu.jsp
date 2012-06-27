<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
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
    <li><a class="menudw" href="archivesmenu.jsp" target="nav" title="档案查询">档案查询</a></li>
    <li><a href="lendmenu.jsp" target="nav" title="调阅管理">调阅管理</a></li>
    <li><a href="stuArchivesmenu.jsp" target="nav" title="入库管理">入库管理</a></li>    
    <li><a href="outlogmenu.jsp" target="nav" title="调出管理">调出管理</a></li>
    <li><a href="changelogmenu.jsp" target="nav" title="变更管理">变更管理</a></li>
    <li><a href="countmenu.jsp" target="nav" title="档案统计">档案统计</a></li>  
    <li><a href="storemenu.jsp" target="nav" title="档案柜管理">档案柜管理</a></li>
    <li><a href="sysmenu.jsp" target="nav" title="系统设置">系统设置</a></li>
  </ul>
</div>
</body>
</html>


