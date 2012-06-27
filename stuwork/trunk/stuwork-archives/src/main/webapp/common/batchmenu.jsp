<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>迎新批次设置</title>
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
 	 <span>迎新批次设置</span> 
 	 	 <a class="hover" href="../batch/welbatch.action" target="index">批次浏览</a> 
 	 	 <a href="../batch/welbatch!input.action" target="index">批次新增</a>
  </div>
</div>
</body>
</html>