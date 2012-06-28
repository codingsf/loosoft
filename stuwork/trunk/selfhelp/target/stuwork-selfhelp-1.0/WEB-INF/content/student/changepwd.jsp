<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生修改密码</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#oldPwd").focus();
		//为inputForm注册validate函数
		$("#dataForm").validate({
			rules: { 	
				oldPwd: {
					"required":true,
					minlength: 6,
					remote: "changepwd!checkLoginPwd.action"
				},
				pwd: {
					required: true,
					minlength:6
				},
				repwd: {
					required: true,
					equalTo:"#pwd"
				} 
			},
			messages: { 
				oldPwd:{
					required:"请输入旧密码",	
					minlength:"旧密码长度至少为{0}位",
					remote: "密码输入错误"
					},
				pwd:{
					required:"请输入新密码",	
					minlength:"新密码长度至少为{0}位" 
					},
				repwd: { 	
					required:"请输入确认新密码",
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
<form id="dataForm" name="dataForm" method="post"  action="${ctx }/student/changepwd!savePwd.action" >
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">修改密码</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF">
     	  <div id="message">
		  <s:actionmessage theme="custom" cssClass="success" />
		  </div>
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" style="text-align: right;">旧密码</td>
				<td height="30" align="left"><input type="password" name="oldPwd" class="wid16" id="oldPwd"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新密码<span class="STYLE1">*</span></td>
				<td height="30"><input type="password" name="pwd" class="wid16" id="pwd"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">&nbsp;&nbsp;&nbsp;&nbsp;确认新密码<span class="STYLE1">*</span></td>
				<td height="30"><input type="password" name="repwd" class="wid16" id="repwd"/></td>
			</tr>        
	      </table>
      </td>
    </tr>
    <tr>
      <td align="center" height="32" style="background: url('../images/login/tabbg02.jpg');">
      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="edit" type="submit" class="bulebu" value="修改" /></td>
          <td><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
</div>	

</form>
</body>
</html>