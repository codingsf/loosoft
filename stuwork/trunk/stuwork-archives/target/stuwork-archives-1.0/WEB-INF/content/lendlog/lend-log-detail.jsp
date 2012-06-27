<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>调阅记录详情</title>
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
		<td><input type="text" name="stuId" value="${studentDTO.studentNo }" id="stuId" style="border: 0px"/></td>
		<th>姓名</th>
		<td><input type="text" name="stuId" value="${studentDTO.name }" id="stuId" style="border: 0px"/></td>
	</tr>
	<tr>
		<th>学院</th>
		<td>${studentDTO.collegeName }</td>
		<th>性别</th>
		<td>${studentDTO.sexDesc }</td>
	</tr>
	<tr>
		<th>专业</th>
		<td>${studentDTO.majorName }</td>
		<th>出身年月</th>
		<td><fmt:formatDate value="${studentDTO.birthday }" type="date" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<th>班级</th>
		<td>${studentDTO.className }</td>
		<th>身份证号</th>
		<td>${studentDTO.IDcard }</td>
	</tr>
	<tr>
		<th>入学时间</th>
		<td><fmt:formatDate value="${studentDTO.inDate }" type="date" pattern="yyyy-MM-dd"/></td>
		<th>档案状态</th>
		<td>${archives.status }</td>
	</tr>
	<tr>
		<th>档案库位</th>
		<td colspan="3">${archives.storeInfo}</td>
	</tr>
</table>
<br />
<div class="xzwz">
<h1>调阅详情</h1>
</div>
<form action="" method="post" id="dataForm">

<table class="tbhs1">
	<tr>
		<th width="30%">调阅单位</th>
		<td>${entity.organization}</td>
	</tr>
	<tr>
		<th width="30%">调阅时间</th>
		<td><fmt:formatDate value="${entity.lendDate}" type="date"
			pattern="yyyy-MM-dd hh:MM" /></td>
	</tr>
	<tr>
		<th width="30%">计划归还时间</th>
		<td><fmt:formatDate value="${entity.planDate}" type="date"
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
	<tr>
		<th width="30%">扫描文件名</th>
		<td>${entity.fileName }</td>
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