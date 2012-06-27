<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>编辑档案库位</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#project").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			area: "required",
			rank:{
				required:true,
				digits:true
				},
			storow:{
			required:true,
			digits:true
			},
			stocolumn:{
				required:true,
				digits:true
				}
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
.STYLE1 {
	color: #FF0000
}
-->
</style>

</head>
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<form id="dataForm" name="dataForm" action="${ctx}/store/store!save.action" method="post">
   <input type="hidden" name="id" value="${id}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      档案库位(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">区域<span class="redz">* </span></td>

          <td width="65%" ><input type="text" name="area" value="${area }"  /><span style="color:red;">${actionMessage }</span></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">排<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	         <input type="text" name="rank" class="wid16"
			     style="height: 15px;" id="rank" value="${rank}" />自动生成<input type="checkbox" value="1" name="checkTrue" />
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">行<span class="redz">* </span></td>
          <td>
            <input type="text" name="storow" class="wid16" style="height: 15px;" id="row" value="${storow}" />
          </td>
          </tr>
          <tr>

          <td height="30" align="right"   class="tbg02 pr10">列<span class="redz">* </span></td>
          <td>
            <input type="text" name="stocolumn" class="wid16" style="height: 15px;" id="column" value="${stocolumn}" />
          </td>
          </tr>   
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="submitbut" type="submit" class="bulebu" value="确 定" /></td>

          <td><input name="button" type="button" class="bulebu" value="返 回" onclick="history.back();" /></td>
          <td> <input name="button" type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	
</form>


</body>
</html>