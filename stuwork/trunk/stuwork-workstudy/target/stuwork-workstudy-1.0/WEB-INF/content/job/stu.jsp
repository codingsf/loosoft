<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>岗位对应学生列表</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script type="text/javascript">
          
	function choseOneRecord(stuJobsId,postId,url){
	  if(confirm('您确定要选择此学生吗?')){
	   $.ajax({
	            type: "post",
	            dataType: "html",
	            url: url,
	            data: "stuJobsId=" + stuJobsId+"&postId=" + postId,
	            success: function (msg) {
	            if (msg!=""){
	                    alert("选择成功！");
	                    location.reload();
	                    }
	            },
	            error: function() {
	                 alert("操作失败,请联系管理员");
	            }
	        });
	    }
	}
	
	function passOneRecord(stuJobsId,postId,url){
	  if(confirm('您确定要淘汰此学生吗?')){
	   $.ajax({
	            type: "post",
	            dataType: "html",
	            url: url,
	            data: "stuJobsId=" + stuJobsId+"&postId=" + postId,
	            success: function (msg) {
	            if (msg!=""){
	                    alert("淘汰成功！");
	                    location.reload();
	                    }
	            },
	            error: function() {
	                 alert("操作失败,请联系管理员");
	            }
	        });
	    }
	}
	
	</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="mid1003_r">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" 
	style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">    
    <tr>
		<td bgcolor="#FFFFFF">
	    <form id="searchForm" name="searchForm" action="${ctx}/job/stu.action?postId=${postId}" method="post">
          <input type="hidden" name="commonPage.tempPageNo" id="pageNo" value="${pageNo}"/>
		</form>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		
	      <tr>
              <td height="30" colspan="8" bgcolor="#F7E582" class="br002"><strong>应聘岗位学生列表</strong></td>
          </tr>
		  <tr>
	          <td width="10%" height="25" class="tbg03"><strong>岗位名称</strong></td>
	          <td width="15%" class="tbg03"><strong>学号</strong></td>
	          <td width="15%" class="tbg03"><strong>学生姓名</strong></td>          
	          <td width="15%" class="tbg03"><strong>已招聘人数</strong></td>
	          <td width="15%" class="tbg03"><strong>招聘人数</strong></td>
	          <td width="15%" class="tbg03"><strong>选择状态</strong></td>
	          <td width="18%" class="tbg03"><strong>操作</strong></td>
	          
		  </tr>
		  <s:iterator value="studentVOs" status="status" var="studentVO">
		  <tr>
		      <s:set value="studentVO.chose"  var="chose"/>
			  <s:set value="studentVO.exisitcount"  var="exisitcount"/>
			  <s:set value="studentVO.reqcount"  var="reqcount"/>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>" height="25">${studentVO.postname }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentVO.stuId}&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentVO.name }&nbsp;</td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentVO.exisitcount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${studentVO.reqcount }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">&nbsp;
		       <s:if test="chose == 'apply'">
					已选上
				</s:if>
				<s:elseif test="chose == 'pass'">
					未选上
				</s:elseif>
				<s:else>
					选择中
				</s:else>
		    </td> 
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
			   <s:if test="reqcount != exisitcount">
					<s:if test="chose == 'chosing'">
						<a href="#" onclick="choseOneRecord('${studentVO.stuJobsId}','${studentVO.postId }','${ctx}/job/stu!chose.action');">确定用工</a>
						<a href="#" onclick="passOneRecord('${studentVO.stuJobsId}','${studentVO.postId }','${ctx}/job/stu!unchose.action');">淘汰</a>
					</s:if>
				</s:if>
				<a href="${ctx}/job/stu!findStu.action?studentNo=${studentVO.stuId}">查看学生信息</a>
		    </td>
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>
	
	<tr>
      <td height="32" style="background: url('../images/login/tabbg02.jpg')">
      	<%@ include file="/common/commonPage.jsp"%>
      </td>
    </tr>
	</table>
	<br/>
	<input name="button"
			type="button" class="bulebu" value="返 回" onclick="history.back();" />
</div>


</body>
</html>
