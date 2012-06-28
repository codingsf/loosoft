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
          
         $("#newcollegeselect").bind("change",function() {
     		//取得学院下的专业
     		var newcollegeCode = $("#newcollegeselect").val();
     		var newcollegeName =$("#newcollegeselect").find("option:selected").text();
     		//$("#newcollegeName").val(newcollegeName);
     		if(newcollegeCode) {
     			$.getJSON("../related/related!majorList.action",{"collegeCode":newcollegeCode},function(data) {
     				$("#newmajorselect option[value!='']").remove();
     				var majors = eval(data.majors);
     				if(majors.length == 0) return;
     				for(var i = 0 ;i < majors.length ; i++) {
     					$("#newmajorselect").append("<option value='"+majors[i].code+"'>"+majors[i].name+"</option>");
     				}
     			});
     		}else {
     			$("#newmajorselect option[value!='']").remove();
     		}
     	});
     	
     	$("#newmajorselect").bind("change",function() {
     		//取得专业下的班级
     		var newmajorCode = $("#newmajorselect").val();
     		var newmajorName =$("#newmajorselect").find("option:selected").text();
     		//$("#majorName").val(majorName);
     		if(newmajorCode) {
     			$.getJSON("../related/related!clazzList.action",{"majorCode":newmajorCode},function(data) {
     				$("#newclazzselect option[value!='']").remove();
     				var clazzs = eval(data.clazzs);
     				if(clazzs.length == 0) return;
     				for(var i = 0 ;i < clazzs.length ; i++) {
     					$("#newclazzselect").append("<option value='"+clazzs[i].code+"'>"+clazzs[i].name+"</option>");
     				}
     			});
     		}else {
     			$("#newclazzselect option[value!='']").remove();
     		}
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
			    <li><a href="#" id="queryButton">隐藏查询</a></li>
	        </ul>
	      </div>
      </td>
    </tr>
 
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/student/school-roll-change!list.action" method="post">
		<table id="filter" width="100%"  style="height: 35px" border="2" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="4%" align="right" style="padding-left:5px">学号:</td>
	            <td width="10%" align="center"><input type="text" name="filter_LIKES_studentNo" id="studentNo" class="wid100px" value="${param['filter_LIKES_studentNo']}"/></td>
	            				<td width="7%" align="right" style="padding-left:5px">原所属院系:</td>
	            <td width="13%" align="center">
	                <s:select id="collegeselect" theme="simple" list="collegues"  listKey="code" listValue="name" name="filter_EQS_collegeCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode" cssStyle="width:130px;"/>
                </td>
                <td width="7%" align="right" style="padding-left:5px">原所属专业:</td>
	            <td width="13%" align="center">
	                <s:select id="majorselect" theme="simple" list="majors" listKey="code"  listValue="name" name="filter_EQS_majorCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode" cssStyle="width:130px;"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">原所属班级:</td>
	            <td width="13%" align="center">
	                <s:select id="clazzselect" theme="simple" list="clazzs" listKey="code" listValue="name"  name="filter_EQS_classCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode" cssStyle="width:130px;"/>
                </td>	            
		  </tr>
		 	
		  <tr>
			    <td  align="right" style="padding-left:5px">批次:</td>
	            <td  align="center">
	                 <s:select id="batchselect" theme="simple" list="batches" listKey="comname" listValue="comname"  name="filter_EQS_batchname"
				      headerKey="" headerValue="全部" value="#parameters.filter_EQS_batchname" cssStyle="width:103px;"/>
				</td>
	   	            				<td width="7%" align="right" style="padding-left:5px">现所属院系:</td>
	            <td width="13%" align="center">
	                <s:select id="newcollegeselect" theme="simple" list="collegues"  listKey="code" listValue="name" name="filter_EQS_newcollegeCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_newcollegeCode" cssStyle="width:130px;"/>
                </td>
                <td width="7%" align="right" style="padding-left:5px">现所属专业:</td>
	            <td width="13%" align="center">
	                <s:select id="newmajorselect" theme="simple" list="newMajors" listKey="code"  listValue="name" name="filter_EQS_newmajorCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_newmajorCode" cssStyle="width:130px;"/>
				</td>
	            <td width="7%" align="right" style="padding-left:5px">现所属班级:</td>
	            <td width="13%" align="center">
	                <s:select id="newclazzselect" theme="simple" list="newClazzs" listKey="code" listValue="name"  name="filter_EQS_newclassCode"
			        headerKey="" headerValue="请选择" value="#parameters.filter_EQS_newclassCode" cssStyle="width:130px;"/>
                </td>	 
	           
		  </tr> 
		  <tr>
		    <td align="right" style="padding-left:5px">姓名:</td>
	      	<td align="center"><input type="text" name="filter_LIKES_name" id="studentNo" class="wid100px" value="${param['filter_LIKES_name']}"/></td>
		  	<td align="right" style="padding-left:5px">操作人:</td>
	      	<td align="center"><input type="text" name="filter_LIKES_operateUsername" id="operateUsername" class="wid130px" value="${param['filter_LIKES_operateUsername']}"/></td>
		   	<td align="right" style="padding-left:5px">异动时间从:</td>
            <td align="center">
            	<input name="filter_GED_changeDateTime" value="${param['filter_GED_changeDateTime']}" id="applyDate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
           &nbsp; 到&nbsp;</td>
            <td  align="right" colspan="2">
            	<input name="endChangeDateTime" value="${param['endChangeDateTime']}" id="applyDate" type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
      		&nbsp;&nbsp;
	    	<input  type="submit" class="ybu" value="查 询"/>
           <input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
		  </tr>
        </table>
            <input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
			<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
			<input type="hidden" name="page.order" id="order" value="${page.order}" />
		</form>
		
		<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="11" bgcolor="#F7E582" class="br002"><strong>学籍异动记录信息</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="9%" class="tbg03"><strong>姓名</strong></td>
	          <td width="6%" class="tbg03"><strong>学号</strong></td>
	          <td width="8%" class="tbg03"><strong>批次</strong></td>
	          <td width="10%" class="tbg03"><strong>原所属院系</strong></td>
	          <td width="10%" class="tbg03"><strong>原所属专业</strong></td>
	          <td width="10%" class="tbg03"><strong>原所属班级</strong></td>
	          <td width="10%" class="tbg03"><strong>现所属院系</strong></td>
	          <td width="10%" class="tbg03"><strong>现所属专业</strong></td>
	          <td width="10%" class="tbg03"><strong>现所属班级</strong></td>
	          <td width="8%" class="tbg03"><strong>异动时间</strong></td>
	          <td width="9%" class="tbg03"><strong>操作人</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentNo }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${batchname }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${collegeName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${majorName}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${className}&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${newcollegeName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${newmajorName}&nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${newclassName}&nbsp;</td>   
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><s:date name="changeDateTime" format="yyyy.MM.dd"/> &nbsp;</td>  
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${operateUsername}&nbsp;</td>  
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