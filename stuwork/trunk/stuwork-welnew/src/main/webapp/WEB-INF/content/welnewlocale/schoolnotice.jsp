<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>学院报到</title>
<style type="text/css">
a:hover {
	cursor: hand;
}
</style>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<link media="screen" rel="stylesheet" href="${ctx}/css/colorbox.css" />
<%@ include file="/common/meta.jsp" %>
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/headerQuery.js"></script>
<script type="text/javascript" src="${ctx}/js/table.js"></script>
<script src="${ctx}/js/jquery.colorbox.js" type="text/javascript"></script>
<script type="text/javascript">
<!--	
	$(document).ready(function(){
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
          
	  	$("#submitDevo").click(function(){
		    var flag = true;
		    $("span[name='qfMoney']").each(function(){
				if ($(this).attr("need") == "true" && eval($(this).html())>0) {
					flag = false;
					return  false;
				}
		    })
		    //是否通过资格审查
			var checked = $("#checkPass").attr("checked");
			if(!checked){
				alert("未通过资格审查的不能报道！");
				return false;
			}
				
		    //分配寝室
		    //validRoom();
		    //if(!confirm('您确定要学院报道确认吗?')) return  false;
		    document.getElementById("searchForm").action="schoolnotice!submitSchoolNotice.action";
			document.getElementById("searchForm").target="parent";
			document.getElementById("searchForm").submit();
		    document.getElementById("searchForm").action="${ctx}/welnewlocale/schoolnotice!searchStudent.action";
			document.getElementById("searchForm").target="_self";
		    //if (!flag){
				//alert("必交费用没有缴费,不能确认报到！");
				//return  false;
		    //}			  	

		});


		$("#queryButton").click();

		var flag = '${filter_EQS_filterColumn}';
		if (flag=='') {
			$("#columnexamineeNo").attr("checked","checked");
		}
	}); 

	function validRoom() {
		//先验证是否已经分配了寝室，如果分配了就通过验证，进行注册
		var checked = $("#isAuto").attr("checked");
		$.getJSON("${ctx}/room/bed-assign!validBed.action",{"examineeNo":'${student.examineeNo}',"rand":Math.random()},function(data) {
			if(data.validResult=='has'){
				//提交
			    //if(!confirm('您确定要学院报道确认吗?')) return  false;
			    document.getElementById("searchForm").action="schoolnotice!submitSchoolNotice.action";
				document.getElementById("searchForm").target="parent";
				document.getElementById("searchForm").submit();
			    document.getElementById("searchForm").action="${ctx}/welnewlocale/schoolnotice!searchStudent.action";
				document.getElementById("searchForm").target="_self";
				$("#value").select();
			}else if(data.validResult=='no' || !checked){
				//弹出手工分配寝室层
				$.colorbox({href:'${ctx}/room/bed-assign!select.action?examineeNo=${student.examineeNo}',width:'650px'})
			}else{
				//提交
			    //if(!confirm('您确定要学院报道确认吗?')) return  false;
			    document.getElementById("searchForm").action="schoolnotice!submitSchoolNotice.action";
				document.getElementById("searchForm").target="parent";
				document.getElementById("searchForm").submit();
			    document.getElementById("searchForm").action="${ctx}/welnewlocale/schoolnotice!searchStudent.action";
				document.getElementById("searchForm").target="_self";
				$("#value").select();
			}
		});
	}

	///再次打印报道表
	function reprint(){
		var column = $("input:[name=filter_EQS_filterColumn]:radio:checked").val();
		var value = $("#value").val();
		if(column=='' && value==''){
			alert("请输入新生信息!");
			return;
		}
		window.open("${ctx}/welnewlocale/schoolnotice!print.action?column="+column+"&value="+value);
	}
-->
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">

<div class="emb"></div>
<form id="searchForm" name="searchForm" action="${ctx}/welnewlocale/schoolnotice!searchStudent.action" method="post" target="_self">
<input type="hidden" value="" id="hiddenColumn"/>
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
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>${userCollegeName}学院报到</strong></td>
          </tr>
		</table> 
		
		<table id="filter" width="100%" style="height: 35px" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7E582" class="br07" >
		  <tr style="margin-top: 5px">
			    <td width="20%" style="padding-left:5px"><s:radio list="radioList" listKey="value" listValue="label" id="column" name="filter_EQS_filterColumn" value="#parameters.filter_EQS_filterColumn" theme="simple"  onclick="$('#hiddenColumn').val(this.value)"></s:radio> </td>
	            <td width="10%" ><input type="text" value="${param.value }" name="value" id="value" class="wid100px" /></td>
	            <td width="30%" align="left" ><input type="button" id="mainformsearch" class="ybu" value="查 询" />&nbsp;&nbsp;
	            <s:if test="student.reged">
	            <input type="button" id="printbutton" class="ybu" value="再次打印报到表" onclick="reprint()"/>
	            </s:if>
	            </td>
	            <td width="8%"></td>
		  </tr>
        </table>		
		</td>  
	</tr>	
	</table>
