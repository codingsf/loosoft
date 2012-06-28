<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="cn.loosoft.stuwork.stuinfo.web.attachment.UploadPath"%><html>
<head>
<title>新增学生信息</title>
<link href="../css/newpage.css" rel="stylesheet" type="text/css" />
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/js.jsp"%>
<script src="${ctx}/js/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">

//邮政编码验证  
jQuery.validator.addMethod("zipCode", function(value, element) {
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "邮政编码格式错误");

//身份证号码验证  
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
	var idcard=/(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
  return this.optional(element) || (idcard.test(value));  
}, "请正确输入身份证号码");  

	$(document).ready(function() {
		//聚焦第一个输入框
		$("#studentNo").focus();
		//为dataForm注册validate函数
		$("#dataForm").validate({
			rules: {
		    IDcard:{
	         required:true,
	         digits:true
	        },
	        examineeNo:{
	        	  required:true
		        },
			    name:{
				    required:true,
				    maxlength:20
				},
				former:{
					maxlength:20
				},
			    sex:"required",
			    type:"required",
			    collegeCode:"required",
			    majorCode:"required", 
			    length:"required", 
				birthday:"required",
				inDate:"required", 
			    email:"email",
			    onlineWeb:"url",
			    bankAccount:"creditcard",
			    specialty:{
		        	maxlength:255
		        },
		        pinyin:{
		        	maxlength:255
		        },
		        fatherName:{
		        	maxlength:20
		        },
		        motherName:{
		        	maxlength:20
		        },
		        cardNum:"creditcard",
		        remarks:{
		        	maxlength:255
		        },
		        familyCode:"zipCode",
		        IDcard:{
			        required:true,
			        isIdCardNo:true
			    } ,
		        grade:"required",
		        education:"required"
			},
			messages: {
				passwordConfirm: {
					equalTo: "输入与上面相同的密码"
				} 
			}
	
		});

		$("#inSchool").click(function (){
			if($("#inSchool").attr("checked")==true){
				$("#sayHello").hide();
			}else{
				$("#sayHello").show();
			}
			
		});
			
	});

	function changeImg(obj){
	document.getElementById("img").src=obj;
	}

	//判断上传附件的文件格式
 	function check(files) 
 	{ 
 		var val = files.value.substr(files.value.lastIndexOf(".")).toLowerCase(); 
 		var fileType = new Array(".gif",".GIF",".jpg",".jpeg",".JPEG",".png",".PNG");
 		var flag = false;
 	 	for(var i=0;i<fileType.length;i++)
 	 	{ 
			if(fileType[i]==val){
				flag =true;
			}
 	 	}
 	  
 	 	if(!flag){
			alert("上传相片的格式不正确,请重新上传");
			var objVal = document.getElementById('hid_picfile').value; 
			if(objVal==null || ""==objVal){
				document.getElementById('span1').innerHTML='<input type=file name=picfile id=picfile size=20 align=right value=选择文件  onchange=check(this); />';
			}
 	 	 	return;
 	 	} 
 	 	
 	 	//上传附件
 	 	ajaxAttchFileUpload();
 	} 
 	
 	 //上传附件
	function ajaxAttchFileUpload(){ 
		var studentNo = $("#studentNo").val();
		if(studentNo ==""){
			alert("请先填写学号，再上传照片!");
			return;
		}
		$("#att_show").show();//显示上传附件时用到的上传等待图片
		
		$.ajaxFileUpload　//调用方法上传附件
		(
			{
				url:'${ctx}/attachment/upload.action?stuno='+studentNo,//用于文件上传的服务器端请求地址
				secureuri:false,//一般设置为false
				fileElementId:'picfile',//文件上传空间的id属性  <input type="file" id="file" name="file" />
				dataType: 'json',//返回值类型 一般设置为json
				success: function (data, status)  //服务器成功响应处理函数
				{
					$("#att_show").hide(); //隐藏上传附件时用到的上传等待图片
	
					if(data!=null){
						if(data.message!=null){
							alert(data.message);//错误提示信息，如附件太大，上传失败
							//上传失败后，清空上传文件框
							$("#span1").html('<input type=file name=picfile id=picfile size=20 align=right value=选择文件  onchange=check(this); />');
							return;
						}else{
							var avatar = data.avatarname;//获得上传成功后的文件名
							$("#hid_picfile").val(avatar);//将上传成功后的文件名赋与hidden文本框，以保存文件名到数据库
							var va =$('#ava_url').val()+avatar;
							$("#define_ava_div").html('<img src="'+va+'" width="110" height="90" border="1px solid;"/>');
							
					 	 	//显示"删除文件"
					 	 	$("#delFile_div").show();
						}
					} 
					if(typeof(data.error) != 'undefined')
					{
						if(data.error != '')
						{
							alert(data.error);
						}else
						{
							alert(data.message);
						}
					}
				},
				error: function (data, status, e)//服务器响应失败处理函数
				{
					alert(e);
				}
			}
		)
		return false;
	}
	
	//删除附件 	
	function onDelAttch(){
		//清空附件文本框
		$("#span1").html('<input type=file name=picfile id=picfile size=20 align=right value=选择文件  onchange=check(this); />');
		//取得附件名称
		var val = $("#hid_picfile").val();
		//后台删除附件
		$.getJSON("${ctx}/attachment/upload!deleteStudentPic.action",{"delPicFileName":val},function(data) {
			 if(data!=null){//删除失败，打印提示信息
			 	alert(data.value);
			 }else{
				   //删除成功
				$("#delFile_div").hide(); //隐藏＂删除文件＂的链接
				$("#hid_picfile").val("");//删除完成后将附件名清置空
				$("#define_ava_div").html('<div style="vertical-align: middle;width: 110px;height: 90px;border: 1px solid;text-align: center;line-height: 90px;">预览区</div>');
			 }
		});
	}	
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
<form id="dataForm" name="dataForm"
	action="${ctx}/student/student!save.action" method="post"
	enctype="multipart/form-data"><input type="hidden" name="id"
	value="${id}" /> <input type="hidden" name="collegeName" value="${collegeName }"
	id="collegeName" /> <input type="hidden" name="majorName" value="${majorName }"
	id="majorName" /> <input type="hidden" name="className" id="className"  value="${className }" />
	
	<input type="hidden" name="oldBankName" id="oldBankName" value="${bankName}" />
	<input type="hidden" name="oldBankAccount" id="oldBankAccount" value="${bankAccount}" />

	<input type="hidden" name="oldCollegeCode" value="${collegeCode}" />
	<input type="hidden" name="oldMajCode" value="${majorCode}" />
	<input type="hidden" name="oldClaCode" value="${classCode}" /> 
	<input type="hidden" name="oldCollgeName" value="${collegeName}" />
	<input type="hidden" name="oldMajName" value="${majorName}" />
	<input type="hidden" name="oldClaName" value="${className}" />
