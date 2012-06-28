<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改角色</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
	<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#name").focus();
		//为dataForm注册validate函数
		$("#inputForm").validate({
			rules: {
			    name:"required"
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
<form id="inputForm" name="inputForm" action="role!save.action" method="post" >
	<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      <s:if test="id == null">新增</s:if><s:else>修改</s:else>角色(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="4%" height="30" align="right" class="tbg02 pr10">角色名<span class="redz">* </span></td>
	          <td width="96%" >
	          	<input type="text" name="name" size="50" id="name" value="${name}"/>
	          </td>
	        </tr>

	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">后台授权</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:checkboxlist name="checkedAuthIds" list="backAuthorityList" listKey="id"
										listValue="name" theme="custom"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right"  class="tbg02 pr10">学生信息系统授权</td>
	          <td width="40%">
	          	<s:checkboxlist name="checkedAuthIds" list="stuinfoAuthorityList" listKey="id"
										listValue="name" theme="custom"/>	
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">档案系统授权</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:checkboxlist name="checkedAuthIds" list="archivesAuthorityList" listKey="id"
										listValue="name" theme="custom"/>		
	          </td>
	        </tr>

	        
	        <tr>
	          <td width="10%" height="30" align="right"  class="tbg02 pr10">勤工助学系统授权</td>
	          <td width="40%" >
	          	<s:checkboxlist name="checkedAuthIds" list="stuworkAuthorityList" listKey="id"
										listValue="name" theme="custom"/>
	          </td>
	        </tr>

	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">军训系统授权</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:checkboxlist name="checkedAuthIds" list="militrainAuthorityList" listKey="id"
										listValue="name" theme="custom"/>	
	          </td>
	        </tr>

	        <tr>
		         <td width="10%" height="30" align="right"  class="tbg02 pr10">迎新系统授权</td>
		         <td width="40%">
		         	<s:checkboxlist name="checkedAuthIds" list="welnewAuthorityList" listKey="id"
										listValue="name" theme="custom"/>
		         </td>
			</tr>
			
			
			<tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">学生自助系统授权</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	<s:checkboxlist name="checkedAuthIds" list="selfhelpAuthorityList" listKey="id"
										listValue="name" theme="custom"/>	
	          </td>
	        </tr>
	        
	        
	        <tr>
		         <td width="10%" height="30" align="right"  class="tbg02 pr10">迎新网站授权</td>
		         <td width="40%">
		         	<s:checkboxlist name="checkedAuthIds" list="welsiteAuthorityList" listKey="id"
										listValue="name" theme="custom"/>	
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