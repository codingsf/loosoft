<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>文件下载菜单</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx }/js/nav.js"></script>
<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			//设置右边内容
			window.parent.document.getElementById("index").src="${ctx}/file/upload!down.action";
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
		};
		// ]]>
		</script>
</head>
<body>
<div id="my_menu" class="sdmenu">
<div class="collapsed"><span>文件下载</span> <a
	href="../file/upload!down.action" target="index">文件下载</a> 
</div>
</div>
</body>
</html>