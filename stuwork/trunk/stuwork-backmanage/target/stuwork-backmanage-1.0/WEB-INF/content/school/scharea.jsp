<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>校区列表</title>
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
			   //$("#deleteForm").attr("action","${ctx}/school/scharea!deletes.action");

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
    <li><a href="scharea!input.action" ><span>新增校区</span></a></li>
    <li><a href="#" id="delbut"><span>删除</span></a></li>
  </ul>
</div>
<form action="${ctx}/school/scharea!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
    <th class="wid10px">
      <label>
        <input type="checkbox" id="checkboxall"/>
        </label>
    </th>
    <th >校区代码</th>    
    <th >名称</th>
    <th >地址</th>
    <th >操作</th>
  </tr>
  <s:iterator id="obj" value="allAreaList" status="stat">
  <tr>
    <td><input type="checkbox" id="ids" name="ids" value="${obj.id }" /></td>
    <td>${obj.code }&nbsp;</td>
    <td>${obj.name }&nbsp;</td>    
    <td>${obj.address }&nbsp;</td>
    <td><a href="${ctx}/school/scharea!input.action?id=${obj.id }">修改</a> <a href="#" onclick="delOneRecord('${obj.id }','${ctx}/school/scharea!delete.action');">删除</a></td>
  </tr>
  </s:iterator>
</table>
</form>
</body>
</html>