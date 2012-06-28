<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位审批进度查询</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
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
<body>
<div class="xzwz">
<h1>岗位审批进度查询</h1>
</div>
<div class="caozuo">
<ul>
	<li><a><span id="queryButton">显示查询</span></a></li>
</ul>
</div>
<form id="searchForm" action="${ctx}/query/jobs-check-query!list.action" method="post">
<div id="filter" class="fenye" style="display: none">
	<h3>
          岗位名称: <input type="text" name="filter_LIKES_postName" value="${param['filter_LIKES_postName']}" style="width: 100px"/>
	审核状态: <s:select list="statusList" listKey="value" listValue="label" headerKey="" headerValue="请选择" name="filter_EQS_auditStatus" value="#parameters.filter_EQS_auditStatus" ></s:select>
	<span class="btn2"><a href="javascript:search();"   title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);" id="mainformreset" href="javascript:search();" title="重置查询条件"><span>重置查询条件</span></a></span>
	<input type="reset" style="display:none;" id="resetbutton"/>
	</h3>
 <div class="clear"></div>
</div> 
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" /> 
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}" /> 
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success" /></div>
<table class="tbhs" width="95%">
	<tr>
		<th>岗位名称</th>
		<th>性别限制</th>
		<th>发布时间</th>
		<th>招聘截止时间</th>
		<th>招聘人数</th>
		<th>已招聘人数</th>
	    <th>招聘状态</th>
	    <th>审核状态</th>
		<th>操作</th>
	</tr>
	<s:iterator value="page.result">
		<tr>
			<td>${postName }&nbsp;</td>		
			<td>${sexLimit}&nbsp;</td>
			<td><fmt:formatDate value="${pubdate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
			<td><fmt:formatDate value="${stopdate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
	        <td>${reqCount}&nbsp;</td>
	        <td>${exisitCount}&nbsp;</td>
	        <td>${postStatusDesc}&nbsp;</td>
	        <td>${auditStatusDesc}&nbsp;</td>
			<td>
			 <a href="${ctx}/query/jobs-check-query!detail.action?id=${id}">查看</a>
			</td>
		</tr>
	</s:iterator>
</table>
<%@ include file="/common/turnpage.jsp"%>
</body>
</html>