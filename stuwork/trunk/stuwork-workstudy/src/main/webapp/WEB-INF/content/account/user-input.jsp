<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改用户</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
.onError {
	color: red;
	font-weight: bold;
	background: transparent url(${ctx}/js/validate/images/unchecked.gif) no-repeat scroll left bottom;
	padding-left: 18px;
}
-->
</style>
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
				companyId:"required",
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

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="inputForm" name="inputForm" action="user!save.action" method="post" onsubmit="return check();">
<input type="hidden" name="id" value="${id}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      用户(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
           <td width="35%" height="30" align="right" class="tbg02 pr10">登录名<span class="redz">* </span></td>
           <td width="65%" >
              <input type="text" name="loginName"  id="loginName" value="${loginName}" <s:if test="id != null">disabled="disabled"</s:if> />
           </td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">密码<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	         <input type="password" name="password"  id="password" value="${password}" />
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">确认密码<span class="redz">* </span></td>
          <td>
            <input type="password" name="passwordConfirm"  id="passwordConfirm" value="${password}" />
          </td>
          </tr>
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <input type="text" name="name" id="name" value="${name}" />
          </td>
          </tr>
          <tr>

          <td height="30" align="right"  class="tbg02 pr10">邮箱&nbsp;</td>
          <td >
             <input type="text" name="email" size="30" id="email" value="${email}" />
          </td>
          </tr> 
          <tr>
          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">所属单位<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9" id="compVal">
            <s:select id="companyId" name="companyId" list="companyList" value="%{companyId}" listKey="id" listValue="companyName" theme="simple" headerKey="" headerValue="--请选择--" onchange="compSel()"></s:select>
		    <span id="compId"></span>
          </td>
          </tr> 
          
          <tr>
	          <td height="30" align="right"  class="tbg02 pr10">角色&nbsp;</td>
	          <td >
	            <s:checkboxlist name="checkedRoleIds" id="roleIds" list="allRoleList" listKey="id" listValue="name" theme="custom" />
	          </td>
          </tr> 
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" type="submit" class="bulebu" value="确 定" /></td>

          <td><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	
</form>

</body>
</html>