<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>公寓用品发放记录列表</title>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/js.jsp" %>
    <script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>
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
				<li><a href="#" id="queryButton"><span>隐藏查询</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form action="${ctx}/wuzi/give-record.action" method="post" id="mainForm">
		<input type="hidden" name="filter_EQS_type" value="${params['filter_EQS_type'] }"/>
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="7%" align="right">批次:</td>
            <td width="13%" align="center">
            	<s:select id="batchselect" theme="simple" list="batches" listKey="id" listValue="comname" name="filter_EQL_welbatch$id"
			 	headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_welbatch$id)"/>
            </td>
            <td width="7%" align="right">院系:</td>
            <td width="13%" align="center">
            	<s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="filter_EQS_collegeCode"
			 	headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode"/>
            </td>
            <td width="7%" align="right">专业:</td>
            <td width="13%" align="center">
            	<s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
			 	headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
            </td>
            <td width="7%" align="right">班级:</td>
            <td width="13%" align="center">
            	<s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
			 	headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
            </td>
            <td width="7%" align="right">性别:</td>
            <td width="13%" align="center">
            	<s:select theme="simple" list="sexes" listKey="value" listValue="label" name="filter_EQS_sex"
			 	headerKey="" headerValue="请选择" value="#parameters.filter_EQS_sex"/>
            </td>
            <td width="7%" align="right">状态:</td>
            <td width="13%" align="center">
            	<s:select theme="simple" list="#{'1':'已发','0':'未发'}" name="filter_EQB_gived"
			 	headerKey="" headerValue="请选择" value="@java.lang.Integer@parseInt(#parameters.filter_EQB_gived)"/>
            </td>            
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" />
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
            </td>
            <!-- 
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" />
            </td>
            -->
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/wuzi/giveRecord!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>发放明细</strong></td>
          </tr>
		  <tr>
	          <td width="7%" class="tbg03" height="25"><strong>批次</strong></td>
	          <td width="10%" class="tbg03"><strong>院系</strong></td>
	          <td width="10%" class="tbg03"><strong>专业</strong></td>
	          <td width="7%" class="tbg03"><strong>班级</strong></td>
	          <td width="10%" class="tbg03"><strong>考生号</strong></td>
	          <td width="7%" class="tbg03"><strong>姓名</strong></td>
	          <td width="5%" class="tbg03"><strong>发放状态</strong></td>
	          <td width="10%" class="tbg03"><strong>发放清单</strong></td>
	          
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${welbatch.comname}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${coldepartdesc }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorName}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${className }</td>  
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${examineeNo }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${gived?"是":"否" }</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${giveList}</td>
		    
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