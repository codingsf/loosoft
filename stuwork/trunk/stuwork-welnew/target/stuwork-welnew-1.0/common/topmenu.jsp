<%@ page language="java" pageEncoding="UTF-8"%>
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
    <li><a href="menu/batchmenu.jsp" target="nav" title="入学批次管理"><span>入学批次管理</span></a></li>
    <li><a href="menu/sysmenu.jsp" target="nav" title="系统管理"><span>系统管理</span></a></li>
    <li><a href="menu/sitemenu.jsp" target="nav" title="网站管理"><span>网站管理</span></a></li>
	<li><a href="menu/newstumenu.jsp" target="nav" title="学生信息管理"><span>新生信息管理</span></a></li>
	<li><a href="menu/enrolstumenu.jsp" target="nav" title="招生管理"><span>招生管理</span></a></li>	    
	<li><a href="menu/clazzmenu.jsp" target="nav" title="分班管理"><span>分班管理</span></a></li>
	<!--
	<li><a href="menu/regmenu.jsp" target="nav" title="新生注册"><span>新生注册</span></a></li>
	-->
	<!--
	<li><a href="menu/stunomenu.html"  target="nav" title="学籍管理"><span>学号分配管理</span></a></li>
	-->
	<li><a href="menu/roommenu.jsp" target="nav" title="寝室分配"><span>寝室分配</span></a></li>
	<li><a href="menu/wuzimenu.jsp" target="nav" title="发放管理"><span>发放管理</span></a></li>
	<li><a href="menu/devolvermenu.jsp" target="nav" title="转移登记"><span>转移登记</span></a></li>	
	<!--
	<li><a href="menu/residencemenu.jsp" target="nav" title="户籍管理"><span>户籍管理</span></a></li>
	-->
	<li><a class="menudw" href="menu/welnewlocalemenu.jsp" target="nav" title="迎新现场"><span>迎新现场</span></a></li>
	<li><a href="menu/querycountmenu.jsp" target="nav" title="查询统计"><span>查询统计</span></a></li>
  </ul>
</div>
</body>
</html>
