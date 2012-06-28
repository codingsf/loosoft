<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>手工调整班级</title>
	<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
	<script type="text/javascript" src="${ctx }/js/headerQuery.js" ></script>
<script type="text/javascript">
<!--    
   function delUser(id){
       if(confirm('您确定要删除吗?')){
	       $.ajax({
	                type: "post",
	                dataType: "html",
	                url: "${ctx}/common/user/user!delete.action",
	                data: "id=" + id,
	                success: function (msg) {
	                if (msg!=""){
	                        alert(msg);
	                        location.reload();
	                        }
	                },
	                error: function() {
	                     alert("删除失败,请联系管理员");
	                }
	            });
            }
    }
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

         var ids="";
         var ids2="";
	     var classCode=$("#clazzselect").val();
	     var collegeCode=$("#majorselect").val();
	     var majorCode=$("#majorCode").val();
	     var type=$("#typeselect").val();

	     function getIds(){
	      	   $("input[name='ids']").each(function(){
	      		 if($(this).attr("checked")){
	      			ids+=$(this).val()+",";
		         }
	      		   
	      	   });
	      }

	     function getIds2(){
	      	   $("input[name='ids2']").each(function(){
	      		 if($(this).attr("checked")){
	      			 ids2+=$(this).val()+",";
	      		 }
	      		  
	      	   });
	      }
         
		$("#deleteUser").click(
		   function(){
			   getIds2();
		       if($("[id=ids2]:input:checked").length==0) {
		            alert("没有可操作数据,请勾选");
		            return false;
		       } 
		       if(!confirm('您确定要将学生从此班级移除吗？')) return  false;
		       $.ajax({
		            type: "post",
		            dataType: "html",
		            url: "${ctx}/clazz/clazz-assign!handClazz.action",
		            data: "ids2=" + ids2+"&flag=delete"+"&classCode="+classCode+"&majorCode="+majorCode+"&collegeCode="+collegeCode+"&type="+type,
		            success: function (msg) {
		            	if (msg!=""){		
		                    alert(msg);
		      			  	$("#mainForm").submit();
		                }
		            },
		            error: function() {
		                 alert("登记失败,请联系管理员");
		            }
		        });

		 });

		
		 $("#addUser").click(
			function(){
				getIds();
				if($("[id=ids]:input:checked").length==0){
					 alert("没有可操作数据，请勾选");
					 return false;
				}
				if(!confirm('您确定要将学生添加到此班级吗？')) return false;
				$.ajax({
		            type: "post",
		            dataType: "html",
		            url: "${ctx}/clazz/clazz-assign!handClazz.action",
		            data: "ids=" + ids+"&flag=update"+"&classCode="+classCode+"&majorCode="+majorCode+"&collegeCode="+collegeCode+"&type="+type,
		            success: function (msg) {
		            	if (msg!=""){
		                    alert(msg);
		      			  	$("#mainForm").submit();
		                }
		            },
		            error: function() {
		                 alert("登记失败,请联系管理员");
		            }
		        });
         });


		 $("#search").bind("click", function () {
			   //验证
				if($("#majorselect").val()=="" || $("#clazzselect").val()==""){
					alert("请选择专业和班级！");
				}else if($("#typeselect").val()==""){
					alert('请选择学生类别！');
		        }else{
				   if($("#mainForm"))$("#mainForm").submit();
				}
			}
		);
		 
	   $("#checkboxall").click(function(){
		     $("input[name='ids']").attr("checked",$(this).attr("checked"));
		});
	   $("#checkboxall2").click(function(){
		     $("input[name='ids2']").attr("checked",$(this).attr("checked"));
		});
	   $("#queryButton").click();
    }); 
-->
</script>

