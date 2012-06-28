<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Insert title here</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
       学生信息详情
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">姓名</td>
	          <td width="40%" >
	          	${stuInfo.name}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">性别</td>
	          <td width="40%" >
	          	${stuInfo.sexdesc}
	          </td>
	        </tr>
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学号</td>
	          <td bgcolor="#F1F4F9">
	          	 ${stuInfo.stuId}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">考生号</td>
	          <td bgcolor="#F1F4F9">
	          	 ${stuInfo.examineeNo}
	          </td>
	        </tr>
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">身份证号</td>
	          <td width="40%" >
	          	${stuInfo.IDcard}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">民族</td>
	          <td width="40%" >
	          	${stuInfo.nation }
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">出生年月</td>
	          <td bgcolor="#F1F4F9">
	          	 <fmt:formatDate value="${stuInfo.birthday}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">电话</td>
	          <td bgcolor="#F1F4F9">
	          	 ${stuInfo.phone}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">联系地址</td>
	          <td width="40%" >
	          	${stuInfo.address}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">学院名称</td>
	          <td width="40%" >
	          	${stuInfo.collegeName }
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级</td>
	          <td bgcolor="#F1F4F9">
	          	 ${stuInfo.className}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">专业名称</td>
	          <td bgcolor="#F1F4F9">
	          	 ${stuInfo.majorName}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">银行名称</td>
	          <td width="40%" >
	          	${stuInfo.bankName}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">银行帐号</td>
	          <td width="40%" >
	          	${stuInfo.bankAccount }
	          </td>
	        </tr>

	        
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr align="center" >
	          <td><input name="button" type="submit" class="bulebu" value="返回" onclick="history.back();"/></td>
	          
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</body>
</html>