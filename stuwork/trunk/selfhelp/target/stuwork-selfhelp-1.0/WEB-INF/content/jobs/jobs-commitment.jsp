<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>承诺书</title>
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
	  
	  function apply(id,url){
   		$.ajax({
            type: "post",
            dataType: "html",
            url: url,
            data: "id=" + id,
            success: function (msg) {
	            if (msg!=""){
	                    alert("申请成功");
	            }
	        },
            error: function() {
                 alert("操作失败,请联系管理员");
            }
        });
	}
	
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form action="${ctx}/jobs/jobs!toApplyReason.action" method="post">
<input type="hidden" name="id" id="id" value="${jobsId}"/>
<div class="mid1003_r">


  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  align="center" style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	${commitmentDTO.name}
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="left" class="tbg02 pr10">${commitmentDTO.content}</td>
	        </tr>
  
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td align="center">
	          	<input name="submitbut" type="submit" class="btn" value="同 意" /> &nbsp; 
				<input name="button" type="button" class="btn" value="不 同 意" onclick="history.back();" />
			  </td>
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>