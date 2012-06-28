<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位详情</title>
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
<form id="dataForm" name="dataForm"  method="post">
<div class="mid1003_r">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">
    
    <tr>
      <td height="25"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">
      		岗位详情
      </td>
    </tr>
    
    
    <tr>
      <td bgcolor="#FFFFFF">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">岗位名称 </td>
	          <td width="40%" >
	          	${jobsDTO.postName}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">性别限制 </td>
	          <td width="40%" >
	          	${jobsDTO.sexLimit}
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">地点</td>
	          <td bgcolor="#F1F4F9">
	          	${jobsDTO.address}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">勤工内容</td>
	          <td bgcolor="#F1F4F9">
	          	${jobsDTO.content}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right"  class="tbg02 pr10">勤工要求 </td>
	          <td>
	          	${jobsDTO.requireMents}
	          </td>
	          <td height="30" align="right"  class="tbg02 pr10">所属单位 </td>
	          <td>
	          	${jobsDTO.companyName}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">发布时间 </td>
	          <td bgcolor="#F1F4F9">
	          	<fmt:formatDate value="${jobsDTO.pubdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">报名截止时间 </td>
	          <td bgcolor="#F1F4F9">
	          	<fmt:formatDate value="${jobsDTO.stopdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	        </tr>
	        	
	        
	        
	        <tr>
	          <td height="30" align="right" class="tbg02 pr10">招聘人数 </td>
	          <td>
	          	 ${jobsDTO.reqCount}
	          </td>
	          <td height="30" align="right" class="tbg02 pr10">已招聘人数 </td>
	          <td>
	          	 ${jobsDTO.exisitCount}
	          </td>
	        </tr>
  
	      </table>
      </td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');">
	      <table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td align="center">
	          <input name="button" type="button" class="bulebu" value="返回" onclick="history.back();"/>
	          </td>
	        </tr>
	      </table>
      </td>
    </tr>
  </table>

</div>
</form>
</body>
</html>