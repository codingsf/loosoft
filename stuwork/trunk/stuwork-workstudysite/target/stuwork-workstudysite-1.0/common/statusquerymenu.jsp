<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>状态查询菜单</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx }/js/nav.js"></script>
<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			//设置右边内容
			window.parent.document.getElementById("index").src="${ctx}/query/student-check-query.action";
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
		};
		// ]]>
		</script>
</head>
<body>
<div id="my_menu" class="sdmenu">
<div  class="collapsed">    
	 <span>状态查询</span> 
	 <!-- 
	 <a href="../query/jobs-check-query.action" target="index">岗位审批进度查询</a>
	 -->
	 <a href="../query/student-check-query.action" target="index">申请审批进度查询</a>
</div>  
</div>
</body>
</html>