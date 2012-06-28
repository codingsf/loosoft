<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>公寓用品发放</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#testNo").focus();
		//为inputForm注册validate函数
		$("#dataForm").validate({
			rules: {
				testNo: "required"
			},
			messages: {
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
<h1>公寓用品现场发放</h1>
</div>
<form name="dataForm"  action="${ctx}/wuzi/give!save.action" method="post">
<table class="tbhs1">
	<tr>
		<td width="100%" colspan="2" align="center">
		<div id="useridTip" style="width: 400px; float: left;">
		<ul>
			<li>提示：</li>
			<li>1、每位新生公寓用品发放后要做下记录</li>
			<li>2、输入考生号，点击发放即可</li>
		</ul>
		</div>
		<!-- 
					<div id="useridTip" style="width:500px;float:right;">
					<ul>
					<li>当前农学系新生公寓用品发放情况：</li>
					<li>1、预发100套</li>
					<li>2、已发放50套</li>
					<li>3、未发50套</li>
					</ul>
					</div>
				-->
		</td>
	</tr>
	<tr>
		<th>请输入学号</th>
		<td><input id="testNo" name="testNo" value="${testNo}" type="text" class="wid20" /></td>
	</tr>
	<tr>
		<th>发放情况</th>
		<td><input id="giveStatus" name="giveStatus" value="${giveStatus}" type="text" class="wid20" /></td>
	</tr>
	<tr>
		<td></td>
		<td><label></label> <input name="submitbut" type="submit" class="btn" value="确认发放" /></td>
	</tr>
</table>
</form>
</body>
</html>