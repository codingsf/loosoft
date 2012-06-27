<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>变更记录详情</title>
<%@ include file="/common/meta.jsp"%>

<%@ include file="/common/jscss.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#stuNo").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			stuNo: "required",
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
<h1>学生基本信息</h1>
</div>
<table class="tbhs1">
<tr>
<th>学号</th><td><input type="text" name="studentNo" value="${studentNo }"  /></td>
<th>姓名</th><td><input type="text" name="name" value="${name }"  /></td>
</tr>
<tr>
<th>学院</th><td><input type="text" name="collegeName" value="${collegeName }" /></td>
<th>性别</th><td><input type="text" name="sex" value="${sex }" /></td>
</tr>
<tr>
<th>专业</th><td><input type="text" name="collegeName" value="${collegeName }" /></td>
<th>出身年月</th><td><input type="text" name="sex" value="${sex }" /></td>
</tr>
<tr>
<th>班级</th><td><input type="text" name="collegeName" value="${collegeName }" /></td>
<th>身份证号</th><td><input type="text" name="sex" value="${sex }" /></td>
</tr>
<tr>
<th>入学时间</th><td><input type="text" name="collegeName" value="${collegeName }" /></td>
<th>档案状态</th><td><input type="text" name="sex" value="${sex }" /></td>
</tr>
<tr>
<th>档案库位</th><td colspan="3"><input type="text" name="collegeName" value="${collegeName }" /></td>
</tr>
</table >
<br />
<c:if test="${changeLog ne null}">
<div class="xzwz">
<h1>变更详情</h1>
</div>
<table class="tbhs1">
<tr>
<th>变更时间</th><td><fmt:formatDate value="${changeLog.changeDate}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
<th>变更经办人</th><td>${changeLog.operater }</td>
</tr>
<tr>
<th>变更内容</th><td colspan="3">${changeLog.content }</td>
</tr>
<tr>
<th>变更说明</th><td colspan="3">${changeLog.remark }</td>
</tr>
</table>
</c:if>
<br />
<div style="text-align: center"><input name="button"
			type="button" class="btn" value="返 回" onclick="history.back();" /></div>
</body>
</html>