<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>调阅管理</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
	<style type="text/css"> 
		.focus { 
			 border: 1px solid #f00;
			 background: #fcc;
		} 
    </style>
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


         $("#queryButton").click();

    }); 
-->

</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;" onkeydown="if (event.keyCode==13) {$('#searchForm').submit();}">
<script type="text/javascript">
function diaoyue(status,stuNo)
{
	if(status=="调阅"){
		alert('操作失败，该档案已被调阅。');
	}else{
		$("#submitForm").attr("action","${ctx}/lendlog/lend-log!input.action?stuNo="+stuNo);
		$("#submitForm").submit();
	}
		
}
function guidang(status,stuNo)
{
	if(status=="在库"){
		alert('操作失败，该档案已在库。');
	}else{
        $("#submitForm").attr("action","${ctx}/returnlog/return-log!input.action?stuNo="+stuNo);
	    $("#submitForm").submit();
	}
		
}
</script>
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
		<form id="searchForm" name="searchForm" action="${ctx}/lendlog/lend-manage!list.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">学号:</td>
	            <td width="13%" align="center"><input type="text" name="stuNo" class="wid100px" value="${stuNo }"/></td>
	            <td width="7%" align="right" style="padding-left:5px">姓名:</td>
	            <td width="13%" align="center"><input type="text" name="name" class="wid100px" value="${name}"/></td>

	            <td width="7%" align="right" style="padding-left:5px">考生号:</td>
	            <td width="13%" align="center"><input type="text" name="examineeNo" class="wid100px" value="${examineeNo}"/></td>
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
          <input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
		</form>
		
		<form  method="post" id="submitForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>调阅管理</strong></td>
          </tr>
		  <tr>
	          <td width="10%" class="tbg03" height="25"><strong>学号</strong></td>
	          <td width="5%" class="tbg03"><strong>姓名</strong></td>
	          <td width="10%" class="tbg03"><strong>入库时间</strong></td>
	          <td width="10%" class="tbg03"><strong>库位号</strong></td>
	           <td width="10%" class="tbg03"><strong>档案状态</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
	          
	          
	          
		  </tr>
		  <s:iterator id="obj" value="page.result"  status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${stuId }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${ name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><fmt:formatDate value="${storageTime}" type="date" pattern="yyyy-MM-dd"/>&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${storeInfo}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${status}&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			   <c:if test="${status eq '调阅'}">
                        <a href="javascript:void(0);" onclick="javascript:guidang('${status}','${stuId}')">归档</a>
               </c:if>
               <c:if test="${status eq '在库'}">
                        <a href="javascript:void(0);" onclick="javascript:diaoyue('${status}','${stuId}')">调阅</a>
               </c:if>
               <a href="${ctx}/lendlog/lend-manage!detail.action?stuNo=${stuId}">详情</a>
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