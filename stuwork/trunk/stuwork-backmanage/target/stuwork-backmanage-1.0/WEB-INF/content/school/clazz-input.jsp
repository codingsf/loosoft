<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改班级</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#year").focus();
		//为inputForm注册validate函数
		$("#dataForm").validate({
			rules: {
			    year:"required",
				code: "required",
				name:"required",
				season:"required",
				specialtyCode:"required"
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
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/school/clazz!save.action" method="post" >
	<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      <s:if test="id == null">新增</s:if><s:else>修改</s:else>班级(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">入学年份<span class="redz">* </span></td>
	          <td width="65%" >
	          	<input type="text" name="year" size="52" id="year" value="${year}" />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学季节<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9">
	          	<s:select name="season" id="season" list="#{'秋季':'秋季','春季':'春季'}" theme="simple"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">班级代码<span class="redz">* </span></td>
	          <td>
	          	<input type="text" name="code" size="52" id="code" value="${code}" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">班级名称<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="name" size="52" id="name" value="${name}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">培养方式<span class="redz">* </span></td>
	          <td>
	          	<s:select list="clazzTypes" listKey="value" listValue="label" theme="simple" name="type"></s:select>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">辅导员</td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="leader" size="52" id="leader" value="${leader}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">辅导员电话</td>
	          <td>
	          	<input type="text" name="leaderTelnum" size="52" id="leaderTelnum" value="${leaderTelnum}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">班主任</td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="teacher" size="52" id="teacher" value="${teacher}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">班主任电话</td>
	          <td>
	          	<input type="text" name="teacherTelnum" size="52" id="teacherTelnum" value="${teacherTelnum}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">预设教室</td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="room" size="52" id="room" value="${room}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">所属专业<span class="STYLE1">*</span></td>
	          <td>
	          	<s:select id="specialtyCode" name="specialtyCode" list="specialtyList" listKey="code" listValue="name" theme="simple"></s:select>
	          </td>
	        </tr>
	        
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td><input name="submitbut" type="submit" class="bulebu" value="提交" /></td>
	          <td><input name="button" type="submit" class="bulebu" value="返回" onclick="history.back();"/></td>
	          <td><input name="button" type="submit" class="bulebu" value="重置" /></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>