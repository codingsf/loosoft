<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>通知书样本列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
	
		$(document).ready(function(){
	         $("#queryButton").click(function(){
	                var helloDivObj = $("#filter");   
	                var buttonObj = $("#queryButton");   
	                var val = buttonObj.text();
	               if(val=="隐藏查询"){
	                    helloDivObj.hide(); 
	                    buttonObj.text("显示查询");  
	                }else{   
	                    helloDivObj.show();  
	                    buttonObj.text("隐藏查询"); 
	                }   
	          });
	     });    
	     function useOneRecord(id,url){
		   if(confirm('您确定要使用吗?')){
		   $.ajax({
		            type: "post",
		            dataType: "html",
		            url: url,
		            data: "id=" + id,
		            success: function (msg) {
		            if (msg!=""){
		                    location.reload();
		                    }
		            },
		            error: function() {
		                 alert("操作失败,请联系管理员");
		            }
		        });
		    }
		 } 
		
	
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
			    <li><a href="${ctx}/noticeBook/notice-book!upload.action"><span>上传通知书</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form action="${ctx}/news/news.action" method="post" id="mainForm">
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form  method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="13" bgcolor="#F7E582" class="br002"><strong>通知书样本</strong></td>
          </tr>
		  <tr>
	          <td width="5%" height="25" class="tbg03"><strong>年限</strong></td>
	          <td width="10%" class="tbg03"><strong>图片名称</strong></td>
	          <td width="10%" class="tbg03"><strong>说明</strong></td>
	          <td width="7%" class="tbg03"><strong>状态</strong></td>
	          <td width="8%" class="tbg03"><strong>操作</strong></td>
	          
	          
		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${year}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${imageName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${introduce}&nbsp;</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/noticeBook/notice-book!setting.action?id=${id}" target="_blank">设置</a>
				<a href="${ctx}/noticeBook/notice-book!view.action?id=${id}" target="_blank">预览</a>
				<a href="#" onclick="delOneRecord('${id }','${ctx}/noticeBook/notice-book!delete.action');">删除</a>
				<s:if test="status=='未用'">
				<a href="#" onclick="useOneRecord('${id }','${ctx}/noticeBook/notice-book!using.action');">使用</a>
				</s:if>
		    </td>
		    
		    
		    
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/turnpage.jsp"%>
      </td>
    </tr>
	
	
	</table>
	
</div>
</body>
</html>