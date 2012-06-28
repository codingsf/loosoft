<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>迎新网站管理</title>
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
			window.parent.document.getElementById("index").src="${ctx}/welnewlocale/schoolnotice.action";
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
    <div class="leftlist_ico">迎新现场</div>
    <div class="listbox">
      <div id="menudiv" class="listw">
        <ul>
        	 <!--  
	 	 	 <li><a href="../welnewlocale/welnewlocale.action" target="index">迎新流程</a></li>
	 	 	 -->
	 		 <li><a href="../../welnewlocale/cost.action" target="index">财务缴费</a></li>
	 		 <li><a href="../../welnewlocale/green.action" target="index">绿色通道</a></li>
	 		 <li><a class="listbgg" href="../../welnewlocale/schoolnotice.action" target="index">学院报道</a></li>
	 		 <li><a href="../../wuzi/give!input.action" target="index">现场发放</a></li>
	 		 <li><a href="../../welnewlocale/check.action" target="index">入学资格审查</a></li>
        </ul>
      </div>
      
      <div style="text-align:center; "><img src="../../images/login/bu_help.gif" width="169" height="47" /></div>
    </div>
  </div>
</div>
</body>
</html>	
