<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>编辑报到时间</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			startdate:"required",
			enddate:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				}
			}
		});
	});


	function check(){
		 var startdate=$("#startdate").val();
		 var enddate=$("#enddate").val();
		 var tip = $("#message");
		 if(startdate>enddate){
			    tip.addClass("onError");
			    tip.html("开始时间不能大于结束时间");
			    return false;
	      }else{
	    	    tip.removeClass();
				tip.html("");
		  }
    }
</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
.onError {
	color: red;
	font-weight: bold;
	background: transparent url(${ctx}/js/validate/images/unchecked.gif) no-repeat scroll left bottom;
	padding-left: 18px;
}
.onSuccess {
	background: transparent url(${ctx}/js/validate/images/checked.gif) no-repeat scroll left bottom;
}
-->
</style>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form action="${ctx}/sys/registertime!save.action" method="post" id="dataForm" onsubmit="return check();">
  <input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	报到时间段设置
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">开始时间<span class="STYLE1">*</span></td>
	          <td width="65%" >
	          	<input name="startdate" id="startdate"
					value="<fmt:formatDate value="${startdate}" type="date" pattern="yyyy-MM-dd"/>"
					type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" /><span id="message"></span>
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">结束时间<span class="STYLE1">*</span></td>
	          <td bgcolor="#F1F4F9">
	          	<input name="enddate" id="enddate"
					value="<fmt:formatDate value="${enddate}" type="date" pattern="yyyy-MM-dd"/>"
					type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
	          </td>
	        </tr>

	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td width="30%"><input name="submitbut" type="submit" class="bulebu" value="提交" /></td>
	          <td><input name="button" type="submit" class="bulebu" value="返回" onclick="history.back();"/></td>
<!--	          <td><input name="button" type="reset" class="bulebu" value="重置" /></td>-->
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>