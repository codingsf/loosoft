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
		$("#postname").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			    postname:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				},
				postname:"请输入岗位名称"
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
<h1><s:if test="id == null">新增</s:if><s:else>修改</s:else> 岗位（<span
	class="STYLE1">*</span>为必填）</h1>
</div>
<form id="dataForm" name="dataForm"
	action="${ctx}/job/jobs-apply!save.action" method="post"><input
	type="hidden" name="id" value="${id}" />
<table class="tbhs1">
	<tr>
		<th width="20%">岗位名称<span class="STYLE1">*</span></th>
		<td><input type="text" name="postname" class="wid30"
			id="postname" value="${postname}" /></td>
	</tr>
	<tr>
		<th>性别限制&nbsp;</th>
		<td><input type="text" name="sexLimit" class="wid30"
			id="sexLimit" value="${sexlimit}" /></td>
	</tr>
	<tr>
		<th>招聘人数&nbsp;</th>
		<td><input type="text" name="reqcount" class="wid30"
			id="reqcount" value="${reqcount}" /></td>
	</tr>
	<tr>
		<th>所属单位<span class="STYLE1">*</span></th>
		<td><input type="text" name="company" class="wid16" id="company"
			value="${company.companyName}" /></td>
	</tr>
	<tr>
		<th>报名截止时间&nbsp;</th>
		<td><input name="stopdate" id="stopdate"
			value="<fmt:formatDate value="${stopdate}" type="date" pattern="yyyy-MM-dd"/>"
			type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" /></td>
	</tr>
	<tr>
		<th>地点&nbsp;</th>
		<td><textarea name="address" rows="8" class="wid70 ipt hei40"
			onmouseover="this.address='wid70 ipth hei40'"
			onmouseout="this.address='wid70 ipt hei40'" id="address">${address}</textarea></td>
	</tr>
	<tr>
		<th>勤工内容&nbsp;</th>
		<td><textarea name="content" rows="8" class="wid70 ipt hei40"
			onmouseover="this.content='wid70 ipth hei40'"
			onmouseout="this.content='wid70 ipt hei40'" id="content">${content}</textarea></td>
	</tr>
	<tr>
		<th>勤工要求&nbsp;</th>
		<td><textarea name="requirements" rows="8"
			class="wid70 ipt hei40"
			onmouseover="this.requirements='wid70 ipth hei40'"
			onmouseout="this.requirements='wid70 ipt hei40'" id="requirements">${requirements}</textarea></td>
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