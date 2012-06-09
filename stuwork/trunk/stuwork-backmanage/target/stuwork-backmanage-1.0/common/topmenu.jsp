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
    <li><a class="menudw" href="batchmenu.jsp" target="nav" title="批次处理" >批次处理</a></li>
    <li><a href="schoolmenu.jsp" target="nav" title="学校基础数据处理" >学校基础数据处理</a></li>
    <li><a href="usermenu.jsp" target="nav" title="用户管理" >用户管理</a></li>
  </ul>
</div>
</body>
</html>