</head>
<body  style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<div class="xzwz">
<h1>手工分班</h1>
</div>
<form id="mainForm" action="${ctx }/clazz/clazz-assign!adjust.action" method="post">
<div id="filter" class="fenye" style="display: block;">
	    批次:<s:select list="welbatchList" theme="simple" listKey="id" listValue="comname" headerKey="" 
	    headerValue="请选择" name="filter_EQL_welbatch$id" value="@java.lang.Integer@parseInt(#parameters.filter_EQL_welbatch$id)"></s:select>
	    院系:<s:select list="colleges" id="collegeselect" theme="simple" name="collegeCode" 
	    listKey="code" listValue="name" headerKey="" headerValue="请选择" value="collegeCode"></s:select>
	    专业:<s:select list="majors" id="majorselect"  listKey="code" listValue="name" headerKey=""
	    name="majorCode" value="majorCode" headerValue="请选择" theme="simple"></s:select>
	   班级:<s:select list="clazzs" id="clazzselect" listKey="code" listValue="name"  
	   headerKey="" name="clazzCode" value="clazzCode" headerValue="请选择" theme="simple"></s:select>
	    类别:<s:select list="studentTypeList" id="typeselect" listKey="value" listValue="label"  
	   headerKey="" name="type" value="type" headerValue="请选择" theme="simple"></s:select>
	 <span class="btn2"><a href="javascript:void(0);" id="search"  title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:void(0);" id="mainformreset" title="重置查询条件"><span>重置查询条件</span></a></span>
 <div class="clear"></div>
</div>
<input type="hidden" name="pageByMajor.pageNo" id="pageNo" value="${pageByMajor.pageNo}"/>
<input type="hidden" name="pageByMajor.orderBy" id="orderBy" value="${pageByMajor.orderBy}"/>
<input type="hidden" name="pageByMajor.order" id="order" value="${pageByMajor.order}" />

<input type="hidden" name="pageByClazz.pageNo" id="ortherPageNo" value="${pageByClazz.pageNo}"/>
<input type="hidden" name="pageByClazz.orderBy" id="ortherOrderBy" value="${pageByClazz.orderBy}"/>
<input type="hidden" name="pageByClazz.order" id="ortherOrder" value="${pageByClazz.order}" />
</form>
<br/><br/>
<!-- two column student-->
<div style="width:99%">
  <form id="handForm" method="post" action="">
	<!-- left student list-->
	<table  style="border:none; width:100%; text-align: center">
	<tr>
	<td valign="top" style="width:40%">
    <table width="100%" border="0" cellspacing="0" cellpadding="0"
	style="border-left: 1px solid #B4C8D3; border-right: 1px solid #B4C8D3;">

	   <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">专业下的新生</td>
    </tr>

	 <tr>
		<td bgcolor="#FFFFFF">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		      <td width="1%" height="25" class="tbg03">
				<label>
			        <input name="checkboxall" type="checkbox" id="checkboxall"/>
			    </label>
			  </td>
		      <td width="17%" height="25" class="tbg03"><strong>考生号</strong></td>
	          <td width="16%" class="tbg03"><strong>姓名</strong></td>
	          <td width="19%" class="tbg03"><strong>性别</strong></td>
	          <td width="19%" class="tbg03"><strong>生源身份</strong></td>
		  </tr>
		  <s:iterator id="obj" value="pageByMajor.result" status="status">
		  <tr>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
		  	   <input type="checkbox" id="ids" name="ids" value="${id }" />
		  	</td>
		    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${examineeNo }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>    
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexdesc }&nbsp;</td>
		    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${province}&nbsp;</td>    
		  </tr>
		  </s:iterator>
		</table> 
		</td>  
	</tr>

	<tr>
		<td height="32" style="background: url('../images/login/tabbg02.jpg')">
		   <div class="fenye">
				  <h6>
				    <span class="wz">第 <span class="shuzi">
				    <c:choose>
				    <c:when test="${pageByMajor.totalCount!=0 && ((pageByMajor.pageNo-1)*pageByMajor.pageSize+1)<pageByMajor.totalCount}">
				    	<c:out value="${(pageByMajor.pageNo-1)*pageByMajor.pageSize+1}"/>-
				    </c:when>
				    <c:otherwise>
				    	<c:choose>
				    	<c:when test="${pageByMajor.totalCount==0}">
				    	 0 -
				    	</c:when>
				    	<c:otherwise>
				    	 1 -
				    	</c:otherwise>
				    	</c:choose>
				    </c:otherwise>
				    </c:choose>
				    <c:choose>
				    <c:when test="${pageByMajor.totalCount!=0 && (pageByMajor.pageNo*pageByMajor.pageSize)<pageByMajor.totalCount}">
				    	<c:out value="${pageByMajor.pageNo*pageByMajor.pageSize}"/>
				    </c:when>
				    <c:otherwise><c:out value="${pageByMajor.totalCount}"/></c:otherwise>
				    </c:choose>
				    </span> 条，共 <span class="shuzi"><b>${pageByMajor.totalCount}</b></span> 条</span>
					<a href="javascript:jumpPage(1)">首页</a>
					<s:if test="pageByMajor.hasPre"><a href="javascript:jumpPage(${pageByMajor.prePage})">上一页</a></s:if>
					<s:if test="pageByMajor.hasNext"><a href="javascript:jumpPage(${pageByMajor.nextPage})">下一页</a></s:if>
					<a href="javascript:jumpPage(${pageByMajor.totalPages})">末页</a>
				  </h6>
				  <div class="clear"></div>
		 </div>
		</td>
	</tr>
