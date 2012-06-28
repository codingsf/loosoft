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
		  <tr style="height: 25px;" >
	          <th width="20%" class="tbg03"><strong>项目名称</strong></th>
	          <th width="20%" class="tbg03"><strong>应转移人数</strong></th>
	          <th width="20%" class="tbg03"><strong>转移人数</strong></th>
	          <th width="20%" class="tbg03"><strong>未转移人数</strong></th>
	          <th width="20%" class="tbg03"><strong> 转移率</strong></th>
		  </tr>           
          <s:iterator value="qxList" status="status">
		  <tr>
	          <td height="25px" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${itemname}</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${znum}</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${ynum}</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${vnum}</td> 
	          <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${rate}</td> 
		  </tr> 
		  </s:iterator>
		</table>  
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>各学院统计</strong></td>
          </tr>
            <tr style="height: 25px;" >
              <th width="20%" class="tbg03"><strong>学院名称</strong></th>
	          <th width="15%" class="tbg03"><strong>项目名称</strong></th>
	          <th width="15%" class="tbg03"><strong>应转移人数</strong></th>
	          <th width="15%" class="tbg03"><strong>转移人数</strong></th>
	          <th width="20%" class="tbg03"><strong>未转移人数</strong></th>
	          <th width="15%" class="tbg03"><strong> 转移率</strong></th>
		  </tr>         
          <s:iterator value="devolverLists" status="status">
          	<td width="15%"  height="25px" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${collegeName}</td>
          	<td colspan="5" width="20%">
          		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			        <s:iterator value="devolvers" status="status">
						<tr>
					          <td width="19%" height="25px" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${itemname}</td> 
					          <td width="18%" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${znum}</td> 
					          <td width="19%" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${ynum}</td> 
					          <td width="24%" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${vnum}</td> 
					          <td width="19%" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"  class="tbg03">${rate}</td> 
						</tr> 
					</s:iterator>
		  		</table>
          	</td> 
		  <tr><td>&nbsp;</td></tr>
		  </s:iterator>
		</table>
		
</div>


</body>
</html>