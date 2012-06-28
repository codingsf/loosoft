<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>列表户籍列表</title>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
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
    <li><a href="residence-input.action" ><span>新增</span></a></li>
    <li><a href="#" id="delbut"><span>删除</span></a></li>
    <li><a><span id="queryButton">显示查询</span></a></li>
  </ul>
</div>
<form id="searchForm" action="common/user/list.html" method="post">
<div id="filter" class="fenye" style="display: none">
	<h3>
	    入学批次:<select><option>请选择</option><option>植物科学学院</option></select>
	    学院:<select><option>请选择</option><option>植物科学学院</option></select>
	    系:<select><option>请选择</option><option>农学系</option><option>植物系</option></select>
	    专业:<select><option>请选择</option><option>农学院</option></select>
	    班级:<select><option>请选择</option><option>农学院</option></select>
	    状态:<select><option>请选择</option><option>已迁入</option><option>未迁入</option></select>
	        <span class="btn2"><a href="javascript:search();" title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:search();" title="查 询"><span>重置查询条件</span></a></span>
	</h3>
 <div class="clear"></div>
</div> 
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>

<form action="${ctx}/residence/residence!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
    <th class="wid10px">
      <label>
        <input type="checkbox" id="checkboxall"/>
        </label>
    </th>
    <th >入学年份</th>
    <th >院系</th>
    <th >专业</th>
    <th >班级</th>
    <th >姓名</th>    
    <th >身份证号</th>
    <th >性别</th>
    <th >迁移证号</th>
    <th >原户籍所在地</th>
    <th >现户籍所在地</th>
    <th >操作</th>
  </tr>
  <s:iterator id="obj" value="dataList" status="stat">
  <tr>
    <td><input type="checkbox" id="ids" name="ids" value="${obj.id }" /></td>  
    <td>${obj.welbatch.comname }&nbsp;</td>
    <td>${obj.coldepartdesc }&nbsp;</td>
    <td>${obj.majorName }&nbsp;</td>  
    <td>${obj.className }&nbsp;</td>    
    <td>${obj.student.name }&nbsp;</td>  
    <td>${obj.idCardNo }&nbsp;</td>      
    <td>${obj.student.sexdesc }&nbsp;</td>
    <td>${obj.migrateNo }&nbsp;</td>      
    <td>${obj.origAddress }&nbsp;</td>       
    <td>${obj.curAddress }&nbsp;</td>                             
    <td><a href="${ctx}/residence/residence!input.action?id=${obj.id}">修改</a> </td>
  </tr>
  </s:iterator>
</table>
</form>
</body>
</html>