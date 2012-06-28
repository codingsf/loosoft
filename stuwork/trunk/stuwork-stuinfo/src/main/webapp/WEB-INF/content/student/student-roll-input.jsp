<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增 OR 修改 学生学籍信息</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#studentNo").focus();
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
			 studentNo:{
	          required:true
	        } ,
		    IDcard:{
	         required:true,
	         digits:true
	        },
	        examineeNo:{
	        	  required:true,
			         digits:true
		        },
			    name:"required",
			    collegeCode:"required",
			    majorCode:"required",
			    length:"required",
				cultureWay:"required",
				inDate:"required",
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
<body
	style="background: #E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm"
	action="${ctx}/student/student-roll!save.action" method="post">
<input type="hidden" name="id" value="${id}" />

<input type="hidden" name="oldCollegeCode" value="${collegeCode}" />
<input type="hidden" name="oldMajCode" value="${majorCode}" />
<input type="hidden" name="oldClaCode" value="${classCode}" />
<input type="hidden" name="oldCollgeName" value="${collegeName}" />
<input type="hidden" name="oldMajName" value="${majorName}" />
<input type="hidden" name="oldClaName" value="${className}" />

<div class="mid1003_r">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	style="border-left: 1px solid #B4C8D3; border-right: 1px solid #B4C8D3;">

	<tr>
		<td height="27"
			style="background: url('../images/login/tabbg01.jpg');"
			class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>
		学籍信息(<span class="redz">*</span>为必填)</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td height="30" width="20%" align="right" bgcolor="#F1F4F9"
					class="tbg01 pr10">姓名<span class="redz">* </span></td>
				<td bgcolor="#F1F4F9" width="30%"><input id="name" name="name"
					value="${name}" type="text" class="wid40px" /></td>
					
				<td height="30" width="15%" bgcolor="#F1F4F9" align="right"
					class="tbg01 pr10">学号&nbsp;</td>
				<td bgcolor="#F1F4F9" width="35%"><input id="studentNo"
					name="studentNo" value="${studentNo }" type="text" class="wid40px" /></td>
			</tr>

			<tr>
				<td height="30" align="right" class="tbg02 pr10">身份证号<span
					class="redz">* </span></td>
				<td><input id="IDcard" name="IDcard" value="${IDcard}"
					type="text" class="wid40px" /></td>
					
				<td height="30" align="right" class="tbg02 pr10">学位&nbsp;</td>
				<td><s:select id="xwfsselect" theme="simple" list="xw"
					listKey="value" listValue="label" name="degree" headerKey=""
					headerValue="请选择" value="degree" /></td>
			</tr>

			<tr>
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">院系<span
					class="redz">* </span></td>
				<td bgcolor="#F1F4F9"><s:select id="collegeselect"
					theme="simple" list="collegues" listKey="code" listValue="name"
					name="collegeCode" headerKey="" headerValue="请选择"
					value="collegeCode" /></td>
					
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业<span
					class="redz">* </span></td>
				<td bgcolor="#F1F4F9"><s:select id="majorselect" theme="simple"
					list="majors" listKey="code" listValue="name" name="majorCode"
					headerKey="" headerValue="请选择" value="majorCode" /></td>
			</tr>
			<tr>
				<td height="30" align="right" class="tbg02 pr10">班级&nbsp;</td>
				<td><s:select id="clazzselect" theme="simple" list="clazzs"
					listKey="code" listValue="name" name="classCode" headerKey=""
					headerValue="请选择" value="classCode" /></td>

				<td height="30" align="right" class="tbg02 pr10">学制&nbsp;</td>
				<td><s:select id="length" theme="simple" list="xz"
					listKey="value" listValue="label" name="length" headerKey=""
					headerValue="请选择" value="length" /></td>
			</tr>

			<tr>
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学历&nbsp;</td>
				<td bgcolor="#F1F4F9"><s:select theme="simple" list="xl"
					listKey="value" listValue="label" name="education" headerKey=""
					headerValue="请选择" value="education" /></td>

				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间<span
					class="redz">* </span></td>
				<td bgcolor="#F1F4F9"><input name="inDate" id="inDate"
					value="<fmt:formatDate value="${inDate}" type="date" pattern="yyyy-MM-dd"/>"
					type="text" class="Wdate" class="ipt wid20 "
					onclick="WdatePicker()" /></td>
			</tr>

			<tr>
				<td height="30" align="right" class="tbg02 pr10">是否在校&nbsp;</td>
				<td><s:checkbox id="inSchool" theme="simple" name="inSchool"
					value="inSchool" /></td>
					
				<td height="30" align="right" class="tbg02 pr10">是否注册&nbsp;</td>
				<td><s:checkbox id="reged" theme="simple" name="reged"
					value="reged" /></td>
			</tr>


			<tr>
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任&nbsp;</td>
				<td bgcolor="#F1F4F9"><input id="headTeacher"
					name="headTeacher" value="${headTeacher}" type="text" class="wid40" /></td>
					
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任电话&nbsp;</td>
				<td bgcolor="#F1F4F9"><input id="headTeacherPhone"
					name="headTeacherPhone" value="${headTeacherPhone}" type="text"
					class="wid40" /></td>
			</tr>

			<tr>
				<td height="30" align="right" class="tbg02 pr10">辅导员&nbsp;</td>
				<td><input id="counselor" name="counselor" value="${counselor}"
					type="text" class="wid40" /></td>
					
				<td height="30" align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
				<td><input id="counselorPhone" name="counselorPhone"
					value="${counselorPhone}" type="text" class="wid40" /></td>
			</tr>

			<tr>
				<td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业时间&nbsp;</td>
				<td colspan="3" bgcolor="#F1F4F9"><input name="finishDate"
					id="inDate"
					value="<fmt:formatDate value="${finishDate}" type="date" pattern="yyyy-MM-dd"/>"
					type="text" class="Wdate" class="ipt wid20 "
					onclick="WdatePicker()" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="32"
			style="background: url('../images/login/tabbg02.jpg');">
		<table width="30%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td><input name="submitbut" type="submit" class="bulebu"
					value="确 定" /></td>

				<td><input name="button" type="button" class="bulebu"
					value="返 回" onclick="history.back();" /></td>
				<td><input name="button" type="reset" class="bulebu"
					value="重 置" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

</form>
</body>
</html>