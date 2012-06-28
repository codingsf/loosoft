<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%><html>
<head>
<title>欢迎登录智搜学生综合管理平台</title>
<link href="css/landt.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
<div id="login01">
<div id="login05"></div>
<div id="login06">
<div id="login_boxtxt">
  <form id="dataform" name="dataform" action="${ctx}/j_spring_security_check" method="post" >
  <input type="hidden" name="id" value="${id}"/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    
      <tr>
	    <td colspan="2" width="100%" height="20" align="center" class="sytt">
	    
	    <span class="STYLE1"><strong>
			<%
			if (session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY) != null) {
			%>
			登录失败，用户名或密码错误
			<%
				session.removeAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY);
			}
			%>
		</strong>
		</span>
	    </td>
	  </tr>
    
      <tr>
        <td width="24%" height="32" align="right" class="sytt"><strong>用户名</strong></td>
        <td width="76%">		
		    <input type='text' id='j_username' name='j_username' class="txtsy" 
			<s:if test="not empty param.error">
				value='<%=session.getAttribute(UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>'
			</s:if>
			/>
	    </td>
        
      </tr>
      <tr>
        <td height="32" align="right" class="sytt"><strong>密码</strong></td>
        <td>
        	<input type='password' id='j_password' name='j_password' class="txtsy" />
        </td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="12%" align="left"><input type="checkbox" name="checkbox" value="checkbox" /></td>
              <td width="88%" style="color:#26A9E8;">记住我的用户名</td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="32">&nbsp;</td>
        <td><input name="submitbut" type="submit" class="bu01" value="登 录" />
        </td>
      </tr>
    </table>
    </form>
  </div>
</div>
</div>
</body>
</html>