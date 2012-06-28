<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生工资详情</title>
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
<h1>学生工资详情</h1>
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
		<th>岗位&nbsp;</th>
		<td>${entity.postName}</td>
		<th>单位名称&nbsp;</th>
		<td>${entity.companyName}</td>

	</tr>
	<tr>
		<th>工作开始时间&nbsp;</th>
		<td><fmt:formatDate value="${entity.workStartTime}" type="date"
			pattern="yyyy-MM-dd"></fmt:formatDate></td>
		<th>工作时间&nbsp;</th>
		<td><fmt:formatDate value="${entity.workStopTime}" type="date"
			pattern="yyyy-MM-dd"></fmt:formatDate></td>
	</tr>
	<tr>
		<th>工作时长&nbsp;</th>
		<td>${entity.workTime}</td>
		<th>工资标准&nbsp;</th>
		<td>${entity.standard}</td>
	</tr>
	<tr>
		<th>工资&nbsp;</th>
		<td>${entity.amount}</td>
		<th>制单日期&nbsp;</th>
		<td><fmt:formatDate value="${entity.createDate}" type="date"
			pattern="yyyy-MM-dd"></fmt:formatDate></td>
	</tr>
	<tr>
	   <th>小组审核状态&nbsp;</th>
		<td>${entity.groupStatusDesc}</td>
		<th>中心审核状态&nbsp;</th>
		<td>${entity.centerStatusDesc }</td>
	</tr>
	<tr>
	   <th>银行名称&nbsp;</th>
		<td>${entity.bankName}</td>
		<th>银行账户&nbsp;</th>
		<td>${entity.bankAccount }</td>
	</tr>
	<tr>
		<th>小组审核未通过原因&nbsp;</th>
		<td colspan="3">${entity.groupNoPassReason}</td>
	</tr>

	<tr>
		<th>中心审核未通过原因&nbsp;</th>
		<td colspan="3">${entity.centerNoPassReason}</td>
	</tr>
	<tr>
		<th>单位评价&nbsp;</th>
		<td colspan="3">${entity.comments}</td>
	</tr>
	<tr>
		<th>备注&nbsp;</th>
		<td colspan="3">${entity.remark}</td>
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