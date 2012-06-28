<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>打印预览</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<!--startprint-->
<div style="text-align: center">
<h2>安徽科技学院新生入学资格审查结果通知</h2>
</div>
<div class="mid1003_r">
${name}&nbsp;同学:<br/><br/>
<s:if test="noPassCheckItems.size != 0">
	你因&nbsp;以下&nbsp;审核项目未能通过入学资格审查,请按下列办法处理:<br/><br/>
</s:if>
<s:else>
	<font color="gray">恭喜你已通过所有的审查项目！</font>
</s:else>
</div>
<s:if test="noPassCheckItems.size != 0">
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    <tr>
		<td bgcolor="#FFFFFF">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		 <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>审查未过项目</strong></td>
          </tr>
		  <tr>
	          <td width="30%" class="tbg03" height="25"><strong>审查项目</strong></td>
	          <td width="70%" class="tbg03"><strong>处理办法</strong></td>
		  </tr>
		  <s:iterator value="noPassCheckItems" status="status" >
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${project }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${solution }&nbsp;</td>      
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	</table>
</div>
</s:if>
<!--endprint--> <br />
<div style="text-align: center" class="mid1003_r">
  <input name="button" type="button" class="bulebu" value="打 印" onclick="execPrint()" /> &nbsp;&nbsp; 
  <input name="button" type="button" class="bulebu" value="返 回" onclick="history.back();" />
</div>	
</body>
</html>