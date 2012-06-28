<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增学生信息</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/js.jsp" %>

	<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#building").focus();
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
			building:"required",
			floor:"required",
			room:"required",
			bedNo:"required",
			sex:"required"
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
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/room/bed!save.action" method="post" onsubmit="return submitForm(this)" >
	 <input type="hidden" name="assigned" value="false"/>
	 <input type="hidden" name="id" value="${id }"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      新增  床位信息(<span class="redz">*</span>为必填)
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">公寓楼<span class="STYLE1">*</span></td>
	          <td width="40%" >
	          	<input id="building" name="building"  value="${building }" type="text" class="wid40" />
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">楼层<span class="STYLE1">*</span></td>
	          <td width="40%" >
	          	<input id="floor" name="floor"  value="${floor}" type="text" class="wid40" />
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">寝室<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	<input id="room" name="room"  value="${room}" type="text" class="wid40" />
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">床位<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	<input id="bedNo" name="bedNo"  value="${bedNo}" type="text" class="wid40" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">性别<span class="STYLE1">*</span></td>
	          <td>
	          <s:radio list="sexes" name="sex" key="" id="sex" theme="simple" listKey="value" listValue="label"></s:radio>
			  </td>
			  <td height="30" align="right"  class="tbg02 pr10">院系<span class="STYLE1">*</span></td>
	          <td>
	          <s:select list="collegues" theme="simple" name="collegeCode" id="collegeselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择院系--"></s:select>
			  </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">专业<span class="STYLE1">*</span></td>
	          <td>
			  <s:select list="majors" name="majorCode" theme="simple" id="majorselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择专业--"></s:select>
			  </td>
			  <td height="30" align="right"  class="tbg02 pr10">班级<span class="STYLE1">*</span></td>
	          <td>
			  <s:select list="clazzes" theme="simple" name="classCode" id="clazzselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择班级--"></s:select> 
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