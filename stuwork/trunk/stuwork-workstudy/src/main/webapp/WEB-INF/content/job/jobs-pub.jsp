<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位发布列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;"> 
<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/job/jobs-pub!list.action" method="post">
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/company/company!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>岗位列表</strong></td>
          </tr>
		  <tr>
	          <td width="20%" height="25" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="10%" class="tbg03"><strong>性别限制</strong></td>
	          <td width="10%" class="tbg03"><strong>提交时间</strong></td>
	          <td width="10%" class="tbg03"><strong>发布时间</strong></td>	    
	          <td width="10%" class="tbg03"><strong>已聘人数</strong></td>	
	          <td width="10%" class="tbg03"><strong>招聘人数</strong></td>
	          <td width="10%" class="tbg03"><strong>招聘状态</strong></td>		          
	          <td width="10%" class="tbg03"><strong>审核状态</strong></td>	          
	          <td width="30%" class="tbg03"><strong>操作</strong></td> 
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${postName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexLimit}&nbsp;</td>    
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${createDate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${pubdate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${exisitCount}&nbsp;</td>	
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${reqCount}&nbsp;</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postStatusDesc}&nbsp;</td>  		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${auditDesc}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		      <s:if test="auditStatus=='shz'">
			  <a href="javascript:void(0);" onclick="pass('${id }','${ctx}/job/jobs-pub!pass.action');">审核通过</a>
			  <a href="${ctx}/job/jobs-pub!toReason.action?id=${id}">退回</a>
			  </s:if>
			  <a href="${ctx}/job/jobs-pub!detail.action?id=${id}">查看</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/turnpage.jsp"%>
      </td>
    </tr>
	</table>
</div>


</body>
</html>