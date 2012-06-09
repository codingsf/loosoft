<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>班级列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
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
	          
			$("#delbut").click(
			   function(){
			       if($("input:checked").length==0) {
			            alert("没有可删除记录,请勾选");
			            return false;
			       } 
			       if(!confirm('您确定要删除吗?')) return  false;
				   $("#deleteForm").submit();
			 });  

			$("#queryButton").click();
			 
		   $("#checkboxall").click(function(){
			     $("input[name='ids']").attr("checked",$(this).attr("checked"));
			});
	    }); 
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
	          	<li><a href="clazz!input.action" >新增班级</a></li>
				<li><a href="#" id="delbut">删除</a></li>
			    <li><a href="#" id="queryButton">显示查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx }/school/clazz.action" method="post">
		<table id="filter" width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
        <tr>
        	<td width="7%" align="right" style="padding-left:5px">入学年份:</td>
            <td width="13%" align="center">
            	<input name="filter_LIKES_year" type="text" size="12" value="${param['filter_EQS_year']}"/>
            </td>
            <td width="7%" align="right" style="padding-left:5px">季节:</td>
            <td width="13%" align="center">
            	<s:select list="#{'春季':'春季','秋季':'秋季'}" theme="simple" name="filter_EQS_season" value="#parameters.filter_EQS_season" headerKey="" headerValue="请选择"></s:select>
            </td>
            <td width="7%" align="right" style="padding-left:5px">班级名称:</td>
            <td width="13%" align="center">
            	<input name="filter_LIKES_name" type="text" size="12" value="${param['filter_LIKES_name']}"/>
            </td>
            <td width="7%" align="right" style="padding-left:5px">辅导员:</td>
            <td width="13%" align="center">
            	<input name="filter_LIKES_leader" type="text" size="12" value="${param['filter_LIKES_leader']}"/>
            </td>
         </tr>
         <tr>
            <td width="7%" align="right" style="padding-left:5px">班主任:</td>
            <td width="13%" align="center">
            	<input name="filter_LIKES_teacher" type="text" size="12" value="${param['filter_LIKES_teacher']}"/>
            </td>
            <td width="7%" align="right" style="padding-left:5px">培养方式:</td>
            <td width="13%" align="center">
            	<s:select list="typeList" listValue="label" listKey="value" headerKey="" headerValue="请选择" theme="simple" name="filter_EQS_type" value="#parameters.filter_EQS_type"></s:select>
            </td>
            
            
            
            
            <td width="8%"><input name="Submit32" type="submit" class="ybu" value="查 询" /></td>
            <td width="8%"><input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
            
			<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</tr>	
        </table>
		</form>
		
		<form action="${ctx}/school/clazz!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="15" bgcolor="#F7E582" class="br002"><strong>学院列表</strong></td>
          </tr>
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
	          <td width="6%" class="tbg03"><strong>入学年份</strong></td>
	          <td width="5%" class="tbg03"><strong>季节</strong></td>
	          <td width="10%" class="tbg03"><strong>所在专业</strong></td>
	          <td width="6%" class="tbg03"><strong>培养方式</strong></td>
	          <td width="8%" class="tbg03"><strong>班级代码</strong></td>
	          <td width="10%" class="tbg03"><strong>班级名称</strong></td>
	          <td width="6%" class="tbg03"><strong>辅导员</strong></td>
	          <td width="8%" class="tbg03"><strong>辅导员电话</strong></td>
	          <td width="6%" class="tbg03"><strong>班主任</strong></td>
	          <td width="8%" class="tbg03"><strong>班主任电话</strong></td>
	          <td width="10%" class="tbg03"><strong>预设教室</strong></td>
	          <td width="6%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		  	<td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  		<input type="checkbox" id="ids" name="ids" value="${obj.id }" />
		  	</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.year }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.season }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.specialty.name}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.typeDesc}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.code }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.leader}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.leaderTelnum}&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.teacher }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.teacherTelnum }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${obj.room}&nbsp;</td>
		    
		        
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			    <a href="${ctx}/school/clazz!input.action?id=${id }">修改</a> 
			    <a href="#" onclick="delOneRecord('${obj.id }','${ctx}/school/clazz!delete.action');">删除</a>
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
	<br/>
	<div>
	<span class="btn2">
	   <a href="${ctx }/school/clazz!printExcel.action"><span>导出Excel</span></a>
	</span>
	</div>
	
</div>
</body>
</html>