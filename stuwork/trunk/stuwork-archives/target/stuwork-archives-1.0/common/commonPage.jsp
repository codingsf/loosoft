<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">

function go(){
	var pageNo = $("#goNo").val();
	var current = /^[0-9]*$/;
	var v = current.test(pageNo);
	if(v){
		jumpPage(pageNo);
	}else{
		alert("请输入整数！");
	}
}

</script>
<table width="60%" border="0" align="right" cellpadding="0"
			cellspacing="0" style="color: #183553;">
			<tr>
				<td width="201">总记录数：${commonPage.totalCount}条 显示页：${commonPage.pageNo }/${commonPage.totalPages} 页</td>
				<td width="25"><a href="javascript:jumpPage(1)" title="首页"><img
					src="../images/login/ico_02.jpg" width="12" height="14" border="0" /></a></td>
				<td width="25"><c:if test="${commonPage.hasPre}"><a href="javascript:jumpPage(${commonPage.prePage})"  title="上一页"><img
					src="../images/login/ico_03.jpg" width="8" height="14" border="0" /></a></c:if><c:if test="${!commonPage.hasPre}"><img
					src="../images/login/ico_003.jpg" width="8" height="14" border="0" /></c:if></td>
				<td width="25"><c:if test="${commonPage.hasNext}"><a href="javascript:jumpPage(${commonPage.nextPage}) "  title="下一页"><img
					src="../images/login/ico_04.jpg" width="8" height="14" border="0"  /></a></c:if><c:if test="${!commonPage.hasNext}"><img
					src="../images/login/ico_004.jpg" width="8" height="14" border="0"  /></c:if></td>
				<td width="25"><a href="javascript:jumpPage(${commonPage.totalPages})"  title="末页"><img
					src="../images/login/ico_05.jpg" width="12" height="12" border="0" /></a></td>
					  
				<td width="51">转到页：</td>
				<td width="48"><input name="goNo" id="goNo" type="text" size="4" /></td>
				<td width="63" align="center"><a href="javascript:go(0)"><img
					src="../images/login/go.jpg" width="32" height="20" border="0" id="query" name="query" /></a></td>
					
			</tr>
</table>
