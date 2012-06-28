<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="cn.loosoft.stuwork.common.entity.user.SecurityUser"%>
<%@page import="org.springside.modules.security.springsecurity.SpringSecurityUtils"%><html>
<head>
<title>岗位列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
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
			 
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
	    }); 
	-->
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
	          	<li><a href="jobs-apply!input.action" >新增</a></li>            
	           	<li><a href="#" id="delbut">删除</a></li>
			    <li><a href="#" id="queryButton">隐藏查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="jobs-apply.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
	            <td >
		                            岗位名称: <input type="text" name="filter_LIKES_postName" value="${param['filter_LIKES_postName']}" style="width: 100px"/><!--&nbsp;
	                                       发布时间:  从: 
	               <input name="filter_GED_createdate" id="startdate" value="${param.filter_GED_createdate}" type="text" class="Wdate"onclick="WdatePicker()" size="12"/>
		                            到: <input name="endPub" id="createdate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
		               <input name="endPostTime" id="endPostTime" value="${param.endPostTime}" type="text" class="Wdate" onclick="WdatePicker()"  size="12"/>
		           &nbsp;
		          -->
		          <input type="submit" class="ybu" value="查 询" />&nbsp;
		          <input type="reset" id="resetbutton" class="ybu" value="重 置" />
	            </td>
		  </tr>
        </table>
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/job/jobs-apply!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>岗位列表</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="20%" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="20%" class="tbg03"><strong>发布单位</strong></td>
	          <td width="15%" class="tbg03"><strong>性别限制</strong></td>
	          <td width="15%" class="tbg03"><strong>申请时间</strong></td>          
	          <td width="28%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${obj.id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${company.companyName }&nbsp;</td>    		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexLimit }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${createDate}" type="date" pattern="yyyy-MM-dd" />&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="#" onclick="delOneRecord('${id }','${ctx}/job/jobs-apply!delete.action');">删除</a>
			    <a href="${ctx}/job/jobs-apply!input.action?id=${id}">修改</a>
			    <a href="${ctx}/job/jobs-apply!detail.action?id=${id}">查看</a>
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
</div>
</body>
</html>