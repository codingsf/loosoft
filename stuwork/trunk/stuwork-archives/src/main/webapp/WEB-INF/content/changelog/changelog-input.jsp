<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>变更记录详情</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#stuNo").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			stuNo: "required",
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				}
			}
		});
	});
	
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
			
<!--startprint-->		
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
		            ${studentDTO.name}
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
	          <td height="30" width="20%" align="right" class="tbg02 pr10">档案状态&nbsp;</td>
	          <td  width="30%" >
		        ${archivesVO.status }
	          </td>
	           <td height="30" width="15%" align="right"   class="tbg02 pr10">档案库位&nbsp;</td>
	          <td  width="35%">
		        ${archivesVO.storeInfo }
	          </td>
        </tr>
        
      </table></td>
    </tr>
  </table>
</div>
<br/>
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">变更详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">变更时间&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        <fmt:formatDate value="${changeDate}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
		      </td>
		       <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">变更经办人&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		         ${operater }
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">变更内容&nbsp;</td>
	          <td  width="30%">
		         ${content }
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">变更说明&nbsp;</td>
	          <td  width="35%">
		          ${remark }
	          </td>
        </tr>
       
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">扫描文件名&nbsp;</td>
	          <td colspan="3" bgcolor="#F1F4F9">
		        ${outLog.fileName }
	          </td>
        </tr>
        
        
      </table></td>
    </tr>
  </table>
</div>	
<!--endprint-->

<br />
<div style="text-align: center" class="mid1003_r">
  <input name="button" type="button" class=bulebu value="打印" onclick="execPrint()" />&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="button" type="button" class="bulebu" value="返回"   onclick="history.back();" />
</div>		
			
			
</body>
</html>