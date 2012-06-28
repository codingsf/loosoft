<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>基础信息详情</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>

<script type="text/javascript">
	function changeImg(obj){
		document.getElementById("img").src=obj;
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
<form id="dataForm" name="dataForm" method="post"  action="${ctx }/student/infoedit!list.action">
	
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">我的资料</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td  height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">学号&nbsp;</td>
	          <td >${studentDTO.studentNo }</td>
		      <td  height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10"  rowspan="4">相片&nbsp;</td>
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="4">
			<s:if test="studentDTO.img==null||studentDTO.img=''">
			未上传照片
			</s:if>
			<s:else>
			<img src="${studentDTO.img}"  name="img" height="90" width="110" id="img" alt=""  /> <br /> 
        	</s:else>
        	</td>	
        </tr>
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名&nbsp;</td>
	          <td >
		           ${studentDTO.name }
	          </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">性别&nbsp;</td>
	          <td >
		         ${studentDTO.sexDesc }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">考生号&nbsp;</td>
	          <td >
		      ${studentDTO.examineeNo }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业中学&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        ${studentDTO.graduateSchool}
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">港澳台&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		            ${studentDTO.autonomy?"是":"否" }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">姓名拼音&nbsp;</td>
	          <td  width="30%">
		         ${studentDTO.pinyin}
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">曾用名&nbsp;</td>
	          <td  width="35%">
		       ${studentDTO.former}
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${studentDTO.IDcard}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">出生年月&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      <fmt:formatDate value="${studentDTO.birthday}" type="date" pattern="yyyy-MM-dd"/>
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">院系&nbsp;</td>
	          <td  >
		         ${studentDTO.collegeName }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">专业&nbsp;</td>
	          <td  >
		        ${studentDTO.majorName }
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.className }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">宿舍&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.roombed}
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">民族&nbsp;</td>
	          <td  >
		       ${studentDTO.nation }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">籍贯&nbsp;</td>
	          <td  >
		     ${studentDTO.birthPlace}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">政治面貌&nbsp;</td>
	          <td bgcolor="#F1F4F9" >	
			     ${studentDTO.politicsFace }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学制&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
	          ${studentDTO.length }
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">培养方式&nbsp;</td>
	          <td  >
		    
			${studentDTO. cultureWay}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学历&nbsp;</td>
	          <td  >
			${studentDTO.education}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学位&nbsp;</td>
	          <td bgcolor="#F1F4F9" >   
			${studentDTO.degree}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       <fmt:formatDate value="${studentDTO.inDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">毕业时间&nbsp;</td>
	          <td >
		      <fmt:formatDate value="${studentDTO.finishDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">研究方向导师&nbsp;</td>
	          <td >
		       ${studentDTO.hierophant}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">班主任&nbsp;</td>
	          <td >
		      ${studentDTO.headTeacher}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">班主任电话&nbsp;</td>
	          <td >
		       ${studentDTO.headTeacherPhone}
	          </td>
        </tr>
                <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">辅导员&nbsp;</td>
	          <td >
		      ${studentDTO.counselor}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
	          <td >
		       ${studentDTO.counselorPhone}
	          </td>
        </tr>       
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">联系电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.phone}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">一卡通&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.cardNum}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">教育方向&nbsp;</td>
	          <td>
		   ${studentDTO.edudirection}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">生源地&nbsp;</td>
	          <td  >
		      ${studentDTO.testaddr}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">父亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.fatherName}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">母亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${studentDTO.motherName}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">家庭地址&nbsp;</td>
	          <td  >
		         ${studentDTO.address}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">家庭邮编&nbsp;</td>
	          <td >
	           ${studentDTO.familyCode}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">家庭电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.homePhone}
	          </td>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">血型&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.blood}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">健康状况&nbsp;</td>
	          <td>
		        ${studentDTO.healthInfo}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">婚姻状况&nbsp;</td>
	          <td>
		 
			${studentDTO.marryInfo }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">心理状况&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		    ${studentDTO.psyInfo}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">国别&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      ${studentDTO.country}
	          </td>
        </tr>
            
        <tr>
	          <td height="30"  align="right" " class="tbg02 pr10">银行名称&nbsp;</td>
	          <td  >
		       ${studentDTO.bankName}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">银行账户&nbsp;</td>
	          <td  >
		     ${studentDTO.bankAccount}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">个人主页&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${studentDTO.onlineWeb}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">邮箱&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${studentDTO.email}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">入学前户口&nbsp;</td>
	          <td  >
		     ${studentDTO.account}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">是否毕业&nbsp;</td>
	          <td  >
		        ${studentDTO.graduated?"是":"否" }
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">是否在校&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		       ${studentDTO.inSchool?"是":"否" }
	          </td>
	           <td height="30"  align="right"  bgcolor="#F1F4F9" class="tbg01 pr10">是否注册&nbsp;</td>
	          <td  bgcolor="#F1F4F9">
		        ${studentDTO.reged?"是":"否" }
	          </td>
        </tr>
        <tr id="sayHello">
	          <td height="30"  align="right" class="tbg02 pr10">所在年级&nbsp;</td>
	          <td  colspan="3">
		      ${studentDTO.culGrade}
	          </td>
        </tr>
        <tr id="sayHello">
	          <td height="70"  align="right" class="tbg01 pr10">非在校原因&nbsp;</td>
	          <td  colspan="3" class="tbg01 pr10">
		      ${studentDTO.notSchoolReason}
	          </td>
        </tr>
        
        <tr>
	          <td height="70" bgcolor="#F1F4F9"  align="right"  class="tbg02 pr10">特长&nbsp;</td>
	          <td  colspan="3" bgcolor="#F1F4F9"  class="tbg02 pr10">
		      ${studentDTO.specialty}
	          </td>
        </tr>
         <tr>
	          <td height="70"  align="right"  class="tbg01 pr10">备注&nbsp;</td>
	          <td  colspan="3"  class="tbg01 pr10">
		  ${studentDTO.remarks}
	          </td>
        </tr>
        
      </table></td>
    </tr>
    <tr>
      <td align="center" height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="edit" type="submit" class="bulebu" value="修改" /></td>
          <td><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	

</form>
</body>
</html>