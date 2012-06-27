<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案调出</title>
<%@ include file="/common/meta.jsp"%>

<%@ include file="/common/jscss.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#organization").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			organization: "required",
			outDate: "required",
			operater: "required",
			isbn:"required",
			type:"required",
			remarkselect:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				}
			}
		});
		$("#dataForm").submit(function(){
			if($("#organization").val()==""){
				return false;
			}
			if($("#type").val()==""){
				return false;
			}
			if($("#isbn").val()==""){
				return false;
			}
			if($("#organization").val()==""){
				return false;
			}
			if($("#operater").val()==""){
				return false;
			}
			if($("#picfile").val()==""){
				if(window.confirm("你确定不提供调档函扫描件吗？")){
								
				return true;
			}else{
                return false;
			}
		}

			
			});
		
	});
	
</script>
<script type="text/javascript">
function changeRemark(){
	if(document.getElementById("remarkselect").value=="其他"){
		document.getElementById("shuru").innerText="请输入其他理由";
		document.getElementById("remark").value="";
		}else{
		document.getElementById("shuru").innerText="";
		document.getElementById("remark").value=document.getElementById("remarkselect").value;
		}
}


</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>

</head>
<body>
<!--startprint-->
<div class="xzwz">
<h1>档案调出详细</h1>
</div>
<form action="${ctx}/outlog/outlog!save.action" method="post"
	id="dataForm" enctype="multipart/form-data"><input name="stuId"
	value="${stuId }" type="hidden" />
<table class="tbhs1">
	<tr>
		<th style="width: 15%;">调档单位</th>
		<td>
	${organization }
			</td>

	</tr>
	<tr>
		<th>调出方式</th>
		<td>
			${type }
			</td>

	</tr>
	<tr>
		<th>调档存根</th>
		<td>
		${isbn }

		</td>
	</tr>
	
	<tr>
		<th>调档理由</th>
		<td>${remark}</td>
	</tr>
		<tr>
		<th>调出时间</th>
		<td><fmt:formatDate value="${outDate}" type="date" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></td>
	</tr>
	<tr>
		<th>调档函扫描件</th>
		<td>${fileName }</td>
	</tr>
	<tr>
		<th>调档经办人</th>
		<td>
		${operater }
		
	</tr>
		<tr>
		<th>调出地址</th>
		<td>

	${address }

	</tr>
	<!--endprint-->
	<tr>
		<td><span style="color: red;">${actionMessage }</span></td>
		<td>
			<input name="printbtn" type="button" onclick="execPrint()"
				class="btn" value="打印档案调出单" />
		&nbsp; <input name="button"   type="button"  class="btn" value="取消"
			onclick="history.back();" /></td>
	</tr>
</table>
</form>
</body>
</html>