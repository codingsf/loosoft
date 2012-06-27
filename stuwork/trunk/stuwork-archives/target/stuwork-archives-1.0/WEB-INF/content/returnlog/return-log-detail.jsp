<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>归档详情</title>
<%@ include file="/common/meta.jsp"%>

<%@ include file="/common/jscss.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#project").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			area: "required",
			rank:"required",
			storow: "required",
			stocolumn:"required"
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
<!--startprint-->
<div class="xzwz">
<h1>学生基本信息</h1>
</div>
<table class="tbhs1">
	<tr>
		<th>学号</th>
		<td><input type="text" name="stuId" value="${archivesVO.stuId }" style="border: 0px"/></td>
		<th>姓名</th>
		<td><input type="text" name="name" value="${archivesVO.name }" style="border: 0px"/></td>
	</tr>
	<tr>
		<th>学院</th>
		<td>${archivesVO.collegeName }</td>
		<th>性别</th>
		<td>${archivesVO.sexDesc }</td>
	</tr>
	<tr>
		<th>专业</th>
		<td>${archivesVO.majorName }</td>
		<th>出身年月</th>
		<td><fmt:formatDate value="${archivesVO.birthday }" type="date" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<th>班级</th>
		<td>${archivesVO.className }</td>
		<th>身份证号</th>
		<td>${archivesVO.IDcard }</td>
	</tr>
	<tr>
		<th>入学时间</th>
		<td><fmt:formatDate value="${archivesVO.inDate }" type="date" pattern="yyyy-MM-dd" /></td>
		<th>档案状态</th>
		<td>${archivesVO.status }</td>
	</tr>
	<tr>
		<th>档案库位</th>
		<td colspan="3">${archivesVO.storeInfo}</td>
	</tr>
</table>
<br />
<div class="xzwz">
<h1>归档详情</h1>
</div>
<form action="" method="post" id="dataForm">

<table class="tbhs1">
	<tr>
		<th width="30%">调阅单位</th>
		<td><input type="text" name="organization" value="${lendLog.organization}" style="border: 0px"/></td>
	</tr>
	<tr>
		<th width="30%">调阅时间</th>
		<td><fmt:formatDate value="${lendLog.lendDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" /></td>
	</tr>
	<tr>
		<th width="30%">计划归档时间</th>
		<td><fmt:formatDate value="${lendLog.planDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" /></td>
	</tr>
	<tr>
		<th width="30%">实际归档时间</th>
		<td><fmt:formatDate value="${entity.returnDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" /></td>
	</tr>
	<tr>
		<th>经办人</th>
		<td>${entity.operater }</td>
	</tr>
	<tr>
		<th>备注</th>
		<td>${entity.remark }</td>
	</tr>
</table>
</form>
<!--endprint--> <br />
<div style="text-align: center">
  <input name="button" type="button" class="btn" value="打印" onclick="execPrint()" /> &nbsp;&nbsp; 
  <input name="button" type="button" class="btn" value="返 回" onclick="history.back();" />
</div>
</body>
</html>