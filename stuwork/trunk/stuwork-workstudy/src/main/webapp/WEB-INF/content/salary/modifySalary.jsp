<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>修改工资单</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript">
	
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#workStartTime").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				workStartTime:{
			      required:true
		        },
		        workStopTime:{
			      required:true
		        },
		        workTime:{
			      required:true,
			      maxlength:20
		        },
		        standard:{
			      required:true,
			      maxlength:20
		        },
		        amount:{
			      required:true,
			      maxlength:20
		        }
			},
			messages: {
				workStartTime:{
					required:"请输入工作开始日期"
				},
				workStopTime:{
					required:"请输入工作结束日期"
				},
				workTime:{
					required:"请输入工作时长",
					maxlength:"请输入一个长度最多是 20 的字符串"
				},
				standard:{
					required:"请输入工资标准",
					maxlength:"请输入一个长度最多是 20 的字符串"
				},
				amount:{
					required:"请输入工资金额",
					maxlength:"请输入一个长度最多是 20 的字符串"
				}
			}
		});
	});
	
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/salary/create-salary!save.action" method="post">
	<input type="hidden" name="id" value="${entity.id}" />
	<input type="hidden" name="postId" value="${entity.postId}" />
	<input type="hidden" name="companyId" value="${entity.companyId}" />
	<input type="hidden" name="examineeNo" value="${entity.studentNo}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      工资单(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">岗位名称<span class="redz">* </span></td>

          <td width="65%" ><input  type="text" readonly name="companyName" class="wid16" id="companyName" value="${entity.companyName }" /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">岗位<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	        <input type="text" readonly name="postName" class="wid16" id="postName" value="${entity.postName }" />	   
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">学生<span class="redz">* </span></td>
          <td>
            <input type="text" readonly name="studentName" class="wid16" id="studentName" value="${entity.studentName }" />
          </td>
          </tr>
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">工作开始时间<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
            <input name="workStartTime" id="workStartTime"
			value="<fmt:formatDate value="${entity.workStartTime}" type="date" pattern="yyyy-MM-dd"/>"
			type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
          </td>
          </tr>
          <tr>

          <td height="30" align="right"  class="tbg02 pr10">工作结束时间&nbsp;</td>
          <td >
            <input name="workStopTime" id="workStopTime"
			value="<fmt:formatDate value="${entity.workStopTime}" type="date" pattern="yyyy-MM-dd"/>"
			type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
          </td>
          </tr> 
          
           <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">工作时长<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <input type="text" name="workTime" class="wid16" id="workTime"
			value="${entity.workTime}" />
          </td>
          </tr>
          
           <tr>

          <td height="30" align="right"  class="tbg02 pr10">工作标准&nbsp;</td>
          <td >
            <input type="text" name="standard" class="wid16" id="standard"
			value="${entity.standard}" />
          </td>
          </tr> 
          
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">工资金额<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           
           <input type="text" name="amount" class="wid16" id="amount"
			value="${entity.amount}" />
          </td>
          </tr>
          
            <tr>

          <td height="30" align="right"  class="tbg02 pr10">评价&nbsp;</td>
          <td >
           <textarea name="comments">${entity.comments}</textarea>
     
          </td>
          </tr> 
          
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">备注<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
                  <textarea name="remark">${entity.remark}</textarea>
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