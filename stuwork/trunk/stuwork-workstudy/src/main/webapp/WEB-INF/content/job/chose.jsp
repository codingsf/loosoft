<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>用工选择</title>
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
			    <li><a href="#" id="queryButton">隐藏查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/job/chose.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        	<tr>
	        	<td width="11%" align="left" style="padding-left:5px">岗位名称:</td>
	            <td width="15%" align="center">
	            	<input type="text" name="filter_LIKES_postName" value="${param['filter_LIKES_postName']}" style="width: 100px"/>
	            </td>
	            <td width="14%" align="left">发布时间 ：</td>
	            <td width="15%" align="center">
	            	<input name="startPubDate" id="pubdate" type="text" class="Wdate" class="ipt wid10 " onclick="WdatePicker()" />
	            </td>
	            <td width="5%" align="left">到：</td>
	            <td width="15%" align="center">
	            	<input name="endPubDate" id="pubdate" type="text" class="Wdate" class="ipt wid10 " onclick="WdatePicker()" />
	            </td>
	            <td width="13%" align="right">截止时间 ：</td>
	            <td width="15%" align="center">
	            	<input name="startStopDate" id="stopdate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
	            </td>
	            
	            <td width="5%" align="right">到：</td>
	            <td width="15%" align="center">
	            	<input name="endStopDate" id="stopdate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />		
	            	<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
					<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
					<input type="hidden" name="page.order" id="order" value="${page.order}" />
	            </td>
            </tr>
            <tr>
            	<td width="10%" colspan="10" align="right"><input name="Submit32" type="submit" class="ybu" value="查 询" />
            	<input type="reset" id="resetbutton" class="ybu" value="重 置" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>	
        </table>
		</form>
		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>申请审核</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="25%" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="13%" class="tbg03"><strong>性别限制</strong></td>
	          <td width="13%" class="tbg03"><strong>发布时间</strong></td>
	          <td width="13%" class="tbg03"><strong>报名截止时间</strong></td>
	          <td width="13%" class="tbg03"><strong>已招聘人数</strong></td>
	          <td width="13%" class="tbg03"><strong>招聘人数</strong></td>
	          <td width="13%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator  value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postName}&nbsp;</td>
		    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				${sexLimit}
			</td>  
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${pubdate}" type="date" pattern="yyyy-MM-dd" />
			</td>   
			
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				<fmt:formatDate value="${stopdate}" type="date" pattern="yyyy-MM-dd" />
			</td>
			<td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				${exisitCount}
			</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    ${reqCount }
		    </td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/job/stu.action?postId=${id}">查看应聘学生</a>
		    </td>
		    
		    
		    
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
	<br/>
	
</div>
</body>
</html>