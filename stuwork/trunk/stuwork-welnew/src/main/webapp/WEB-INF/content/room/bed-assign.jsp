<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>分配宿舍</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	//聚焦第一个输入框
	$("#IDcard").focus();

	//$("#examineeNo").bind("change",getStudentInfo);
	//$("#IDcard").bind("change",getStudentInfo);
})

var isSubmit = false;
function getStudentInfo(obj){
	$("#regStatus").val("");
	var examineeNo = $("#examineeNo").val();
	var IDcard = $("#IDcard").val();
	if((examineeNo.trim()=="" && IDcard.trim()=="")){
		return;
	}

	clearForm(obj);
	$.getJSON("../related/related!getStudent.action",{"examineeNo":$("#examineeNo").val(),"IDcard":$("#IDcard").val()},function(data) {
		if(data.batch==""){
			$("#assignResult").val("请先设置当前入学批次");
			return;
		}
		if(data.students==""){
			$("#assignResult").val("该新生在当前批次中不存在，确认输入正确或者新生名单已经导入系统");
			return;
		}
		var student = eval('(' + data.students+ ')');
		$("#name").val(student.name);
		$("#province").val(student.province);
		$("#IDcard").val(student.IDcard);
		$("#examineeNo").val(student.examineeNo);
		if(isSubmit){
			isSubmit = false;
			$("#dataForm").submit();
		}
	});
}

function clearForm(obj){	
	if(obj.id=='IDcard') 	
		$("#examineeNo").val("");
	else
		$("#IDcard").val("");
	$("#name").val("");
	$("#province").val("");
	$("#assignResult").val("");
}

function open_select(){
	var examineeNo = document.getElementById("examineeNo").value;
	var IDcard = document.getElementById("IDcard").value;
	if(examineeNo =="" && IDcard=="" ){
		alert("请输入考生号或身份证号");
		return;
	}
	window.open("bed-assign!select.action?examineeNo="+examineeNo+"&IDcard="+IDcard);
}

function submitForm(){
	//验证
	if($("#examineeNo").val()=="" && $("#IDcard").val()==""){
		alert("请输入考生号或省份证号");
		return false;
	}
	//isSubmit = true;
	//getStudentInfo();
	document.getElementById("dataForm").submit();
}
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form name="dataForm" id="dataForm" action="${ctx}/room/bed-assign!autoAssign.action" method="post">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      	分配宿舍床位
      </td>
    </tr>
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="100%" colspan="2" align="left" >
				<div id="useridTip" style="width:400px;padding-left:20px;">
				分配原则：
				<ul>
				<li style="height: 20px;">1、自动分配按照宿舍楼、楼层、宿舍和床位的升序依次分配</li>
				<li style="height: 20px;">2、手工分配需要手工选择剩余床位给该学生</li>
				</ul>
				</div>	
			  </td>
	        </tr>

	        <tr>
	          <td width="20%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">请输考生号或身份证号</td>
	          <td width="80%" bgcolor="#F1F4F9">
	          	考生号：<input id="examineeNo" name="examineeNo" value="${examineeNo}" type="text" class="ipt wid20" onchange="getStudentInfo(this)"/>
				身份证号：<input id="IDcard" name="IDcard"  value="${IDcard}" type="text" class="ipt wid20" onchange="getStudentInfo(this)"/>
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="20%" height="30" align="right"  class="tbg02 pr10">学生信息</td>
	          <td width="80%" >
	          	姓&nbsp;&nbsp;&nbsp;&nbsp;名：<input id="name" name="name" value="${student.name}" type="text" class="ipt wid20" disabled="disabled"/>
				生源省份：<input id="province" name="province"  value="${student.province}" type="text" class="ipt wid20" disabled="disabled" />	
	          </td>
	        </tr>
	        
	        <tr>
	          <td height="30" align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">分配的宿舍床位</td>
	          <td bgcolor="#F1F4F9">
	          	<input id="assignResult" name="assignResult"  value="${assginResult}" type="text" class="ipt wid100px" disabled="disabled" style=" width:416px;"/>
	          </td>
	        </tr>
	        
	      </table>
      </td>
    </tr>
    
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td><input name="submitbut" type="button" class="btn" value="自动分配" onclick="submitForm();" /> </td>
	          <td><input name="submitbut" type="button" class="btn" value="手工分配" onclick="open_select()" /></td>
	        </tr>
	      </table>
      </td>
    </tr>
  </table>
</div>
</form>
</body>
</html>