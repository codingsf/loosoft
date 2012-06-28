<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>导入班级</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
	     obj.action = 'clazz/importclass.action'; 
	     obj.submit(); 
	} 
	} 
	//]]>
</script>
</head>
<body style="background:#E3F1FA url(../../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<form name="uploadForm" id="uploadForm"  enctype="multipart/form-data" method="post">
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27" style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">导入学生班级</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" class="tbg02 pr10">

		  <div class="lin24"><strong>提示：</strong><br />
		  	<p>
            1、excel的格式必须符合模板中定义格式，否则会导致数据不能正确导入<br />
            2、excel版本必须是2003或以上<br />
            3、院系、专业名称必须和系统后台设置的名称完全一致,否则会导致数据不能正确导入<br />
            4、如果数据量很大，导入过程中需要等待几分钟<br />
            
            5、点击下载&nbsp;&nbsp;<a href="${ctx}/attachment/download.action?name=学生班级模版.xls&path=template" style="color: red;">学生班级模版.xls</a>
            </p>
			</div>
			</td>
          </tr>
        <tr id="">
          <td bgcolor="#F1F4F9" class="tbg01 pr10">
		  <div class="lin24"><strong>导入结果：</strong><br />	 
		  <s:if test="finished">
		  	<p>
            1、共对${total}条信息进行导入；<br />
            2、成功${total-failnum}条信息； <br />
            3、失败${failnum}条信息；<a href="${ctx}/attachment/download.action?name=${logFilename}&path=log"><span style="color:red;">点击下载失败信息</span></a><br />
            4、失败excel行号：<br/>${failstr}
            </p>
			</s:if> 
			<s:else>
			<p>&nbsp;</p>
			</s:else>           
			</div>
			</td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="32"  style="background: url('../images/login/tabbg02.jpg');"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0"  style="color:#183553;">
        <tr>
          <td>请选择导入的excel文件</td>
          <td><input id="upload" name="upload"  value="" type="file" class="wid30" /></td>
          <td><input id="isAuto" name="isAuto"  type="checkbox" />自动生成不存在的班级</td>          
          <td><input name="submitbut" type="button" class="bulebu" value="确认导入" onclick="uploadSubmit(this.form)" /></td>
          </tr>
      </table></td>
    </tr>
  </table>
</div>
	
	
</form>



</body>
</html>