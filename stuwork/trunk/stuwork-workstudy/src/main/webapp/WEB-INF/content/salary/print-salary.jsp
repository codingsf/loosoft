<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>打印工资单</title>
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
	
		$("#checkboxall").click(function(){
			$("input[name='ids']").attr("checked",$(this).attr("checked"));
		});
		
		$("#printbut").click(
		   function(){
		       if($("input:checked").length==0) {
		            alert("没有勾选记录,请勾选");
		            return false;
		       } 
		       if(!confirm('您确定要生成Excel吗?')) return  false;
			   
			   $("#printForm").submit();
		 }); 
	}); 	
	
	function print(id,url){
	  if(confirm('您确定要生成Excel吗?')){
	   $.ajax({
	            type: "post",
	            dataType: "html",
	            url: url,
	            data: "id=" + id,
	            success: function (msg) {
		            if (msg!=""){
		            	location.reload();
		            }
	            },
	            error: function() {
	                 alert("操作失败,请联系管理员");
	            }
	        });
	    }
	}
	
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">

<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	            <li><a href="#" id="printbut">生成Excel</a></li>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/salary/print-salary.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">岗位名称:</td>
	            <td width="13%" align="center"><input type="text" name="filter_LIKES_postName" value="${param['filter_LIKES_postName']}" style="width: 100px"/></td>
	            <td width="7%" align="right" style="padding-left:5px">学生姓名:</td>
	            <td width="13%" align="center">  <input type="text" name="filter_LIKES_studentName" value="${param['filter_LIKES_studentName']}" style="width: 100px"/></td>
	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center"></td>
		  </tr>
		  
		  <tr>
			    <td  colspan="8" width="100%">
			       		工作开始 从：<input name="startWorkStartTime" id="workStartTime"
				type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
		        到：<input name="endWorkStartTime" id="workStartTime"
			    type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
	     工作结束 从：<input name="startWorkStopTime" id="workStopTime"
				type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
		        到：<input name="endWorkStopTime" id="workStopTime"
			    type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
			    </td>
		  </tr>
		  <tr>
			    <td colspan="7" align="right"><input  type="submit" class="ybu" value="查 询" /><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
			    <td width="7%">&nbsp;</td>
		  </tr>
        </table>
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/job/jobs-apply!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>打印工资单</strong></td>
          </tr>
		  <tr>
		     <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="8%" class="tbg03" height="25"><strong>岗位名称</strong></td>
	          <td width="6%" class="tbg03"><strong>学生姓名</strong></td>
	          <td width="10%" class="tbg03"><strong>工作开始时间</strong></td>          
	          <td width="10%" class="tbg03"><strong>工作结束时间</strong></td>
	          <td width="6%" class="tbg03"><strong>工作时长</strong></td>
	          <td width="6%" class="tbg03"><strong>工资标准</strong></td>          
	          <td width="6%" class="tbg03"><strong>工资金额</strong></td>          
	          <td width="6%" class="tbg03"><strong>银行名称</strong></td>
	          <td width="11%" class="tbg03"><strong>银行账户</strong></td>
	          <td width="6%" class="tbg03"><strong>是否已生成</strong></td>
	          <td width="6%" class="tbg03"><strong>操作</strong></td>
	          
	          
	          
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${postName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${workStartTime}" type="date" pattern="yyyy-MM-dd" />&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${workStopTime}" type="date" pattern="yyyy-MM-dd" />&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${workTime }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${standard }&nbsp;</td>
		    
		    
		        <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${amount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${bankName }&nbsp;</td> 
		        <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${bankAccount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${isPrint }&nbsp;</td> 
			<td>
			    <a href="${ctx}/salary/print-salary!print.action?id=${id}">生成Excel</a>
				<!--  
				<a href="javascript:void(0);" onclick="print('${id }','${ctx}/salary/print-salary!print.action');">生成Excel</a>
				-->
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
</div>




</body>
</html>