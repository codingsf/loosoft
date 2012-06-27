<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案归档列表</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<%@ include file="/common/meta.jsp"%>

<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript">
	<!--
	    $(document).ready(function(){
	         $("#queryButton").click(function(){
	                var helloDivObj = $("#filter");   
	                var buttonObj = $("#queryButton");   
	                var val = buttonObj.text();
	               if(val=="隐藏查询"){
	                    helloDivObj.hide(); 
	                    buttonObj.text("显示查询");  
	                }else{   
	                    helloDivObj.show();  
	                    buttonObj.text("隐藏查询"); 
	                }   
	          });
	          
	        
		 		
			$("#delbut").click(
			   function(){
			       if($("input:checked").length==0) {
			            alert("没有可删除记录,请勾选");
			            return false;
			       } 
			       if(!confirm('您确定要删除吗?')) return  false;
	
				   $("#deleteForm").submit();
			 });  
			 
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});

	
	    }); 
	-->
	</script>
</head>
<body>
<div class="caozuo">
<ul>
    <li><a href="#" id="delbut"><span>删除</span></a></li>
	<li><a><span id="queryButton">显示查询</span></a></li>
</ul>
</div>

<form id="searchForm" action="${ctx}/lendlog/lend-log!list.action"
	method="post">
<div id="filter" class="fenye" style="display: none">

  <h3>
          学号：<input type="text" name="filter_EQS_stuId" /> <span class="btn2"><a href="javascript:void(0);" id="mainformsearch"
	title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);"
	id="mainformreset" href="javascript:search();" title="重置查询条件"><span>重置查询条件</span></a></span>
<input type="reset" style="display: none;" id="resetbutton" />
  </h3>
<div class="clear"></div>
</div>
    <input type="hidden" name="page.pageNo" id="pageNo"value="${page.pageNo}" /> 
    <input type="hidden" name="page.orderBy"id="orderBy" value="${page.orderBy}" />
    <input type="hidden"name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom"cssClass="success" /></div>
<table class="tbhs" width="95%">
	<tr>
	<th class="wid10px"><label> <input type="checkbox"
			id="checkboxall" /> </label></th>
		<th>编号</th>
		<th>学号</th>
		<th>经办人</th>
		<th>归档时间</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result" status="i">
		<tr>
			<td><input type="checkbox" id="ids" name="ids" value="${id }" /></td>
			<td>${i.index+1}</td>
			<td>${stuId}</td>
			<td>${operater}</td>
			<td><fmt:formatDate value="${returnDate}" type="date" pattern="yyyy-MM-dd HH:mm" /></td>
			<td><a href="${ctx}/returnlog/return-log!detail.action?stuNo=${stuId}">详情</a></td>
		</tr>
	</s:iterator>
</table>
<div><jsp:include page="/common/turnpage.jsp"></jsp:include></div>
</body>
</html>