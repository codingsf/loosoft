<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>绿色通道</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
	          
	        
		 	
		
			 $("#mainformsearch").click(function(){
				$("#searchForm").submit();
				 });
		  
			$("#submitDebt").click(function(){
				document.getElementById("searchForm").action="green!submitDebt.action";
				document.getElementById("searchForm").submit();
			});
	
	    }); 
	-->
	</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">	
	
<div class="emb"></div>
<!--startprint-->

<!-- 学生基本信息 -->
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
    <tr>
		<td bgcolor="#FFFFFF">	
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>学生基本信息</strong></td>
          </tr>
          <tr>
	          <td  height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">学号&nbsp;</td>
	          <td >${student.studentNo }</td>
		      <td  height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10"  rowspan="4">相片&nbsp;</td>
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="4"> <img src="${img }" name="img" height="70" width="70" id="img" alt="" /> <br /> </td>	
        </tr>
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名&nbsp;</td>
	          <td >
		           ${student.name }
	          </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">性别&nbsp;</td>
	          <td >
		         ${student.sexdesc }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">院系&nbsp;</td>
	          <td >
		      ${student.collegeName}
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${student.majorName}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		           ${student.IDcard}
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">班级&nbsp;</td>
	          <td  width="30%">
		       ${student.className}
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">考生号&nbsp;</td>
	          <td  width="35%">
		      ${student.examineeNo}
	          </td>
        </tr>
        
          <tr>
	          <td height="30" width="20%" align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">出生年月&nbsp;</td>
	          <td  width="30%"  bgcolor="#F1F4F9">
		      ${student.birthday}
	          </td>
	           <td height="30" width="15%" align="right"  bgcolor="#F1F4F9"  class="tbg01 pr10">通知书编号&nbsp;</td>
	          <td  width="35%"  bgcolor="#F1F4F9">
		      ${student.noticeId}
	          </td>
        </tr>
        
		</table> 
		</td>  
	</tr>
	
	
	</table>
</div>

<!-- 交费详情 -->
<div class="mid1003_r">
  
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    <tr>
		<td bgcolor="#FFFFFF">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>交费详情</strong></td>
          </tr>
		  <tr>
		 
	          <td width="10%" class="tbg03" height="25"><strong>费用类别</strong></td>
	          <td width="10%" class="tbg03"><strong>费用标准(元)</strong></td>
	          <td width="10%" class="tbg03"><strong>已交金额(元)</strong></td>
	          <td width="10%" class="tbg03"><strong>缓交金额(元)</strong></td>
	          <td width="5%" class="tbg03"><strong>欠费金额(元)</strong></td>
	          
	          
	          
		  </tr>
		  <s:iterator  value="payStudentVoList" status="status" >
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${type }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${money }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${payedMoney}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${debtMoney}&nbsp;</td>     
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${money-payedMoney-debtMoney}&nbsp;</td>  
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	</table>

</div>
<!--endprint-->
<br />
<div style="text-align: center" class="mid1003_r">
  <!-- 
  <input name="button" type="button" class="bulebu" value="打 印"  onclick="execPrint()" /> &nbsp;&nbsp;
   --> 
  <input name="button" type="button" class="bulebu" value="返 回"   onclick="history.back();" />
</div>	
</body>
</html>