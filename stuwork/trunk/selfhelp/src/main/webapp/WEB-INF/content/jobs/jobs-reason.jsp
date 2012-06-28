<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>填写岗位申请原因</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#applyReason").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			   applyReason:{
			      required:true,
			      maxlength:200
			   }
			},
			messages: {
				applyReason:{
					required:"请填写申请原因",
					maxlength:"请输入一个长度最多是 200  的字符串"
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
<form id="dataForm" name="dataForm" action="${ctx}/jobs/jobs!save.action" method="post">
	<input type="hidden" name="id" value="${jobsDTO.id}" />
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
           请填写申请原因(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="15%" height="30" align="right" class="tbg02 pr10">岗位名称<span class="redz">* </span></td>
	          <td width="85%" >
	          	<input type="text" name="postname" class="wid30" id="postname" value="${jobsDTO.postName}" disabled="disabled" />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">申请原因<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9">
	          	<textarea name="applyReason" rows="5" cols="80" id="applyReason">${applyReason}</textarea>
	          </td>
	        </tr>
	        
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td><input name="submitbut" type="submit" class="bulebu" value="提交" /></td>
	          <td><input name="button" type="submit" class="bulebu" value="返回" onclick="history.back();"/></td>
	          <td><input name="button" type="submit" class="bulebu" value="重置" /></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>