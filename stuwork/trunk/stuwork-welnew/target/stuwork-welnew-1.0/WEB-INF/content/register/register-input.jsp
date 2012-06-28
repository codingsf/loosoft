<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>新生注册</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>

	<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#noticeId").focus();
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
			    noticeId:"required",
			    pid:{
		         required:true,
		         digits:true
		        },
			    passwordque:"required",
			    passwordans:"required",
			    email:"required",
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
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
<body>
<div class="caozuo">
  <ul>
    <li><a href="register!input.action" ><span>新生注册</span></a></li>
  </ul>
</div>

<form action="${ctx}/register/register!save.action" method="post" id="dataForm">
<table class="tbhs" width="95%">
  <tr>
    <td >通知书编号:</td>   <td><input type="text" name="noticeId"></input></td> 
    </tr>
  <tr>
    <td >身份证号码:</td>   <td><input type="text" name="pid"></input></td> 
    </tr>
     <tr>
    <td >密码:</td>   <td><input type="text"></input></td> 
    </tr>
     <tr>
    <td >再次输入密码:</td><td><input type="text" name="password"></input></td> 
    </tr>
         <tr>
    <td >密码保护问题:</td>   <td><input type="text" name="passwordque"></input></td> 
    </tr>
         <tr>
    <td >密码保护答案:</td>   <td><input type="text" name="passwordans"></input></td> 
    </tr>
           <tr>
    <td >安全邮箱:</td>   <td><input type="text"  name="email" ></input></td> 
    </tr>
    
 <tr>

      <td colspan="2" align="center">
   
        <input name="submitbut" type="submit" class="btn" value="确 定" />
        &nbsp;
        <input name="button"  type="button" class="btn" value="返 回" onclick="history.back();" />
        &nbsp;
        <input name="button"  type="reset" class="btn" value="重 置" />        </td>
    </tr>
</table>
</form>
</body>
</html>