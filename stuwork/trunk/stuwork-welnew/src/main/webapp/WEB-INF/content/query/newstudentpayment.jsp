<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>新生缴费查询</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
	<script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>
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
<body>
<div class="caozuo">
  <ul>
    <li><a><span id="queryButton">显示查询</span></a></li>
  </ul>
</div>

<form id="searchForm" action="${ctx}/query/newstudentpayment!list.action" method="post">
	<h3>
		考生号：<input type="text" name="filter_LIKES_student$examineeNo" value="${param['filter_LIKES_student$examineeNo']}" style="width: 100px"/>		
	   	姓名：<input type="text" name="filter_LIKES_student$name" value="${param['filter_LIKES_student$name']}" style="width: 100px"/>
	    批次:<s:select id="batchselect" theme="simple" list="batches" listKey="id" listValue="comname" name="filter_EQL_student$welbatch$id"
			 headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_student$welbatch$id)"/>
	    院系:<s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="filter_EQL_student$collegeCode"
			 headerKey="" headerValue="请选择" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_collegeCode)"/>
	    专业:<s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
	    班级:<s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
	   
	      <span class="btn2"><a href="javascript:void(0);" id="mainformsearch"  title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);" id="mainformreset" href="javascript:search();" title="重置查询条件"><span>重置查询条件</span></a></span>
	      <input type="reset" style="display:none;" id="resetbutton"/>
	</h3>
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>
<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
  	<th>入学批次</th>
    <th >学号</th>
    <th >考生号</th>
    <th >姓名</th>
    <th >性别</th>
    <th >学院</th>
    <th >专业</th>
    <th >班级</th>
    <th >缴费项目</th>
    <th >缴费金额</th>
  </tr>
  <s:iterator value="page.result" status="stat">
  <tr>
   <td>${student.welbatch.comname }</td>
    <td>${student.studentNo }</td>
    <td>${student.examineeNo }</td>
    <td>${student.name }</td>
    <td>${student.sexdesc }</td>
    <td>${student.collegeName }</td>
    <td>${student.majorName }</td>
    <td>${student.className }</td>
    <td>${costItem.project }&nbsp;</td>
    <td>${payedMoney }&nbsp;</td>
  </tr>
</s:iterator>
</table>
</form>
<%@ include file="/common/turnpage.jsp" %>

<div>
<span class="btn">
   <a href="${ctx }/query/newstudentpayment!printExcel.action"><span>导出Excel</span></a>
</span>
</div>
</body>
</html>