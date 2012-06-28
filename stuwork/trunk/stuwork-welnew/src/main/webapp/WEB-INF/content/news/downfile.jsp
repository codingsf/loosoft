<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>附件管理列表</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>
<script type="text/javascript">
	<!--
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
	          
	         $("#picfile").focus();
	 		//为inputForm注册validate函数
	 		
	 		$("#attachmentForm").validate({
	 			rules: {
	 				picfile: "required",
	 			},
	 			messages: {
	 				picfile: "请选择上传的文件"
	 			}
	 		});
			 
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
			
		   $("#delbut").click(
				   function(){
					   if(!checkSelect()) {
				            alert("没有可删除记录,请勾选");
				            return false;
				       } 
				       if(!confirm('您确定要删除吗?')) return  false;
		
					   $("#deleteForm").submit();
				 });  
	
	    });
	function checkSelect() {
		var flag = false;
		$("input[name='ids']:checked").each(function(){
			flag = true;
		}); 
		return flag;
	}  
	function delRecord(url){
		var x = document.getElementById("deleteForm");
		   x.action=url;
	       if(confirm('您确定要删除吗?')) {
	          	x.submit();
	          	return true;    
	       } else{
		       return false;
	       }  
	}
	-->
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
				<li><a href="#" id="delbut"><span>删除</span></a></li>
				<li><a href="#" id="queryButton"><span>隐藏查询</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form action="${ctx}/news/downfile.action" method="post" id="mainForm">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="13%" align="right" style="padding-left:5px">发布时间 从:</td>
            <td width="13%" align="center">
            	<input name="filter_GED_postTime" id="startdate" value="${param.filter_GED_postTime}" type="text" class="Wdate" onclick="WdatePicker()" />
            </td>
            <td width="7%" align="right">到:</td>
            <td width="13%" align="center">
            	<input name="endPostTime" id="endPostTime" value="${param.endPostTime}" type="text" class="Wdate" onclick="WdatePicker()" />
            </td>
            <td width="7%" align="right">关键字:</td>
            <td width="13%" align="center">
            	<input type="text" name="filter_LIKES_name" value="${param.filter_LIKES_name }" style="height: 18px;" />
            </td>

            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/news/downfile!delete.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>附件列表</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="5%" class="tbg03"><strong>序号</strong></td>
	          <td width="25%" class="tbg03"><strong>附件名称</strong></td>
	          <td width="10%" class="tbg03"><strong>上传时间</strong></td>
	          <td width="8%" class="tbg03"><strong>操作</strong></td>

		  </tr>
		  <s:iterator value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${id}" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status.index+1}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${postTime}" pattern="yyyy-MM-dd"
				type="date"></fmt:formatDate>
			</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="#" onclick="delRecord('${ctx}/news/downfile!delete.action?id=${id}')">删除</a>
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
<div style="text-align: center; margin-top: 50px;">
<form action="${ctx}/news/downfile!save.action" method="post"
	enctype="multipart/form-data" id="attachmentForm"><input
	type="file" name="picfile" id="picfile" size="30" />
<button  type="submit">上传</button>
</form>
</div>
</body>
</html>