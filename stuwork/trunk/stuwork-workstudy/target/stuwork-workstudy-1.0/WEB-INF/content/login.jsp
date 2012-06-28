<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%><html>
<head>
<title>用工单位登录-勤工助学系统</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/jscss.jsp" %>
	<script>
		$(document).ready(function() {
			//聚焦第一个输入框
			$("#j_username").focus();
			$("#loginForm").validate();
		});
	</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<%@ include file="/common/loginheader.jsp" %>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<center>
<form id="dataform" name="dataform" action="${ctx}/j_spring_security_check" method="post" >
    <input type="hidden" name="id" value="${id}"/>
	<table class="tbhs1" style="width:400px; align:center;"  >
	  <tr>
	    <td colspan="2" style="text-align:center;height:50px;">
	    <div><h1>用工单位登录</h1></div>
	    
	    <div class="errormsg">   
	    
			<%
			if (session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY) != null) {
			%>
			登录失败，用户名或密码错误.
			<%
				session.removeAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY);
			}
			%>
		</div>
	    </td>
	  </tr>
	  <tr>
	    <th>登录名<span class="STYLE1">*</span></th>
	    <td>					
		    <input type='text' value="admin" id='j_username' name='j_username' class="ipt wid50" 
			<s:if test="not empty param.error">
				value='<%=session.getAttribute(UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>'
			</s:if>
			/>
	    </td>
	  </tr>
	  <tr>
	    <th>密码<span class="STYLE1">*</span></th>
	    <td>
	    	<input type='password' value="admin" id='j_password' name='j_password' class="ipt wid50"  class="required"/>
	    </td>
	  </tr>	   
      <tr>
	      <td></td>
	      <td colspan="3">
	        <label></label>
	        <input name="submitbut" type="submit" class="btn" value="确 定" />
	      </td>
      </tr>
	</table>
</form>
<p>&nbsp;</p><p>&nbsp;</p>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<%@ include file="/common/footer.jsp" %>
<p>&nbsp;</p><p>&nbsp;</p>
</center>
</body>
</html>