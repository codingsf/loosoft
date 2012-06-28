<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>新增or修改岗位</title>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/js.jsp" %>
<script type="text/javascript" src="${ctx}/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="${ctx}/fckeditor/lsfckeditor.js"></script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
.onError {
	color: red;
	font-weight: bold;
	background: transparent url(${ctx}/js/validate/images/unchecked.gif) no-repeat scroll left bottom;
	padding-left: 18px;
}
-->
</style>
<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#postName").focus();
		//为inputForm注册validate函数
		
		$("#dataForm").validate({
			rules: {
				postName:{
			    	required:true,
			    	maxlength:20
			    },
			    reqCount:{
			    	required:true,
			    	maxlength:20
			    },
			    address:{
			    	required:true,
			    	maxlength:200
			    },
			    content:{
			    	required:true,
			    	maxlength:200
			    },
			    requireMents:{
			    	required:true,
			    	maxlength:200
			    }
			    
			},
			messages: {
				postName:{
					required:"请输入岗位名称"
				},
				reqCount:{
					required:"请输入招聘人数"
				},
				address:{
					required:"请输入公司地点"
				},
				content:{
					required:"请输入勤工内容",
					maxlength:"请输入一个长度最多是 200 的字符串"
				},
				requireMents:{
					required:"请输入勤工要求",
					maxlength:"请输入一个长度最多是 200 的字符串"
				}
				
			}
		});
	});
	
	function check(){
		var choseDate = $("#stopdate").val();
		if(choseDate != ""){
			var str = choseDate.split("-");
			var choseYear = str[0];
			var choseMonth = str[1];
			var choseDay = str[2];
			var date = new Date();
			var nowYear = date.getFullYear();
			var nowMonth = date.getMonth()+1;
			var nowDay = date.getDate();
			var tip = $("#er");
			if (choseYear < nowYear) {
			    tip.addClass("onError");
			    tip.html("截止日期应该大于今天");
			    return false;
			} else {
				tip.removeClass();
				tip.html("");
			}
			
			if (choseYear = nowYear){
				if (choseMonth < nowMonth){
					var tip = $("#er");
				    tip.addClass("onError");
				    tip.html("截止日期应该大于今天");
				    return false;
				} else {
					tip.removeClass();
					tip.html("");
				}
				if (choseMonth = nowMonth){
					if (choseDay <= nowDay){
						var tip = $("#er");
					    tip.addClass("onError");
					    tip.html("截止日期应该大于今天");
					    return false;
					} else {
						tip.removeClass();
						tip.html("");
					}
				} else {
					tip.removeClass();
					tip.html("");
				}
				
			} else {
				tip.removeClass();
				tip.html("");
			}
		}
	
		
	}
	
</script>

</head>
<body style="background:#E3F1FA url(../images/login/mid_bg.jpg) repeat-x;">
<div class="emb"></div>
<form id="dataForm" name="dataForm" action="${ctx}/job/jobs-apply!save.action" method="post"  onsubmit="return check();">
<input type="hidden" name="id" value="${id}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      岗位(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="35%" height="30" align="right" class="tbg02 pr10">岗位名称<span class="redz">* </span></td>

          <td width="65%" ><input type="text" name="postName" class="wid30" id="postName" value="${postName}" /></td>
          </tr>
        <tr>
          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">性别限制&nbsp;</td>
          <td bgcolor="#F1F4F9">
	        <input type="text" name="sexLimit" class="wid30" id="sexLimit" value="${sexLimit}" />	   
          </td>
          </tr>
        <tr>

          <td height="30" align="right"  class="tbg02 pr10">招聘人数&nbsp;</td>
          <td>
            <input type="text" name="reqCount" class="wid30" id="reqCount" value="${reqCount}" />
          </td>
          </tr>
            <tr>

          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">报名截至时间&nbsp;</td>
          <td bgcolor="#F1F4F9">
             <input name="stopdate" id="stopdate"
			 value="<fmt:formatDate value="${stopdate}" type="date" pattern="yyyy-MM-dd"/>"
			 type="text" class="Wdate" class="ipt wid30 " onclick="WdatePicker()"/>
          </td>
          </tr>
          <tr>

          <td height="30" align="right"  class="tbg02 pr10">地点<span class="redz">* </span></td>
          <td >
             <textarea name="address" id="address">${address}</textarea>
          </td>
          </tr> 
          <tr>
          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">勤工内容<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
          <textarea name=content id="content" cols="50" rows="5">${content}</textarea>

          </td>
          </tr> 
           <tr>
          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10" >勤工要求<span class="redz">* </span></td>
          <td bgcolor="#F1F4F9">
          <textarea name=requireMents id="requireMents" cols="50" rows="5">${requireMents}</textarea>

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