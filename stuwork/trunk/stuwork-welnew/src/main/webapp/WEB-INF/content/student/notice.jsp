<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新生通知书列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>
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
          
		 $("#printbut").click(
		   function(){
		       if($("input:checked").length==0) {
		            alert("没有可打印记录,请勾选");
		            return false;
		       } 
		       if(!confirm('您确定要打印吗?')) return  false;

			   $("#printForm").submit();
		 });

	    $("#queryButton").click();
		 
	    $("#checkboxall").click(function(){
		     $("input[name='ids']").attr("checked",$(this).attr("checked"));
		});
    }); 
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
	<div class="emb"></div>
	<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
		<tr>
	      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
		      <div class="tabhv">
		        <ul>
		          	<li><a href="#" id="printbut">批量打印</a></li>
				    <li><a href="#" id="queryButton">显示查询</a></li>
		        </ul>
		      </div>
	      </td>
	    </tr>
    	<tr>
			<td bgcolor="#FFFFFF">
			<form id="searchForm" name="searchForm" action="${ctx}/student/notice.action" method="post">
				<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
			  		<tr style="margin-top: 5px">
				    	<td width="7%" align="right" style="padding-left:5px">学号:</td>
		            	<td width="13%" align="center"><input type="text" name="filter_EQS_studentNo" id="studentNo" class="wid100px" value="${param['filter_EQS_studentNo']}"/></td>
		            	<td width="7%" align="right" style="padding-left:5px">姓名:</td>
		            	<td width="13%" align="center"><input type="text" name="filter_LIKES_name" class="wid100px" value="${param['filter_LIKES_name']}" id="name"/></td>
		            	<td width="7%" align="right" style="padding-left:5px">身份证号:</td>
		            	<td width="13%" align="center"><input type="text" name="filter_EQS_IDcard" value="${param['filter_EQS_IDcard']}" class="wid100px" id="IDcard"/></td>
		            	<td width="7%" align="right" style="padding-left:5px">考生号:</td>
		            	<td width="13%" align="center"><input type="text" name="filter_EQS_examineeNo" value="${param['filter_EQS_examineeNo']}" class="wid100px" id="examineeNo"/></td>
			  		</tr>
		  <tr>
			    <td width="7%" align="right" style="padding-left:5px">批次:</td>
	            <td width="13%" align="left">
	                 <s:select id="batchselect" theme="simple" list="batches" listKey="id" listValue="comname" name="filter_EQL_welbatch$id"
			         headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_welbatch$id)"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">院系:</td>
	            <td width="13%" align="left">
	              <s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="filter_EQS_collegeCode"
			       headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode"/>
                </td>
                <td width="7%" align="right" style="padding-left:5px">专业:</td>
	            <td width="13%" align="left">
	               <s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
			       headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">班级:</td>
	            <td width="13%" align="left">
	               <s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
			       headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
                </td>
		  </tr>
		  
		  <tr> 
		        <td width="7%" align="right" style="padding-left:5px">性别:</td>
	            <td width="13%" align="left">
	               <s:select theme="simple" list="sexes" listKey="value" listValue="label" name="filter_EQS_sex"
			 			headerKey="" headerValue="请选择" value="#parameters.filter_EQS_sex"/>
                </td>
		        <td width="7%" align="right" style="padding-left:5px">打印状态:</td>
	            <td width="13%" align="left">
	            	<s:select theme="simple" list="#{'0':'未打','1':'已打'}" name="filter_EQB_printed"
				 	headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQB_printed)"/>
	            </td>                              
	            <td  align="right" style="padding-left:5px"></td>
	            <td width="13%" align="left" colspan="5">
	            <input  type="submit" class="ybu" value="查 询" />&nbsp;&nbsp;
	            <input type="reset" id="resetbutton" class="ybu" value="重 置" />
	            </td>
		  </tr>
        		</table>
	            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
	            <input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
	            <input type="hidden" name="page.order" id="order" value="${page.order}" />
			</form>
		
		<form action="${ctx}/student/notice!prints.action" method="post" id="printForm" target="_blank">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="12" bgcolor="#F7E582" class="br002"><strong>新生信息浏览</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="10%" class="tbg03"><strong>入学批次</strong></td>
	          <td width="12%" class="tbg03"><strong>院系</strong></td>
	          <td width="12%" class="tbg03"><strong>专业</strong></td>
	          <td width="12%" class="tbg03"><strong>班级</strong></td>
	          <td width="15%" class="tbg03"><strong>通知书编号</strong></td>
	          <td width="8%" class="tbg03"><strong>姓名</strong></td>
	          <td width="5%" class="tbg03"><strong>性别</strong></td>
	          <td width="5%" class="tbg03"><strong>已打印</strong></td>     
	          <td width="15%" class="tbg03"><strong>操作</strong></td> 
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${obj.id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${welbatch.comname }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${collegeName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${className}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${noticeId}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexdesc}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexdesc}&nbsp;</td>  		      
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			   <a href="#" onclick="onPrint('${obj.id}');">打印</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="onPreview('${obj.id}');">预览</a>
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