<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>分班发放</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/related.js" ></script>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
//绑定提交事件
$(document).ready(function() {
	$("#clazzselect").bind("change", function () {
		$("#order").val("");
		$("#orderBy").val("");
		$("#pageNo").val("1");
		if($("#searchForm"))$("#searchForm").submit();
	}
)	
	$("#majorselect").bind("change", function () {
			$("#order").val("");
			$("#orderBy").val("");
			$("#pageNo").val("1");
			if($("#searchForm"))$("#searchForm").submit();
	})
    $("#checkboxall").click(function(){
	     $("input[name='ids']").attr("checked",true);
	});
    $("#checkboxallno").click(function(){
	     $("input[name='ids']").attr("checked",false);
	});	

   var checkedIds ="";
   var ids="";
   var checkedExtendIds="";
   function getIds(){
	   $("input[name='ids']").each(function(){
		   ids+=$(this).val()+",";
			if($(this).attr("checked")){
				checkedIds+=$(this).val()+",";
			}
	   });
   }

   function getExtendIds(){
	   $("input[name='extendIds']").each(function(){
		   if($(this).attr("checked")){
			   checkedExtendIds+=$(this).val()+",";
			}
	   });
   }

   $("#submitbut").click(function(){
	     getIds();
	     getExtendIds();
	     if(!confirm("您确定要发放确认吗?")){
		     return false;
	     }
	   
	     $.ajax({
	            type: "post",
	            dataType: "html",
	            url: "${ctx}/wuzi/give!multisave.action",
	            data: "ids=" + ids+"&checkedIds="+checkedIds+"&checkedExtendIds="+checkedExtendIds,
	            success: function (msg) {
	            	if (msg!=""){
	                    alert(msg);
	                }
	            },
	            error: function() {
	                 alert("登记失败,请联系管理员");
	            }
	        });
	});	

   
})
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form method="post" enctype="multipart/form-data">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      分班发放
      </td>
    </tr>
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	     	<form action="${ctx}/wuzi/give!search.action?type=ff" method="post" id="searchForm" >
	        <tr>
				<td colspan="2" align="left" >
				<div id="useridTip" style="width:400px;padding-left:15px;">
				操作提示：
				<ul>
					<li>1、选择班级后，勾选需要发放的学生和发放项目</li>
				</ul>
				</div>
				</td>
			</tr>
			<tr>
				<th width="10%" align="left">选择班级</th>
				<td width="90%" align="left">院系:<s:select id="collegeselect" theme="simple" list="collegues"
					listKey="code" listValue="name" name="filter_EQS_collegeCode" headerKey="" headerValue="请选择"
					value="#parameters.filter_EQS_collegeCode" /> 专业:<s:select id="majorselect" theme="simple"
					list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode" headerKey=""
					headerValue="请选择" value="#parameters.filter_EQS_majorCode" /> 班级:<s:select id="clazzselect"
					theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
					headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode" />
					<input  type="button" id="mainformsearch" class="ybu" value="查 询" />
					&nbsp;&nbsp; <input
					type="button" value="全选" id="checkboxall" class="btn" /><input type="button" value="取消全选"
					id="checkboxallno" class="btn" />
				</td>
			</tr>
			</form>
			<s:iterator value="dataMap" status="stat">
				<c:choose>
					<c:when test="${stat.index==0}">
						<tr>
							<th rowspan="12">待发学生</th>
							<s:iterator value="value">
								<td width="9%">
								<div style="float: right;">
								   <input name="ids" type="checkbox" value="${id}" />
								</div>
								<div style="float: right;">${name}</div>
								</td>
							</s:iterator>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<s:iterator value="value">
								<td width="9%">
								<div style="float: right;">
								   <input name="ids"  type="checkbox" <c:if test="${gived}">checked="checked"</c:if> value="${id}"/>
								</div>
								<div style="float: right;">${name}</div>
								</td>
							</s:iterator>
						</tr>
					</c:otherwise>
				</c:choose>
			</s:iterator>
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td>
	          	<input id="submitbut" type="button" class="btn" value="发放登记" /> 
			  </td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>