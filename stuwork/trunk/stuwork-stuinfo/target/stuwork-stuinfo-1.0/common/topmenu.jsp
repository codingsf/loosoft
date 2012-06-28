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
    <li><a class="menudw" href="batchmenu.jsp" target="nav" title="批次管理">批次管理</a></li>
    <li><a href="basicinfomenu.jsp" target="nav" title="学生基础信息管理">学生基础信息管理</a></li>
    <li><a href="rollinfomenu.jsp" target="nav" title="学生学籍信息管理">学生学籍信息管理</a></li>
  </ul>
</div>
</body>
</html>

