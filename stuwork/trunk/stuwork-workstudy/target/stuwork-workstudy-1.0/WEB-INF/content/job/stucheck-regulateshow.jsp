<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>调剂岗位</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript" src="${ctx }/js/headerQuery.js"></script>
<script type="text/javascript">
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>岗位列表</strong></td>
          </tr>
		  <tr>
	          <td width="10%" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
		  </tr>
		  <s:iterator id="obj" value="jobList" status="status">
		  <tr>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${postName }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			   <a href="${ctx}/job/stucheck!regulate.action?jobId=${id}&jobName=${postName}&entityId=${entity.id}">调剂至该岗位</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
</div>
</body>
</html>