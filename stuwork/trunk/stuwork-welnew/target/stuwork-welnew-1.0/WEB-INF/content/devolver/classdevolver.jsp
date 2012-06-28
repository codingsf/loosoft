<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>分班转移</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
		$(document).ready(function() {

		 	$("#clazzselect").change(function(){

		 		$("#searchForm").submit();
			});
			$("#devolverType").change(function(){
		 		$("#searchForm").submit();
			});
			$("#submitDevolver").click(function(){	
				document.getElementById("searchForm").action="classdevolver!devolverStudent.action";
				document.getElementById("searchForm").submit();
				});

	    }); 

	</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>


<form id="searchForm" name="searchForm" action="${ctx}/devolver/classdevolver!submitStudent.action" method="post">
<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

     <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">分班转移</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10%" height="30" align="right" class="tbg02 pr10">选择班级&nbsp;</td>

          <td width="90%" >
			              院系:<s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="filter_EQS_collegeCode"
						 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode"/>
				    专业:<s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
						 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
				    班级:<s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
						 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
				    类型:
				    <s:select id="devolverType" theme="simple" list="devolveItemList" listKey="typeDesc" listValue="name" name="filter_EQS_devolverType"
						 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_devolverType"/>
          </td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">待转学生&nbsp;</td>
          <td bgcolor="#F1F4F9">
	          <c:forEach items="${stuList}" var="stu" varStatus="i" ><input type="checkbox" value="${stu.studentNo}" name="stunoFilter" />${stu.name}</c:forEach>   
          </td>
        </tr>      
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <button id="submitDevolver" type="button" class="bulebu">转移</button></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	
</form>


</body>
</html>