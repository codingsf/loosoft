<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>用户类型列表</title>
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
	    }); 
	-->
	</script>

</head>
<body>
<div class="caozuo">
  <ul>
    <li><a href="user-type!input.action" ><span>新增用户类型</span></a></li>    
  </ul>
</div>
<form id="searchForm" name="searchForm" action="user-type.action" method="post">
<!-- 
<div id="filter" class="fenye" style="display: none">
	<h3>
	登录名: <input type="text" name="filter_EQS_loginName" value="${param['filter_EQS_loginName']}" size="9"/>
	姓名或Email: <input type="text" name="filter_LIKES_name_OR_email" value="${param['filter_LIKES_name_OR_email']}" size="9"/>
	<span class="btn2"><a href="javascript:search();" title="查 询"><span>查 询</span></a></span>
	</h3>
 <div class="clear"></div>
</div> 
 -->
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>

<form action="${ctx}/account/user!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
  <!--
    <th class="wid10px">
      <label>
        <input type="checkbox" id="checkboxall"/>
      </label>
    </th>
   -->
    <th>标识</th>
    <th>类型</th>  
    <!-- 
 	<th align="center" width="15%" class="bodyText th">操作</th> 
 	 -->         
  </tr>
  
  <s:iterator  value="page.result">
  <tr>
    <td>${id}&nbsp;</td>
    <td>${type }&nbsp;</td>  
    <!-- 
    <td><a href="${ctx}/account/user!input.action?id=${obj.id }">修改</a> <a href="#" onclick="delOneRecord('${obj.id }','${ctx}/account/user!delete.action');">删除</a></td>
     -->  
  </tr>
  </s:iterator>
</table>
</form>
<jsp:include page="/common/turnpage.jsp"></jsp:include>
</body>
</html>