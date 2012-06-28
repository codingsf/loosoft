<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生工资查询</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
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

			$("#queryButton").click();
			
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
	    }); 
	-->
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
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/jobs/salary!list.action" method="post">
			<input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
		</form>
		
		<form action="" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="10" bgcolor="#F7E582" class="br002"><strong>我的工资</strong></td>
          </tr>
		  <tr>
		      
	          <td width="5%" height="25" class="tbg03"><strong>姓名</strong></td>
	          <td width="10%" class="tbg03"><strong>考生号</strong></td>
	          <td width="10%" class="tbg03"><strong>岗位</strong></td>
	          <td width="15%" class="tbg03"><strong>单位名称</strong></td>
	          <td width="10%" class="tbg03"><strong>工作开始时间</strong></td>
	          <td width="10%" class="tbg03"><strong>工作结束时间</strong></td>
	          <td width="5%" class="tbg03"><strong>工作时长</strong></td>
	          <td width="5%" class="tbg03"><strong>工资标准</strong></td>
	          <td width="5%" class="tbg03"><strong>工资</strong></td>
	          <td width="5%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator value="salaryDTOList" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${examineeNo}&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${companyName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${workStartTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${workStopTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>   
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${workTime}</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${standard}</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${amount}</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		    	<a href="${ctx}/jobs/salary!detail.action?id=${id}">查看</a>
		    </td>
		    
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/commonPage.jsp" %>
      </td>
    </tr>
	
	
	</table>
	<br/>
	
</div>
</body>
</html>