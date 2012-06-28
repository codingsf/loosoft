<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>通知书设置</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp" %>
<script type="text/javascript">
function moveLoad(){
	document.getElementById("NoticeMove").style.left="${moveUtil.noticeMoveLeft}";
	document.getElementById("NoticeMove").style.top="${moveUtil.noticeMoveTop}";
	document.getElementById("NameMove").style.left="${moveUtil.nameMoveLeft}";
	document.getElementById("NameMove").style.top="${moveUtil.nameMoveTop}";
	document.getElementById("CollegeMove").style.left="${moveUtil.collegeMoveLeft}";
	document.getElementById("CollegeMove").style.top="${moveUtil.collegeMoveTop}";
	document.getElementById("XingMaMove").style.left="${moveUtil.xingMaMoveLeft}";
	document.getElementById("XingMaMove").style.top="${moveUtil.xingMaMoveTop}";
	document.getElementById("MajorMove").style.left="${moveUtil.majorMoveLeft}";
	document.getElementById("MajorMove").style.top="${moveUtil.majorMoveTop}";
	document.getElementById("YearMove").style.left="${moveUtil.yearMoveLeft}";
	document.getElementById("YearMove").style.top="${moveUtil.yearMoveTop}";
	document.getElementById("InDateMove").style.left="${moveUtil.inDateMoveLeft}";
	document.getElementById("InDateMove").style.top="${moveUtil.inDateMoveTop}";
	document.getElementById("FinishDateMove").style.left="${moveUtil.finishDateMoveLeft}";
	document.getElementById("FinishDateMove").style.top="${moveUtil.finishDateMoveTop}";
	document.getElementById("LuQuMove").style.left="${moveUtil.luQuMoveLeft}";
	document.getElementById("LuQuMove").style.top="${moveUtil.luQuMoveTop}";
	document.getElementById("WorkMove").style.left="${moveUtil.workMoveLeft}";
	document.getElementById("WorkMove").style.top="${moveUtil.workMoveTop}";

	}
</script>
</head>
<body onload="moveLoad()" style="position: relative; margin: auto; width: 1024px; height: 768px;">

<form id="searchForm" action="${ctx}/noticeBook/noticebook!save.action"
	method="post">
	<input type="hidden" id="id" name="id" value="${moveUtil.id }" />
	<input type="hidden" id="NoticeMoveLeft" name="noticeMoveLeft" value="${moveUtil.noticeMoveLeft }" />
	<input type="hidden" id="NoticeMoveTop" name="noticeMoveTop" value="${moveUtil.noticeMoveTop }" />
	<input type="hidden" id="NameMoveLeft" name="nameMoveLeft" value="${moveUtil.nameMoveLeft }" /> 
	<input type="hidden" id="NameMoveTop" name="nameMoveTop" value="${moveUtil.nameMoveTop }" />
	<input type="hidden" id="CollegeMoveLeft" name="collegeMoveLeft" value="${moveUtil.collegeMoveLeft }" />
    <input type="hidden" id="CollegeMoveTop" name="collegeMoveTop" value="${moveUtil.collegeMoveTop }" /> 
    <input type="hidden" id="XingMaMoveLeft" name="xingMaMoveLeft" value="${moveUtil.xingMaMoveLeft }" /> 
	<input type="hidden" id="XingMaMoveTop" name="xingMaMoveTop" value="${moveUtil.xingMaMoveTop }" /> 
	<input type="hidden" id="MajorMoveLeft" name="majorMoveLeft" value="${moveUtil.majorMoveLeft }" />
    <input type="hidden" id="MajorMoveTop" name="majorMoveTop" value="${moveUtil.majorMoveTop }" />
    <input type="hidden" id="YearMoveLeft" name="yearMoveLeft" value="${moveUtil.yearMoveLeft }" />
    <input type="hidden" id="YearMoveTop" name="yearMoveTop" value="${moveUtil.yearMoveTop }" />
    <input type="hidden" id="InDateMoveLeft" name="inDateMoveLeft" value="${moveUtil.inDateMoveLeft }" /> 
    <input type="hidden" id="InDateMoveTop" name="inDateMoveTop" value="${moveUtil.inDateMoveTop }" /> 
    <input type="hidden" id="FinishDateMoveLeft" name="finishDateMoveLeft" value="${moveUtil.finishDateMoveLeft }" />
	<input type="hidden" id="FinishDateMoveTop" name="finishDateMoveTop" value="${moveUtil.finishDateMoveTop }" />
	<input type="hidden" id="LuQuMoveLeft" name="luQuMoveLeft" value="${moveUtil.luQuMoveLeft }" />
	<input type="hidden" id="LuQuMoveTop" name="luQuMoveTop" value="${moveUtil.luQuMoveTop }" />
	<input type="hidden" id="WorkMoveLeft" name="workMoveLeft" value="${moveUtil.workMoveLeft }" /> 
	<input type="hidden" id="WorkMoveTop" name="workMoveTop" value="${moveUtil.workMoveTop }" />

