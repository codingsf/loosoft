<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>新生报到注册清单</title>
 	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/jscss.jsp" %>
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
          
		$("#delbut").click(
		   function(){
		       if($("input:checked").length==0) {
		            alert("没有可删除记录,请勾选");
		            return false;
		       } 
		       if(!confirm('您确定要删除吗?')) return  false;
			   $("#mainForm").attr("action","common/user/delUsers.html");
			   $("#mainForm").submit();
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
    <li><a><span id="queryButton">显示查询</span></a></li>
  </ul>
</div>

<form id="mainForm" action="common/user/list.html" method="post">
<div id="filter" class="fenye" style="display: none">
	<h3>
	    年份:<input type="text" name="filter_LIKES_username" value="${param['filter_LIKES_username']}" class="ipt wid100px"/>
		季节::<select><option>请选择</option><option>秋季</option><option>春季</option></select>
	    学院:<select><option>请选择</option><option>植物科学学院</option></select>
	    系:<select><option>请选择</option><option>农学系</option><option>植物系</option></select>
	    专业:<select><option>请选择</option><option>农学院</option></select>
	    班级:<select><option>请选择</option><option>农学院</option></select>
	        <span class="btn2"><a href="javascript:search();" title="查 询"><span>查 询</span></a>&nbsp;<a href="javascript:search();" title="查 询"><span>重置查询条件</span></a></span>
	</h3>
 <div class="clear"></div>
</div> 
<input type="hidden" name="page.pageNo" id="pageNo" value="${page.pageNo}"/>
<input type="hidden" name="page.orderBy" id="orderBy" value="${page.orderBy}"/>
<input type="hidden" name="page.order" id="order" value="${page.order}" />

<table class="tbhs" width="95%">
  <tr>
    <th >入学年份</th>
    <th >院系</th>
    <th >专业</th>
    <th >序号</th>
    <th >班级</th>
    <th >考生号</th>
    <th >身份证号</th>
    <th >性别</th>
    <th >姓名</th>
    <th >电话</th>
    <th >出生日期</th>
  </tr>
  <tr>
    <td>${obj.userid }&nbsp;</td>
    <td><a href="${ctx}/common/user/user!query.action?id=${obj.id }">${obj.username }</a></td>
    <td>${obj.circlesname }&nbsp;</td>
    <td>1</td>
    <td>${obj.mobilephone }&nbsp;</td>
    <td>${obj.telephone }&nbsp;</td>
    <td>${obj.sex }&nbsp;</td>
    <td>男</td>
    <td>${obj.usertype }&nbsp;</td>
    <td>${obj.sex }&nbsp;</td>
    <td>${obj.sex }&nbsp;</td>
    <td>1990-09-01&nbsp;</td>
  </tr>
</table>
<div class="fenye">
  <h6>
     第1页, 共12页 
	<a href="javascript:jumpPage(1)">首页</a>
	<s:if test="page.hasPre"><a href="javascript:jumpPage(${page.prePage})">上一页</a></s:if>
	<s:if test="page.hasNext"><a href="javascript:jumpPage(${page.nextPage})">下一页</a></s:if>
	<a href="javascript:jumpPage(${page.totalPages})">末页</a>
  </h6>
  <div class="clear"></div>
</div>
</form>
</body>
</html>