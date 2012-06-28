<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>现场发放</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	   	//聚焦第一个输入框
	   	$("#value").focus();
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
      	
        $("#submitbut").click(function(){
	   		if(!confirm('您确定要发放确认吗?')) return false;
			var res = validItemFee();
			if(!res)return res;
		    $("#dataForm").attr("action","${ctx}/wuzi/give!save.action");
		    $("#dataForm").submit();
        });
        
		$("#queryButton").click();
		var flag = '${filter_EQS_filterColumn}';
		if (flag=='') {
			$("#columnexamineeNo").attr("checked","checked");
		}
	});

	//验证发放项目的缴费情况
	function validItemFee(){
		var tishi="";
		$('input[name="extendIds"]:checked').each(function(){    
			var itemId = $(this).val();
			var itemqFee = $("#extentItem_"+itemId).val();
			if(itemqFee>0){
				tishi+=","+$("#extentItemName_"+itemId).val();
			}
		});

		if(tishi.length>0){
			alert(tishi.substring(1)+"项目还欠费，不能发放");
			return false;
		}
	    return true;
	}
</script>

<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div id="message" style="margin-left: 10px;"><s:actionmessage theme="custom" cssClass="success"/></div>

<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
	<tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');">
	      <div class="tabhv">
	        <ul>
				<li><a href="#" id="queryButton"><span>显示/隐藏查询</span></a></li>
	        </ul>
	      </div>
      </td>
    </tr>
    
    <tr>
		<td bgcolor="#FFFFFF">
		<form action="${ctx}/wuzi/give!search.action?type=ff" method="post" id="searchForm" >
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="15%" style="padding-left:5px">${#filter_EQS_filterColumn} <s:radio list="radioList" listKey="value" listValue="label" id="column" name="filter_EQS_filterColumn" value="#parameters.filter_EQS_filterColumn" theme="simple"></s:radio> </td>
	            <td width="7%" ><input type="text" value="${param.value }" name="value" id="value" class="wid100px" /></td>
	            <td width="8%" align="right" ><input  type="button" id="mainformsearch" class="ybu" value="查 询" />&nbsp;<input type="reset" id="resetbutton" class="ybu" value="重 置" /></td>
	            <td width="8%"></td>
	            <td width="8%"></td>
		  </tr>
        </table>
		</form>
			
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002">
              	<strong>学生基本信息</strong>
              </td>
            </tr>
            
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">学号</td>
	          <td width="40%" >
	          	${student.studentNo }
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10" rowspan="4">相片</td>
	          <td width="40%" rowspan="4">
	          	<img src="${img }" name="img" height="70" width="70" id="img" alt="" />
	          </td>
	        </tr>
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名</td>
	          <td bgcolor="#F1F4F9">
	          	${student.name }
	          </td>
	        </tr>
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">性别</td>
	          <td>
	          	${student.sexdesc}
	          </td>
	        </tr>
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">院系</td>
	          <td bgcolor="#F1F4F9">
	          	${student.collegeName}
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">专业</td>
	          <td width="40%" >
	          	${student.majorName}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">身份证号</td>
	          <td width="40%" >
	          	${student.IDcard}
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	${student.className}
	          </td>
	           <td width="10%" height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号</td>
	          <td width="40%" bgcolor="#F1F4F9">
	          	${student.examineeNo}
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">出生年月</td>
	          <td width="40%" >
	          	${student.birthday}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">通知书编号</td>
	          <td width="40%" >
	          	${student.noticeId}
	          </td>
	        </tr>
	        
	    </table>
		
		<form method="post" id="dataForm" name="dataForm">
		<input name="examineeNo" id="examineeNo" value="${student.examineeNo }" type="hidden"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002">
              	<strong>发放清单</strong>
              	<s:iterator var="item" value="extendItems" status="status">
              	<input type="checkbox" name="extendIds" id="extendIds_${status.even}" <s:if test='received'>checked</s:if> value="${id}"/>${project}
              	</s:iterator>
              </td>
          </tr>
         
		  <tr>
	          <td height="30" width="20%" class="tbg03"><strong>类别</strong></td>
	          <td height="30" width="12%" class="tbg03"><strong>费用标准(元)</strong></td>
	          <td height="30" width="12%" class="tbg03"><strong>已缴费金额(元)</strong></td>
	          <td height="30" width="12%" class="tbg03"><strong>欠费金额(元)</strong></td>
	          <td height="30" width="10%" class="tbg03"><strong>是否领取</strong></td>
		  </tr>
		  <s:iterator value="extendVOList" status="status">
		  <tr>
		    <td height="30" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		    <input type="hidden" id="extentItem_${id}" value="${unPayedMoney}"/>
		    <input type="hidden" id="extentItemName_${id}" value="${project}"/>
		    ${project}&nbsp;
		    </td>
		    <td height="30" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${price}&nbsp;</td>    
		    <td height="30" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${payedMoney}&nbsp;</td>
			<td height="30" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${unPayedMoney}&nbsp;</td>    
		    <td height="30" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${received?"是":"否" }&nbsp;</td>  
		  </tr>
		  </s:iterator>
		</table> 
		</form>
		</td>  
	</tr>
	
	<tr>
       <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td align="center">
	          <input name="submitbut" type="button" id="submitbut" class="bulebu" value="确认发放"  <c:if test="${student eq null}">disabled="disabled" </c:if>  />
	          </td>
	        </tr>
	      </table>
      </td>
    </tr>
	</table>
</div>
</body>
</html>