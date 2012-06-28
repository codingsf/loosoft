<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>导入新生户籍</title>
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
	     obj.action = 'residence/importhuji.action'; 
	     obj.submit(); 
	} 
	} 
	//]]>
</script>
</head>
<body>
<div class="xzwz">
  <h1>导入新生户籍</h1>
</div>
<form method="post" enctype="multipart/form-data"> 
	<table class="tbhs1">
	  <tr>
	    <td width="100%" colspan="2" align="center" >
			<div id="useridTip" style="width:500px;float:left;">
			<ul>
			<li>提示：</li>
			<li>1、excel的格式必须符合模板中定义格式，否则会导致数据不能正确</li>
			<li>2、<a href="">模板excel下载</a></li>
			<li>3、对于已有校区的新生可以将现户籍所在地空出来</li>
			<li>4、完成后可以用户籍浏览功能查看导入明细</li>
			</ul>
			</div>	   
			<div id="useridTip" style="width:500px;float:right;">
			<ul>
			<li>导入结果：</li>
			<li>1、共导入${total}笔</li>
			<li>2、成功导入${total-failnum}笔</li>
			<li>3、失败${failnum}笔</li>
			<li>4、excel中${failstr}笔错误，请检查！</li>
			</ul>
			</div>	
		</td>
	  </tr>
	  <tr>
	    <th>请选择导入的excel文件</th>
	    <td><input name="upload" type="file" class="ipt wid20" style="height: 20px"/></td>
	  </tr>
    <tr>
      <td></td>
      <td>
        <label></label>
        <input name="submitbut" type="button" class="btn" value="确认导入" onclick="uploadSubmit(this.form)" />
 </td>
    </tr>
	</table>
	</form>
</body>
</html>