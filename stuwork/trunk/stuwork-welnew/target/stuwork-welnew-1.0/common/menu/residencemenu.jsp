<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>户籍登记菜单</title>
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
 	 <span>户籍管理</span> 
 	 	 <a href="../../residence/residence!input.action" target="index">户籍迁入</a> 
 		 <a href="../../residence/importhuji.action" target="index">批量导入</a>
 		 <a href="../../residence/residence.action" target="index">户籍浏览</a> </div>
</div>
</body>
</html>