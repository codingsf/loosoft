<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻类型列表</title>
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
	<li><a href="news-type!input.action"><span>新增</span></a></li>
	<li><a href="#" id="delbut"><span>删除</span></a></li>
</ul>
</div>
<div id="message"><s:actionmessage theme="custom"
	cssClass="success" /></div>
<form action="${ctx}/sys/news-type!deletes.action" method="post"
	id="deleteForm">
<table class="tbhs" width="95%">
	<tr>
		<th class="wid10px"><label> <input type="checkbox"
			id="checkboxall" /> </label></th>
		<th>标识</th>
		<th>类型</th>
		<th>添加时间</th>
		<th>操作人</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result">
		<tr>

			<td><input type="checkbox" id="ids" name="ids" value="${id }" /></td>
			<td>${id }&nbsp;</td>
			<td>${type }&nbsp;</td>
			<td><fmt:formatDate value="${time}" type="date"
				pattern="yyyy-MM-dd" />&nbsp;</td>
			<td>${operator }&nbsp;</td>
			<td><a href="#"
				onclick="delOneRecord('${id }','${ctx}/sys/news-type!delete.action');">删除</a>
			<a href="${ctx}/sys/news-type!input.action?id=${id}">修改</a></td>
		</tr>
	</s:iterator>
</table>
</form>
</body>
</html>