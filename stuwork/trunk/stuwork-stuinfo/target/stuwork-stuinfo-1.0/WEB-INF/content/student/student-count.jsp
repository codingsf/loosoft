<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生基础信息列表</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/jscss.jsp" %>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
	function onSub(){
		if($("#education").attr("checked")==false && 
				$("#collegeCode").attr("checked")==false && 
				$("#majorCode").attr("checked")==false && 
				$("#length").attr("checked")==false && 
				$("#classCode").attr("checked")==false && 
				$("#sex").attr("checked")==false){
			alert("请选择统计字段");
			return ;
		}
		if($("#education").attr("checked")){
			$("#education").attr("value","education");
		}else{
			$("#education").attr("value","");
		}
		if($("#collegeCode").attr("checked")){
			$("#collegeCode").attr("value","collegeCode");
		}else{
			$("#collegeCode").attr("value","");
		}
		if($("#majorCode").attr("checked")){
			$("#majorCode").attr("value","majorCode");
		}else{
			$("#majorCode").attr("value","");
		}
		if($("#length").attr("checked")){
			$("#length").attr("value","length");
		}else{
			$("#length").attr("value","");
		}
		if($("#classCode").attr("checked")){
			$("#classCode").attr("value","classCode");
		}else{
			$("#classCode").attr("value","");
		}
		if($("#sex").attr("checked")){
			$("#sex").attr("value","sex");
		}else{
			$("#sex").attr("value","");
		}  
		var x=document.getElementById("searchForm");
		x.action="${ctx}/student/student!countStudent.action";
		x.submit();
	}
