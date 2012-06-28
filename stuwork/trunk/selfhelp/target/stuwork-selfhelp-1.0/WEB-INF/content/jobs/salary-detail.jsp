<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生工资详情</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
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
<form id="dataForm" name="dataForm" method="post">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      		学生工资详情
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">姓名&nbsp;</td>
	          <td width="40%" >
	          	${entity.studentName}
	          </td>
	          <td width="15%" height="30" align="right" class="tbg02 pr10">考生号&nbsp;</td>
	          <td width="35%" >
	          	${entity.examineeNo}
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">岗位&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.postName}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">单位名称&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.companyName}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">工作开始时间&nbsp;</td>
	          <td>
	          	<fmt:formatDate value="${entity.workStartTime}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	          <td height="30" align="right"  class="tbg02 pr10">工作结束时间&nbsp;</td>
	          <td>
	          	<fmt:formatDate value="${entity.workStopTime}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">工作时长&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.workTime}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">工资标准&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.standard}
	          </td>
	        </tr>
	        	
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">工资&nbsp;</td>
	          <td>
	          	 ${entity.amount}
	          </td>
	          <td height="30" align="right" class="tbg02 pr10">制单日期&nbsp;</td>
	          <td>
	          	 <fmt:formatDate value="${entity.createDate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">银行名称&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	 ${entity.bankName}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">银行账户&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	 ${entity.bankAccount}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">小组审核状态&nbsp;</td>
	          <td >
	          	${entity.groupStatusDesc}
	          </td>
	          <td height="30" align="right" class="tbg02 pr10">小组审核未通过原因&nbsp;</td>
	          <td >
	          	${entity.groupNoPassReason}
	          </td>
	        </tr>

	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">中心审核状态&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.centerStatusDesc}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">中心审核未通过原因&nbsp;</td>
	          <td bgcolor="#F1F4F9">
	          	${entity.centerNoPassReason}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">单位评价&nbsp;</td>
	          <td>
	          	 ${entity.comments}
	          </td>
	          <td height="30" align="right" class="tbg02 pr10">备注&nbsp;</td>
	          <td>
	          	 ${entity.remark}
	          </td>
	        </tr>
  
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td align="center">
	          <input name="button" type="button" class="bulebu" value="返回" onclick="history.back();"/>
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