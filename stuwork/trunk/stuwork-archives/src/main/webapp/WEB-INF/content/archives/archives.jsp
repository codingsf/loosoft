<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>档案查询</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<style type="text/css"> 
.focus { 
	 border: 1px solid #f00;
	 background: #fcc;
} 
</style>
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

     
	
         $("#queryButton").click();
         
         $("#print").click(function(){
			document.getElementById("searchForm").action="archives!print.action";
			document.getElementById("searchForm").submit();
          });

         $("#printexcel").click(function(){
 			document.getElementById("searchForm").action="archives!printExcel.action";
 			document.getElementById("searchForm").submit();
 		 });
    }); 
-->
</script>
<script>
		function search(){
			$("#searchForm").attr("action","${ctx}/archives/archives!list.action");
			$("#searchForm").submit();
		}
</script>
</head>
<body onkeydown="if (event.keyCode==13) {$('#searchForm').submit();}" style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">

<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/archives/archives!list.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">学号:</td>
	            <td width="13%" align="center"><input type="text" name="stuId" class="wid100px" value="${stuId }"/></td>
	            <td width="7%" align="right" style="padding-left:5px">姓名:</td>
	            <td width="13%" align="center"><input type="text" name="name" class="wid100px" value="${name}"/></td>
	            <td width="7%" align="right" style="padding-left:5px">身份证号:</td>
	            <td width="13%" align="center"><input type="text" name="IDcard" value="${IDcard }" class="wid100px"/></td>
	            <td width="7%" align="right" style="padding-left:5px">考生号:</td>
	            <td width="13%" align="center"><input type="text" name="examineeNo" value="${examineeNo }" class="wid100px"/></td>
		  </tr>
		 	
		  <tr>
			    <td width="7%" align="right" style="padding-left:5px">毕业时间</td>
	            <td width="13%" align="center">
	                 <input name="period" id="period" value="${param.period}" type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
				</td>
	            <td width="7%" align="right" style="padding-left:5px">院系:</td>
	            <td width="13%" align="center">
	               <s:select id="collegeselect" theme="simple" list="colleges" listKey="code" listValue="name" name="filter_EQS_collegeCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode"/>
                </td>
                <td width="7%" align="right" style="padding-left:5px">专业:</td>
	            <td width="13%" align="center">
	               <s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">班级:</td>
	            <td width="13%" align="center">
	               <s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
                </td>
		  </tr>
		  <tr> 
		        <td width="7%" align="right" style="padding-left:5px">显示个数:</td>
	            <td width="13%" align="center">
	              <s:select id="pageselect" theme="simple" list="selectPageList" listKey="value" listValue="label" name="filter_EQS_pageCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_pageCode"/>
                </td>
	            <td  align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center">
	             
	            </td>
	            <td align="right" style="padding-left:5px"></td>
	            <td align="center">
	            </td>
	            <td align="right" style="padding-left:5px"></td>
	            <td  align="center"></td>
		  </tr>
		  <tr>
			    <td width="8%"><input  type="submit" class="ybu" value="查 询" /></td>
	            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
	            <td></td>
	            <td></td>
		  </tr>
        </table>
          <input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
		</form>
		
		<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>档案信息</strong></td>
          </tr>
		  <tr>
	          <td width="10%" class="tbg03" height="25"><strong>学号</strong></td>
	          <td width="5%" class="tbg03"><strong>姓名</strong></td>
	          <td width="10%" class="tbg03"><strong>入库时间</strong></td>
	          <td width="10%" class="tbg03"><strong>库位号</strong></td>
	           <td width="10%" class="tbg03"><strong>档案状态</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
	          
	          
	          
		  </tr>
		  <s:iterator id="obj" value="archivesVOs" var="archivesVO" status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${archivesVO.stuId }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${archivesVO.name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${archivesVO.storageTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${archivesVO.storeInfo}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${archivesVO.status}&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/archives/archives!detail.action?stuId=${archivesVO.stuId}">详情</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/commonPage.jsp"%>
      </td>
    </tr>
	
	
	</table>
	<br/>
	<div>
		<span class="btn2">
			<c:set value="[]" var="temp"></c:set>
			<c:if test="${tempList ne temp}">
			   <div>
			   	  <a href="javascript:void(0)" id="print" name="print"><span>打印条形码</span></a> 
			   	   <a href="javascript:void(0)" id="printexcel" name="printexcel"><span>导出Excel</span></a> 
			      <span style="color:red;">${actionMessage }</span>  <span style="color:red;">${stuNoImg }</span>
				</div>
			</c:if>
		</span>
	</div>
</div>
</body>

</html>