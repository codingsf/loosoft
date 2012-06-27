<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>按专业统计</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
		   
		   $("#printexcel").click(function(){
				document.getElementById("dataForm").action="major-count!printExcel.action";
				document.getElementById("dataForm").submit();
			});
	    }); 
	-->
	</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
       <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">按专业统计</td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
	   <form action="" id="dataForm" name="dataForm" method="post">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
	          <td width="20%" class="tbg03" height="25"><strong>学院</strong></td>
	          <td width="20%" class="tbg03"><strong>专业</strong></td>
	          <td width="10%" class="tbg03"><strong>状态</strong></td>
	          <td width="10%" class="tbg03"><strong>人数</strong></td>
	          <td width="10%" class="tbg03"><strong>专业总人数</strong></td>
	                  
		  </tr>
		  <s:iterator  value="majorVOs"  status="status">
		  <tr>
	
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${collegeName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${amount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${total }&nbsp;</td> 
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>	
	
	</table>
	<br/>
	<div>
		<span class="btn2">
			<c:set value="[]" var="temp"></c:set>
			<c:if test="${tempList ne temp}">
			   <div>
			   	   <a href="javascript:void(0)" id="printexcel" name="printexcel"><span>导出Excel</span></a> 
			       <span style="color:red;">${actionMessage }</span> 
				</div>
			</c:if>
		</span>
	</div>
</div>



</body>
</html>