<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>报道须知管理列表</title>
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
			 
			 function useOneRecord(id,url){
			   			if(confirm('您确定要使用吗?'))return false;
			   	}
			 
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
			    <li><a href="${ctx }/noticeBook/report-notice!input.action"><span>新增</span></a></li>
    			<li><a href="#" id="delbut"><span>删除</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" action="${ctx}/noticeBook/report-notice.action" method="post">
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/noticeBook/report-notice!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="13" bgcolor="#F7E582" class="br002"><strong>报道须知管理</strong></td>
          </tr>
		  <tr>
	  		  <td width="1%" height="25" class="tbg03">
			  <label>
		          <input type="checkbox" id="checkboxall"/>
		      </label>
			  </td>
	          <td width="10%" class="tbg03"><strong>说明</strong></td>
	          <td width="7%" class="tbg03"><strong>状态</strong></td>
	          <td width="8%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${id }" />
		  	</td>   
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${introduce}&nbsp;</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			     <a href="#" onclick="delOneRecord('${id }','${ctx}/noticeBook/report-notice!delete.action');">删除</a>
			     <s:if test="status=='未用'">
			     <a href="${ctx}/noticeBook/report-notice!using.action?id=${id }">使用</a>
			     </s:if>
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