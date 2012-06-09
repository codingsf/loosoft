<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>学生基础数据设置</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
	<script type="text/javascript" src="${ctx }/js/nav.js" ></script>	
	<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
		};
		// ]]>
		</script>
	</head>
<body >
<div id="my_menu" class="sdmenu">
  <div  class="collapsed"> 
 	 <span>学生基础数据设置</span> 
 	 	 <a href="../student/set-item.html" target="index">学生基础数据设置</a> 
 	 	 <a href="../student/import-student.html" target="index">导入学生信息</a> 
 	 	 <a href="../student/syn-student.html" target="index">学生基础信息显示</a> 
  </div>
</div>
</body>
</html>