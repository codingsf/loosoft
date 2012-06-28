<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>查询统计菜单</title>
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
			myMenu = new SDMenu("my_menu");
			myMenu.init();
			myMenu.expandAll();
			//设置右边内容
			window.parent.document.getElementById("index").src="${ctx }/query/newstudent.action";
		};
		// ]]>
		</script>
	</head>
	
<body style="background:#E3F1FA url(../../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_l">
  <div id="my_menu" >
    <div class="leftlist_ico">查询统计</div>
	    <div class="listbox">
	      <div id="menudiv" class="listw">
	        <ul>
	          <li><a class="listbgg" href="../../query/newstudent.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">新生报到查询</a></li>
	 	 	  <li><a href="../../query/newstudentpayment.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">新生缴费查询</a></li>
	 	 	  <li><a href="../../query/abnormal.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">异常缴费查询</a></li>
	 	 	  <li><a href="../../query/remittance.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">银行汇款查询</a></li>
	 	 	  <li><a href="../../query/confirm.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">学院确认查询</a></li>
	 	 	  <!--
	 	 	  <li><a href="../../query/transfer.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">转移登记查询</a></li>
	 	 	  --> 
	 	 	  <li><a href="../../query/check.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">入学资格审查查询</a></li>
	 	 	  <li><a href="../../query/give.action?filter_EQL_student$welbatch$id=${curWelbatch.id}" target="index">发放查询</a></li>
	 	 	  <li><a href="../../count/register.action" target="index">网上报到统计</a></li>
	 	 	  <li><a href="../../count/studentreport.action" target="index">新生报到统计</a></li>
	 	 	  <li><a href="../../count/tuition.action" target="index">学费统计</a></li>
	 	 	  <!--
	 	 	  <li><a href="../../student/attendence!list.action" target="index">费用缓交统计</a></li>
	 	 	  -->
	 	 	  <li><a href="../../student/attendence!elist.action" target="index">异常缴费统计</a></li>
	 	 	  <li><a href="../../count/devolvereport.action" target="index">转移记录统计</a></li> 
	 	 	  <li><a href="../../count/check.action" target="index">入学资格审核统计</a></li> 
	 	 	  <li><a href="../../count/givecount.action" target="index">发放统计</a></li>  
	        </ul>
	      </div>
	      <div style="text-align:center; "><img src="../../images/login/bu_help.gif" width="169" height="47" /></div>
	    </div>
    </div>
</div>
</body>
</html>		
