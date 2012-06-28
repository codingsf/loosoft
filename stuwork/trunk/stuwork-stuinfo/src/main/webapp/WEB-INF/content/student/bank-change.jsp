<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>学生银行账号异动信息列表</title>
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
		<form id="searchForm" name="searchForm" action="${ctx}/student/bank-change!list.action" method="post">
		<table id="filter" width="100%"  style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="8%" align="right" style="padding-left:5px">原银行名称:</td>
	            <td width="17%" align="center">
	            	<input type="text" name="filter_LIKES_bankName" id="bankName" style="width: 95%;" value="${param['filter_LIKES_bankName']}"/>
	            </td>
	            <td width="8%" align="right" style="padding-left:5px">原银行账号:</td>
	            <td width="17%" align="center">
	                <input type="text" name="filter_LIKES_bankAcount" id="bankAcount" style="width: 95%;" value="${param['filter_LIKES_bankAcount']}"/>
                </td>
                <td width="8%" align="right" style="padding-left:5px">现银行名称:</td>
	            <td width="17%" align="center">
	                <input type="text" name="filter_LIKES_newBankName" id="newBankName" style="width: 95%;" value="${param['filter_LIKES_newBankName']}"/>
				</td>
	            <td width="8%" align="right" style="padding-left:5px">现银行账号:</td>
	            <td align="center">
	                <input type="text" name="filter_LIKES_newBankAcount" id="newBankAcount" style="width: 95%;" value="${param['filter_LIKES_newBankAcount']}"/>
                </td>	            
		  </tr>
		 	 
		  <tr>
		  	<td align="right" style="padding-left:5px">操作人:</td>
	      	<td align="center">
	      		<input type="text" name="filter_LIKES_operateUsername" id="operateUsername" style="width: 95%;" value="${param['filter_LIKES_operateUsername']}"/>
	      	</td>
		   	<td align="right" style="padding-left:5px">异动时间从:</td>
            <td align="center">
            	<input name="filter_GED_operateDateTime" value="${param['filter_GED_operateDateTime']}" id="applyDate" type="text" style="width: 95%" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
            </td>
            <td  align="right" colspan="2">到&nbsp;
            	<input name="endChangeDateTime" value="${param['endChangeDateTime']}" id="applyDate" type="text" style="width: 65%" class="Wdate" class="ipt wid30 " onclick="WdatePicker()" />
      		&nbsp;&nbsp; 
      		</td>
			<td align="right" style="padding-left:5px">学号:</td>
            <td align="center">
            	<input name="filter_LIKES_studentNo" value="${param['filter_LIKES_studentNo']}" id="studentNo" style="width: 95%;" type="text" class="ipt wid30 " />
            </td>      		
		  </tr>
		   <tr>
		  	<td align="right" style="padding-left:5px">姓名:</td>
	      	<td align="center">
	      		<input name="filter_LIKES_name" value="${param['filter_LIKES_name']}" id="name" style="width: 95%;" type="text" class="ipt wid30 " />
	      	</td>
		   	<td align="right" style="padding-left:5px">入学批次:</td>
            <td align="center">
            	<s:select id="batchselect" theme="simple" list="batches" listKey="comname" listValue="comname"  name="filter_EQS_batch"
				      headerKey="" headerValue="全部" value="#parameters.filter_EQS_batch"/>
            </td>
            <td  align="right" colspan="4"> 
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
              <td height="30" colspan="9" bgcolor="#F7E582" class="br002"><strong>银行账号异动信息</strong></td>
          </tr>
		  <tr>
	          <td height="25" width="21%" class="tbg03"><strong>学号</strong></td>
	          <td width="12%" class="tbg03"><strong>姓名</strong></td>
	          <td width="9%" class="tbg03"><strong>入学批次</strong></td>
	          <td width="12%" class="tbg03"><strong>原银行名称</strong></td>
	          <td width="18%" class="tbg03"><strong>原银行账号</strong></td>
	          <td width="18%" class="tbg03"><strong>现银行名称</strong></td>
	          <td width="18%" class="tbg03"><strong>现银行账号</strong></td>
	          <td width="18%" class="tbg03"><strong>操作时间</strong></td>
	          <td width="9%" class="tbg03"><strong>操作人</strong></td>
		  </tr>
		  <s:iterator id="obj" value="page.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentNo }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${batch}&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${bankName }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${bankAcount }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${newBankName }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${newBankAcount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>"><s:date name="operateDateTime" format="yyyy.MM.dd"/>&nbsp;</td>  
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