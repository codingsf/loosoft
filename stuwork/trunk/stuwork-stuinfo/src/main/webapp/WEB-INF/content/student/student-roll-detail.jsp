<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生学籍信息详情</title>
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
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生学籍信息详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${student.name}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		     ${student.studentNo}
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">身份证号&nbsp;</td>
	          <td  >
		         ${student.IDcard }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学位&nbsp;</td>
	          <td  >
		        ${student.culDegree}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">院系&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.collegeName }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${student.collegeName}
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">班级&nbsp;</td>
	          <td  >
		       ${student.className }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学制&nbsp;</td>
	          <td  >
		     ${student.length}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否在校&nbsp;</td>
	          <td bgcolor="#F1F4F9" >	
			     ${student.inSchool?"是":"否" }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否注册&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
	            ${student.reged?"是":"否"}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">教育方向&nbsp;</td>
	          <td  >
		    
			${student.edudirection}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">培养方式&nbsp;</td>
	          <td  >
			${student.cultureWay}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任&nbsp;</td>
	          <td bgcolor="#F1F4F9" >   
			${student.headTeacher }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${student.headTeacherPhone}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">辅导员&nbsp;</td>
	          <td >
		     ${student.counselor }
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
	          <td >
		      ${student.counselorPhone}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      <fmt:formatDate value="${student.inDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <fmt:formatDate value="${student.finishDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">学历&nbsp;</td>
	          <td>
		   ${student.educationDesc}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">批次&nbsp;</td>
	          <td  >
		      ${student.comname}
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