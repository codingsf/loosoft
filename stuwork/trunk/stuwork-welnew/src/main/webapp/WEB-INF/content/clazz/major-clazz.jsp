<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>专业分班情况列表</title>
    <link href="../css/newpage.css" rel="stylesheet" type="text/css" />
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

		//分班
    	function assignClazz(id){
			var personNum = $("#personNum").val();
			if(personNum==''){
				alert("请输入班级预设人数！");
				return;
			}
        	if(!confirm("确认班级预设人数,"+personNum+"人？")){
            	return;
        	}
            	
			window.location="${ctx}/clazz/clazz-assign!autoAssign.action?majorClazzInfoId="+id+"&personNum="+personNum;
        }
	-->
	</script>

</head>
<body style="background: #E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<!-- 
<div class="caozuo">
  <ul>
    <li><a href="student!input.action"><span>全部分班</span></a></li>
  </ul>
</div>
-->
<!--  
<div class="xzwz">
<h1>自动分班</h1>
</div>
-->

<div class="emb"></div>
<div class="mid1003_r">
    <h3>
		分班设置：  班级预设人数:			
		<input type="text" name="personNum" id="personNum" value="${personNum }"/>
	</h3>
</div> 
<div class="mid1003_r">
<form action="${ctx}/residence/residence!deletes.action" method="post"
	id="deleteForm">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	style="border-left: 1px solid #B4C8D3; border-right: 1px solid #B4C8D3;">

	 <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>自动分班</strong></td>
          </tr>
		  <tr>
		      <td  width="9%"  height="25" class="tbg03"><strong>入学批次</strong></td>
	          <td width="13%" class="tbg03"><strong>院系</strong></td>
	          <td width="13%"  class="tbg03"><strong>专业</strong></td>
	          <td width="7%"  class="tbg03"><strong>学生类别</strong></td>
	          <td width="7%" class="tbg03"><strong>学生人数</strong></td>
	          <td width="7%" class="tbg03"><strong>班级数量</strong></td>
	          <td width="32%" class="tbg03"><strong>班级</strong></td>
	          <td width="7%"  class="tbg03"><strong>分班状态</strong></td>
	          <td  class="tbg03"><strong>操作</strong></td> 
		  </tr>
		  <s:iterator id="obj" value="dataList" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.welbatch }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.collegeDepartName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.majorName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.typedesc }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.studentNums }&nbsp;</td> 
		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.clazzNums }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.clazzs }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.assigned?"是":"否" }&nbsp;</td>       
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		       <c:choose>
			      <c:when test="${obj.assigned}">
			        <a href="#" onclick="assignClazz(${obj.infoId});">再分班</a>
			      </c:when>
			      <c:otherwise>
			        <a href="#" onclick="assignClazz(${obj.infoId});">分班</a>
			      </c:otherwise>
			   </c:choose>
           </td>
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
</table>
</form>
</div>


</body>
</html>