-->
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
	<td height="27" style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生信息统计</td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form id="searchForm" name="searchForm" action="${ctx}/student/student-count.action" method="post" >
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="8%" style="padding-left:15px">院系:</td>
	            <td width="13%" align="left">
	                <s:select id="collegeselect" theme="simple" list="collegues"  listKey="code" listValue="name" name="collegeCode"
			        headerKey="" headerValue="请选择" value="#parameters.collegeCode" cssStyle="width:150px;"/>
                </td>
                <td width="8%" style="padding-left:15px">专业:</td>
	            <td width="13%" align="center">
	                <s:select id="majorselect" theme="simple" list="majors" listKey="code"  listValue="name" name="majorCode"
			        headerKey="" headerValue="请选择" value="#parameters.majorCode" cssStyle="width:150px;"/>
				</td>
	            <td width="6%" align="right" style="padding-left:5px;padding-right: 5px;">
	            <input  type="submit" class="ybu" value="统 计"/>
	            </td>
	            <td  align="center"><input type="reset" style="padding-left:5px" id="resetbutton" class="ybu" value="重 置" /></td>
		  </tr>
		  <tr> 
              <td height="30" colspan="6" colspan="10" bgcolor="#F7E582" class="br002"><strong>&nbsp;</strong></td>
            </tr>
        </table> 
		</form>
		 
		</td>
		</tr> 
		<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="background-color: #E8F3EC;" bordercolor="#C3CED1" >
	    	<tr height="22px;">
	    		<th width="126px;" rowspan="3" colspan="2"><img src="../images/tjimage.jpg" width="175" height="100"/></th> 
	    		<th rowspan="2" colspan="2" style="font-weight: bold;text-align: center;" width="54px">预科</th>
	    		<th colspan="6" style="font-weight: bold;text-align: center;" width="162px">1年级</th>
	    		<th colspan="6" style="font-weight: bold;text-align: center;" width="162px">2年级</th>
	    		<th colspan="4" style="font-weight: bold;text-align: center;" width="108px">3年级</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">4年级</th> 
	    		<th colspan="2" rowspan="2" style="font-weight: bold;text-align: center;" width="54px">小计</th>
	    		<th rowspan="3" style="font-weight: bold;text-align: center;" width="72px">合计</th>
	    		<th colspan="4" style="font-weight: bold;text-align: center;" width="108px;">预计毕业生数</th>
	    	</tr> 
	    	  
			<tr height="30px;" style="border-color: black">   
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">本科</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">专科</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">专<br/>升本</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">本科</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">专科</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">专<br/>升本</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">本科</th>
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">专科</th> 
	    		<th colspan="2" style="font-weight: bold;text-align: center;" width="54px">本科</th>    
	    		<th colspan="4" style="font-weight: bold;text-align: center;">${year}年</th> 
	    	</tr>
	    	 
	    	<tr height="30px;" style="border-color: black">  
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>  
	    		<th style="font-weight: bold;text-align: center;" width="27px;">班<br/>级</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">人<br/>数</th>  
	    		<th style="font-weight: bold;text-align: center;" width="27px;">本<br/>科</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">专<br/>科</th>
	    		<th style="font-weight: bold;text-align: center;" width="27px;">专<br/>升本</th>  
	    		<th style="font-weight: bold;text-align: center;" width="27px;">毕业<br/>人数</th>
	    	</tr>
	    	 
	    		 
	    <s:iterator value="stuCountVOList">
	    	<tr height="30px;" style="border-color: black">
	    		<s:if test="specialSize!=0">
	    		<th rowspan="${specialSize}" style="font-weight: bold;text-align: center;width:70px;">${collegeName}</th>
	    		</s:if> 
	    		<th style="font-weight: bold;text-align: center;width:50px;">${specialName}</th>
	    		<th  style="font-weight: bold;text-align: center;" width="27px"><s:if test="yukeClCount!=0">${yukeClCount}</s:if></th>
	    		<th  style="font-weight: bold;text-align: center;" width="27px"><s:if test="yukeStuCount!=0">${yukeStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freBeClCount!=0">${freBeClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freBeStuCount!=0">${freBeStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freZhClCount!=0">${freZhClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freZhStuCount!=0">${freZhStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freZsbClCount!=0">${freZsbClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="freZsbStuCount!=0">${freZsbStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopBeClCount!=0">${sopBeClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopBeStuCount!=0">${sopBeStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopZhClCount!=0">${sopZhClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopZhStuCount!=0">${sopZhStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopZsbClCount!=0">${sopZsbClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="sopZsbStuCount!=0">${sopZsbStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="junBeClCount!=0">${junBeClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="junBeStuCount!=0">${junBeStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="junZhClCount!=0">${junZhClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="junZhStuCount!=0">${junZhStuCount}</s:if></th> 
	    		<th style="font-weight: bold;text-align: center;"><s:if test="senBeClCount!=0">${senBeClCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="senBeStuCount!=0">${senBeStuCount}</s:if></th>
	    		<th style="font-weight: bold;text-align: center;"><s:if test="totalClNumber!=0">${totalClNumber}</s:if></th> 
	    		<th style="font-weight: bold;text-align: center;"><s:if test="totalStuNumber!=0">${totalStuNumber}</s:if></th>  
	    		<s:if test="specialSize!=0">
	    		<th rowspan="${specialSize}" style="font-weight: bold;text-align: center;width:70px;"><s:if test="totalCount!=0">${totalCount}</s:if></th>
	    		</s:if> 
	    		 
	    		<th style="font-weight: bold;text-align: center;"><s:if test="totalBenStuNumber!=0">${totalBenStuNumber}</s:if></th> 
	    		<th style="font-weight: bold;text-align: center;"><s:if test="totalZhStuNumber!=0">${totalZhStuNumber}</s:if></th> 
	    		<th style="font-weight: bold;text-align: center;"><s:if test="totalZsbStuNumber!=0">${totalZsbStuNumber}</s:if></th> 
	    		<s:if test="specialSize!=0">
	    		<th rowspan="${specialSize}" style="font-weight: bold;text-align: center;"><s:if test="totalNumber!=0">${totalNumber}</s:if></th>
	    		</s:if>
	    	</tr>
	    	</s:iterator>
	    	<tr>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="2">学生数总合计</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="2">预科学生数${yukeCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="6">一年级学生数${freCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="6">二年级学生数${sopCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="4">三年级学生数${junCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="2">四年级学生数${senCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="2">小计学生数${xiaojiCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" >全校学生数${allCount}</th>
	    		<th style="font-weight: bold;text-align: center;width:50px;" colspan="4">${year}年预计毕业生数${yujiCount}</th>
	    	</tr> 
		</table>
		
		</td></tr>
		</table>
	<br/>
	<div> 
	</div>
	
</div>
  
</body>
</html>