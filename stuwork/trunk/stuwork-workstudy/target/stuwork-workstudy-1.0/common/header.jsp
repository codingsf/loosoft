<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="org.springside.modules.security.springsecurity.SpringSecurityUtils"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="cn.loosoft.common.security.springsecurity.user.User"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.time.DateUtils"%>

<%@page import="cn.loosoft.stuwork.common.entity.user.SecurityUser"%>
<%@page import="org.apache.commons.lang.StringUtils"%><html>
<head>
	<link href="${ctx}/css/newpage.css" rel="stylesheet" type="text/css" />
</head>
<body style="background:url(${ctx}/images/login/header01.jpg) repeat-x;">
	<div class="header_mid01">
	  <div class="header_mid01l"><img src="${ctx}/images/login/logo05.jpg" width="640" height="90" /></div>
	  <div class="header_mid01r">
	    <table width="100%" height="21" border="0" cellpadding="0" cellspacing="0">
	      <tr>
	        <td width="11%" align="center"><img src="${ctx}/images/login/ico_01.gif" width="16" height="16" /></td>
	        <td width="50%" class="dbyz">
	        	<%if(!"anonymousUser".equals(SpringSecurityUtils.getCurrentUserName())&&!"".equals(SpringSecurityUtils.getCurrentUserName())){%>
				<span class="status">
				欢迎：
				<%
				SecurityUser user = (SecurityUser)SpringSecurityUtils.getCurrentUser();
				request.setAttribute("name",user.getName());
				
				if(!StringUtils.isEmpty(user.getDepartName())){
					request.setAttribute("cname","-"+user.getDepartName());
				}
				%>
				${name}${cname}
				&nbsp;&nbsp;
				<security:authorize ifNotGranted="ROLE_勤工助学_用工人员">
				<a href="<common:prop name="cas.securityContext.logoutUrl" propfilename="application.properties"/>?from=<common:prop name="backmanage.webapp.url" propfilename=""/>" target="_parent">注销</a>&nbsp;
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_勤工助学_用工人员">
				<a href="${ctx }/logout" target="_parent">注销</a>
				</security:authorize>
				&nbsp;&nbsp;
				<security:authorize ifNotGranted="ROLE_勤工助学_用工人员">
				<a href="<common:prop name="backmanage.webapp.url" propfilename=""/>" target="parent">返回平台入口</a>	
				</security:authorize>
				</span>
			  <%}%>
	        </td>
	      </tr>
	    </table>
	  </div>
	</div>
</body>
</html>