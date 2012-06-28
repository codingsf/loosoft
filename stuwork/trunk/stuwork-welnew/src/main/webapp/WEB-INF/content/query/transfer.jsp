<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>转移登记查询</title>
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
    <li><a href="#" id="delbut"><span>导出</span></a></li>
  </ul>
</div>

<form id="searchForm" action="${ctx}/student/student!list.action" method="post">
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>
<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
    <th >学号</th>
    <th >姓名</th>
    <th >性别</th>
    <th >学院</th>
    <th >专业</th>
    <th >班级</th>
    <th >缴费项目</th>
    <th >缓交金额</th>
  </tr>
  <s:iterator value="page.result" status="stat">
  <tr>
    <td>${welbatch.comname }&nbsp;</td>
    <td>${collegeName }${departName }</td>
    <td>${majorName }&nbsp;</td>
    <td>${className }&nbsp;</td>
    <td>${examineeNo }&nbsp;</td>
    <td>${IDcard }&nbsp;</td>
    <td>${name }&nbsp;</td>
    <td>${IDcard }&nbsp;</td>
  </tr>
</s:iterator>
</table>
</form>
<%@ include file="/common/turnpage.jsp" %>
</body>
</html>