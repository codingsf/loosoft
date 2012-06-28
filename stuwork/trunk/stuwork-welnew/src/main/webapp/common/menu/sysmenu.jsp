<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>系统管理</title>
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
			window.parent.document.getElementById("index").src="${ctx}/sys/extenditem.action";
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
    <div class="leftlist_ico">项目设置</div>
    <div class="listbox">
      <div id="menudiv" class="listw">
        <ul>
         <li><a class="listbgg" href="../../sys/extenditem.action" target="index">发放项目设置</a></li>
	 	 <li><a href="../../sys/devolveitem.action" target="index">转移项目设置</a></li>
	 	 <li><a href="../../sys/checkitem.action" target="index">审查项目设置</a></li>
	 	 <li><a href="../../sys/costitem.action" target="index">缴费项目设置</a></li>
	 	 <li><a href="../../sys/turnoveritem.action" target="index">上缴项目设置</a></li>
	 	 <li><a href="../../sys/importclass.action" target="index">银行数据导入</a></li>
        </ul>
      </div>
    </div>
    
    <div class="leftlist_ico">系统字典</div>
    <div class="listbox">
      <div class="listw">
        <ul>
         	 <li><a href="../../sys/registertime!input.action" target="index">报到设置</a></li>
	 		 <li><a href="../../sys/sysdata.action" target="index">来校方式</a></li>
	 	     <li><a href="../../sys/stuno!input.action" target="index">学号设置</a></li>
	 	     <li><a href="../../sys/logdata.action" target="index">操作日志</a></li>
        </ul>
      </div>
      <div style="text-align:center; "><img src="../../images/login/bu_help.gif" width="169" height="47" /></div>
    </div>
    
    
  </div>
</div>
</body>
</html>	
