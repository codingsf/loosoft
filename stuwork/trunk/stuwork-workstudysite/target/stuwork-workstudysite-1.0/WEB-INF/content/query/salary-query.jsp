<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生工资查询</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
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

			$("#queryButton").click();
			
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
	    }); 
	-->
	</script>
</head>
<body>
<div class="xzwz">
<h1>我的工资</h1>
</div>
<form id="searchForm" action="${ctx}/query/salary-query!list.action" method="post">
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" /> 
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}" /> 
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success" /></div>
<table class="tbhs" width="95%">
	<tr>
		<th>姓名</th>
		<th>学号</th>
		<th>岗位</th>
		<th>单位名称</th>
		<th>工作开始时间</th>
		<th>工作结束时间</th>
		<th>工作时长</th>
		<th>工资标准</th>
		<th>工资</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result">
		<tr>
			<td>${studentName }</td>		
			<td>${studentNo}</td>
		    <td>${postName}&nbsp;</td>
		    <td>${companyName}&nbsp;</td>
			<td><fmt:formatDate value="${workStartTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
			<td><fmt:formatDate value="${workStopTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
	        <td>${workTime}</td>
	        <td>${standard}&nbsp;</td>
	        <td>${amount}&nbsp;</td>
			<td>
			 <a href="${ctx}/query/salary-query!detail.action?id=${id}">查看</a>
			</td>
		</tr>
	</s:iterator>
</table>
<%@ include file="/common/turnpage.jsp"%>
</body>
</html>