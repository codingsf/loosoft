<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>工资单列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
	
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
		}); 
	
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
			    <li><a href="#" id="queryButton">隐藏查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" action="${ctx}/salary/create-salary!modifyList.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="12%" align="left" style="padding-left:5px">岗位名称:</td>
            <td width="13%" align="center">
            	<input type="text" name="filter_LIKES_postName" value="${param['filter_LIKES_postName']}"/>
            </td>
            <td width="12%" align="left">学生姓名:</td>
            <td width="13%" align="center">
            	<input type="text" name="filter_LIKES_studentName" value="${param['filter_LIKES_studentName']}" />
            </td>
            <td width="13%" align="right">小组审核:</td>
            <td width="13%" align="center">
            	<s:select id="statusselect" theme="simple" list="statusList" listKey="value" listValue="label" name="filter_EQS_groupStatus"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_groupStatus"/>
            </td>
            <td width="13%" align="right">中心审核:</td>
            <td width="13%" align="center">
            	<s:select id="statusselect" theme="simple" list="statusList" listKey="value" listValue="label" name="filter_EQS_centerStatus"
			 	headerKey="" headerValue="请选择" value="#parameters.filter_EQS_centerStatus"/>
            </td>
         </tr>
         <tr>
            <td width="13%" align="right">工作开始时间 从：</td>
            <td width="13%" align="center">
            	<input name="startWorkStartTime" id="workStartTime"
				type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            <td width="3%" align="right">到：</td>
            <td width="13%" align="center">
            	<input name="endWorkStartTime" id="workStartTime"
			    type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            <td width="13%" align="right">工作结束时间 从：</td>
            <td width="13%" align="center">
            	<input name="startWorkStopTime" id="workStopTime"
				type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            <td width="3%" align="right">到：</td>
            <td width="13%" align="center">
            	<input name="endWorkStopTime" id="workStartTime"
			    type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>工资单列表</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="13%" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="6%" class="tbg03"><strong>学生姓名</strong></td>
	          <td width="6%" class="tbg03"><strong>工作开始日期</strong></td>
	          <td width="6%" class="tbg03"><strong>工作结束日期</strong></td>
	          <td width="6%" class="tbg03"><strong>工作时长</strong></td>
	          <td width="5%" class="tbg03"><strong>工资标准</strong></td>
	          <td width="5%" class="tbg03"><strong>工资金额</strong></td>
	          <td width="5%" class="tbg03"><strong>小组审核</strong></td>
	          <td width="18%" class="tbg03"><strong>小组未通过原因</strong></td>
	          <td width="5%" class="tbg03"><strong>中心审核</strong></td>
	          <td width="18%" class="tbg03"><strong>中心未通过原因</strong></td>
	          <td width="5%" class="tbg03"><strong>操作</strong></td>
	          
	          
		  </tr>
		  <s:iterator  value="page.result" status="status">
		  <s:if test="centerStatus=='shtg'">
		  <s:if test="groupStatus=='shtg'"></s:if>
		  </s:if>
		  <s:else>
		  
			  <tr>
			    <s:set value="groupStatusDesc"  var="groupStatusDesc"/>
			    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postName}&nbsp;</td>
				<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					${studentName}
				</td>   
				
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					<fmt:formatDate value="${workStartTime}" type="date"
					pattern="yyyy-MM-dd" />&nbsp;
				</td>
				<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					<fmt:formatDate value="${workStopTime}" type="date"
					pattern="yyyy-MM-dd" />&nbsp;
				</td> 
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				    ${workTime }
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				    ${standard}&nbsp;
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				   ${amount}&nbsp;
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					${groupStatusDesc}
				</td> 
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				    ${groupNoPassReason}&nbsp;
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				    ${centerStatusDesc}&nbsp;
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				   ${centerNoPassReason}&nbsp;
			    </td>
			    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				   <s:if test="groupStatusDesc != '审核通过'">
						<a href="${ctx}/salary/create-salary!modify.action?id=${id}">修改</a>
					</s:if>
			    </td>
			    
			  </tr>
		  </s:else>
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
	<br/>
	
</div>
</body>
</html>