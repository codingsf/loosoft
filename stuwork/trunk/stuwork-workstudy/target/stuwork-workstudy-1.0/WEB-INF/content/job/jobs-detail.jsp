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
	          <td width="10%" height="30" align="right" class="tbg02 pr10">岗位名称</td>
	          <td width="40%" >
	          	${jobs.postName}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">性别限制</td>
	          <td width="40%" >
	          	${jobs.sexLimit}
	          </td>
	        </tr>
	        
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">地点</td>
	          <td bgcolor="#F1F4F9">
	          	 ${jobs.address}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">勤工内容</td>
	          <td bgcolor="#F1F4F9">
	          	 ${jobs.content}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">勤工要求</td>
	          <td width="40%" >
	          	${jobs.requireMents}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">所属单位</td>
	          <td width="40%" >
	          	${jobs.company.companyName}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">发布时间</td>
	          <td bgcolor="#F1F4F9">
	          	 <fmt:formatDate value="${jobs.pubdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">报名截止时间</td>
	          <td bgcolor="#F1F4F9">
	          	 <fmt:formatDate value="${jobs.stopdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">招聘人数</td>
	          <td width="40%" >
	          	${jobs.reqCount}
	          </td>
	          <td width="10%" height="30" align="right" class="tbg02 pr10">已招聘人数</td>
	          <td width="40%" >
	          	${jobs.exisitCount}
	          </td>
	        </tr>
	        
	        
	        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">招聘状态</td>
	          <td bgcolor="#F1F4F9">
	          	 ${jobs.postStatusDesc}
	          </td>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">审核状态</td>
	          <td bgcolor="#F1F4F9">
	          	 ${jobs.auditDesc}
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