<div class="mid1003_r">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-left:1px solid #B4C8D3; border-right:1px solid #B4C8D3;">

    <tr>
      <td height="27"  style="background: url('../images/login/tabbg01.jpg');" class="tbigtt"><s:if test="id == null">新增</s:if><s:else>修改</s:else>     
      学生信息(<span class="redz">*</span>为必填)</td>
    </tr>
    <tr>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
	          <td height="30" bgcolor="#F1F4F9" align="right" class="tbg01 pr10">学号&nbsp;</td>
	          <td><input id="studentNo" name="studentNo"
				value="${studentNo}" type="text" class="wid40px" /></td>
		      <td  height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10"  rowspan="5">相片&nbsp;</td>
	          <td  class="tbg02" bgcolor="#F1F4F9" rowspan="4"> 
	          <input type="hidden" name="img" id="hid_picfile" value="${img }"/>
	          <div id="define_ava_div">
	               <s:if test="img!=null && img!=''">
                      <img src="<common:prop name="stuinfo.webapp.url" propfilename="sysconfig.properties" defaultvalue="${pageContext.request.contextPath}"/><%=UploadPath.PICTUREPATH%><%=UploadPath.STUDENTPIC%>/${img}" width="110" height="90" border="1px;"/>
                   </s:if>
                   <s:else>
                   <div style="vertical-align: middle;width: 110px;height: 90px;border: 1px solid;text-align: center;line-height: 90px;">请提交电子照片</div>
                   </s:else>
              </div>     
              <br /> </td>
        </tr>
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"   class="tbg01 pr10">姓名<span class="redz">* </span></td>
	          <td >
		           <input id="name" name="name" value="${name}" type="text"class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">性别<span class="redz">* </span></td>
	          <td >
		         <s:select theme="simple" list="#{'m':'男','f':'女'}" name="sex" headerKey="" headerValue="请选择" value="sex" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9"  class="tbg01 pr10">考生号<span class="redz">* </span></td>
	          <td >
		        <input id="examineeNo" name="examineeNo" value="${examineeNo}" type="text" class="wid40px" />
		      </td>
        </tr>
        
        <tr>
	          <td height="30" align="right" bgcolor="#F1F4F9" class="tbg01 pr10">毕业中学&nbsp;</td>
	          <td bgcolor="#F1F4F9">
		        <input id="graduateSchool" name="graduateSchool" value="${graduateSchool}" type="text" class="wid40px" />
		      </td>
	          <td bgcolor="#F1F4F9">
	          	<div id="span1" style="float: left;">
		           <input type="file" name="picfile" id="picfile" align="right" size="20" value="选择文件" onchange="check(this);"/><br/>
		        </div>
		        	<div style="float: left;">
		        	<input id="ava_url" name="ava_url" type="hidden" value="<common:prop name="stuinfo.webapp.url" propfilename="sysconfig.properties" defaultvalue="${pageContext.request.contextPath}"/><%=UploadPath.PICTUREPATH%><%=UploadPath.STUDENTPIC%>"/>
		        	</div>
		        	<div style="float: left;">
		           <img src="${ctx}/images/loading.gif" id="att_show" name="att_show"  width="30" height="30"  style="display: none;"/>
		           </div>
                   <div style="<s:if test="img!=null && img!=''">display: block;</s:if><s:else>display: none;</s:else>float: left;" id="delFile_div">
                     	<a href="javascript:void(0);" onclick="onDelAttch();">&nbsp;删除文件</a>&nbsp;
                   </div>
		      </td>
        </tr>
        
        <tr>
	          <td height="30" width="20%" align="right" class="tbg02 pr10">姓名拼音&nbsp;</td>
	          <td  width="30%">
		          <input id="pinyin" name="pinyin" value="${pinyin}" type="text"  />
	          </td>
	           <td height="30" width="15%" align="right"  class="tbg02 pr10">曾用名&nbsp;</td>
	          <td  width="35%">
		       <input id="former" name="former" value="${former}" type="text"  />
	          </td>
        </tr>
        
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">身份证号<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		         <input id="IDcard" name="IDcard" value="${IDcard}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">出生年月<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		       <input name="birthday" id="birthday" value="<fmt:formatDate value="${birthday}" type="date" pattern="yyyy-MM-dd"/>" type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
	          </td>         
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">院系<span class="redz">* </span></td>
	          <td  >
		         <s:select id="collegeselect" theme="simple" list="collegues" listKey="code" listValue="name" name="collegeCode" headerKey="" headerValue="请选择" value="collegeCode" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">专业<span class="redz">* </span></td>
	          <td  >
		        <s:select id="majorselect" theme="simple" list="majors" listKey="code" listValue="name" name="majorCode" headerKey="" headerValue="请选择" value="majorCode" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">班级&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <s:select id="clazzselect" theme="simple" list="clazzs"
			listKey="code" listValue="name" name="classCode" headerKey=""
			headerValue="请选择" value="classCode" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">宿舍</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="roombed" name="roombed" value="${roombed}" type="text" class="wid40px" />
	          </td>
        </tr>
           
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">民族&nbsp;</td>
	          <td  >
		        <s:select id="mzselect" theme="simple" list="mz"
			listKey="value" listValue="label" name="nation" headerKey=""
			headerValue="请选择" value="nation" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">籍贯&nbsp;</td>
	          <td  >
		        <input id="birthPlace" name="birthPlace" value="${birthPlace}" type="text" class="wid40px" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">政治面貌&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <s:select theme="simple" list="zzmm" listKey="value"
			listValue="label" name="politicsFace" headerKey="" headerValue="请选择"
			value="politicsFace" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学制<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		        <s:select id="length" theme="simple" list="xz"
			listKey="value" listValue="label" name="length" headerKey=""
			headerValue="请选择" value="length" />
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">培养方式<span class="redz">* </span></td>
	          <td  >
		       <s:select id="type" theme="simple" list="pyfs"
			listKey="value" listValue="label" name="type" headerKey=""
			headerValue="请选择" value="type" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">学历<span class="redz">* </span></td>
	          <td  >
		       <s:select theme="simple" list="xl" listKey="value"
			listValue="label" name="education" id="education" headerKey="" headerValue="请选择"
			value="education" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">学位&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		       <s:select id="xwfsselect" theme="simple" list="xw"
			listKey="value" listValue="label" name="degree" headerKey=""
			headerValue="请选择" value="degree" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学时间<span class="redz">* </span></td>
	          <td bgcolor="#F1F4F9" >
		       <input name="inDate" id="inDate"
			value="<fmt:formatDate value="${inDate}" type="date" pattern="yyyy-MM-dd"/>"
			type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">毕业时间&nbsp;</td>
	          <td >
		      <input name="finishDate" id="finishDate"
			value="<fmt:formatDate value="${finishDate}" type="date" pattern="yyyy-MM-dd"/>"
			type="text" class="Wdate" class="ipt wid20 " onclick="WdatePicker()" />
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">研究方向导师&nbsp;</td>
	          <td >
		        <input id="hierophant" name="hierophant" value="${hierophant}" type="text" class="wid40px" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">班主任&nbsp;</td>
	          <td >
		      <input id="headTeacher" name="headTeacher" value="${headTeacher}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">班主任电话&nbsp;</td>
	          <td >
		        <input id="headTeacherPhone" name="headTeacherPhone" value="${headTeacherPhone}" type="text" class="wid40px" />
	          </td>
        </tr>
         <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">辅导员&nbsp;</td>
	          <td >
		      <input id="counselor" name="counselor" value="${counselor}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">辅导员电话&nbsp;</td>
	          <td >
		        <input id="counselorPhone" name="counselorPhone" value="${counselorPhone}" type="text" class="wid40px" />
	          </td>
        </tr>
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">联系电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="phone" name="phone" value="${phone}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">一卡通&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="cardNum" name="cardNum" value="${cardNum}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">教育方向&nbsp;</td>
	          <td>
		       <input id="edudirection" name="edudirection" value="${edudirection}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">生源地</td>
	          <td  >
		        <input id="testaddr" name="testaddr" value="${testaddr}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">父亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         <input id="fatherName" name="fatherName" value="${fatherName}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">母亲姓名&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="motherName" name="motherName" value="${motherName}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">家庭地址&nbsp;</td>
	          <td  >
		         <input id="address" name="address" value="${address}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">家庭邮编&nbsp;</td>
	          <td >
		      <input id="familyCode" name="familyCode" value="${familyCode}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">家庭电话&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		         <input id="homePhone" name="homePhone" value="${homePhone}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">血型&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="blood" name="blood" value="${blood}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">健康状况&nbsp;</td>
	          <td  >
		        <input id="healthInfo" name="healthInfo" value="${healthInfo}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">婚姻状况&nbsp;</td>
	          <td  >
		       <s:select id="hyzkselect" theme="simple" list="hyzk"
			listKey="value" listValue="label" name="marryInfo" headerKey=""
			headerValue="请选择" value="marryInfo" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">心理状况&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="psyInfo" name="psyInfo" value="${psyInfo}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">国别&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="country" name="country" value="${country}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">港澳台&nbsp;</td>
	          <td  >
		        <s:checkbox id="autonomy" theme="simple" name="autonomy" value="autonomy" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">宗教信仰&nbsp;</td>
	          <td  >
		        <input id="religion" name="religion" value="${religion}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">银行名称&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="bankName" name="bankName" value="${bankName}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">银行账户&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="bankAccount" name="bankAccount" value="${bankAccount}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" class="tbg02 pr10">个人主页&nbsp;</td>
	          <td  >
		        <input id="onlineWeb" name="onlineWeb" value="${onlineWeb}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right"  class="tbg02 pr10">邮箱&nbsp;</td>
	          <td  >
		        <input id="email" name="email" value="${email}" type="text" class="wid40px" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">入学前户口</td>
	          <td bgcolor="#F1F4F9" >
		        <input id="account" name="account" value="${account}" type="text" class="wid40px" />
	          </td>
	           <td height="30"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">是否毕业&nbsp;</td>
	          <td bgcolor="#F1F4F9" >
		        <s:checkbox id="graduated" theme="simple" name="graduated" value="graduated" />
	          </td>
        </tr>
        
        <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">是否在校&nbsp;</td>
	          <td  >
		       <s:checkbox id="inSchool" theme="simple" name="inSchool" value="inSchool" />
	          </td>
	           <td height="30"  align="right" class="tbg02 pr10">是否注册&nbsp;</td>
	          <td  >
		        <s:checkbox id="reged" theme="simple" name="reged" value="reged" />
	          </td>
        </tr>
                <tr>
	          <td height="30"  align="right"  class="tbg02 pr10">所在年级<span class="redz">* </span></td>
	          <td colspan="3" >
		       <s:select id="grade" theme="simple" list="gradeList"
					listKey="value" listValue="label" name="grade" headerKey=""
					headerValue="请选择" value="grade" cssStyle="width:90px;"/>
	          </td> 
        </tr>
        <tr id="sayHello">
	          <td height="70"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">非在校原因&nbsp;</td>
	          <td bgcolor="#F1F4F9" colspan="3">
		       <textarea name="notSchoolReason"  style="width:300px; height: 50px"  id="notSchoolReason">${notSchoolReason}</textarea>
	          </td>
        </tr>
        
        <tr>
	          <td height="70"  align="right"  class="tbg02 pr10">特长&nbsp;</td>
	          <td  colspan="3">
		      <textarea name="specialty" style="width:300px;height: 50px" id="specialty">${specialty}</textarea>
	          </td>
        </tr>
         <tr>
	          <td height="70"  align="right" bgcolor="#F1F4F9" class="tbg01 pr10">备注&nbsp;</td>
	          <td bgcolor="#F1F4F9" colspan="3">
		     <textarea name="remarks"  style="width:300px;height: 50px" id="remarks">${remarks}</textarea>
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