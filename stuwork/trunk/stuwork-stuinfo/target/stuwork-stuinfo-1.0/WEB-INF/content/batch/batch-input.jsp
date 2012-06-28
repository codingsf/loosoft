<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改批次</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#year").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				year: "required",
				season:"required",
				startdate:"required",
				enddate:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				}
			}
		});
	});
	
</script>
</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>

<form id="dataForm" name="dataForm" action="${ctx}/batch/batch!sav.action" method="post">
<input type="hidden" name="id" value="${id}"/>
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      批次(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">批次<span class="redz">* </span></td>

          <td width="65%" ><input type="text"  name="year" class="wid17" id="year"  value="${year}" <s:if test="id != null">readonly="readonly"</s:if> /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">季节<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
	           <s:if test="id !=null">
		          <input type="text"  name="season" class="wid17" id="season"  value="${season}" readonly="readonly" />
		       </s:if>
		       <s:else>
		        <s:select theme="simple" list="#{'秋季':'秋季','春季':'春季'}" name="season"  />
		       </s:else>	   
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">开始日期<span class="redz">* </span></td>
          <td>
          <input name="startdate" id="startdate"
							value="<fmt:formatDate value="${startdate}" type="date" pattern="yyyy-MM-dd"/>"
							type="text" class="Wdate" class="ipt wid20 "
							onclick="WdatePicker()" />
          </td>
          </tr>
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">结束日期<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
           <input name="enddate" id="enddate"
							value="<fmt:formatDate value="${enddate}" type="date" pattern="yyyy-MM-dd"/>"
							type="text" class="Wdate" class="ipt wid20 "
							onclick="WdatePicker()" />

          </td>
          </tr>
          <tr>

          <td height="30" align="right"  class="tbg02 pr10">是否当前批次&nbsp;</td>
          <td >
             <s:checkbox id="current" name="current" theme="simple" value="current"></s:checkbox>
          </td>
          </tr>   
      </table></td>
    </tr>
    <tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg');"><table width="30%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td> <input name="submitbut" type="submit" class="bulebu" value="确 定" /></td>

          <td><input name="button"  type="button" class="bulebu"  value="返 回" onclick="history.back();" /></td>
          <td><input name="button"  type="reset" class="bulebu" value="重 置" /> </td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>	
</form>

</body>
</html>