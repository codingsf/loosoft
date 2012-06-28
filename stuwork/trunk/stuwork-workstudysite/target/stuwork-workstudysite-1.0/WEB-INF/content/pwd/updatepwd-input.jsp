<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>新增or修改岗位</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
$(document).ready(function() {
	//聚焦第一个输入框
	$("#oldPwd").focus();
	//为inputForm注册validate函数
	$("#dataForm").validate({
		rules: { 	
			oldPwd: {
				"required":true,
				minlength: 6,
				remote: "updatepwd!checkLoginPwd.action"
			},
			pwd: {
				required: true,
				minlength:6
			},
			repwd: {
				required: true,
				equalTo:"#pwd"
			} 
		},
		messages: { 
			oldPwd:{
				required:"请输入旧密码",	
				minlength:"旧密码长度至少为{0}位",
				remote: "密码输入错误"
				},
			pwd:{
				required:"请输入新密码",	
				minlength:"新密码长度至少为{0}位" 
				},
			repwd: { 	
				required:"请输入确认新密码",
				equalTo: "输入与上面相同的密码"
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
<h1>修改密码（<span
	class="STYLE1">*</span>为必填）</h1>
</div>
<form id="dataForm" name="dataForm"
	action="${ctx}/pwd/updatepwd!savePwd.action" method="post"><input
	type="hidden" name="id" value="${id}" />
<div id="message">
   <s:actionmessage theme="custom" cssClass="success" />
</div>
<table class="tbhs1">
	<tr>
		<th>学号&nbsp;</th>
		<td>${userName}</td>
	</tr> 
	<tr>
		<th width="20%">姓名&nbsp;</th>
		<td>${name}</td>
	</tr>

	<tr>
		<th>旧密码<span class="STYLE1">*</span></th>
		<td><input type="password" name="oldPwd" class="wid16" id="oldPwd"/></td>
	</tr>
	<tr>
		<th>新密码<span class="STYLE1">*</span></th>
		<td><input type="password" name="pwd" class="wid16" id="pwd"/></td>
	</tr>
	<tr>
		<th>确认新密码<span class="STYLE1">*</span></th>
		<td><input type="password" name="repwd" class="wid16" id="repwd"/></td>
	</tr> 
	<tr>
		<td></td>
		<td colspan="3"><label></label> <input name="submitbut"
			type="submit" class="btn" value="确 定" />
		&nbsp; <input name="button" type="reset" class="btn" value="重 置" /></td>
	</tr>
</table>
</form>
</body>
</html>