<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>单位详情</title>
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
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">单位详情</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">单位名称&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.companyName}
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">联系电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         ${entity.phone}
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">地址&nbsp;</td>
	          <td>
		         ${entity.address}
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">单位简介&nbsp;</td>
	          <td  >
		        ${entity.introduction}
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">备注&nbsp;</td>
	          <td bgcolor="#F1F4F9"  colspan="3">
		       ${entity.remark}
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