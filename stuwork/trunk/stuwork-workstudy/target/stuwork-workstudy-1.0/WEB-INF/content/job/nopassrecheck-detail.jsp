<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>未过原因</title>
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
<h1>未过原因</h1>
</div>
<form id="dataForm" name="dataForm" method="post">

<table class="tbhs1">

	<tr>
		<th>学生姓名&nbsp;</th>
		<td colspan="3">${entity.studentName}</td>
	</tr>
	<tr>
		<th>未过原因&nbsp;</th>
		<td colspan="3">${entity.centerNoPassReason}</td>
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