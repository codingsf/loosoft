<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>信息查询菜单</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx }/js/nav.js"></script>
<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			//设置右边内容
			window.parent.document.getElementById("index").src="${ctx}/news/news.action";
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
		};
		// ]]>
		</script>
</head>
<body>
<div id="my_menu" class="sdmenu">
<div class="collapsed"><span>信息查询</span> 
	<a href="../news/news.action" target="index">新闻查询</a> 
	<a href="../query/salary-query.action" target="index">工资查询</a> 
	<a href="../query/student-apply-jobs.action" target="index">入职岗位</a></div>
</div>
</body>
</html>