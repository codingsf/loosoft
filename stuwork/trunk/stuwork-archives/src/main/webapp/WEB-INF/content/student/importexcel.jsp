<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>导入新生</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/jscss.jsp" %>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
<script type="text/javascript">
	// <![CDATA[
	function uploadSubmit(obj) 
	{ 
	if(confirm("您确定要导入吗？")) 
	{ 
	  var uploadfile = obj.upload.value; 
	  if((null == uploadfile) ||( "" == uploadfile)) 
	  { 
	   alert("上传文件没有指定！"); 
	   return false; 
	  } 
	     obj.action = 'student/importexcel.action'; 
	     obj.submit(); 
	} 
	} 
	//]]>
</script>
</head>
<body>
<div class="xzwz">
  <h1>导入新生信息</h1>
</div>
 	<form name="uploadForm" enctype="multipart/form-data" method="post">
	<table class="tbhs1">
	  <tr>
	    <td width="100%" colspan="4" align="center" >
			<div id="useridTip" style="width:450px;float:left;">
			<ul>
			<li>提示：</li>
			<li>1、excel的格式必须符合模板中定义格式，否则会导致数据不能正确</li>
			<li>2、excel版本必须是2003或以上</li>
			<li>3、院系，专业名称必须是和系统后台设置的名称完全一致</li>
			<li>4、如果数据很大，导入过程中需要等待几分钟</li>
			<li>5、下载模板excel:&nbsp;&nbsp;<a href="${ctx }/attachment/Download!getDownloadFile.action?name=2010统招新生名单.xls">《2010统招新生名单.xls》</a></li>
			</ul>
			</div>	   
			<div id="useridTip" style="width:450px;float:right;">
			<ul>
			<li>导入结果：</li>
			<li>
			1、共导入${total}笔。
			</li>
			<li>
			2、失败${failnum}笔；
			</li>
			<li>
			3、失败excel行号：${failstr}
			</li>
			</ul>
			</div>	
		</td>
	  </tr>
	  <tr>
	    <th>请选择导入的excel文件</th>
	    <td width="30%"><input id="upload" name="upload"  value="" type="file" class="wid50" /></td>
	    <th>请选择学生类别</th>
	    <td width="30%">
	    <s:select id="type" name="type" list="typeList" listKey="value" listValue="label" theme="simple"></s:select>
	    </td>
	  </tr>
    <tr>
      <td></td>
      <td colspan="3">
        <label></label>
        <input name="submitbut" type="button" class="btn" value="确认导入" onclick="uploadSubmit(this.form)" />
 	</td>
    </tr>
    
	</table>
	</form>
</body>
</html>