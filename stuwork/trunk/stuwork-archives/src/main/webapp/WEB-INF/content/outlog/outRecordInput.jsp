<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>调出绘制档案</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="searchForm" action="${ctx}/outlog/outlog!updateRecord.action" method="post" >
<input name="id" value="${id }" type="hidden" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">调出回执录入</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">档案信息&nbsp;</td>

          <td width="65%" >${outArchives.archivesInfo }</td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">回执单&nbsp;</td>
          <td bgcolor="#F1F4F9">
	         <FCK:editor instanceName="outRecord" width="700px" value="${outArchives.outRecord}" height="400px">
		     </FCK:editor>
          </td>
          </tr>  
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" type="submit" class="bulebu"  value="保存" /></td>

          <td><input name="button" type="button" class="bulebu" value="取消" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" onclick="window.location.reload()" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>

<br/>
<div  class="mid1003_r">
  <span style="color:red;">${actionMessage }</span>
</div>

</form>
</body>
</html>