<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>学生信息详情</title>
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
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">学生信息详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.name}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">性别&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.sexdesc }
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">学号&nbsp;</td>
	          <td  >
		         ${entity.studentNo }
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">考生号&nbsp;</td>
	          <td  >
		        ${entity.examineeNo }
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">批次&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.welbatch.comname}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">通知书编号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.noticeId}
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">身份证号&nbsp;</td>
	          <td  >
		      ${entity.IDcard}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">民族&nbsp;</td>
	          <td  >
		        ${entity.nation}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">联系地址&nbsp;</td>
	          <td bgcolor="#F1F4F9" >	
			     ${entity.address}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">生源省份&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
	            ${entity.province}
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">生源地&nbsp;</td>
	          <td  >
	            ${entity.testaddr}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">高考分数&nbsp;</td>
	          <td  >
			   ${entity.mark}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取学院代码&nbsp;</td>
	          <td bgcolor="#F1F4F9" >   
			   ${entity.collegeCode}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取学院名称&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${entity.collegeName}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">录取专业代码&nbsp;</td>
	          <td >
		      ${entity.majorCode}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">录取专业名称&nbsp;</td>
	          <td >
		      ${entity.majorName}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取班级代码&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.classCode}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">录取班级名称&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.className}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">培养层次&nbsp;</td>
	          <td>
		       ${entity.gradation}
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">学生类别&nbsp;</td>
	          <td  >
		       ${entity.catdesc}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学制&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        ${entity.length}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">报到序号&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		      ${entity.orderNum}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">报到日期&nbsp;</td>
	          <td  >
		       ${entity.registerdate}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">是否入学&nbsp;</td>
	          <td >
	          ${entity.reged?"是":"否"}
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否公寓用品发放&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       ${entity.gived?"是":"否"}
	          </td>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">公寓用品发放时间&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <fmt:formatDate type="date" value="${entity.givetime}" pattern="yyyy-MM-dd"/>
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">寝室信息&nbsp;</td>
	          <td colspan="3">
		     ${entity.roombed}
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