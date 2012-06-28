<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>新增or修改缴费项目设置</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#project").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			    project:{
		         required:true,
		         remote: "costitem!checkProject.action?oldProject=" + encodeURIComponent('${project}')
		        },
			    price:{
				  required:true,
				  number:true
				}
			},
			messages: {
				project: {
			    remote: "缴费项目已存在"
		        },
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
<form action="${ctx}/sys/costitem!save.action" method="post"
	id="dataForm"><input type="hidden" name="id" value="${id}" />
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      <s:if test="id == null">新增</s:if><s:else>修改</s:else>缴费项目(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">缴费项目名称<span class="STYLE1">*</span></td>
	          <td width="65%" >
	          	<input type="text" name="project" class="wid16" size="40" id="project" value="${project}"  <s:if test="id != null">disabled="disabled"</s:if> />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">费用单价<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="price" class="wid16" size="40" id="price" value="${price}" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">是否必须</td>
	          <td>
			   <s:checkbox id="need" name="need" theme="simple" value="need"></s:checkbox>
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
	          <td><input name="button" type="reset" class="bulebu" value="重置" /></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>