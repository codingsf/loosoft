<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>注册登记菜单</title>
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
 	 <span>新生注册登记</span> 
 	 	 <a href="../../student/reg.action" target="index">注册登记</a> 
 	 	 <!-- 
 		 <a href="../student/reg-list.action" target="index">注册清单</a>
 		 -->
  </div>   
</div>
</body>
</html>