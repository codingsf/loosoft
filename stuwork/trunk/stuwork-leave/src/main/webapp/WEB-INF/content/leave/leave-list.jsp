
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生基础信息列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript" src="${ctx }/js/related.js"></script>
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

	   $("#queryButton").click();
		 
	   $("#checkboxall").click(function(){
		     $("input[name='ids']").attr("checked",$(this).attr("checked"));
		});

	   /**
	    * 根据查询条件导出数据到Excel	 
	    * @author shanru.wu
	    * @since  2011-3-17  
	    */
	    $("#printexcel").click(function(){
		    var studentNo=$("#studentNo").val(); //学号
		    var name=$("#name").val(); //姓名
		    var IDcard=$("#IDcard").val(); //身份证号
		    var examineeNo=$("#examineeNo").val(); //考生号
		    var batchID=$("#batchselect").val(); //批次
		    var collegeCode=$("#collegeselect").val(); //院系
		    var majorCode=$("#majorselect").val(); //专业
		    var classCode=$("#clazzselect").val(); //班级
		    var sex=$("#sex").val(); //性别
		    
			document.getElementById("printForm").action="student!printExcel.action?studentNo="+studentNo+"&name="+name+"&IDcard="+IDcard+"&examineeNo="+examineeNo+"&batchID="+batchID+"&collegeCode="+collegeCode+"&majorCode="+majorCode+"&classCode="+classCode+"&sex="+sex;
			document.getElementById("printForm").submit();
		 });
    }); 
-->
</script>

</head>
<body
	style="background: #E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	style="border-left: 1px solid #B4C8D3; border-right: 1px solid #B4C8D3;">

	<tr>
		<td height="27"
			style="background: url('../images/login/tabbg01.jpg');"></td>
	</tr>

	<tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm"
			action="${ctx}/leave/leave!check.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0"
			cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07">
			<tr style="margin-top: 5px">
				<td width="7%" align="right" style="padding-left: 5px">学号:</td>
				<td width="13%" align="center"><input type="text"
					name="studentNo" id="studentNo" class="wid100px" value="" /></td>
				<td width="7%" align="right" style="padding-left: 5px">批次:</td>
				<td width="13%" align="center"><s:select id="batchselect"
					theme="simple" list="batches" listKey="comname" listValue="comname"
					name="comname" headerKey="" headerValue="全部" value="comname" /></td>
				<td width="7%" align="right" style="padding-left: 5px">学院:</td>
				<td width="13%" align="center"><s:select id="collegeselect"
					theme="simple" list="colleges" listKey="code" listValue="name"
					name="filter_EQS_collegeCode" headerKey="" headerValue="请选择"
					value="#parameters.filter_EQS_collegeCode" /></td>
				<td width="7%" align="right" style="padding-left: 5px">专业:</td>
				<td width="13%" align="center"><s:select id="majorselect"
					theme="simple" list="majors" listKey="code" listValue="name"
					name="filter_EQS_majorCode" headerKey="" headerValue="请选择"
					value="#parameters.filter_EQS_majorCode" /></td>
			</tr>

			<tr>
				<td width="7%" align="right" style="padding-left: 5px">班级:</td>
				<td width="13%" align="center"><s:select id="clazzselect"
					theme="simple" list="clazzes" listKey="code" listValue="name"
					name="filter_EQS_classCode" headerKey="" headerValue="请选择"
					value="#parameters.filter_EQS_classCode" /></td>
				<td width="7%" align="right" style="padding-left: 5px">是否审批:</td>
				<td width="13%" align="center">
				<table>
					<s:checkbox name="ischeck" />
					</table>
					
					   <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
				</td>
				<td width="7%" align="right" style="padding-left: 5px"></td>
				<td width="13%" align="center"></td>
				<td width="7%" align="right" style="padding-left: 5px"><input  type="submit" class="ybu" value="查 询" /></td>
				<td width="13%" align="center"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
			
			</tr>

		</table>

		</form>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="30" colspan="10" bgcolor="#F7E582" class="br002"><strong>学生基础信息</strong></td>
			</tr>
			<tr>
				<td width="1%" height="25" class="tbg03"><label> <input
					type="checkbox" id="checkboxall" /> </label></td>
				<td width="10%" class="tbg03"><strong>学号</strong></td>
				<td width="10%" class="tbg03"><strong>姓名</strong></td>
				<td width="10%" class="tbg03"><strong>批次</strong></td>
				<td width="10%" class="tbg03"><strong>学院</strong></td>
				<td width="8%" class="tbg03"><strong>专业</strong></td>
				<td width="10%" class="tbg03"><strong>操作</strong></td>
			</tr>


			<s:iterator id="obj" value="page.result" status="status">
				<tr>
					<td height="25"
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					<input type="checkbox" id="ids" name="ids" value="${obj.id }" /></td>
					<td
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentno}&nbsp;</td>
					<td
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${fullname}&nbsp;</td>
					<td
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${comname}&nbsp;</td>
					<td
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${collegename}&nbsp;</td>
					<td
						class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorname
					}&nbsp;</td>
					<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
					<a href="../leave/leave!check.action?sid=${obj.id}" onclick="return confirm('注意：请仔细操作，一旦审批通过将禁止修改！')">审批</a>
					</td>
				</tr>
			</s:iterator>


		</table>
		</td>
	</tr>

	<tr>
		<td height="32" style="background: url('../images/login/tabbg02.jpg')">
		<%@ include file="/common/turnpage.jsp"%></td>
	</tr>


</table>
<br />

</div>

</body>
</html>