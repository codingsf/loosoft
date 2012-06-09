<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改用户类型</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#type").focus();
		//为inputForm注册validate函数
		$("#inputForm").validate({
			rules: {
			   type: {
			        required: true,
			        remote: "user-type!checkUserType.action?oldType=" + encodeURIComponent('${type}')
		        }
			},
			messages: {
				type: {
				    remote: "用户类型已存在"
			    },
				passwordConfirm: {
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
<h1><s:if test="id == null">新增</s:if><s:else>修改</s:else> 用户类型（<span
	class="STYLE1">*</span>为必填）</h1>
</div>
<form id="inputForm" name="inputForm" action="user-type!save.action"
	method="post">
	<input type="hidden" name="id" value="${id}" />
<table class="tbhs1">
	<tr>
		<th width="10%">类型<span class="STYLE1">*</span></th>
		<td>
		 <input type="text" name="type" size="50" id="type" value="${type}" <s:if test="id != null">disabled="disabled"</s:if> />
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