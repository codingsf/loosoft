<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>注册登记</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>

	<script type="text/javascript">
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#examineeNo").focus();
		$("#examineeNo").bind("change",getStudentInfo);
		$("#IDcard").bind("change",getStudentInfo);
		$("#examineeNo").bind("focus",clearForm);
		$("#IDcard").bind("focus",clearForm);	
	})
	
	var isSubmit = false;
	function getStudentInfo() {
		$("#regStatus").val("");
		var examineeNo = $("#examineeNo").val();
		var IDcard = $("#IDcard").val();
		$.getJSON("../related/related!getStudent.action",{"examineeNo":examineeNo,"IDcard":IDcard},function(data) {
			if(data.students==""){
				$("#regStatus").val("学生不存在");
				return;
			}
			var student = eval('(' + data.students+ ')');
			$("#name").val(student.name);
			$("#province").val(student.province);
			$("#regStatus").val(student.regStatus)
			if(isSubmit){
				isSubmit = false;
				$("#dataForm").submit();
			}
		});
	}

	function clearForm(){
		$("#name").val("");
		$("#province").val("");
		$("#examineeNo").val("");
		$("#IDcard").val("");
		$("#regStatus").val("");
	}
	
	function submitForm(thisForm){
		//验证
		if($("#examineeNo").val()=="" && $("#IDcard").val()==""){
			alert("请输入考生号或省份证号号。");
			return false;
		}
		isSubmit = true;
		getStudentInfo();
		return false;
	}
	</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<div class="xzwz">
  <h1>新生报到注册登记</h1>
  
</div>
	<form id="dataForm" name="dataForm" action="${ctx}/student/reg.action" method="post" onsubmit="return submitForm(this)" >
	<table class="tbhs1">
	  <tr>
	    <td width="100%" colspan="2" align="center" >
			<div id="useridTip" style="width:400px;float:right;">
			提示：
			<ul>
				<li>
				1、输入考生号或身份证号后点击注册按钮即可。			
				</li>
			</ul>
			</div>	  
			<div id="useridTip" style="width:400px;float:left;">
			${collegeName}报到情况：
			<ul>
			<li>
			${welbatch.year} 年 ${welbatch.season} 已录取新生 ${total} 名，</li>
			<li>其中已报到  ${regTotal} 名，报到率  ${regRate} , </li>
			<li>您正在处理第  ${regTotal+1} 位新生报到。 </li>
			<li></li>
			</ul>
			</div>		
		</td>
	  </tr>
	  <tr>
	    <th>考生号</th>
	    <td><input id="examineeNo" name="examineeNo"  value="${examineeNo }" type="text" class="wid30" /></td>
	  </tr>
	  <tr>
	    <th>或身份证号</th>
	    <td><input id="IDcard" name="IDcard"  value="${IDcard}" type="text" class="wid30" /></td>
	  </tr>	 
	  <tr>
	    <th>新生信息</th>
	    <td>
		姓名：<input id="name" name="name"  value="${name}" type="text" class="ipt wid20" disabled="disabled"/>
		生源地：
		<input id="province" name="province"  value="${province}" type="text" class="ipt wid20" disabled="disabled"/>
		</td>
	  </tr>	
	  <tr>
	    <th>注册状态</th>
	    <td>
		<input id="regStatus" name="regStatus"  value="${regStatus}" type="text" class="ipt wid20" disabled="disabled"/>
		</td>
	  </tr>			   
    <tr>
      <td></td>
      <td>
        <label></label>
        <input name="submitbut" type="submit" class="btn" value="确认注册" />&nbsp;&nbsp;
      </td>
    </tr>
	</table>
	</form>
</body>
</html>