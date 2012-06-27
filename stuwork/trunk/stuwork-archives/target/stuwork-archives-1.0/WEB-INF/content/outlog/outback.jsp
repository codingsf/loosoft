<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>调出撤销</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript">

function chkOneRecord(url){
	if(window.confirm("确实撤销吗?")){
		document.getElementById("searchForm").action=url;
		document.getElementById("searchForm").submit();
	}
}
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
	          
	        
	         $(function(){
	       		$(":input").focus(function(){
	       			  $(this).addClass("focus");
	       			 $(this).val(""); 
	       			  
	       		}).blur(function(){
	       			$(this).removeClass("focus");
	           		})
	           })
			$("#delbut").click(
			   function(){
			       if($("input:checked").length==0) {
			            alert("没有可删除记录,请勾选");
			            return false;
			       } 
			       if(!confirm('您确定要删除吗?')) return  false;
	
				   $("#deleteForm").submit();
			 });  
			 
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});

		   $("#queryButton").click();
		$("#printexcel").click(function(){
			document.getElementById("searchForm").action="outlog!printExcel.action";
			document.getElementById("searchForm").submit();
		});
			
	    }); 
	-->
	</script>
</head>
<body onkeydown="if (event.keyCode==13) {$('#searchForm').submit();}" style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/outlog/outback!list.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">学号:</td>
	            <td width="13%" align="center"><input type="text" name="filter_EQS_stuId" value="${param.filter_EQS_stuId }" class="wid100px" /></td>
	            <td width="7%" align="right" style="padding-left:5px">考生号</td>
	            <td width="13%" align="center"><input type="text" name="filter_EQS_examineeNo" value="${param.filter_EQS_examineeNo }" class="wid100px" /></td>

	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center"></td>
	            <td width="7%" align="right" style="padding-left:5px"></td>
	            <td width="13%" align="center"></td>
		  </tr>
		 	
		  <tr>
			    <td width="8%"><input  type="submit" class="ybu" value="查 询" /></td>
	            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
	            <td></td>
	            <td></td>
		  </tr>
        </table>
          <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
          <input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
          <input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form  method="post" id="submitForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>调出撤销</strong></td>
          </tr>
		  <tr>
		     
	          <td width="10%" class="tbg03" height="25"><strong>学号</strong></td>
	          <td width="15%" class="tbg03"><strong>档案信息</strong></td>
	          <td width="10%" class="tbg03"><strong>库位信息</strong></td>
	          <td width="10%" class="tbg03"><strong>操作人</strong></td>
	           <td width="10%" class="tbg03"><strong>状态</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator id="obj" value="page.result"  status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${stuId }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${archivesInfo }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${storeInfo}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${operater }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status}&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		      <a href="#" onclick="chkOneRecord('outback!save.action?id=${id}');">撤销</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/commonPage.jsp"%>
      </td>
    </tr>
    
	</table>
</div>

</body>
</html>