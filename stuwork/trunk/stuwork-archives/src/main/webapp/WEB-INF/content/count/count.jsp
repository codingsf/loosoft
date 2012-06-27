<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>档案统计</title>
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
			 $("#mainformsearch").click(function(){
				$("#searchForm").submit();
				 });
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
			$("#mainformsearch").click(function(){
				$("#searchForm").submit();
				});
		   $("#queryButton").click();
		   
		   $("#printexcel").click(function(){
				document.getElementById("searchForm").action="count!printExcel.action";
				document.getElementById("searchForm").submit();
			});
	    }); 
	-->
	</script>
	<script>
function cc(){
	document.getElementById("searchForm").action="count!list.action";
	document.getElementById("searchForm").submit();
}
	</script>
</head>
<body onkeydown="if (event.keyCode==13) {$('#searchForm').submit();}">
<div class="xzwz">
<h1>档案统计</h1>
</div>
<div class="caozuo">
<ul>
	<li><a><span id="queryButton">显示查询</span></a></li>
</ul>
</div>
<form id="searchForm" action="${ctx}/count/count!list.action"
	method="post"><input type="hidden" name="tempPageNo" id="pageNo"
	value="${pageNo}" />
<div id="filter" class="fenye" style="display: none;">
<h3>
           院系:<s:select id="collegeselect" theme="simple" list="colleges" listKey="code" listValue="name" name="filter_EQS_collegeCode" headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode" /> 
           专业:<s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode" headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode" /> 
           班级:<s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode" headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode" /> 
           档案状态:<s:select id="archiveType" theme="simple" list="archiveType" listKey="value" listValue="label" name="filter_EQS_status" headerKey="" headerValue="请选择" value="#parameters.filter_EQS_status" /> 
           显示个数:<s:select id="clazzselect" theme="simple" list="selectPageList" listKey="value" listValue="label" name="filter_EQS_pageCode" headerKey="" headerValue="请选择" value="#parameters.filter_EQS_pageCode" /> 
 
           入学时间:<input name="inDate" id="inDate" value="${param.inDate}" type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
           毕业时间:<input name="period" id="period" value="${param.period}" type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
    <br/>
    <br/>
    <span class="btn2"><a href="javascript:search();"   title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);" id="mainformreset" href="javascript:search();" title="重置查询条件"><span>重置查询条件</span></a></span>
    <input type="reset" style="display:none;" id="resetbutton"/>
</h3>
</div>
</form>
<br />
<form action="${ctx}/count/count!list.action" method="post"
	id="deleteForm">
<div style="border: solid 1px white;">
<table class="tbhs" width="95%">
	<tr>
		<th>学院</th>
		<th>专业</th>
		<th>班级</th>
		<th>状态</th>
		<th>人数</th>
	</tr>
	<s:iterator value="tempList" status="stat" var="archivesVO">
		<tr>
			<td>${archivesVO.collegeName }</td>
			<td>${archivesVO.majorName}</td>
			<td>${archivesVO.className}</td>
			<td>${archivesVO.status }</td>
			<td>${archivesVO.classCount}</td>
		</tr>
	</s:iterator>
</table>
</div>

<%@ include file="/common/commonPage.jsp"%></form>
<c:set value="[]" var="temp"></c:set>
<c:if test="${tempList ne temp}">
	<div><span style="color: red;">${actionMessage }</span> <input
		type="button" id="printexcel" value="导出Excel"> &nbsp;&nbsp;
	</div>
</c:if>
</body>
</html>