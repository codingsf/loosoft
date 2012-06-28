<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生申请岗位详情</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
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
<h1>学生申请岗位详情</h1>
</div>
<form id="dataForm" name="dataForm" method="post">

<table class="tbhs1">
	<tr>
		<th width="20%">姓名&nbsp;</th>
		<td width="30%">${entity.studentName}</td>
		<th width="20%">考生号&nbsp;</th>
		<td>${entity.examineeNo}</td>
	</tr>
	<tr>
		<th>申请岗位&nbsp;</th>
		<td>${entity.jobsName}</td>
		<th>申请日期&nbsp;</th>
		<td><fmt:formatDate value="${entity.applyDate}" type="date"
			pattern="yyyy-MM-dd"></fmt:formatDate></td>

	</tr>
	<tr>
		<th>小组审核状态&nbsp;</th>
		<td>${entity.groupStatusDesc }</td>
		<th>中心审核状态&nbsp;</th>
		<td>${entity.centerStatusDesc }</td>
	</tr>
	<tr>
		<th>用工单位是否选择&nbsp;</th>
		<td>${entity.choseDesc}</td>
		<th>选择日期&nbsp;</th>
		<td><fmt:formatDate value="${entity.choseDate}" type="date"
			pattern="yyyy-MM-dd"></fmt:formatDate></td>
	</tr>
	<tr>
		<th>学生申请岗位原因&nbsp;</th>
		<td colspan="3">${entity.applyReason}</td>
	</tr>
	<tr>
		<th>小组审核未过原因&nbsp;</th>
		<td colspan="3">${entity.groupnopassreason}</td>
	</tr>
	<tr>
		<th>中心审核未过原因&nbsp;</th>
		<td colspan="3">${entity.centernopassreason}</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3"><label></label> <input name="button"
			type="button" class="btn" value="返 回" onclick="history.back();" /></td>
	</tr>
</table>
</form>
</body>
</html>