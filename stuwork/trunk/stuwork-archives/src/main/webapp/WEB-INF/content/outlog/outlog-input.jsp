<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案调出</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#organization").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			organization: "required",
			outDate: "required",
			operater: "required",
			isbn:"required",
			type:"required",
			remarkselect:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				}
			}
		});
		$("#dataForm").submit(function(){
			if($("#organization").val()==""){
				return false;
			}
			if($("#type").val()==""){
				return false;
			}
			if($("#isbn").val()==""){
				return false;
			}
			if($("#organization").val()==""){
				return false;
			}
			if($("#operater").val()==""){
				return false;
			}
			if($("#picfile").val()==""){
				if(window.confirm("你确定不提供调档函扫描件吗？")){
								
				return true;
			}else{
                return false;
			}
		}

			
			});
		
	});
	
</script>
<script type="text/javascript">
function changeRemark(){
	if(document.getElementById("remarkselect").value=="其他"){
		document.getElementById("shuru").innerText="请输入其他理由";
		document.getElementById("remark").value="";
		}else{
		document.getElementById("shuru").innerText="";
		document.getElementById("remark").value=document.getElementById("remarkselect").value;
		}
}


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
<form action="${ctx}/outlog/outlog!save.action" method="post"
	id="dataForm" enctype="multipart/form-data">
	<input name="stuId" value="${stuId }" type="hidden" />
	<input name="outDate" value="<%=sdf.format(new Date()) %>" type="hidden" />

<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案调出(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">调档单位<span class="redz">* </span></td>

          <td width="65%" ><input type="text" name="organization" id="organization" value="${organization }" /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调档方式<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	          <s:select list="outTypeList" id="type" listKey="value"
			listValue="value" theme="simple" name="type" headerKey=""
			headerValue="请选择" value="type"></s:select> 
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">调档存根<span class="redz">* </span></td>
          <td>
           <input type="text" name="isbn" id="isbn" value="${isbn }" />
          </td>
        </tr>
        <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">调档理由<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <s:select list="reasonList" id="remarkselect" theme="simple"
			onchange="changeRemark()" listKey="value" listValue="value"
			headerKey="" headerValue="请选择" value="remark"></s:select>

          </td>
       </tr>
       <tr>
          <td height="30" align="right"  class="tbg02 pr10">理由&nbsp;</td>
          <td >
	         <textarea name="remark" id="remark" cols="30" rows="3">${remark }</textarea>
          </td>
       </tr>
       
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调档函扫描件&nbsp;</td>
          <td bgcolor="#F1F4F9">
	        <input type="file" name="picfile" value="${picfile }" id="picfile" />
          </td>
       </tr>
       
        <tr>
          <td height="30" align="right"  class="tbg02 pr10">调档经办人<span class="redz">* </span></td>
          <td >
	        <input type="text" id="operater" value="${operater }" name="operater" />
          </td>
       </tr>
       
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">调出地址&nbsp;</td>
          <td bgcolor="#F1F4F9">
	         <textarea name="address" cols="30" rows="3" id="address">${address }</textarea>
          </td>
       </tr>
         
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="submitbut" type="submit" class="bulebu" value="保存" /></td>
          <td><input name="button" type="button" class="bulebu" value="取消" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>


</form>
</body>
</html>