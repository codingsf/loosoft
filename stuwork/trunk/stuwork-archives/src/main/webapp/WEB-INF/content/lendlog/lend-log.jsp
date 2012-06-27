<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>档案调阅记录</title>
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

         $("#delbut").click(
      		   function(){
      		       if($("input:checked").length==0) {
      		            alert("没有可删除记录,请勾选");
      		            return false;
      		       } 
      		       if(!confirm('您确定要删除吗?')) return  false;

      			   $("#deleteForm").submit();
      	 });

         $("#checkboxall").click(function(){
		     $("input[name='ids']").attr("checked",$(this).attr("checked"));
		});

  		$("#queryButton").click();

  		 $("#printexcel").click(function(){
  			document.getElementById("searchForm").action="lend-log!printExcel.action";
  			document.getElementById("searchForm").submit();
  		 });
    }); 
-->
</script>
	<script>
function search(){
	document.getElementById("searchForm").action="lend-log!list.action";
	document.getElementById("searchForm").submit();
}
	</script>
</head>
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">

<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	            <li><a href="#" id="delbut">删除</a></li>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/lendlog/lend-log!list.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">学号:</td>
	            <td width="13%" align="center"><input type="text" name="filter_EQS_stuId"   class="wid100px" /></td>
	            <td width="7%" align="right" style="padding-left:5px">姓名:</td>
	            <td width="13%" align="center"><input type="text" name="filter_EQS_name" class="wid100px" /></td>
	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center"></td>
	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center"></td>
		  </tr>
		  
		  <tr>
			    <td width="8%"><input  type="submit" class="ybu" value="查 询" /></td>
	            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
	            <td></td>
	            <td></td>
		  </tr>
        </table>
           <input type="hidden" name="page.pageNo" id="pageNo"value="${page.pageNo}" /> 
           <input type="hidden" name="page.orderBy"id="orderBy" value="${page.orderBy}" />
           <input type="hidden"name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>调阅记录</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="15%" class="tbg03" height="25"><strong>学号</strong></td>
	          <td width="10%" class="tbg03"><strong>姓名</strong></td>
	          <td width="15%" class="tbg03"><strong>调阅组织</strong></td>
	          <td width="10%" class="tbg03"><strong>调阅时间</strong></td>
	           <td width="10%" class="tbg03"><strong>计划归还时间</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
	          
	          
	          
		  </tr>
		  <s:iterator  value="page.result"  status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${obj.id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${stuId }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${organization}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${lendDate }" pattern="yyyy-MM-dd" type="Date" />&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${planDate }" pattern="yyyy-MM-dd" type="Date" />&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		     <a href="#" onclick="delOneRecord('${id }','${ctx}/lendlog/lend-log!delete.action');">删除</a>
			 <a href="${ctx}/lendlog/lend-log!detail.action?id=${id}&stuNo=${stuId}">详情</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/turnpage.jsp"%>
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