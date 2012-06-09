<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" uri="http://www.common.lib/tags/util" %>
<%
	String activeUrl = request.getParameter("activeUrl");
	if(activeUrl!=null&&!"".equals(activeUrl)){
		response.sendRedirect(activeUrl);
	}
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title>欢迎登录智搜学生综合管理平台</title>
<link href="<c:url value="/css/landt.css"/>" rel="stylesheet" type="text/css"/>
</head>

<body>

<div id="login_box">
<div id="login_boxup"></div>
<div id="login_boxdown">
<div id="login_boxtxt">
  <form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true" onsubmit="return submitForm(this);">
            
                <table width="100%" style="margin:-10px 0px" border="0" cellspacing="0" cellpadding="0">
                <tr>    
					<td width="24%" height="32" align="right" class="sytt"><strong>用户名</strong></td>
					
					<td width="76%">
						<c:if test="${not empty sessionScope.openIdLocalId}">
						<strong>${sessionScope.openIdLocalId}</strong>
						<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
						</c:if>                            
						<c:if test="${empty sessionScope.openIdLocalId}">
						<form:input id="username" cssClass="input" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true" />
						</c:if>
						<div class="prompt ll">
						    <p class="prompt_err  ml10 ll " >
						  	  <form:errors path="*"  id="status" />
						    </p>
						</div>
					
					</td>
				</tr>
				
				<tr>
					<td height="32" align="right" class="sytt"><strong>密码</strong></td>
					<td>
						<form:password id="password" cssClass="input" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
					</td>
				</tr>
				
				<tr>
			        <td height="30">&nbsp;</td>
			        <td>
				        <table width="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
				              <td width="12%" align="left">
				              	<input type="checkbox" name="rememberMe" id="rememberMe" value="true" />
				              </td>
				              <td width="88%" style="color:#26A9E8;">记住我的用户名</td>
				            </tr>
				        </table>
			        </td>
			    </tr>

				<tr>
			        <td height="32">
				        <input type="hidden" name="lt" value="${flowExecutionKey}" />
						<input type="hidden" name="_eventId" value="submit" />
			        </td>
			        <td>
			        	<input name="Submit" type="submit" class="bu01" value="登 录" />
			        </td>
			    </tr>
            	</table>
</form:form>
</div>
</div>
</div>
</body>
</html>
