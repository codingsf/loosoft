<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
<title>新增or修改单位</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
jQuery.validator.addMethod("companyName", function(value, element) {
    return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
}, "单位名称只能包括中文字、英文字母和数字");  
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#companyName").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
				rules: {
				   companyName:{
			          required:true,
			          userName:true,
			          maxlength:20
		           },
		           manager:{
		           		required:true,
				      maxlength:20
		           },
		           phone:{
		           		required:true,
				      maxlength:20
		           },
				   address:{
				   		required:true,
				      maxlength:200
			       },
			        introduction:{
			           required:true,
			           maxlength:200
			       }
			     },
			messages: {
				companyName:{
					required:"请输入单位名称",
					maxlength:"请输入一个长度最多是 20 的字符串"
				},
				manager:{
					required:"请输入岗位负责人",
					maxlength:"请输入一个长度最多是 20 的字符串"
				},
				phone:{
					required:"请输入单位电话",
					maxlength:"请输入一个长度最多是 20 的字符串"
				},
				address:{
				    required:"请输入单位地址",
					maxlength:"请输入一个长度最多是 200 的字符串"
			    },
			    introduction:{
			    	required:"请输入单位简介",
					maxlength:"请输入一个长度最多是 200 的字符串"
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
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/company/company!save.action" method="post">
<input type="hidden" name="id" value="${id}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      单位(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">单位名称<span class="redz">* </span></td>

          <td width="65%" ><input type="text" name="companyName" class="wid30" id="companyName" value="${companyName}" /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">岗位负责人<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	         <input type="text" name="manager" class="wid30" id="manager" value="${manager}" />	   
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">联系电话<span class="redz">* </span></td>
          <td>
            <input type="text" name="phone" class="wid30" id="phone" value="${phone}" />
          </td>
          </tr>
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">地址<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <textarea name="address"  id="address">${address}</textarea>

          </td>
          </tr>
          <tr>

          <td height="30" align="right"  class="tbg02 pr10">单位简介<span class="redz">* </span></td>
          <td >
             <textarea name="introduction" id="introduction">${introduction}</textarea>
          </td>
          </tr> 
          <tr>
          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">备注</td>
          <td bgcolor="#F1F4F9">
          <textarea name="remark" id="remark">${remark}</textarea>

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