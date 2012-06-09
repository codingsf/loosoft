<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>用户列表</title>
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
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	          	<li><a href="user!input.action" >新增用户</a></li>
				<li><a href="#" id="delbut">删除</a></li>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="user.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="7%" align="right" style="padding-left:5px">登录名:</td>
            <td width="13%" align="center">
            	<input name="filter_EQS_loginName" type="text" size="12" value="${param['filter_EQS_loginName']}"/>
            </td>
            <td width="7%" align="right">姓名或Email:</td>
            <td width="13%" align="center">
            	<input name="filter_LIKES_name_OR_email" type="text" size="12" value="${param['filter_LIKES_name_OR_email']}"/>
            </td>
            <td width="7%" align="right">用户类型:</td>
            <td width="13%" align="center">
            	<s:select list="#{0:'学生',1:'老师'}" name="filter_EQI_type"   headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQI_type)" theme="simple"></s:select>
            </td>
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/account/user!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="16" bgcolor="#F7E582" class="br002"><strong>用户列表</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="3%" class="tbg03"><strong>登录名</strong></td>
	          <td width="5%" class="tbg03"><strong>姓名</strong></td>
	          <td width="6%" class="tbg03"><strong>用户类型</strong></td>
	          <td width="10%" class="tbg03"><strong>邮箱</strong></td>
	          <td width="10%" class="tbg03"><strong>所属学院</strong></td>
	          <td width="10%" class="tbg03"><strong>所属专业</strong></td>
	          <td width="10%" class="tbg03"><strong>所属班级</strong></td>
	          <td width="10%" class="tbg03"><strong>角色</strong></td>
	          <td width="10%" class="tbg03"><strong><a href="javascript:sort('createDate','asc')">创建时间</a></strong></td>
	          <td width="8%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${obj.id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.loginName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.type==0?'学生':'老师' }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.email}&nbsp;</td>   
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.instituteName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.specialtyName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.clazzName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.roleNames}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		    	<fmt:formatDate value="${obj.createDate }" type="date" pattern="yyyy-MM-dd"/>
		    </td>
		     
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/account/user!input.action?id=${obj.id }">修改</a> 
			    <a href="#" onclick="delOneRecord('${obj.id }','${ctx}/account/user!delete.action');">删除</a>
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
	<br/>
	
</div>
</body>
</html>