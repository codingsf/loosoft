<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>导入宿舍</title>
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
	     obj.action = 'room/importchuangwei.action'; 
	     obj.submit(); 
	} 
	} 
	//]]>
</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form method="post" enctype="multipart/form-data"> 
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" >
     	 导入预分寝室
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="100%" colspan="2" align="left" >
				<div id="useridTip" style="width:400px;padding-left:20px;">
				提示：
				<p>
				1、excel的格式必须符合模板中定义格式<br/>
				2、点击下载<a href="${ctx }/attachment/download.action?name=宿舍模版.xls&path=template" style="color: red;">宿舍模板.xls</a><br/>
				3、导入后可以到床位浏览去查看导入详情<br/>
				</p>
				</div>	
			  </td>
	        </tr>        
	        <tr>
	          <td width="100%" height="30" align="left" bgcolor="#F1F4F9" colspan="2">
	          	<div id="useridTip" style="width:400px;padding-left:20px;">
	          	导入结果：
	            <s:if test="finished">
	    	  	<p>
				1、共导入${total}笔<br/>
				2、成功导入${total-failnum}笔<br/>
				3、失败${failnum}笔<br/>
				<c:if test="${not empty failstr}">
				4、excel中${failstr}笔不成功请检查格式或是否床位已经存在<br/>
				</c:if>
				</p>   
				</s:if>
				<s:else>
				<p>&nbsp;</p>
				</s:else>    
				</div> 
	          </td>
	        </tr>
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td>请选择导入的excel文件:<input name="upload" type="file" class="ipt wid20" style="height: 20px"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="submitbut" type="button" class="btn" value="确认导入" onclick="uploadSubmit(this.form)" /></td>
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>