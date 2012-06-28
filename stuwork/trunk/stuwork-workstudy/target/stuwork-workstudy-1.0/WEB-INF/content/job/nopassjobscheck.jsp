<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>未过原因</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
	<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script> 
	<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>	
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#title").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				centernopassreason: {
				 	required:true,
			      	maxlength:200
			   }
			},
			messages:{
				centernopassreason: {
					required:"请输入未过原因",
					maxlength:"请输入一个长度最多是 200 的字符串"
				}
			}
		});
	});
	
</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>
</head>
<body>
<div class="xzwz">
<h1>请填写未过原因（<span class="STYLE1">*</span>为必填）</h1>
</div>
<form id="dataForm" name="dataForm"
	action="${ctx}/job/jobscheck!nopass.action" method="post">
	<input type="hidden" name="id" value="${entity.id}" />
	
<table class="tbhs1">

	<tr>
		<th width="30%">未过原因<span class="STYLE1">*</span></th>
		<td align="left" class="bodyText" valign="top">
				<textarea name="nopassreason"></textarea>
			   </td>
	</tr>
	
	<tr>
		<td></td>
		<td colspan="3"><label></label> <input name="submitbut"
			type="submit" class="btn" value="确 定" /> &nbsp; <input name="button"
			type="button" class="btn" value="返 回" onclick="history.back();" />
		&nbsp; <input name="button" type="reset" class="btn" value="重 置" /></td>
	</tr>
</table>
</form>
</body>
</html>