</div>
<!-- 学生基本信息 -->
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
	
    <tr>
		<td bgcolor="#FFFFFF">	
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>学生基本信息</strong></td>
        </tr>
        
        <tr>
	          <td  height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">出生年月&nbsp;</td>
	          <td >${student.birthday}</td>
		      <td  height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10" rowspan="10">相片&nbsp;</td>
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="10"> 
	          <s:if test='student.type=="zsb"'>
	          <img src="${ctx}/photo/${student.welbatch.id}/${student.IDcard}.jpg" name="img" id="img" alt=""  width="210" height="280"/>
	          </s:if>
	          <s:else>
	          <img src="${ctx}/photo/${student.welbatch.id}/${student.photo}" name="img" id="img" alt=""  width="210" height="280"/>
	          </s:else>
	          </td>	
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名&nbsp;</td>
	          <td>
		           ${student.name }
	          </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">性别&nbsp;</td>
	          <td >
		         ${student.sexdesc }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">院系&nbsp;</td>
	          <td >
		      ${student.collegeName}
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业&nbsp;</td>
	          <td>
		        ${student.majorName}
		      </td>
        </tr>
        
        <tr>		      
		      <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号&nbsp;</td>
	          <td >
		           ${student.IDcard}
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级&nbsp;</td>
	          <td  width="30%">
		      ${student.className}
	          </td>
        </tr>
        
        <tr>	          
	           <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号&nbsp;</td>
	          <td  width="35%">
		      ${student.examineeNo}
	          </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">是否报到&nbsp;</td>
	          <td  width="30%">
	          <s:if test="student.reged"><font style="color: red;">是</font></s:if><s:else>否</s:else>
	          </td>
        </tr>
        
        <tr>	          
	          <td height="30" width="15%" align="right"  bgcolor="#F1F4F9"  class="tbg01 pr10">通知书编号&nbsp;</td>
	          <td  width="35%" >
		      ${student.noticeId}
	          </td>
        </tr>
        
		</table> 
		</td>  
	</tr>
	</table>
</div>


<!-- 报到操作 -->
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
       <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>报到操作</strong></td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="20%" height="30" align="right" class="tbg02 pr10">上交物品&nbsp;</td>

          <td colspan="3">${turnOverString }</td>
        </tr>
        
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">业务处理&nbsp;</td>
          <td bgcolor="#F1F4F9" colspan="3">
	          	   确认新生是否已经提交了${devolverString }
          </td>
        </tr>
        
        <tr>
          <td height="30" align="right"  class="tbg02 pr10">是否提交&nbsp;</td>
          <td colspan="3">
             <c:forEach items="${devolverVOList}" var="di">
			    <input type="checkbox" name="idList" value="${di.id}" <c:if test="${di.devolver eq true}">checked="checked"</c:if> />${di.name}&nbsp;&nbsp;
		     </c:forEach>
          </td>
        </tr> 
        
        <tr>
          <td width="25%" height="30" align="right" class="tbg01 pr10">是否通过资格审查&nbsp;</td>
          <td width="25%" bgcolor="#F1F4F9">
		  <input type="checkbox" name="checkPass" id="checkPass" value="1"/>是
          </td> 
          <td height="30" align="right" class="tbg01 pr10"><!-- 是否自动分配寝室 -->&nbsp;</td>
          <td bgcolor="#F1F4F9">
		  <!-- <input type="checkbox" name="isAuto" id="isAuto" value="1" checked="checked"/>是-->&nbsp;
          </td>        
          </tr>              
      </table>
      </td>
    </tr>
  </table>
</div>	

<!-- 交费记录 -->
<div class="mid1003_r">
	<!-- 提示信息 -->
	<div class="mid1003_r">
	   <span style="color: red;"><s:actionmessage theme="custom" cssClass="STYLE1" />${noticeMessage }</span>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    <tr>
		<td bgcolor="#FFFFFF" width="100%">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>交费记录</strong></td>
          </tr>
		  <tr>
	          <td width="20%" class="tbg03" height="25"><strong>费用类别<span style="color: red;">（*为必缴项目）</span></strong></td>
	          <td width="20%" class="tbg03"><strong>费用标准(元)</strong></td>
	          <td width="20%" class="tbg03"><strong>已交金额(元)</strong></td>
	          <td width="20%" class="tbg03"><strong>缓交金额(元)</strong></td>
	          <td width="20%" class="tbg03"><strong>欠费金额</strong></td>
		  </tr>
		  <s:iterator  value="payStudentList" status="status" >
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${type }<s:if test="need"><span style="color: red;">（*）</span></s:if></td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${money }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${payedMoney }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		    	<c:if test="${debtMoney>0}">
				 <span style="color: green;">${debtMoney}</span>
			   </c:if>
			   <c:if test="${debtMoney<=0}">
			     <span>${debtMoney}</span>
			   </c:if>
		      <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">&nbsp;
		       <c:if test="${(money-payedMoney-debtMoney)>0}">
				 <span style="color: red;" <c:if test="${need}">need="true"</c:if> name="qfMoney">${money-payedMoney-debtMoney}</span>
			   </c:if>
			   <c:if test="${(money-payedMoney-debtMoney)<=0}">
			      <span name="qfMoney" <c:if test="${need}">need="true"</c:if>>${money-payedMoney-debtMoney}</span>
			   </c:if>
		    </td>   
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
          <button type="button" id="submitDevo" class="bulebu" <c:if test="${student eq null || student.reged }">disabled="disabled"</c:if>>确认报到</button>
	 </td>
        </tr>
      </table></td>
    </tr>
	</table>
</div>
</form>

</body>
</html>