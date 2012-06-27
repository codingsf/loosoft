<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增学生信息</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>

	<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#examineeNo").focus();
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
			    examineeNo:{
		          required:true,
		          digits:true
		        } ,
			    IDcard:{
		         required:true,
		         digits:true
		        },
		        mark:"digits",
			    name:"required",
			    sex:"required",
			    collegeCode:"required",
			    collegeCode:"required",
			    batchId:"required",
			    length:"required",
				telephone:"digits",
				orderNum:"digits",
			    type:"required"
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
     新生信息（<span class="STYLE1">*</span>为必填）
  </h1>
</div>
	<form id="dataForm" name="dataForm" action="${ctx}/student/student!save.action" method="post" onsubmit="return submitForm(this)" >
	 <input type="hidden" name="id" value="${id}"/>
	<table class="tbhs1">
	  <tr>
	    <th width="25%">考生号<span class="STYLE1">*</span></th>
	    <td width="25%"><input id="examineeNo" name="examineeNo"  value="${examineeNo }" type="text" class="wid40" /></td>
	    <th width="25%">身份证号<span class="STYLE1">*</span></th>
	    <td width="25%"><input id="IDcard" name="IDcard"  value="${IDcard}" type="text" class="wid40" /></td>
	  </tr>
	  <tr>
	    <th>姓名<span class="STYLE1">*</span></th>
	    <td><input id="name" name="name"  value="${name}" type="text" class="wid40" /></td>
	    <th>高考分数&nbsp;</th>
	    <td><input id="mark" name="mark"  value="${mark}" type="text" class="wid40" /></td>
	  </tr>
	  <tr>
	    <th>性别&nbsp;</th>
	    <td>

	    <s:radio list="sexes" name="sex" key="" id="sex" theme="simple" listKey="value" listValue="label"></s:radio>
	    </td>
	    <th>名族&nbsp;</th>
	    <td><input id="nation" name="nation"  value="${nation}" type="text" class="wid40" /></td>
	  </tr>
	  <tr>
	    <th>电话&nbsp;</th>
	    <td><input id="telephone" name="telephone"  value="${telephone}" type="text" class="wid40" /></td>
	    <th>联系地址&nbsp;</th>
	    <td><input id="address" name="address"  value="${address}" type="text" class="wid40" /></td>
	  </tr>
	  <tr>
	    <th>生源地&nbsp;</th>
	    <td><input id="testaddr" name="testaddr"  value="${testaddr}" type="text" class="wid40" /></td>
	    <th>培养层次&nbsp;</th>
	    <td><input id="gradation" name="gradation"  value="${gradation}" type="text" class="wid40" /></td>
	    <th>录取校区&nbsp;</th>
	    <td>
	     <select name="schareaCode">
	       <option>--请选择校区--</option>
	     </select>
	    </td>
	  </tr>
	  <tr>
	    <th>批次<span class="STYLE1">*</span></th>
	    <td>
	    <s:select list="batches" theme="simple" name="batchId" id="batchId" listKey="id" listValue="comname" headerKey="" headerValue="--请选择批次--"></s:select>
	    </td>
	    <th>录取院系<span class="STYLE1">*</span></th>
	    <td>
	     <s:select list="collegues" theme="simple" name="collegeCode" id="collegeselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择院系--"></s:select>
	    </td>
	  </tr>
	  <tr>
	    <th>录取专业&nbsp;</th>
	    <td>
	     <s:select list="majors" name="majorCode" theme="simple" id="majorselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择专业--"></s:select>
	      <select name="majorCode" id="majorselect">
	        <option>--请选择专业--</option>
	     </select>
	    </td>
	    <th>录取班级&nbsp;</th>
	    <td>
	      <s:select list="clazzes" theme="simple" name="classCode" id="clazzselect" listKey="code" listValue="name" headerKey="" headerValue="--请选择班级--"></s:select>
	      <select name="classCode" id="clazzselect">
	       <option>--请选择班级--</option>
	     </select>
	    </td>
	  </tr>
	  <tr>
	    <th>生源省份&nbsp;</th>
	     <td>
	     <select name="province">
	     <option value="">--请选择省份--</option>
	      <option value="安徽省">安徽省</option>
	    </select>
	    </td>
	    <th>学制<span class="STYLE1">*</span></th>
	    <td>
	     <s:select list="studentLengthList" name="length" id="length" listKey="value" listValue="label" headerKey="" headerValue="--请选择学制--" theme="simple"></s:select>
        </td>
	  </tr>
	  <tr>
       <th>学生类别<span class="STYLE1">*</span></th>
	    <td>
	    <s:select list="studentTypeList" name="type" id="type" listKey="value" listValue="label" headerKey="" headerValue="--请选择类别--" theme="simple"></s:select>
	    </td>
	    <th>&nbsp;</th>
	    <td></td>
	      <th>培养层次&nbsp;</th>
	    <td><input id="gradation" name="gradation"  value="${gradation}" type="text" class="wid40" /></td>
	  </tr>
     <tr>
      <td colspan="4" style="text-align: center">
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