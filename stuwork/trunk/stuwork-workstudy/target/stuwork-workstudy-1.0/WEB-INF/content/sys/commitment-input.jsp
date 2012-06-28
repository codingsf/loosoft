<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改承诺书</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
	$(document).ready(function(){
			$("#dataForm").validate({
				rules: {
					name:{
				      required:true,
				      maxlength:20
			        },
			        content:{
				      required:true
			        }
				},
				messages: {
					name:{
						required:"请输入承诺书名称"
					},
					content:{
						required:"请输入承诺书内容"
					}
				}
			});
	  }); 
	
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/sys/commitment!save.action" method="post">
    <input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	修改承诺书（<span class="STYLE1">*</span>为必填）
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">名称<span class="STYLE1">*</span></td>
	          <td width="65%" >
	          	<input type="text" name="name" class="wid30" id="name" value="${name}"/>
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">内容<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	 <textarea name="content">${content}</textarea>
				 <script type="text/javascript">
					createCkEditor("${ctx}/fckeditor/","content",640,500,"MyToolbar",'${curUser.id}','${curUser.createYm}',true,80,'replace');
			     </script>
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
	          <td><input name="button" type="button" class="bulebu" value="返回" onclick="history.back();"/></td>
	          <td><input name="button" type="button" class="bulebu" value="重置" /></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>