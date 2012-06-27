<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter"%>
<%@page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%><html>
<head>
<title>登录</title>
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
<body style="background-color:#FFFFFF; font-size:12px; color:#333333">

<div style="position:relative; margin-left:auto; margin-right:auto; width:1000px">
  <div style="position:relative; margin-left:auto; margin-right:auto; width:1000px">
    
    <div style="position:absolute; z-index:2;"><img src="images/r1_c1.jpg" /></div>
    <div style="position:absolute; left: 431px; top: 12px;z-index:2;"><img src="images/r2_c2.jpg" /></div>
    <div style="position:absolute; left: 382px; top: 107px; z-index:2;"><img src="images/r3_c2.jpg" /> </div>
    <div style="position:absolute; left: 0px; top: 107px; width:100%; height:289px; z-index:1; background-image:url(images/r3_c4.jpg)"></div>
    <div style="position:absolute; left: 572px; top: 217px; z-index:2;"><img src="images/r4_c6.jpg" /> </div>
     <div style="position:absolute; left: 529px; top: 454px;z-index:3;"><input type="radio" name="radioType" id="radioType" value="student" /></div>
       <div style="position:absolute; left: 598px; top: 454px;z-index:3;"><input type="radio" name="radioType" id="radioType" value="teacher" checked="checked" /></div>
    <div style="position:absolute; left: 438px; top: 451px;z-index:2;"><img src="images/r4_c3.jpg" />
      
          <form id="dataform" name="dataform" action="${ctx}/j_spring_security_check" method="post" >
            <div style="position:absolute; left: 94px; top: 37px; height: 20px; width: 206px;">

            <input  name="j_username" id="j_username" type="text" style="border:none; background-color:#FFFFFF" size="21" />
            <s:if test="not empty param.error">
				value='<%=session.getAttribute(UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>'
			</s:if>
            </div>
            <div style="position:absolute; left: 94px; top: 77px; height: 23px; width: 206px;">
            <input  id='j_password' name='j_password' type="password" style="border:none;background-color:#FFFFFF" size="23" />
            </div>
            <div style="position:absolute; left: 287px; top: 27px;">
           	  <input type="submit" value="登录"  style="background-image:url(images/r5_c8.jpg); width:127px; height:79px; border:none;"/>
            </div>
                        <%
			if (session.getAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY) != null) {
			%>
			登录失败，用户名或密码错误.
			<%
				session.removeAttribute(AbstractAuthenticationProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY);
			}
			%>
          </form>
      
    </div>
    <div style="position:absolute; left: 189px; top: 642px;">地址:九华路9号  邮编:100084  电话查号台:0550-6732041<br/>
      管理员信箱:zbahstu@126.com<br/>
      文保网安备案号:1101080011</div>
  </div>
</div>
</body>
</html>