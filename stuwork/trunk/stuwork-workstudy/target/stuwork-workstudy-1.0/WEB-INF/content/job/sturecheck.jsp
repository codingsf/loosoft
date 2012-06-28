<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>复审列表</title>
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
		<form id="searchForm" name="searchForm" action="sturecheck.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="12%" align="left" style="padding-left:5px">岗位名称:</td>
            <td width="13%" align="center">
            	<input type="text" name="filter_LIKES_jobsName" value="${param['filter_LIKES_jobsName']}"/>
            </td>
            <td width="12%" align="left">学生姓名:</td>
            <td width="13%" align="center">
            	<input type="text" name="filter_LIKES_studentName" value="${param['filter_LIKES_studentName']}" />
            </td>
            <td width="16%" align="right">申请时间 从：</td>
            <td width="13%" align="center">
            	<input name="startApply" id="applyDate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            <td width="3%" align="right">到：</td>
            <td width="13%" align="center">
            	<input name="endApply" id="applyDate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/job/sturecheck!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>申请审核</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="15%" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="12%" class="tbg03"><strong>岗位信息查看</strong></td>
	          <td width="10%" class="tbg03"><strong>学生姓名</strong></td>
	          <td width="12%" class="tbg03"><strong>学生信息查看</strong></td>
	          <td width="12%" class="tbg03"><strong>申请日期</strong></td>
	          <td width="12%" class="tbg03"><strong>中心审核状态</strong></td>
	          <td width="20%" class="tbg03"><strong>未过原因</strong></td>
	          <td width="15%" class="tbg03"><strong>审核</strong></td>
		  </tr>
		  <s:iterator  value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${jobsName}&nbsp;</td>
		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<a href="${ctx}/job/sturecheck!findJob.action?jobID=${jobsID}">查看岗位信息</a>
			</td>  
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				${studentName}
			</td>   
			
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<a href="${ctx}/job/sturecheck!findStu.action?examineeNo=${studentNo}">查看学生信息</a>
			</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${applyDate}" type="date" pattern="yyyy-MM-dd" />
			</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    ${centerStatusDesc }
		    </td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <s:if test="centerStatus=='shwtg'">
				<a href="${ctx}/job/sturecheck!nopassrecheckDetail.action?id=${id}">查看</a>
				</s:if>
		    </td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <s:if test="centerStatus=='shz'">	
				<a href="#" onclick="pass('${id }','${ctx}/job/sturecheck!pass.action');">通过</a>
				<a href="${ctx}/job/sturecheck!unpass.action?id=${id}">未通过</a></s:if>
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