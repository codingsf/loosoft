<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改承诺书</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/taglibs.jsp"%>  
<style type="text/css">
<!--
/*按钮*/
html>body .btn {
	outline:none;
}/*FF, Opera*/
 .btn:focus::-moz-focus-inner {
 border-color:transparent;
}/*FF去按钮虚线框*/
.btn {
	padding:1px 14px;
	*padding:0px 7px;
	height:25px;
	line-height:25px;
	*height:25px;
	*line-height:22px;
	font-size:12px;
	color:#333;
	border:1px solid #818487;
	background:#fff url(btn.jpg) repeat-x left -34px;
	*background:#fff url(btn.jpg) repeat-x left -37px;
}/*按钮形状*/
.btn:hover, .btnh {
	background:url(../images/btn.jpg) repeat-x left top;
	border:1px solid #7398B3;
	color:#292D30;
	border:1px solid #3C80B1;
	outline:none;
}
-->
</style>
</head>
<body>
<h1>${name}</h1>
<div>${content}</div>
 

<form action="${ctx}/jobs/jobs-apply!toApplyReason.action" method="post">
	<input type="hidden" name="id" id="id" value="${jobId}"/>

	
	<input name="submitbut"
			type="submit" class="btn" value="同 意" /> &nbsp; 
	<input name="button"
			type="button" class="btn" value="不 同 意" onclick="history.back();" />
</form> 
</body>
</html>