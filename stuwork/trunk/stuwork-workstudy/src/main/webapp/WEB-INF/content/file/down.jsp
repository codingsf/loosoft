<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>文件下载</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	
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
	
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <form id="searchForm" name="searchForm" action="../file/upload!down.action" method="post">

	<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
	<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
	<input type="hidden" name="page.order" id="order" value="${page.order}" />
	</form>
    
    
    <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>文件下载</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="10%" class="tbg03"><strong>文件别名</strong></td>
	          <td width="10%" class="tbg03"><strong>文件名称</strong></td>
	          <td width="7%" class="tbg03"><strong>上传日期</strong></td>
	          <td width="10%" class="tbg03"><strong>上传人</strong></td>
	          <td width="10%" class="tbg03"><strong>备注</strong></td>
	          <td width="8%" class="tbg03"><strong>操作</strong></td>
	          
	          
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		${fileName}
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${fileRealName}&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${uploadDate}" type="date"
				pattern="yyyy-MM-dd" />
			</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				${uploadUser}
			</td>  
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${remark }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/file/down.action?id=${id}"><span>下载</span></a>
		    </td>
		    
		  </tr>
		  </s:iterator>
		</table> 
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