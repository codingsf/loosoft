<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>中心审核未过原因</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
	<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script> 
	<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>	
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#centerNoPassReason").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				centerNoPassReason:{
			      required:true
		        }
			},
			messages: {
				centerNoPassReason:{
					required:"请输入未通过原因"
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


<form id="dataForm" name="dataForm" action="${ctx}/salary/center-audit-salary!save.action" method="post">
	<input type="hidden" name="id" value="${entity.id}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">请填写未过原因(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="30%" height="30" align="right" class="tbg02 pr10">未过原因<span class="redz">* </span></td>

          <td width="70%" >
             <textarea name="centerNoPassReason" rows="4" cols="30" id="centerNoPassReason">${centerNoPassReason}</textarea>
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