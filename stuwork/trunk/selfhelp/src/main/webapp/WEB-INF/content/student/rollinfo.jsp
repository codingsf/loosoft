<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学籍信息详情</title>
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
<form id="dataForm" name="dataForm" method="post" action="${ctx }/student/rolledit!list.action">
	
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">基础信息详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${studentDTO.name}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		     ${studentDTO.studentNo}
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">身份证号&nbsp;</td>
	          <td  >
		         ${studentDTO.IDcard }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学位&nbsp;</td>
	          <td  >
		        ${studentDTO.degree }
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">院系&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.collegeName }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${studentDTO.collegeName}
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">班级&nbsp;</td>
	          <td  >
		       ${studentDTO.className }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学制&nbsp;</td>
	          <td  >
		     ${studentDTO.length}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否在校&nbsp;</td>
	          <td bgcolor="#F1F4F9" >	
			     ${studentDTO.inSchool?"是":"否" }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否注册&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
	            ${studentDTO.reged?"是":"否"}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">教育方向&nbsp;</td>
	          <td  >
		    
			${studentDTO.edudirection}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">培养方式&nbsp;</td>
	          <td  >
			${studentDTO.cultureWay}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任&nbsp;</td>
	          <td bgcolor="#F1F4F9" >   
			${studentDTO.headTeacher }
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班主任电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${studentDTO.headTeacherPhone}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">辅导员&nbsp;</td>
	          <td >
		     ${studentDTO.counselor }
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
	          <td >
		      ${studentDTO.counselorPhone}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      <fmt:formatDate value="${studentDTO.inDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <fmt:formatDate value="${studentDTO.finishDate}" type="date" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">学历&nbsp;</td>
	          <td>
		   ${studentDTO.educationDesc}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">批次&nbsp;</td>
	          <td  >
		      ${studentDTO.comname}
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