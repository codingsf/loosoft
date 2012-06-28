<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>编辑迎新辞</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script> 
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#title").focus();
		//为inputForm注册validate函数
		//自定义验证规则
	 		$.validator.addMethod("validContent",function(value,element,params){
	 			var oEditor = FCKeditorAPI.GetInstance("content");
	 		 	var oDOM = oEditor.EditorDocument;
	 		 	var iLength ;
	 		 	if(document.all){
	 		 		iLength = oDOM.body.innerText.length;
	 		 	}else{
	 			 	var r = oDOM.createRange();
	 			 	r.selectNodeContents(oDOM.body);
	 			 	iLength = r.toString().length;
	 		 	}
	 		 	if(iLength == 0)   
	 				return false; 
	 		 	else
		 		 	return true;  
			},"请输入内容");
			
		$("#dataForm").validate({
			rules: {
				title: "required",
				content:"validContent"
			},
			messages: {
				title: "请输入标题"
			}
		});
	});
	
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form action="${ctx}/news/welcomearticle!save.action" method="post" id="dataForm" name="dataForm">
  <input type="hidden" name="id" value="${welcomeArticle.id}"/>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      编辑迎新辞
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="35%" height="30" align="right" class="tbg02 pr10">标题<span class="STYLE1">*</span></td>
	          <td width="65%" >
	          	<input type="text" name="title" size="38" class="wid16" id="title" value="${welcomeArticle.title}"/>
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">作者</td>
	          <td bgcolor="#F1F4F9">
	          	<input type="text" name="user" size="38" class="wid16" readonly="readonly" id="user" value="${welcomeArticle.user}"/>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">内容<span class="STYLE1">*</span></td>
	          <td>
			    <textarea rows="20" id="content" name="content"  cols="50">${welcomeArticle.content }</textarea>
		     	<script type="text/javascript">
					createCkEditor("${ctx}/fckeditor/","content",600,300,"MyToolbar",'${curUser.id}','${curUser.createYm}',true,80,'replace');
				</script>
			  </td>
	        </tr>
	        
	        
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td><input name="submitbut" type="submit" class="bulebu" value="提交" /></td>
	          <td><input name="button" type="button" class="bulebu" value="返回" onclick="history.back();"/></td>
	          <td><input name="button" type="button" class="bulebu" value="重置" /></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>