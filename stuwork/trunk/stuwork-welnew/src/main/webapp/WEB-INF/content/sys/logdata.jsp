<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>系统操作日志</title>
	<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/js.jsp" %>
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
	     $("#queryButton").click();
		 
    }); 
-->
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
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
		<form id="searchForm" name="searchForm" action="logdata.action" method="post">
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">操作人:</td>
	            <td width="13%" align="left"><input type="text" name="filter_LIKES_username" id="username" class="wid100px" value="${param['filter_LIKES_username']}"/></td>
	            <td width="7%" align="right" style="padding-left:5px">操作类型:</td>
	            <td width="13%" align="left"><input type="text" name="filter_EQS_operatetype" class="wid100px" value="${param['filter_EQS_operatetype']}" id="operatetype"/></td>
	            <td width="7%" align="right" style="padding-left:5px">操作时间从:</td>
	            <td width="13%" align="left"><input type="text" name="filter_GED_operatedate" value="${param['filter_GED_operatedate']}" onclick="WdatePicker();" readonly="readonly"  class="wid100px" id="operatedate"/></td>
	            <td width="7%" align="right" style="padding-left:5px">到:</td>
	            <td width="13%" align="left"><input type="text" name="operateEndDate" value="${param['operateEndDate']}" class="wid100px" onclick="WdatePicker();" readonly="readonly" id="operateEndDate"/></td>
		  </tr>
		  <tr > 
	            <td width="13%" align="center"colspan="8">
		            <input  type="submit" class="ybu" value="查 询" />&nbsp;&nbsp;
		            <input type="reset" id="resetbutton" class="ybu" value="重 置" />
	            </td>
		  </tr>
        </table>
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
            <input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
            <input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="4" bgcolor="#F7E582" class="br002"><strong>系统操作日志</strong></td>
          </tr>
		  <tr>
	          <td width="25%" class="tbg03"><strong>操作</strong></td>
	          <td height="30" width="25%" class="tbg03"><strong>操作类型</strong></td>
	          <td width="25%" class="tbg03"><strong>操作用户</strong></td>
	          <td width="25%" class="tbg03"><strong>操作时间</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		  <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${operate}&nbsp;</td>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${operatetype}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${username}&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><s:date name="operatedate" format="yyyy-MM-dd HH.mm.ss"/>&nbsp;</td>
		  </tr>
		  </s:iterator>
		</table> 
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