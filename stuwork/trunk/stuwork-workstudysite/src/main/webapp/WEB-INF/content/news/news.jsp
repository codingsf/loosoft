<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻列表</title>
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
<div class="xzwz">
<h1>新闻列表</h1>
</div>
<form id="searchForm" action="${ctx}/news/news!list.action" method="post">
	<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" /> 
    <input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}" /> 
    <input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success" /></div>

<form action="${ctx}/news/news!deletes.action" method="post"
	id="deleteForm">
<table class="tbhs" width="95%">
	<tr>
		<th>标题</th>
		<th>发布时间</th>
		<th>发布作者</th>
		<th>访问次数</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result">
		<tr>
			<td><a href="${ctx}/news/news!detail.action?id=${id}">${title }</a>&nbsp;</td>
			<td><fmt:formatDate value="${pubdate}" type="date"
				pattern="yyyy-MM-dd" />&nbsp;</td>
			<td>${pubuser }&nbsp;</td>
			<td>${clickscount}&nbsp;</td>	
			<td>
			 <a href="${ctx}/news/news!detail.action?id=${id}">查看</a>
			</td>
		</tr>
	</s:iterator>
</table>
<%@ include file="/common/turnpage.jsp"%>
</form>
</body>
</html>