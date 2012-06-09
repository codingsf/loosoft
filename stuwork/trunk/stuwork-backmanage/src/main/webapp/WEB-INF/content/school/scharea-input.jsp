<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改校区</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#code").focus();
		//为inputForm注册validate函数
		$("#dataForm").validate({
			rules: {
				code: "required",
				name:"required"
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
<body>
<div class="xzwz">
  <h1>
  <s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      学校校区（<span class="STYLE1">*</span>为必填）
  </h1>
</div>
<form id="dataForm" name="dataForm" action="${ctx}/school/scharea!save.action" method="post" onsubmit="return SubmitUser(this)" >
    <input type="hidden" name="id" value="${id}"/>
	<table class="tbhs1">
	  <tr>
	    <th width="20%">校区代码<span class="STYLE1">*</span></th>
	    <td><input type="text" name="code" size="52" id="code" value="${code}"/>
	    </td>
	  </tr>
	  <tr>
	    <th>校区名称<span class="STYLE1">*</span></th>
	    <td><input type="text" name="name" size="52" id="name" value="${name}"/>
	    </td>
	  </tr>
	  <tr>
	    <th>校区地址&nbsp;</th>
	    <td colspan="3"><textarea name="address" rows="8" class="wid92 ipt hei40" 
			onmouseover="this.className='wid92 ipth hei40'"
			onmouseout="this.className='wid92 ipt hei40'" id="textfield2">${address}</textarea></td>
	  </tr>
    <tr>
      <td></td>
      <td colspan="3">
        <label></label>
        <input name="submitbut" type="submit" class="btn" value="确 定" />
        &nbsp;
        <input name="button"  type="button" class="btn" value="返 回" onclick="history.back();" />
        &nbsp;
        <input name="button"  type="reset" class="btn" value="重 置" />        </td>
    </tr>
	</table>
</form>
</body>
</html>