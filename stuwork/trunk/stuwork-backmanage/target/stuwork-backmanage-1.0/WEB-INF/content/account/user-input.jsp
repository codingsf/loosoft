<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改用户</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
					required: true,
					minlength:3
				},
				passwordConfirm: {
					equalTo:"#password"
				},
				email:"email",
				checkedRoleIds:"required",
				type:"required"
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
<form id="inputForm" name="inputForm" action="user!save.action" method="post">
	<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      <s:if test="id == null">新增</s:if><s:else>修改</s:else>用户(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">登录名<span class="redz">* </span></td>
	          <td width="40%" >
	          	<input type="text" name="loginName" size="20" id="loginName" value="${loginName}"
				<s:if test="id != null">disabled="disabled"</s:if> />
	          </td>
	          
	          <td width="10%" height="30" align="right" class="tbg02 pr10">姓名<span class="redz">* </span></td>
	          <td width="40%" >
	          	<input type="text" name="name" size="20" id="name" value="${name}" />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">密码<span class="redz">* </span></td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<input type="password" name="password" size="20" id="password" value="${password}" />
	          </td>
	          
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">确认密码<span class="redz">* </span></td>
	          <td width="40%" bgcolor="#F1F4F9">
			    <input type="password" name="passwordConfirm" size="20" id="passwordConfirm" value="${password}" />
			  </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right"  class="tbg02 pr10">学生考试号</td>
	          <td width="40%">
	          	<input type="text" name="examineeNo" size="20" id="examineeNo" value="${examineeNo}" />
	          </td>
	        
	          <td width="10%" height="30" align="right" class="tbg02 pr10">邮箱</td>
	          <td width="40%">
	          	<input type="text" name="email" size="20" id="email" value="${email}" />
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">所属学院</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:select id="collegeselect" name="collegeCode" list="collegues" listKey="code" listValue="code+'-'+name"
					theme="simple" headerKey="" headerValue="请选择" ></s:select>
	          </td>
	          
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">所属专业</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:select id="majorselect" name="majorCode" list="majors" listKey="code" listValue="code+'-'+name"
					theme="simple" headerKey="" headerValue="请选择"></s:select>
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right"  class="tbg02 pr10">所属批次</td>
	          <td width="40%" >
	          	<s:select list="batchs" name="comname" id="batchselect" listKey="comname" listValue="comname" headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	          
	          <td width="10%" height="30" align="right" class="tbg02 pr10">所属班级</td>
	          <td width="40%" >
	          	<div id="clazzdiv"><div id="clazzlist">${clazzName}</div></div>
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">用户类型</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:select list="#{'0':'学生','1':'老师'}" name="type" id="type"  headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10"></td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	
	          </td>
	        </tr>

	        <tr>
		         <td width="10%" height="30" align="right"  class="tbg02 pr10">角色</td>
		         <td width="80%" colspan="3">
		         	<s:checkboxlist name="checkedRoleIds" list="allRoleList" listKey="id" listValue="name" theme="custom" />
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