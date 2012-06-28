<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>学生学籍信息列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/jscss.jsp" %>
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

		 $("#mainformsearch").click(function(){
           $("#dataForm").submit();
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
		<form id="searchForm" name="searchForm" action="${ctx}/student/student-roll!list.action" method="post">
		<table id="filter" width="100%"  style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="7%" align="right" style="padding-left:5px">学号:</td>
	            <td width="13%" align="center"><input type="text" name="studentNo" id="studentNo" class="wid100px" value="${studentNo}"/></td>
	            <td width="7%" align="right" style="padding-left:5px">姓名:</td>
	            <td width="13%" align="center"><input type="text" name="name" class="wid100px" value="${name}" id="name"/></td>
	            <td width="7%" align="right" style="padding-left:5px">身份证号:</td>
	            <td width="13%" align="center"><input type="text" name="IDcard" value="${IDcard}" class="wid100px" id="IDcard"/></td>
	            <td width="7%" align="right" style="padding-left:5px">考生号:</td>
	            <td width="13%" align="center"><input type="text" name="examineeNo" value="${examineeNo}" class="wid100px" id="examineeNo"/></td>
		  </tr>
		 	
		  <tr>
			    <td width="7%" align="right" style="padding-left:5px">批次:</td>
	            <td width="13%" align="center">
	                 <s:select id="batchselect" theme="simple" list="batches" listKey="comname" listValue="comname"  name="comname"
				      headerKey="" headerValue="全部" value="comname"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">院系:</td>
	            <td width="13%" align="center">
	                <s:select id="collegeselect" theme="simple" list="collegues"  listKey="code" listValue="name" name="collegeCode"
			        headerKey="" headerValue="请选择" value="collegeCode"/>
                </td>
                <td width="7%" align="right" style="padding-left:5px">专业:</td>
	            <td width="13%" align="center">
	                <s:select id="majorselect" theme="simple" list="majors" listKey="code"  listValue="name" name="majorCode"
			        headerKey="" headerValue="请选择" value="majorCode"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">班级:</td>
	            <td width="13%" align="center">
	                <s:select id="clazzselect" theme="simple" list="clazzs" listKey="code" listValue="name"  name="classCode"
			        headerKey="" headerValue="请选择" value="classCode"/>
                </td>
		  </tr>
		  <tr> 
		        <td width="7%" align="right" style="padding-left:5px">性别:</td>
	            <td width="13%" align="center">
	               <s:select theme="simple" list="sexList" name="sex" listKey="value" listValue="label" id="sex" headerKey="" headerValue="请选择" value="sex" />
                </td>
	            <td  align="right" style="padding-left:5px">是否在校:</td>
	            <td width="13%" align="center">
	              <s:select list="#{1:'是',0:'否'}" headerKey="" theme="simple" headerValue="全部" name="isInSchool" value="isInSchool"></s:select>
	            </td>
	            <td align="right" style="padding-left:5px">显示个数:</td>
	            <td align="center">
	              <s:select id="pageselect" theme="simple" list="selectPageList" listKey="value" listValue="label" name="pageCode"
			      headerKey="" headerValue="请选择" value="pageCode"/>
	            </td>
	            <td align="right" style="padding-left:5px"></td>
	            <td  align="center"></td>
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
		
		<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>学生学籍信息</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="15%" class="tbg03"><strong>姓名</strong></td>
	          <td width="5%" class="tbg03"><strong>学号</strong></td>
	          <td width="20%" class="tbg03"><strong>院系</strong></td>
	          <td width="20%" class="tbg03"><strong>专业</strong></td>
	          <td width="20%" class="tbg03"><strong>班级</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentNo }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${collegeName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorName}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${className}&nbsp;</td>   
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			     <a href="${ctx }/student/student-roll!input.action?id=${id}">修改</a>
			     <a href="${ctx }/student/student-roll!detail.action?id=${id}">详情</a>
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
</div>


</body>
</html>