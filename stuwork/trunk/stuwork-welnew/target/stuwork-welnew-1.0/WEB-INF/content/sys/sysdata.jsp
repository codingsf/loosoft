<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>来校方式设置</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
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
<script type="text/javascript">
	function check(obj){
		
for(var i=1;i<=2;i++){
	if(obj==i){
		document.getElementById("shezhi"+obj).style.display="block";
		}else{
document.getElementById("shezhi"+i).style.display="none";
			}
}
    }
	</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<form action="${ctx}/sys/sysdata!deletes.action" method="post" id="deleteForm">
	
	<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" /> 
	<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}" /> 
	<input type="hidden" name="page.order" id="order" value="${page.order}" />
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
			  <li><a href="sysdata!input.action"><span>新增</span></a></li>
			  <li><a href="#" id="delbut"><span>删除</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>来校方式设置</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03"><input type="checkbox" id="checkboxall" /></td>
	          <td width="16%" class="tbg03"><strong>序号</strong></td>
	          <td width="30%" class="tbg03"><strong>来校方式</strong></td>
	          <td width="5%" class="tbg03"><strong>操作</strong></td>
	 
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><input type="checkbox" id="ids" name="ids" value="${id }" /></td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status.index+1}</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${setvalue }</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><a href="${ctx}/sys/sysdata!input.action?id=${id}">修改</a></td>
		    
		    
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      <%@ include file="/common/turnpage.jsp"%>
      </td>
    </tr>
	
	
	</table>
	</form>
</div>
</body>
</html>