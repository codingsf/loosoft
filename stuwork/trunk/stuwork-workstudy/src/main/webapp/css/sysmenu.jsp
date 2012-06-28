<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>合肥市政协委员参政议政交互平台</title>
	<link href="../images/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../images/nav.js">	</script>
	<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			myMenu = new SDMenu("my_menu");
			myMenu.init();
		};
		// ]]>
		</script>
	</head>
<body >
<div id="my_menu" class="sdmenu">
  <div  class="collapsed"> 
 	 <span>用户管理</span> 
 	 	 <a href="${ctx}/common/user/list.html" target="index">用户信息</a> 
 		 <a href="${ctx}/common/group/list.html" target="index">群组管理</a>
  </div> 
  <div class="collapsed"> 
  	<span>参数管理</span> 
   		 <a href="sllkz.htm" target="index">时流量控制</a> 
     	<a href="cfsjsz.htm" target="index">重发时间设置</a> 
   </div>
  <div class="collapsed"> 
  	<span>日志管理</span> 
    	<a href="dlrz.htm" target="index">登录日志</a> 
        <a href="czrz.htm" target="index">操作日志</a> 
   </div>
</div>
</body>
</html>