</table>
    
    
    
    
	</td>
	<!-- middle adjust td-->
	<td valign="middle" style="width:10%; text-align: center">
	<a href="javascript:void(0)" id="deleteUser" title="将学生从此班级中移除"><<<</a>
	<br/><br/>
	<a href="javascript:void(0)" id="addUser" title="将学生添加到此班级">>>></a>
	</td>
	<!-- right student list-->
	<td valign="top" style="width:40%">
	
	    <table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="border-left: 1px solid #B4C8D3; border-right: 1px solid #B4C8D3;">
		    <tr>
		      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt">班级下的新生</td>
		    </tr>
		
			<tr>
				<td bgcolor="#FFFFFF">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				      <td width="1%" height="25" class="tbg03">
						<label>
					        <input type="checkbox" id="checkboxall2" name="checkboxall2"/>
					    </label>
					  </td>
				      <td width="17%" height="25" class="tbg03"><strong>考生号</strong></td>
			          <td width="16%" class="tbg03"><strong>姓名</strong></td>
			          <td width="19%" class="tbg03"><strong>性别</strong></td>
			          <td width="19%" class="tbg03"><strong>生源身份</strong></td>
				  </tr>
				  <s:iterator id="obj" value="pageByClazz.result" status="status">
				  <tr>
				    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">
				  		<input type="checkbox" id="ids2" name="ids2" value="${id }" />
				  	</td>
				    <td height="25" class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${examineeNo }&nbsp;</td>
				    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${name }&nbsp;</td>    
				    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${sexdesc }&nbsp;</td>
				    <td class="<s:if test='#status.even'>br05</s:if><s:else>br03</s:else>">${province}&nbsp;</td>    
				  </tr>
				  </s:iterator>
				</table> 
				</td>  
			</tr>
		
			<tr>
				<td height="32" style="background: url('../images/login/tabbg02.jpg')">
				   <div class="fenye">
				  <h6>
				    <span class="wz">第 <span class="shuzi">
				    <c:choose>
				    <c:when test="${pageByClazz.totalCount!=0 && ((pageByClazz.pageNo-1)*pageByClazz.pageSize+1)<pageByClazz.totalCount}">
				    <c:out value="${(pageByClazz.pageNo-1)*pageByClazz.pageSize+1}"/>-
				    </c:when>
				    <c:otherwise>
				    	<c:choose>
				    	<c:when test="${pageByClazz.totalCount==0}">
				    	 0 -
				    	</c:when>
				    	<c:otherwise>
				    	 1 -
				    	</c:otherwise>
				    	</c:choose>
				    </c:otherwise>
				    </c:choose>
				    <c:choose>
				    <c:when test="${pageByClazz.totalCount!=0 && (pageByClazz.pageNo*pageByClazz.pageSize)<pageByClazz.totalCount}">
				    <c:out value="${pageByClazz.pageNo*pageByClazz.pageSize}"/></c:when>
				    <c:otherwise><c:out value="${pageByClazz.totalCount}"/></c:otherwise>
				    </c:choose>
				    </span> 条，共 <span class="shuzi"><b>${pageByClazz.totalCount}</b></span> 条</span>
					<a href="javascript:ortherJumpPage(1)">首页</a>
					<s:if test="pageByClazz.hasPre"><a href="javascript:ortherJumpPage(${pageByClazz.prePage})">上一页</a></s:if>
					<s:if test="pageByClazz.hasNext"><a href="javascript:ortherJumpPage(${pageByClazz.nextPage})">下一页</a></s:if>
					<a href="javascript:ortherJumpPage(${pageByClazz.totalPages})">末页</a>
				  </h6>
				  <div class="clear"></div>
		  </div>
				</td>
			</tr>
	  </table>
	</td>
	</tr>
	</table>
  </form>
</div>
</body>
</html>