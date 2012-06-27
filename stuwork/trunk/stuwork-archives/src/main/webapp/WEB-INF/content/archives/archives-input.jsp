<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案入库</title>
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

         $("#dataForm").validate({
 			rules: {
        	   columnselect:"required",
        	   transfer: "required",
        	   recipient:"required"
        	   
 			},
            errorPlacement: function(error, element) {
                if (element.attr("name") == "columnselect") {
                    $("#columnselect_error").text('');
                    error.appendTo("#columnselect_error");
                }
                if (element.attr("name") == "transfer") {
                    $("#transfer_error").text('');
                    error.appendTo("#transfer_error");
                }
                if (element.attr("name") == "recipient") {
                    $("#recipient_error").text('');
                    error.appendTo("#recipient_error");
                }
            },
 			messages: {
 				passwordConfirm: {
 					equalTo: "输入与上面相同的密码"
 				}
 			}
 		});

         function submitForm(thisForm){
     		//验证
     		if($("#examineeNo").val()=="" && $("#IDcard").val()==""){
     			alert("请输入考生号或省份证号号。");
     			return false;
     		}
     		isSubmit = true;
     		return false;
     	}
         $("#queryButton").click();
    }); 
-->
</script>

<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>

</head>
<body onkeydown="if (event.keyCode==13) {$('#searchForm').submit();}" style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">

<div class="emb"></div>



  <div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
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
					<form id="searchForm" name="searchForm" action="${ctx}/archives/archives!search.action" method="post">
						<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
							  <tr style="margin-top: 5px">
								    <td width="7%" align="right" style="padding-left:5px">学号:</td>
						            <td width="13%" align="center"><input type="text" name="stuId" id="stuId" value="${stuId }" class="wid100px"></td>
						            <td width="7%" align="right" style="padding-left:5px">考生号:</td>
						            <td width="13%" align="center"><input type="text" name="examineeNo" id="examineeNo" value="${examineeNo }" class="wid100px"> </td>
						            <td width="7%" align="right" style="padding-left:5px">身份证号:</td>
						            <td width="13%" align="center"><input type="text" name="IDcard" id="IDcard" value="${IDcard}" class="wid100px"> </td>
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
					</form>
			
			</td>  
		</tr>
	
	</table>
</div>
<!-- 学生基本信息 -->
<form id="dataForm" name="dataForm" action="${ctx}/archives/archives!save.action" method="post"onsubmit="return submitForm(this)">
  <input name="stuId" value="${studentDTO.studentNo}" type="hidden" /> 
  <input name="examineeNo" value="${studentDTO.examineeNo }" type="hidden"/>
  <input name="storageTime" value="<%=sdf.format(new Date())%>" type="hidden" /> 
  <input type="hidden" name="areaText" id="areaText" value="" /> 
  <input type="hidden" name="rankText" id="rankText" /> 
  <input type="hidden" name="rowText" id="rowText" /> 
  <input type="hidden" name="columnText" id="columnText" />

<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生基本信息</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学号&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${studentDTO.studentNo}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            ${studentDTO.name}<input type="hidden" name="name" value="${studentDTO.name}"/>
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">学院&nbsp;</td>
	          <td  width="30%">
		         ${studentDTO.collegeName}
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">性别&nbsp;</td>
	          <td  width="35%">
		          ${studentDTO.sexDesc}
	          </td>
        </tr>
        
       <tr>
	          <td height="30" width="20%" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">专业&nbsp;</td>
	          <td  width="30%" bgcolor="#F1F4F9">
		         ${studentDTO.majorName}
	          </td>
	           <td height="30" width="15%" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">出生年月&nbsp;</td>
	          <td  width="35%" bgcolor="#F1F4F9">
		          <fmt:formatDate value="${studentDTO.birthday }" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">班级&nbsp;</td>
	          <td  width="30%">
		        ${studentDTO.className }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">身份证号&nbsp;</td>
	          <td  width="35%">
		         ${studentDTO.IDcard }
	          </td>
        </tr>
        
          
        <tr>
	          <td height="30" width="20%" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号&nbsp;</td>
	          <td  width="30%" bgcolor="#F1F4F9">
		        ${studentDTO.examineeNo }
	          </td>
	           <td height="30" width="15%" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">入学时间&nbsp;</td>
	          <td  width="35%" bgcolor="#F1F4F9">
		        <fmt:formatDate value="${studentDTO.inDate }" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        
         <tr>
	          <td height="30" width="20%" align="right"  class="tbg02 pr10">档案状态&nbsp;</td>
	          <td  width="30%" >
		       <c:if test="${archives eq null&&studentDTO ne null}">缺档</c:if><c:if test="${archives ne null}">${archives.status}</c:if>
	          </td>
	           <td height="30" width="15%" align="right"   class="tbg02 pr10">档案库位&nbsp;</td>
	          <td  width="35%">
		       <c:if test="${archives eq null&&studentDTO ne null}">未入库</c:if><c:if test="${archives ne null}">${archives.storeInfo}</c:if>
	          </td>
        </tr>      
      </table></td>
    </tr>
  </table>
</div>

<!-- 档案入库 -->
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案入库</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">应交材料<span class="redz">* </span></td>

          <td width="65%" >${archivesStr}<input type="text" name="addArchives" id="addArchives" />手动添加材料，多个之间以逗号隔开</td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">档案库位<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
            <select id="areaselect">
			<option value=''>请选择</option>
			<c:forEach items="${areaList}" var="al">
				<option value="${al.id }">${al.area }</option>
			</c:forEach>
		</select> 区域&nbsp;&nbsp; <select id="rankselect">
			<option value=''>请选择</option>
		</select> 排&nbsp;&nbsp;<select id="rowselect">
			<option value=''>请选择</option>
		</select> 行&nbsp;&nbsp;
		<select id="columnselect" name="columnselect">
			<option value=''>请选择</option>
		</select>列 <span id="columnselect_error"></span>
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">移交人<span class="redz">* </span>&nbsp;</td>
          <td>
           <input type="text" name="transfer" id="transfer" /><span id="transfer_error"></span>
          </td>
        </tr>
        <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">接收人<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <input type="text" name="recipient" id="recipient" /><span id="recipient_error"></span>
          </td>
       </tr>
       
        <tr>

          <td height="30" align="right"   class="tbg02 pr10">入库理由<span class="redz">* </span></td>
          <td >
            <s:select list="storageReasonList" listKey="value" listValue="value" name="reason" theme="simple"></s:select>
          </td>
       </tr>
         
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
           <td>
          <c:if test="${studentDTO eq null && archives eq null}">
			<td><input name="submitbut" type="submit" id="submit"
				class="btn" value="入库" disabled="disabled" /></td>
		</c:if>
		<c:if test="${studentDTO ne null && archives eq null}">
			<td><input name="submitbut" type="submit" id="submit"
				class="btn" value="入库" /></td>
		</c:if>
		<c:if test="${archives ne null}">
			<td><input name="submitbut" type="submit" id="submit"
				class="btn" value="入库" disabled="disabled" /></td>
		</c:if>
           </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	

</form>

</body>
</html>