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
<%@ include file="/common/meta.jsp"%>

<%@ include file="/common/jscss.jsp"%>
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
<body>
<div class="xzwz">
  <h1>
绿色通道
  </h1>
</div>

<table class="tbhs1">
<tr>
<th>学号</th><td><input readonly="readonly" type="text" value="${student.studentNo }" /></td>
<th>姓名</th><td><input readonly="readonly" type="text" value="${student.name }" /> </td>
</tr>
<tr>
<th>学院</th><td><input readonly="readonly" type="text" value="${student.collegeName }" /> </td>
<th>性别</th><td><input readonly="readonly" type="text" value="${student.sexdesc }" /> </td>
</tr>
<tr>
<th>专业</th><td><input readonly="readonly" type="text" value="${student.majorName }" /> </td>
<th>出身年月</th><td><input readonly="readonly" type="text" value="" /></td>
</tr>
<tr>
<th>班级</th><td><input readonly="readonly" type="text" value="${student.className }" /> </td>
<th>身份证号</th><td><input readonly="readonly" type="text" value="${student.IDcard }" /> </td>
</tr>
</table >
<br />

<div class="xzwz">
  <h1>
交费详情
  </h1>
</div>
<table class="tbhs1">
<tr>
<th>费用类别</th>
<th>费用标准(元)</th>
<th>已缴费金额</th>
<th>缓交金额</th>
<th>缓交时间</th>
</tr>
<c:forEach items="${studentVoList}" var="stuvo" varStatus="i">
<tr>
<td>${stuvo.type }</td>
<td>${stuvo.money }</td>
<td>${stuvo.payedMoney }</td>
<td><input type="text" name="debtMoneyFilter${i.index }" value="${i.index }" /></td>
<td><input name="debtDateFilter${i.index }" 
							value="<fmt:formatDate value="${startdate }" type="date" pattern="yyyy-MM-dd"/>"
							type="text" class="Wdate" class="ipt wid20 "
							onclick="WdatePicker()" /></td>
</tr>
</c:forEach>
</table>

</body>
</html>