<div
	style="border: solid 1px gray; height: 500px; width: 600px; float: left; background-color: Gray;">

<div id="NoticeMove" onmousemove="moveDiv('NoticeMove')"
	style="width: 150px; height: 22px; left: 50px; top: 100px; position: absolute; cursor: move">
<input type="text" id="Notice" value="通知书编号"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="NameMove" onmousemove="moveDiv('NameMove')"
	style="width: 80px; height: 22px; left: 50px; top: 120px; position: absolute; cursor: move">
<input type="text" id="Name" value="姓名" size="8"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="CollegeMove" onmousemove="moveDiv('CollegeMove')"
	style="width: 150px; height: 22px; left: 50px; top: 140px; position: absolute; cursor: move">
<input type="text" id="College" value="院系"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="MajorMove" onmousemove="moveDiv('MajorMove')"
	style="width: 150px; height: 22px; left: 50px; top: 160px; position: absolute; cursor: move">
<input type="text" id="Major" value="专业"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="YearMove" onmousemove="moveDiv('YearMove')"
	style="width: 150px; height: 22px; left: 50px; top: 180px; position: absolute; cursor: move">
<input type="text" id="Year" value="年制"
	style="border: solid 1px #7f9db9; cursor: move;width:40px; height:20px;" /></div>

<div id="InDateMove" onmousemove="moveDiv('InDateMove')"
	style="width: 150px; height: 22px; left: 150px; top: 200px; position: absolute; cursor: move">
<input type="text" id="InDate" value="录取开始时间"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="FinishDateMove" onmousemove="moveDiv('FinishDateMove')"
	style="width: 150px; height: 22px; left: 220px; top: 140px; position: absolute; cursor: move">
<input type="text" id="FinishDate" value="录取结束时间"
	style="border: solid 1px #7f9db9; cursor: move;width:100px; height:20px;" /></div>

<div id="LuQuMove" onmousemove="moveDiv('LuQuMove')"
	style="width: 150px; height: 22px; left: 150px; top: 240px; position: absolute; cursor: move">
<input type="text" id="LuQu" value="录取形式"
	style="border: solid 1px #7f9db9; cursor: move;width:80px; height:20px;" /></div>

<div id="WorkMove" onmousemove="moveDiv('WorkMove')"
	style="width: 150px; height: 22px; left: 150px; top: 260px; position: absolute; cursor: move">
<input type="text" id="Work" value="工作导向"
	style="border: solid 1px #7f9db9; cursor: move;width:140px; height:20px;" /></div>

<div id="XingMaMove" onmousemove="moveDiv('XingMaMove')"
	style="width: 180px; height: 70px; left: 50px; top: 280px; position: absolute; cursor: move">
<img id="XingMa" src="tiaoxingma.gif"
	style="border: solid 1px #7f9db9; cursor: move;" alt="条形码" /></div>
</div>

<div
	style="border: solid 1px gray; height: 500px; width: 100px; float: left; text-align: center; margin-left: 20px;">
<input type="button" value="通知书编号" onclick="ButtonMove('Notice')"
	id="NoticeButton" style="width: 80px;" /><br />
<input type="button" value="姓名" onclick="ButtonMove('Name')"
	id="NameButton" style="width: 80px;" /><br />
<input type="button" value="院系" onclick="ButtonMove('College')"
	id="CollegeButton" style="width: 80px;" /><br />
<input type="button" value="专业" onclick="ButtonMove('Major')"
	id="Button5" style="width: 80px;" /><br />
<input type="button" value="年制" onclick="ButtonMove('Year')"
	id="Button6" style="width: 80px;" /><br />
<input type="button" value="录取形式" onclick="ButtonMove('LuQu')"
	id="Button7" style="width: 80px;" /><br />
<input type="button" value="录取开始时间" onclick="ButtonMove('InDate')"
	id="Button2" style="width: 80px;" /><br />
<input type="button" value="录取结束时间" onclick="ButtonMove('FinishDate')"
	id="Button4" style="width: 80px;" /><br />
<input type="button" value="工作导向" onclick="ButtonMove('Work')"
	id="Button3" style="width: 80px;" /><br />
<input type="button" value="条形码" onclick="ButtonMove('XingMa')"
	id="XingMaButton" style="width: 80px;" /><br />
<input type="submit" value="保存" style="width: 80px;" /><br />
<input type="button" value="返回" onclick="window.location.reload();"
	style="width: 80px;" />
	${actionMessage }
	</div>
</form>
</body>
</html>