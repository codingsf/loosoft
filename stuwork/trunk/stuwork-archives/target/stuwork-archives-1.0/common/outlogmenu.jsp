<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>调出管理菜单</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/js.jsp" %>
	<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
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
			window.parent.document.getElementById("index").src="${ctx}/outlog/outlog.action";
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
	
		};
		// ]]>
		</script>
	</head>

<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_l">
  <div>
    <div class="leftlist_ico">批次管理</div>
    <div class="listbox">
      <div id="menudiv" class="listw">
        <ul>
          <li><a class="listbgg" href="../outlog/outlog.action" target="index">调出管理</a></li>
          <li><a href="../outlog/outarchives.action" target="index">调出记录</a></li>
            <li><a href="../outlog/outback.action" target="index">调出撤销</a></li>
          <li><a href="../outlog/outlog!outRecord.action" target="index">调出回执录入</a></li>
        </ul>
      </div>
      <div style="text-align:center; "><img src="../images/login/bu_help.gif" width="169" height="47" /></div>
    </div>
  </div>
</div>
</body>
</html>