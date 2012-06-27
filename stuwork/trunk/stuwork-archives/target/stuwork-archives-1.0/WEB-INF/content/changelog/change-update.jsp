<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>档案变更</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#areaselect").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
			columnselect: "required",
			operater: "required"
			}
		,
        errorPlacement: function(error, element) {
            if (element.attr("name") == "columnselect") {
                $("#columnselect_error").text('');
                error.appendTo("#columnselect_error");
            }
            if (element.attr("name") == "operater") {
                $("#operater_error").text('');
                error.appendTo("#operater_error");
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
<form action="${ctx}/changelog/change!updateArchive.action" method="post" id="dataForm">
<input name="stuId" value="${stuId }" type="hidden" />
<input type="hidden" name="areaText" id="areaText" value="" />
<input type="hidden" name="rankText" id="rankText" />
<input type="hidden" name="rowText" id="rowText"  />
<input type="hidden" name="columnText" id="columnText" />

<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">档案变更(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">档案库位<span class="redz">* </span></td>

          <td width="65%" >
              <select  id="areaselect">
                   <option value="">请选择</option>
                 <c:forEach items="${areaList}" var="al">
                   <option value="${al.id }">${al.area }</option>
                 </c:forEach>
              </select>区域&nbsp;&nbsp;
              <select id="rankselect">
                   <option value=''>请选择</option>
              </select>排&nbsp;&nbsp;
              <select id="rowselect">
                   <option value=''>请选择</option>
              </select>行&nbsp;&nbsp;
              <select id="columnselect" name="columnselect">
                   <option value=''>请选择</option>
              </select>列<span id="columnselect_error"></span>
         </td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">档案材料&nbsp;</td>
          <td bgcolor="#F1F4F9">
	         ${dictionaryName },其他<input type="text" name="content" id="content">
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">变更说明&nbsp;</td>
          <td>
            <textarea cols="50" rows="3" id="remark" name="remark"></textarea>
          </td>
        </tr>
        <tr>

         <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">变更经办人<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
            <input type="text" name="operater" id="operater" /><span id="operater_error"></span>
         </td>
       </tr>
         
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="submitbut" type="submit" class="bulebu" value="保存" /></td>
          <td><input name="button" type="button" class="bulebu" value="取消" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	



</form>
</body>
</html>