<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
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
    <security:authorize ifAnyGranted="ROLE_勤工助学_新闻管理">
    <li><a class="menudw" href="newsmenu.jsp" target="nav" title="新闻管理" ><span>新闻管理</span></a></li>
    </security:authorize>
    <security:authorize ifAnyGranted="ROLE_勤工助学_单位管理">
	<li><a href="companymenu.jsp" target="nav" title="单位管理"><span>单位管理</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_用户管理">
	<li><a href="usermenu.jsp"  target="nav" title="用户管理"><span>用户管理</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_岗位申报">  
	<li><a href="jobapplymenu.jsp" target="nav" title="岗位设置"><span>岗位申报</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_岗位审核">
	<li><a href="jobpubmenu.jsp" target="nav" title="岗位审核"><span>岗位审核</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_岗位浏览">
	<li><a href="jobpubmenu.jsp" target="nav" title="岗位浏览"><span>岗位浏览</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_申请审核">
	<li><a href="checkmenu.jsp" target="nav" title="申请审核"><span>申请审核</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_申请复审">
	<li><a href="jobauditmenu.jsp" target="nav" title="用工审查"><span>申请复审</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_用工选择">
	<li><a href="chosemenu.jsp" target="nav" title="用工选择"><span>用工选择</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_工资核发">
	<li><a href="salarymenu.jsp" target="nav" title="工资核发"><span>工资核发</span></a></li>
	</security:authorize>
	<!--  
	<li><a href="evaluation.jsp" target="nav" title="考评管理"><span>考评管理</span></a></li>
	-->
    <security:authorize ifAnyGranted="ROLE_勤工助学_资料上传下载">
	<li><a href="uploaddownmenu.jsp" target="nav" title="资料上传下载"><span>资料上传下载</span></a></li>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_勤工助学_系统设置"> 
	<li><a href="sysmenu.jsp" target="nav" title="系统设置"><span>系统设置</span></a></li>
	</security:authorize> 
  </ul>
</div>
</body>
</html>
