<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>档案批量入库</title>
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
		var uploadfile = obj.upload.value;
		if((null == uploadfile) ||( "" == uploadfile)) 
		{ 
		    alert("上传文件没有指定！"); 
		    return false; 
		} 
		 obj.action = '${ctx}/archives/importarchives.action'; 
	     obj.submit(); 
	} 
	//]]>
</script>

<script type="text/javascript">
<!--
   $(document).ready(function(){
         $("#view").click(function(){
               $("#uploadForm").attr("action","${ctx}/archives/archives.action");             
               $("#uploadForm").submit();
          });

         $("#test").click(function (){
        	 var uploadfile = $("#upload").val();
     		if((null == uploadfile) ||( "" == uploadfile)) 
     		{ 
     		    alert("上传文件没有指定！"); 
     		    return false; 
     		} 

     	    $("#uploadForm").attr("action","${ctx}/archives/archives!test.action");             
            $("#uploadForm").submit();
                  
         });

    }); 
-->
</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="post">

<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27" style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">导入学生档案</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="40" class="tbg02 pr10">

		  <div class="lin24"><strong>提示：</strong><br />
            1、excel的格式必须符合模板中定义格式，否则会导致数据不能正确<br />
            2、excel版本必须是2003或以上<br />
            3、如果数据量很大，导入过程中需要等待几分钟<br />
            4、<a href="${ctx }/attachment/download.action?name=入库模版.xls">模版下载</a>
			</div>
			</td>

          </tr>
        <tr>
          <td bgcolor="#F1F4F9" class="tbg01 pr10">
		  <div class="lin24"><strong>导入结果：</strong><br />
            1、共对${total}条信息进行导入；<br />
            2、成功${total-failnum}条信息；<span style="color:red;"><a href="${ctx }/archives/archives!printSuccessInfo.action">点击下载成功信息</a></span> <br />
            3、失败${failnum}条信息；<span style="color:red;"><a href="${ctx }/archives/archives!printErrorInfo.action">点击下载失败信息</a></span><br />
			</div></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="32"  style="background: url('../images/login/tabbg02.jpg');"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0"  style="color:#183553;">
        <tr>
          <td>请选择导入的excel文件</td>

          <td><input id="upload" name="upload"  value="" type="file" class="wid30" /></td>
          <td>&nbsp;</td>
          <td> <input name="test" type="button" class="bulebu" id="test" value="测试导入"/></td>
          <td> <input name="submitbut" id="submitbut" type="button" class="bulebu" value="确认导入" onclick="uploadSubmit(this.form)" /></td>
          <td> <input name="view" type="button" class="bulebu" id="view" value="查看导入后数据"/></td>
          </tr>
      </table></td>
    </tr>
  </table>
</div>
	
	
	
</form>
</body>
</html>