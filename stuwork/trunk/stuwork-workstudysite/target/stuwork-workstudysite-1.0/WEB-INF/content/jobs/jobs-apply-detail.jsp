<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位详情</title>
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
<h1>岗位详情</h1>
</div>
<form id="dataForm" name="dataForm" method="post">

<table class="tbhs1">
	<tr>
		<th width="20%">岗位名称&nbsp;</th>
		<td width="30%">${entity.postName}</td>
		<th width="20%">性别限制&nbsp;</th>
		<td>${entity.sexLimit}</td>
	</tr>

	<tr>
		<th>地点&nbsp;</th>
		<td>${entity.address}</td>
		<th>勤工内容&nbsp;</th>
		<td>${entity.content}</td>
	</tr>
	<tr>
	    <th>勤工要求&nbsp;</th>
		<td>${entity.requireMents}</td>
		<th>所属单位&nbsp;</th>
		<td>${entity.company.companyName }</td>
		
	</tr>

	<tr>
		<th>发布时间&nbsp;</th>
		<td><fmt:formatDate value="${entity.pubdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate></td>
		<th>报名截止时间&nbsp;</th>
		<td><fmt:formatDate value="${entity.stopdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate></td>
	</tr>
	<tr>
	    <th>招聘人数&nbsp;</th>
		<td >${entity.reqCount}</td>
		<th>已招聘人数&nbsp;</th>
		<td >${entity.exisitCount}</td>
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