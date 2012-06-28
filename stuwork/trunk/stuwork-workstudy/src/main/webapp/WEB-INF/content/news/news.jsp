<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新闻列表</title>
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
			    <li><a href="news!input.action"><span>新增</span></a></li>
				<li><a href="#" id="delbut"><span>删除</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <form id="searchForm" action="${ctx}/news/news!list.action" method="post">
		<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}" /> 
	    <input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}" /> 
	    <input type="hidden" name="page.order" id="order" value="${page.order}" />
	</form>
    
    
    <tr>
		<td bgcolor="#FFFFFF">
		
		<form action="${ctx}/news/news!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>新闻列表</strong></td>
          </tr>
		  <tr>
		      <td width="4%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td class="tbg03"><strong>标题</strong></td>
	          <td width="12%" class="tbg03"><strong>发布时间</strong></td>
	          <td width="8%" class="tbg03"><strong>发布作者</strong></td>
	          <td width="8%" class="tbg03"><strong>访问次数</strong></td>
	          <td width="15%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><a href="${ctx}/news/news!detail.action?id=${id}">${title }</a>&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${pubdate}" type="date"
				pattern="yyyy-MM-dd" />
			</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				${pubuser }
			</td>  
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${clickscount }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			     <a href="#" onclick="delOneRecord('${id }','${ctx}/news/news!delete.action');">删除</a>
				 <a href="${ctx}/news/news!input.action?id=${id}">修改</a>
				 <a href="${ctx}/news/news!detail.action?id=${id}">查看</a> 
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