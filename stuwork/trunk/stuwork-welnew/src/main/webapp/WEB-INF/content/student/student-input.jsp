<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增学生信息</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#examineeNo").focus();

		//普通座机号：+0086-010-66668888   
		jQuery.validator.addMethod("isPhone", function(value, element) {
			 var patrn = /^[+]{0,1}(\d){1,4}[ ]{0,1}([-]{0,1}((\d)|[ ]){1,12})+$/;
			    var s = $('#telephone').val();  
			    if(s==null || ''==s){
				    return true;
				} 
			    if(!patrn.exec(s)) {   
			        return false;   
			    }   
			    return true;   
		}, "请正确输入联系电话");
				
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
			    examineeNo:{
		          required:true,
		          digits:true
		        } ,
			    IDcard:"required",
		        mark:"digits",
			    name:"required",
			    sex:"required",
			    collegeCode:"required",
			    batchId:"required",
			    length:"required",
				telephone:{ 
					isPhone:true
		        },	
				orderNum:"digits",
			    type:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				},
				examineeNo:"请输入考生号",
				name:"请输入姓名",
				IDcard:"请输入身份证号",
				batchId:"请选择批次",
				collegeCode:"请选择院系",
				length:"请选择学制",
				type:"请选择类别",
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
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">	
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/student/student!save.action" method="post" >
<input type="hidden" name="id" value="${id}"/>
	
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      新生信息(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">

        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		        <input id="examineeNo" name="examineeNo"  value="${examineeNo }" type="text" class="wid40" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		        <input id="IDcard" name="IDcard"  value="${IDcard}" type="text" class="wid40" />
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">姓名<span class="redz">* </span></td>
	          <td  >
		        <input id="name" name="name"  value="${name}" type="text" class="wid40" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">高考分数<span class="redz">* </span></td>
	          <td  >
		       <input id="mark" name="mark"  value="${mark}" type="text" class="wid40" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">性别&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         <s:radio list="sexes" name="sex" key="" id="sex" theme="simple" listKey="value" listValue="label"></s:radio>
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">民族<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		        <input id="nation" name="nation"  value="${nation}" type="text" class="wid40" />
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">电话&nbsp;</td>
	          <td  >
		         <input id="telephone" name="telephone"  value="${telephone}" type="text" class="wid40" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">联系地址&nbsp;</td>
	          <td  >
		        <input id="address" name="address"  value="${address}" type="text" class="wid40" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">生源地&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         <input id="testaddr" name="testaddr"  value="${testaddr}" type="text" class="wid40" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">培养层次&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="gradation" name="gradation"  value="${gradation}" type="text" class="wid40" />
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">批次<span class="redz">* </span></td>
	          <td  >
		         <s:select list="batches" theme="simple" name="batchId" id="batchId" listKey="id" listValue="comname" headerKey="" headerValue="请选择"></s:select>
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">录取学院&nbsp;</td>
	          <td  >
		       <s:select list="collegues" theme="simple" name="collegeCode" id="collegeselect" listKey="code" listValue="name" headerKey="" headerValue="请选择"></s:select>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取专业&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         <s:select list="majors" name="majorCode" theme="simple" id="majorselect" listKey="code" listValue="name" headerKey="" headerValue="请选择"></s:select>
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取班级<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		        <s:select list="clazzes" theme="simple" name="classCode" id="clazzselect" listKey="code" listValue="name" headerKey="" headerValue="请选择"></s:select>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">学生类别&nbsp;</td>
	          <td >
		        <s:select list="studentTypeList" name="type" id="type" listKey="value" listValue="label" headerKey="" headerValue="请选择" theme="simple"></s:select>
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">学制&nbsp;</td>
	          <td >
		        <s:select list="studentLengthList" name="length" id="length" listKey="value" listValue="label" headerKey="" headerValue="请选择" theme="simple"></s:select>
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