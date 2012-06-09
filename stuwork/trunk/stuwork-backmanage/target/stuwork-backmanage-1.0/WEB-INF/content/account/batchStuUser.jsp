<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>批量新增学生用户</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#loginName").focus();
		//为inputForm注册validate函数
		$("#inputForm").validate({
			rules: {
			   loginName: {
			        required: true,
			        remote: "user!checkLoginName.action?oldLoginName=" + encodeURIComponent('${loginName}')
		        },
				name: "required",
				password: {
					required: true
				},
				passwordConfirm: {
					equalTo:"#password"
				},
				collegeCode:"required",
				checkedRoleIds:"required"
			},
			messages: {
				loginName: {
				    remote: "用户登录名已存在"
			    },
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
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom"
	cssClass="success" /></div>

<form id="inputForm" name="inputForm" action="user!saveBatchStuUser.action" method="post">
	<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	批量新增学生用户(<span class="redz">*</span>为必填  <span class="STYLE1">注意：请务必确认批量新增的学生用户登录名和已有用户登录名不重复!</span>)
      </td>
      
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="13%" height="30" align="right" class="tbg02 pr10">选择登录名字段<span class="STYLE1">*</span></td>
	          <td width="37%" >
	          	<s:select list="#{'0':'姓名','1':'学号','2':'考试号'}" name="loginName" id="loginName"  headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	          
	          <td width="13%" height="30" align="right" class="tbg02 pr10">选择密码字段<span class="STYLE1">*</span></td>
	          <td width="37%" >
	          	<s:select list="#{'1':'学号','2':'考试号'}" name="password" id="password"  headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">所属学院<span class="STYLE1">*</span></td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:select id="collegeselect" name="collegeCode"
					list="collegues" listKey="code" listValue="code+'-'+name"
					theme="simple" headerKey="" headerValue="请选择" ></s:select>
	          </td>
	          
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">所属专业<span class="redz">* </span></td>
	          <td width="40%" bgcolor="#F1F4F9">
			    <s:select id="majorselect" name="majorCode"
					list="majors" listKey="code" listValue="code+'-'+name"
					theme="simple" headerKey="" headerValue="请选择"></s:select>
			  </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right"  class="tbg02 pr10">所属批次</td>
	          <td width="40%">
	          	<s:select list="batchs" name="comname" id="batchselect" listKey="comname" listValue="comname" headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	        
	          <td width="10%" height="30" align="right" class="tbg02 pr10">所属班级</td>
	          <td width="40%">
	          	<div id="clazzdiv"><div id="clazzlist">${clazzName}</div></div>
	          </td>
	        </tr>

	        <tr>
		         <td width="10%" height="30" align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">角色</td>
		         <td width="40%" bgcolor="#F1F4F9">
		         	<s:checkboxlist name="checkedRoleIds" list="allRoleList" listKey="id" listValue="name" theme="custom" />
		         </td>
		         <td width="10%" height="30" align="right"  bgcolor="#F1F4F9" class="tbg01 pr10"></td>
		         <td width="40%" bgcolor="#F1F4F9">
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