<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位详情</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
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
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">岗位详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">岗位名称&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.postName}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">性别限制&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.sexLimit}
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">地点&nbsp;</td>
	          <td>
		         ${entity.address}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">勤工内容&nbsp;</td>
	          <td  >
		        ${entity.content}
	          </td>
        </tr>
          
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">勤工要求&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.requireMents}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">所属单位&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.company.companyName}
	          </td>         
        </tr>
        
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">发布时间&nbsp;</td>
	          <td>
		         <fmt:formatDate value="${entity.pubdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">报名截至时间&nbsp;</td>
	          <td  >
		       <fmt:formatDate value="${entity.stopdate}" type="date" pattern="yyyy-MM-dd"></fmt:formatDate>
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">招聘人数&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.reqCount}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">已招聘人数&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.exisitCount}
	          </td>         
        </tr>
        
          <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">招聘状态&nbsp;</td>
	          <td>
		        ${entity.postStatusDesc}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">审核状态&nbsp;</td>
	          <td  >
		        ${entity.auditStatusDesc}
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