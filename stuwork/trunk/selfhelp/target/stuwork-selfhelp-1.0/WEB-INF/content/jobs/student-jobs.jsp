<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>学生申请岗位查询</title>
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
	          
			$("#delbut").click(
			   function(){
			       if($("input:checked").length==0) {
			            alert("没有可删除记录,请勾选");
			            return false;
			       } 
			       if(!confirm('您确定要删除吗?')) return  false;
	
				   $("#deleteForm").submit();
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
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/jobs/student-jobs!list.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="7%" align="right" style="padding-left:5px">申请时间 从：</td>
            <td width="13%" align="center"><input name="startPub" id="pubdate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" /></td>
            <td width="7%" align="right">到：</td>
            <td width="13%" align="center"><input name="endPub" id="pubdate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" /></td>
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/school/specialty!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>学生申请岗位查询</strong></td>
          </tr>
		  <tr>
		      
	          <td width="10%" height="25" class="tbg03"><strong>姓名</strong></td>
	          <td width="10%" class="tbg03"><strong>学号</strong></td>
	          <td width="10%" class="tbg03"><strong>申请岗位</strong></td>
	          <td width="10%" class="tbg03"><strong>申请时间</strong></td>
	          <td width="68%" class="tbg03"><strong>申请原因</strong></td>
	          
		  </tr>
		  <s:iterator value="stujobLists" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentNo}&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${jobsName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${applyDate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${applyReason}</td>
		    
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