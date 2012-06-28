<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link href="../css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
      $('#tabs1 > ul > li').click(function(){ 
		 $('#tabs1 > ul > li').removeClass('hover');   
		 $(this).addClass('hover');  
 		});
    });
</script>
</head>
<body class="subnav">
<div id="tabs1">
<ul>
<li><a href="jobsapplymenu.jsp" target="nav" title="岗位申请"><span>岗位申请</span></a></li>
<li><a href="infoquerymenu.jsp" target="nav" title="信息查询"><span>信息查询</span></a></li>
<li><a href="statusquerymenu.jsp" target="nav" title="状态查询"><span>状态查询</span></a></li>
<li><a href="filemenu.jsp" target="nav" title="文件下载"><span>文件下载</span></a></li>
</ul>
</div>
</body>
</html>
