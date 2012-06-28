<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生申请岗位查询</title>
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
<h1>学生申请岗位查询</h1>
</div>

<table class="tbhs" width="95%">
	<tr>
		<th>姓名</th>
		<th>学号</th>
		<th>申请岗位</th>
		<th>申请时间</th>
		<th>小组审核状态</th>
		<th>中心审核状态</th>
	    <th>用工单位是否选择</th>
		<th>操作</th>
	</tr>
	
	<s:iterator value="studentJobsDTOs">
		<tr>
			<td>${studentName}</td>		
			<td>${studentNo}</td>
			<td>${jobsName}&nbsp;</td>
			<td><fmt:formatDate value="${applyDate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
	        <td>${groupStatusDesc}&nbsp;</td>
	        <td>${centerStatusDesc}&nbsp;</td>
	        <td>${choseDesc}&nbsp;</td>
			<td>
			 <a href="${ctx}/jobs/student-apply-jobs!detail.action?id=${id}">查看</a>
			</td>
		</tr>
	</s:iterator>
</table>
</body>
</html>