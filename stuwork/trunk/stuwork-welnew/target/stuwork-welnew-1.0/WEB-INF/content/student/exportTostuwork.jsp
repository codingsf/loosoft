<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>导入学工系统</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form name="uploadForm" id="uploadForm"  enctype="multipart/form-data" method="post">
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27" style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">导入新生信息到学工系统</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" class="tbg02 pr10">

		  <div class="lin24"><strong>提示：</strong><br />
            1、点击确认导入,系统会将已经报到的新生息转入学生信息管理系统,这样可以减少维护学生基础数据的重复工作 。
			</div>
			</td>

          </tr>
        <tr>
          <td bgcolor="#F1F4F9" class="tbg01 pr10">
		  <div class="lin24"><strong>导入结果：</strong><br />
            1、共对${total}条信息进行导入；<br />
            2、成功${total-failnum}条信息； <br />
            3、失败${failnum}条信息；<span style="color:red;"><a href="${ctx }/student/student!printErrorInfo.action">点击下载失败信息</a></span><br />
            4、失败excel行号：23,43,45
			</div></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="32"  style="background: url('../images/login/tabbg02.jpg');"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0"  style="color:#183553;">
        <tr>
          <td>请选择导入的excel文件</td>
          <td><input id="upload" name="upload"  value="" type="file" class="wid30" /></td>
          <td> <input name="submitbut" type="button" class="bulebu" value="确认导入" onclick="uploadSubmit(this.form)" /></td>
          </tr>
      </table></td>
    </tr>
  </table>
</div>
	
	
</form>
</body>
</html>