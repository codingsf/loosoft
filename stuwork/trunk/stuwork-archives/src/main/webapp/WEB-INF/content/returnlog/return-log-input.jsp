<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="/common/taglibs.jsp"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案归档</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#organization").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			remark: "required",
			operater:"required",
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
.STYLE1 {
	color: #FF0000
}
-->
</style>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form action="${ctx}/returnlog/return-log!save.action" method="post"
	id="dataForm" enctype="multipart/form-data">
	<input type="hidden" name="returnDate" value="<%=sdf.format(new Date()) %>"/>
	<input type="hidden" name="stuNo"  value="${stuNo }"/>

<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案归档(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">调阅单位&nbsp;</td>

          <td width="65%" >${lendLog.organization }</td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调阅理由&nbsp;</td>
          <td bgcolor="#F1F4F9">
	          ${lendLog.remark }
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">档案材料&nbsp;</td>
          <td>
            ${archives.archivesInfo }
          </td>
        </tr>
        <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">归档经办人<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
          <input type="text" id="operater" name="operater" />
          </td>
       </tr>
       
       <tr>

          <td height="30" align="right"  class="tbg02 pr10">备注<span class="redz">* </span></td>
          <td>
            <textarea name="remark">${remark }</textarea>
          </td>
        </tr>
         
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" type="submit" class="bulebu" value="保存" /></td>
          <td><input name="button" type="button" class="bulebu" value="取消"onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>


</form>
</body>
</html>