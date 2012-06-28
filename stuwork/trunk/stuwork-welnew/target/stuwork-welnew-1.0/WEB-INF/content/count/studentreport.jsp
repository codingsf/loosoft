<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新生通知书列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
	<div class="emb"></div>
	<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
		<tr>
	      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
		      <div class="tabhv">
		        <ul>
				    <li><a href="#" id="queryButton">统计结果</a></li>
		        </ul>
		      </div>
	      </td>
	    </tr> 
	</table> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>全校统计</strong></td>
          </tr>
		  <tr style="height: 35px;" >
	          <td width="12%" class="tbg03" align="right"><strong>应报到人数:</strong></td>
	          <td width="12%" class="tbg03"><strong>${countAllReport}</strong></td>
	          <td width="12%" class="tbg03" align="right"><strong>已报到人数:</strong></td>
	          <td width="12%" class="tbg03"><strong>${alreadyAllReport}</strong></td>
	          <td width="15%" class="tbg03" align="right"><strong>报到率:</strong></td>
	          <td class="tbg03"><strong>${noReport}%</strong></td> 
		  </tr> 
		  <tr><td colspan="6">&nbsp;</td> </tr>
		</table>  
	 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>各学院统计</strong></td>
          </tr>
		  <tr style="height: 25px;" >
	          <th width="20%" class="tbg03"><strong>学院名称</strong></th>
	          <th width="20%" class="tbg03"><strong>专业名称</strong></th>
	          <th width="20%" class="tbg03"><strong>应报到人数</strong></th>
	          <th width="20%" class="tbg03"><strong>已报到人数</strong></th>
	          <th width="20%" class="tbg03"><strong>报到率</strong></th>
		  </tr>      
          <s:iterator value="reportVOs" status="status">
		  <tr>
	          <td height="25px" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" width="20%">${collegeName }</td> 
	          <td height="25px" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" width="20%">${majorName }</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" width="20%" class="tbg03">${mustReportCount }</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" width="20%" class="tbg03">${alreadyReportCount }</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" width="20%" class="tbg03">${noReportCount }%</td>  
		  </tr> 
		  </s:iterator>
		</table> 		
</div>


</body>
</html>