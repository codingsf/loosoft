<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新生通知书列表</title>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript">
   $(document).ready(function(){
	  $("#printForm").submit();
   });
   
</script>
</head>
<body>
<form id="printForm" action="<common:prop name="stuwork.reportservice" propfilename="application.properties"></common:prop>" method="post">
<input type="hidden" name="printcontent" value="${printcontent}"/>
</form>
</body>
</html>