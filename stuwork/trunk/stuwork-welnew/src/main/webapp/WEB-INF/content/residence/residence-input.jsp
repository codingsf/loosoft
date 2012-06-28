<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增or修改户籍信息</title>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<div class="xzwz">
  <h1>
   <s:if test="id == null">新增</s:if><s:else>修改</s:else>     
     新生户籍信息（<span class="STYLE1">*</span>为必填）
  </h1>
  
</div>
<form id="dataform" name="dataform" action="${ctx}/residence/residence!save.action" method="post" onsubmit="return SubmitUser(this)" >
	<input type="hidden" name="id" value="${id}"/>
	<table class="tbhs1">
	  <tr>
	    <th width="10%">身份证号<span class="STYLE1">*</span></th>
	    <td width="40%"><input id="idCardNo" name="idCardNo"  value="${user.userid}" type="text" class="wid20" /></td>
	    <th width="10%">姓名</th>
	    <td width="40%" >
	    <input id="name" name="name"  value="" type="text" class="ipt wid20" />（由身份证自动带出）
	    </td>
	  </tr>
	  <tr>
	    <th width="10%">迁移证号<span class="STYLE1">*</span></th>
	    <td width="40%" >
			<input id="migrateNo" name="migrateNo"  value="${migrateNo}" type="text" class="wid20" />
		 </td>
	    <th width="10%">迁入时间</th>
	    <td width="40%" >
	   		<input name="migrateDate" id="migrateDate"
							value="<fmt:formatDate value="${migrateDate}" type="date" pattern="yyyy-MM-dd"/>"
							type="text" class="Wdate" class="ipt wid20 "
							onclick="WdatePicker()" />
	    </td>
	  </tr>
	  <tr>
	    <th>原户籍所在地</th>
	    <td colspan="3"><textarea name="origAddress" rows="4" class="wid92 ipt hei40" 
			onmouseover="this.className='wid92 ipth hei40'"
	onmouseout="this.className='wid92 ipt hei40'" id="textfield2">${origAddress}</textarea></td>
	  </tr>
	  <tr>
	    <th>现户籍所在地</th>
	    <td colspan="3">
			<s:select list="schareaList" listKey="code" listValue="name" theme="simple"></s:select>
		</td>
	  </tr>
    <tr>
      <td></td>
      <td colspan="3">
        <label></label>
        <input name="button"  type="button" class="btn" value="返 回" onclick="history.back();" />
        <input name="submitbut" type="submit" class="btn" value="确 定" />
        <input name="button"  type="reset" class="btn" value="重 置" />        </td>
    </tr>
	</table>
</form>
</body>
</html>