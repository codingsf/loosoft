<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>填写岗位申请原因</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#applyReason").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			   applyReason:{
			      required:true,
			      maxlength:200
			   }
			},
			messages: {
				applyReason:{
					required:"请填写申请原因",
					maxlength:"请输入一个长度最多是 200  的字符串"
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
<h1>请填写申请原因（<span
	class="STYLE1">*</span>为必填）</h1>
</div>
<form id="dataForm" name="dataForm"
	action="${ctx}/jobs/jobs-apply!save.action" method="post">
	<input type="hidden" name="id" value="${entity.id}" />
<table class="tbhs1">
	<tr>
		<th width="20%">岗位名称&nbsp;</th>
		<td>${entity.postName}</td>
	</tr>
	<tr>
		<th>申请原因<span class="STYLE1">*</span></th>
		<td><textarea name="applyReason" rows="8" class="wid70 ipt hei40"
			onmouseover="this.applyReason='wid70 ipth hei40'"
			onmouseout="this.applyReason='wid70 ipt hei40'" id="applyReason">${applyReason}</textarea></td>
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