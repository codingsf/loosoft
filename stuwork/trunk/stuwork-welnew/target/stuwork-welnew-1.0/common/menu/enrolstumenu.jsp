<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>招生管理</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/js.jsp" %>
	<link href="../../css/newpage.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx }/js/nav.js" ></script>	
	<script type="text/javascript">
		// <![CDATA[
		var myMenu;
		window.onload = function() {
			//设置左边菜单选择时候变样
			$('#menudiv > ul > li > a').click(function(){ 
				$('#menudiv > ul > li > a').removeClass('listbgg');   
				$(this).addClass('listbgg');  
	 		});
			//设置右边内容
			window.parent.document.getElementById("index").src="${ctx}/noticeBook/notice-book.action";
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
		};
		// ]]>
		</script>
	</head>
	
<body style="background:#E3F1FA url(../../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_l">
  <div id="my_menu" >
    <div class="leftlist_ico">招生管理</div>
    <div class="listbox">
      <div id="menudiv" class="listw">
        <ul>
          <li><a class="listbgg" href="../../noticeBook/notice-book.action" target="index">通知书管理</a></li>
          <li><a href="../../noticeBook/report-notice.action" target="index">报到须知管理</a></li>
          <li><a href="../../student/notice.action" target="index">打印通知书</a></li>
        </ul>
        
      </div>
      <div style="text-align:center; "><img src="../../images/login/bu_help.gif" width="169" height="47" /></div>
    </div>
  </div>
</div>
</body>
</html>	
