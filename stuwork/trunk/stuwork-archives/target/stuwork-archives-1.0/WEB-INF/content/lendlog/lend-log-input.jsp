<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="/common/taglibs.jsp"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案调阅</title>
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
			planDate: "required",
			remark: "required",
			operater:"required",
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
			if($("#file").val()==""){
				if(window.confirm("您确定不提供调档函扫描件吗？")){			
				    return true;
			    }else{
                    return false;
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
<form action="${ctx}/lendlog/lend-log!save.action" method="post"
	id="dataForm" enctype="multipart/form-data">
	<input name="stuNo" value="${stuNo }" type="hidden" /> 
	<input type="hidden" name="lendDate" value="<%=sdf.format(new Date())%>">
	
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案调阅</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">调阅单位<span class="redz">* </span></td>

          <td width="65%" ><input type="text" name="organization" value="${organization }" id="organization" /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">计划归还时间<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	          <input name="planDate" id="planDate"
			value="<fmt:formatDate value="${planDate}" type="date" pattern="yyyy-MM-dd hh:MM:ss"/>"
			type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />   
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">调档函扫描件&nbsp;</td>
          <td>
            <input type="file" name="file" id="file" />
          </td>
        </tr>
        <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">调阅经办人<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <input type="text" id="operater" name="operater" value="${operater }" />

          </td>
       </tr>
         
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" id="submitbut" type="submit"  class="bulebu"value="保 存" /></td>
          <td><input name="button" type="button"  class="bulebu" value="取 消" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	

</form>
</body>
</html>