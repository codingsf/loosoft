<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>逐个转移</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
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


	         $("#queryButton").click();

	          $("#submitDevolver").click(function(){
	        	  document.getElementById("searchForm").action="devolver!submitDevolver.action";
	        	  document.getElementById("searchForm").submit();
		          });
	          
	    }); 
	 
	</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<form id="searchForm" name="searchForm" action="${ctx}/devolver/devolver!searchStudent.action" method="post">
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>逐个转移</strong></td>
          </tr>
		</table> 
		
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="10%" style="padding-left:5px"> <s:radio list="radioList" listKey="value" listValue="label" id="column" name="filter_EQS_filterColumn" value="#parameters.filter_EQS_filterColumn" theme="simple"></s:radio> </td>
	            <td width="7%" ><input type="text" value="${param.value }" name="value" id="value" class="wid100px" /></td>
	            <td width="8%" align="right" ><input  type="button" id="mainformsearch" class="ybu" value="查 询" />&nbsp;<input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
	            <td width="8%"></td>
	            <td width="8%"></td>
		  </tr>
        </table>
	
	
		
		</td>  
	</tr>
	
	
	</table>
</div>

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
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="4"> <img src="${student.img }" name="img" height="70" width="70" id="img" alt="" /> <br /> </td>	
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
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>转移记录</strong></td>
          </tr>
		  <tr>
		 
	          <td width="10%" class="tbg03" height="25"><strong>类别</strong></td>
	          <c:forEach items="${devolverVOList}" var="deItem">
	            <td width="10%" class="tbg03"><strong>${deItem.name }</strong></td>
	          </c:forEach>
	          
	          
	          
		  </tr>
		  <s:iterator  value="payStudentList" status="status" >
		  <tr>
		    <td class="br05" height="25">是否转移&nbsp;</td>
		    <c:forEach items="${devolverVOList}" var="deItem">
			    <td class="br05">
			       ${deItem.devolverDesc }&nbsp;
			    </td>
		    </c:forEach>     
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
          <button type="button" id="submitDevolver" class="bulebu">确认转移</button>
	      </td>
        </tr>
      </table></td>
    </tr>

	</table>

</div>
</form>


</body>
</html>