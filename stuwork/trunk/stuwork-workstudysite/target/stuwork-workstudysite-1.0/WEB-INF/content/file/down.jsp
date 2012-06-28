<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>文件下载</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript">
	
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
	
	</script>

</head>
<body>
<div class="xzwz">
<h1>文件下载</h1>
</div>
<div id="message"><s:actionmessage theme="custom"
	cssClass="success" /></div>
<div>
	<table class="tbhs" width="95%">
	<tr>

		<th>文件别名</th>
		<th>文件名称</th>
		<th>上传日期</th>
		<th>上传人</th>
		<th>备注</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result">
		<tr>
			<td>${fileName}&nbsp;</td>
			<td>${fileRealName}&nbsp;</td>
			<td><fmt:formatDate value="${uploadDate}" type="date"
				pattern="yyyy-MM-dd" />&nbsp;</td>
			<td>${uploadUser}&nbsp;</td>
			<td>${remark}&nbsp;</td>
			<td><a href="${ctx}/file/down.action?id=${id}"><span>下载</span></a></td>
		</tr>
	</s:iterator>
	
	</table>
	<%@ include file="/common/turnpage.jsp" %>
</div>
</body>
</html>