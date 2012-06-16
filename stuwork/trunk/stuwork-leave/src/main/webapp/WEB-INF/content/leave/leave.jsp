
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改批次</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script>
	String.prototype.trim=function(){  
	　　  return this.replace(/[ ]/g,""); 
	　　 }  

	
	$(document).ready(function() {
		var ids='${departmentids}';
		var idarray=ids.split(',');
		$("input[type=checkbox]").each(function()
		{
			var cbx=$(this);
			$.each(idarray, function(key, val) {
			   if(val.trim()==cbx.val())
			   {
				   cbx.attr("checked",true);
			   }
			});
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
<form id="dataForm" name="dataForm" action="${ctx}/leave/leave!save.action" method="post">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
		初始化部门
      </td>
    </tr>
    <s:actionmessage/>
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="20%" height="30" align="right" class="tbg02 pr10">选择部门</td>
	          <td width="80%" >
				<s:checkboxlist name="departmentids" list="instituteDTOs" listKey="code" listValue="name" theme="custom"/>
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