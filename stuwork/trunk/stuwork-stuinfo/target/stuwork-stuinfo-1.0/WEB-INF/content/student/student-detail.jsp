<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="cn.loosoft.stuwork.stuinfo.web.attachment.UploadPath"%><html>
<head>
<title>学生基础信息详情</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
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
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生基础信息详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td  height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">学号&nbsp;</td>
	          <td >${student.studentNo }</td>
		      <td  height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10"  rowspan="4">相片&nbsp;</td>
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="4">
	           <s:if test="student.img!=null && student.img!=''">
                      <img src="<common:prop name="stuinfo.webapp.url" propfilename="sysconfig.properties" defaultvalue="${pageContext.request.contextPath}"/><%=UploadPath.PICTUREPATH%><%=UploadPath.STUDENTPIC%>/${student.img}" width="110" height="90" border="1px;"/>
                   </s:if>
                   <s:else>
                   <div style="vertical-align: middle;width: 110px;height: 90px;border: 1px solid;text-align: center;line-height: 90px;">请提交电子照片</div>
                   </s:else> 
	          </td>	
        </tr>
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名&nbsp;</td>
	          <td >
		           ${student.name }
	          </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">性别&nbsp;</td>
	          <td >
		         ${student.sexDesc }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">考生号&nbsp;</td>
	          <td >
		      ${student.examineeNo }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业中学&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${student.graduateSchool}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">港澳台&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            ${student.autonomy?"是":"否" }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">姓名拼音&nbsp;</td>
	          <td  width="30%">
		         ${student.pinyin}
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">曾用名&nbsp;</td>
	          <td  width="35%">
		       ${student.former}
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${student.IDcard}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">出生年月&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      <fmt:formatDate value="${student.birthday}" type="date" pattern="yyyy-MM-dd"/>
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">院系&nbsp;</td>
	          <td  >
		         ${student.collegeName }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">专业&nbsp;</td>
	          <td  >
		        ${student.majorName }
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.className }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">宿舍&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.roombed}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">民族&nbsp;</td>
	          <td  >
		       ${student.nationDesc}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">籍贯&nbsp;</td>
	          <td  >
		     ${student.birthPlace}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">政治面貌&nbsp;</td>
	          <td bgcolor="#F1F4F9" >	
			     ${student.politicsFace }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学制&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
	          ${student.length }
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">培养方式&nbsp;</td>
	          <td  >
		    
			${student.cultureWay}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学历&nbsp;</td>
	          <td  >
			${student.educationDesc}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学位&nbsp;</td>
	          <td bgcolor="#F1F4F9" >   
			  ${student.culDegree}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       <fmt:formatDate value="${student.inDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">毕业时间&nbsp;</td>
	          <td >
		      <fmt:formatDate value="${student.finishDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">研究方向导师&nbsp;</td>
	          <td >
		       ${student.hierophant}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">班主任&nbsp;</td>
	          <td >
		      ${student.headTeacher}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">班主任电话&nbsp;</td>
	          <td >
		       ${student.headTeacherPhone}
	          </td>
        </tr>
                <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">辅导员&nbsp;</td>
	          <td >
		      ${student.counselor}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
	          <td >
		       ${student.counselorPhone}
	          </td>
        </tr>       
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">联系电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.phone}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">一卡通&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.cardNum}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">教育方向&nbsp;</td>
	          <td>
		   ${student.edudirection}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">生源地&nbsp;</td>
	          <td  >
		      ${student.testaddr}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">父亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.fatherName}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">母亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${student.motherName}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">家庭地址&nbsp;</td>
	          <td  >
		         ${student.address}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">家庭邮编&nbsp;</td>
	          <td >
	           ${student.familyCode}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">家庭电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.homePhone}
	          </td>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">血型&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.blood}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">健康状况&nbsp;</td>
	          <td>
		        ${student.healthInfo}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">婚姻状况&nbsp;</td>
	          <td>
		 
			${student.culMarriage }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">心理状况&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		    ${student.psyInfo}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">国别&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      ${student.country}
	          </td>
        </tr>
            
        <tr>
	          <td height="30"  align="right" " class="tbg02 pr10">银行名称&nbsp;</td>
	          <td  >
		       ${student.bankName}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">银行账户&nbsp;</td>
	          <td  >
		     ${student.bankAccount}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">个人主页&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${student.onlineWeb}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">邮箱&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${student.email}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">入学前户口&nbsp;</td>
	          <td  >
		     ${student.account}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">是否毕业&nbsp;</td>
	          <td  >
		        ${student.graduated?"是":"否" }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">是否在校&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		       ${student.inSchool?"是":"否" }
	          </td>
	           <td height="30"  align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">是否注册&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${student.reged?"是":"否" }
	          </td>
        </tr>
        <tr id="sayHello">
	          <td height="30"  align="right" class="tbg02 pr10">所在年级&nbsp;</td>
	          <td  colspan="3">
		      ${student.culGrade}
	          </td>
        </tr>
        <tr id="sayHello">
	          <td height="70"  align="right" class="tbg01 pr10">非在校原因&nbsp;</td>
	          <td  colspan="3" class="tbg01 pr10">
		      ${student.notSchoolReason}
	          </td>
        </tr>
        
        <tr>
	          <td height="70" bgcolor="#F1F4F9"  align="right"  class="tbg02 pr10">特长&nbsp;</td>
	          <td  colspan="3" bgcolor="#F1F4F9"  class="tbg02 pr10">
		      ${student.specialty}
	          </td>
        </tr>
         <tr>
	          <td height="70"  align="right"  class="tbg01 pr10">备注&nbsp;</td>
	          <td  colspan="3"  class="tbg01 pr10">
		  ${student.remarks}
	          </td>
        </tr>
        
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center"><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	

</body>
</html>