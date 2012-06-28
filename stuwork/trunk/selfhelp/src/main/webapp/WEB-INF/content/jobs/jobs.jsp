<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>申请岗位</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="searchForm" action="${ctx}/jobs/jobs.action" method="post">
	<input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<form action="" method="post" id="deleteForm">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">岗位列表</td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		      <td width="17%" height="25" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="16%" class="tbg03"><strong>性别限制</strong></td>
	          <td width="19%" class="tbg03"><strong>招聘人数</strong></td>
	          <td width="19%" class="tbg03"><strong>发布时间</strong></td>
	          <td width="19%" class="tbg03"><strong>已报名人数</strong></td>
	          <td width="15%" class="tbg03"><strong>操作</strong></td>

		  </tr>
		  <s:iterator value="dtoLists" status="status" var="dtoList">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${dtoList.postName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${dtoList.sexLimit }</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${dtoList.exisitCount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${dtoList.pubdate}" type="date" pattern="yyyy-MM-dd" />&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${dtoList.reqCount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<a href="${ctx}/jobs/jobs!agreeCommitment.action?id=${id }">申请&nbsp;</a><a href="${ctx}/jobs/jobs!detail.action?id=${id}">查看</a>
			</td>
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/commonPage.jsp" %>
      </td>
    </tr>
	
	
	</table>
	</form>
</div>

</body>
</html>