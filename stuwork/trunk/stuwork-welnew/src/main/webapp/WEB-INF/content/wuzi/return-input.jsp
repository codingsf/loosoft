<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>退还管理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
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
          
		  $("#checkboxall").click(function(){
			     $("input[name='returnIds']").attr("checked",$(this).attr("checked"));
			});

		  $("#submitbut").click(function(){
			  if(!confirm('您确定要退还确认吗?')) return  false;

			     $("#dataForm").attr("action","${ctx}/wuzi/give!returnInput.action");
			     $("#dataForm").submit();
			 
			});
		
          
		  $("#queryButton").click();
	});
</script>

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
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
				<li><a href="#" id="queryButton"><span>显示/隐藏查询</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form action="${ctx}/wuzi/give!search.action?type=ff" method="post" id="searchForm">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="13%" align="right" style="padding-left:5px">通知书编号:</td>
            <td width="13%" align="center">
            	<input type="text" name="noticeId" id="noticeId" value="${noticeId}" class="wid100px" />
            </td>
            <td width="7%" align="right">考生号:</td>
            <td width="13%" align="center">
            	<input type="text" name="examineeNo" id="examineeNo" value="${ examineeNo}" class="wid100px" />
            </td>
            <td width="7%" align="right">身份证号:</td>
            <td width="13%" align="center">
            	<input type="text" name="IDcard" value="${IDcard }" id="IDcard" class="wid100px" /> 
            </td>
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		
		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002">
              	<strong>学生基本信息</strong>
              </td>
            </tr>
            
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">学号</td>
	          <td width="40%" >
	          	${student.studentNo }
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10" rowspan="4">相片</td>
	          <td width="40%" rowspan="4">
	          	<img src="${img }" name="img" height="70" width="70" id="img" alt="" />
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名</td>
	          <td bgcolor="#F1F4F9">
	          	${student.name }
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">性别</td>
	          <td >
	          	${student.sexdesc}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">院系</td>
	          <td bgcolor="#F1F4F9">
	          	${student.collegeName}
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">专业</td>
	          <td width="40%" >
	          	${student.majorName}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">身份证号</td>
	          <td width="40%" >
	          	${student.IDcard}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	${student.className}
	          </td>
	           <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	${student.examineeNo}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">出生年月</td>
	          <td width="40%" width="30" >
	          	${student.birthday}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">通知书编号</td>
	          <td width="40%" width="30" >
	          	${student.noticeId}
	          </td>
	        </tr>

	        
	    </table>
		
		<form method="post" id="dataForm" name="dataForm">
		<input name="examineeNo" id="examineeNo" value="${student.examineeNo }"  type="hidden"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002">
              	<strong>领取明细</strong>
              	
              </td>
          </tr>
         
		  <tr>
		  	  <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="5%" class="tbg03"><strong>类别</strong></td>
	          <td width="10%" class="tbg03"><strong>费用标准(元)</strong></td>
	          <td width="10%" class="tbg03"><strong>已缴费金额(元)</strong></td>
	          <td width="7%" class="tbg03"><strong>欠费金额(元)</strong></td>
	          <td width="10%" class="tbg03"><strong>是否领取</strong></td>
	          <td width="10%" class="tbg03"><strong>退还缘由</strong></td>
	          
		  </tr>
		  <s:iterator value="extendVOList" status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		    	<input type="checkbox" id="returnIds" name="returnIds" value="${id }" />
		    </td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${project}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${price }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${payedMoney}&nbsp;</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${unPayedMoney }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${received?"是":"否" }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><input type="text" name="reason_${id}"/></td>  
		    
		  </tr>
		  </s:iterator>
		</table> 
		<br />
		
		
		</form>
		</td>  
	</tr>
	
	<tr>
       <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td>
	          <input name="submitbut" type="submit" id="submitbut" class="bulebu" value="确认退还"  <c:if test="${student eq null}">disabled="disabled" </c:if>  />
	          </td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
	
      	
	
	</table>
	
</div>
</body>
</html>