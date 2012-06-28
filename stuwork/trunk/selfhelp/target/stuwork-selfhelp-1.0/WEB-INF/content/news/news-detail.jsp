<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻详情</title>
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
<form id="searchForm" action="${ctx}/news/news!list.action" method="post">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	新闻详情
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">标题 </td>
	          <td width="90%" >
	          	${entity.title}
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">发布时间 </td>
	          <td bgcolor="#F1F4F9">
	          	<fmt:formatDate value="${entity.pubdate}" type="date" pattern="yyyy-MM-dd" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">发布作者 </td>
	          <td>
	          	${entity.pubuser}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">访问次数 </td>
	          <td bgcolor="#F1F4F9">
	          	${entity.clickscount}
	          </td>
	        </tr>
	        	
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">内容</td>
	          <td>
	          	${entity.content}
	          </td>
	        </tr>
  
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td><input name="button" type="submit" class="bulebu" value="返回" onclick="history.back();"/></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>