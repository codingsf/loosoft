<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>新生列表</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
<script type="text/javascript">
<!--
   $(document).ready(function(){
         $("#queryButton").click(function(){
                var helloDivObj = $("#filter");   
                var buttonObj = $("#queryButton");   
                var val = buttonObj.text();
               if(val=="隐藏查询"){
                    helloDivObj.hide(); 
                    buttonObj.text("显示查询");  
                }else{   
                    helloDivObj.show();  
                    buttonObj.text("隐藏查询"); 
                }   
          });
          
		$("#delbut").click(
		   function(){
		       if($("input:checked").length==0) {
		            alert("没有可删除记录,请勾选");
		            return false;
		       } 
		       if(!confirm('您确定要删除吗?')) return  false;

			   $("#deleteForm").submit();
		 });
		 
	   $("#checkboxall").click(function(){
		     $("input[name='ids']").attr("checked",$(this).attr("checked"));
		});
    }); 
-->
</script>
</head>
<body>
<div class="caozuo">
  <ul>
  <li><a href="student!input.action"><span>新增</span></a></li>
    <li><a href="#" id="delbut"><span>删除</span></a></li>
    <li><a><span id="queryButton">显示查询</span></a></li>
  </ul>
</div>

<form id="searchForm" action="${ctx}/student/student!list.action" method="post">
<div id="filter" class="fenye" style="display: none">
	<input type="hidden" name="filter_EQS_type" value="${params['filter_EQS_type'] }"/>
	<h3>
	    批次:<s:select id="batchselect" theme="simple" list="batches" listKey="id" listValue="comname" name="filter_EQL_welbatch$id"
			 headerKey="" headerValue="全部" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_welbatch$id)"/>
	    院系:<s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="filter_EQS_collegeCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_collegeCode"/>
	    专业:<s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="filter_EQS_majorCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_majorCode"/>
	    班级:<s:select id="clazzselect" theme="simple" list="clazzes" listKey="code" listValue="name" name="filter_EQS_classCode"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_classCode"/>
	    性别:<s:select theme="simple" list="#{'m':'男','f':'女'}" name="filter_EQS_sex"
			 headerKey="" headerValue="请选择" value="#parameters.filter_EQS_sex"/>
	      <span class="btn2"><a href="javascript:void(0);" id="mainformsearch"  title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);" id="mainformreset" href="javascript:search();" title="重置查询条件"><span>重置查询条件</span></a></span>
	      <input type="reset" style="display:none;" id="resetbutton"/>
	</h3>
 <div class="clear"></div>
</div>
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />
</form>
<div id="message"><s:actionmessage theme="custom" cssClass="success"/></div>
<form action="${ctx}/student/student!deletes.action" method="post" id="deleteForm">
<table class="tbhs" width="95%">
  <tr>
    <th class="wid10px">
      <label>
        <input type="checkbox" id="checkboxall"/>
        </label>
    </th>
    <th >入学批次</th>
    <th >院系</th>
    <th >专业</th>
    <th >班级</th>
    <th >考生号</th>
    <th >身份证号</th>
    <th >姓名</th>
    <th >性别</th>
    <th >学制</th>
    <th >学生类别</th>
    <th >入学状态</th>
    <th >操作</th>
  </tr>
  <s:iterator value="page.result" status="stat">
  <tr>
    <td><input type="checkbox" id="ids" name="ids" value="${id }" /></td>
    <td>${welbatch.comname }&nbsp;</td>
    <td>${collegeName }${departName }</td>
    <td>${majorName }&nbsp;</td>
    <td>${className }&nbsp;</td>
    <td>${examineeNo }&nbsp;</td>
    <td>${IDcard }&nbsp;</td>
    <td>${name }&nbsp;</td>
    <td>${sexdesc }&nbsp;</td>
    <td>${length }&nbsp;</td>
    <td>${catdesc}&nbsp;</td>
    <td>${reged?"是":"否"}&nbsp;</td>
    <td>
    <a href="#" onclick="delOneRecord('${id }','${ctx}/student/student!delete.action');">删除</a>
    <a href="${ctx}/student/student!input.action?id=${id}">修改</a>
    </td>
  </tr>
</s:iterator>
</table>
</form>
<%@ include file="/common/turnpage.jsp" %>
</body>
</html>