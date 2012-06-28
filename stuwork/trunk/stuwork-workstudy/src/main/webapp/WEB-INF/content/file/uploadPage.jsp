<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>选择上传文件</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#workStartTime").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				fileName:"required",
		        file:"required"
			},
			messages: {
				fileName:"文件名不能为空",
				file:"请选择要上传的文件"
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
	action="${ctx}/file/upload!save.action" method="post" enctype="multipart/form-data">
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">选择上传文件</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="30%" height="30" align="right" class="tbg02 pr10">文件名称<span class="STYLE1">*</span></td>

          <td width="70%" >
             <input  type="text" name="fileName" class="wid16" id="fileName" value="${fileName }" />
          </td>
        </tr>
        
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">选择文件<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	 <input id="file" name="file" type="file" />
	          </td>
	    </tr>
	    
	    
	    <tr>
          <td width="30%" height="30" align="right" class="tbg02 pr10">备注</td>
          <td width="70%" >
             <textarea name="remark"></textarea>
          </td>
        </tr>
       
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" type="submit" class="bulebu" value="确 定" /></td>

          <td><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	
</form>


</body>
</html>