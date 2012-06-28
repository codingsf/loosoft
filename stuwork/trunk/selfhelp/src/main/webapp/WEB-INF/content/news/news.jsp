<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	<!--
	    $(document).ready(function(){
	         $("#queryButton").click(function(){
	                var helloDivObj = $("#filter");   
	                var buttonObj = $("#queryButton");   
	                var val = buttonObj.text();
	               if(val=="隐藏查询"){
	                    helloDivObj.hide(); 
	                    buttonObj.text("显示查询");  
	                }else{   
	                    helloDivObj.show();  
	                    buttonObj.text("隐藏查询"); 
	                }   
	          });
	    });
	-->
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="searchForm" action="${ctx}/news/news!list.action" method="post">
		<input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<form action="${ctx}/news/news!deletes.action" method="post" id="deleteForm">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">   
    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">勤工助学资讯</td>
    </tr>
    <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

		  <tr>
		      <td width="35%" height="25" class="tbg03"><strong><a href="${ctx}/news/news!detail.action?id=${id}">标题</a></strong></td>
	          <td width="16%" class="tbg03"><strong>发布时间</strong></td>
	          <td width="29%" class="tbg03"><strong>发布作者</strong></td>
	          <td width="25%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator value="dtoLists" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${title}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${pubdate}" type="date" pattern="yyyy-MM-dd" /></td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${pubuser }&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><a href="${ctx}/news/news!detail.action?id=${id}">查看详情</a></td>
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