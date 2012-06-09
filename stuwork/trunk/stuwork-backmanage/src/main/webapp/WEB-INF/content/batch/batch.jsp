<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>批次列表</title>
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

			
	    }); 
	-->
	</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>
</head>





<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<form action="${ctx}/batch/batch!deletes.action" method="post" id="deleteForm">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	          <li><a href="batch!input.action">新增批次</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>批次列表</strong></td>
          </tr>
		  <tr>
		      <td width="17%" height="25" class="tbg03"><strong>批次年份</strong></td>
	          <td width="16%" class="tbg03"><strong>季节</strong></td>
	          <td width="19%" class="tbg03"><strong>开始时间</strong></td>
	          <td width="19%" class="tbg03"><strong>结束时间</strong></td>
	          <td width="14%" class="tbg03"><strong>是否当前批次</strong></td>
	          <td width="15%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator id="obj" value="dataList" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.year }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.season }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${obj.startdate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${obj.enddate}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.current?"是":"否" }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><a href="${ctx}/batch/batch!input.action?id=${obj.id}">修改</a> </td>
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      </td>
    </tr>
	
	
	</table>
	</form>
</div>






</body>
</html>