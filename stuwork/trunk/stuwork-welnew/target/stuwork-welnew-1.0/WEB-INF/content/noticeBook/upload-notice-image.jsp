<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>选择上传通知书图片</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#workStartTime").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
		        file:{
			      required:true
		        },
		        year:{
			      required:true
		        },
		        introduce:{
			      required:true
		        }
			},
			messages: {
				file:{
					required:"请选择要上传的图片"
				},
				year:{
					required:"请填写年限"
				},
				introduce:{
					required:"请填写说明"
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
<form id="dataForm" name="dataForm"
	action="${ctx}/noticeBook/notice-book!uploadImage.action" method="post" enctype="multipart/form-data">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      选择上传通知书图片
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">年份<span class="STYLE1">*</span></td>
	          <td width="65%" >
	          	<input  type="text" name="year" class="wid16" id="year" value="${year }" />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">说明<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	<input  type="text" name="introduce" class="wid16" id="introduce" value="${introduce }" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">选择图片<span class="STYLE1">*</span></td>
	          <td>
			    <input id="file" name="file" type="file" />
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