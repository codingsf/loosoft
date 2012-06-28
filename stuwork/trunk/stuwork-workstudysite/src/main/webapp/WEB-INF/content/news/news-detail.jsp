<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻详情</title>
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
<h1>新闻详情</h1>
</div>
<table class="tbhs1">
	<tr>
		<th width="20%">标题&nbsp;</th>
		<td>${entity.title}</td>
	</tr>
	<tr>
		<th>发布时间&nbsp;</th>
		<td><fmt:formatDate value="${entity.pubdate}" type="date"
				pattern="yyyy-MM-dd" /></td>
	</tr>
	<tr>
		<th>发布作者&nbsp;</th>
		<td >${entity.pubuser}</td>
	</tr>
	<tr>
		<th>访问次数&nbsp;</th>
		<td >${entity.clickscount}</td>
	</tr>
		<tr>
		<th style="height: 40px">内容&nbsp;</th>
		<td>${entity.content}</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3"><input name="button" type="button" class="btn"
			value="返 回" onclick="history.back();" /></td>
	</tr>
</table>
</body>
</html>