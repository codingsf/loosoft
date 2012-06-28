<%@ page language="java" pageEncoding="UTF-8"%>
    <%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp"%>
<script type="text/javascript">
$(document).ready(function(){  
	   
	/**//* 设置默认属性 */  
	$.validator.setDefaults({  
	  submitHandler: function(form) {  
	  form.submit();  
	  }  
	});   

//字符验证  
jQuery.validator.addMethod("stringCheck", function(value, element) {  
  return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);  
}, "只能包括中文字、英文字母、数字和下划线");  
  
// 中文字两个字节  
jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {  
  var length = value.length;  
  for(var i = 0; i < value.length; i++){  
  if(value.charCodeAt(i) > 127){  
  length++;  
  }  
  }  
  return this.optional(element) || ( length >= param[0] && length <= param[1] );  
}, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");  
  
// 身份证号码验证  
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
	var idcard=/(^\d{15}$)|(^\d{17}([0-9]|X)$)/;
  return this.optional(element) || (idcard.test(value));  
}, "请正确输入您的身份证号码");  
   
// 手机号码验证  
jQuery.validator.addMethod("isMobile", function(value, element) {  
  var length = value.length;  
  var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;  
  return this.optional(element) || (length == 11 && mobile.test(value));  
}, "请正确填写您的手机号码");  
   
// 电话号码验证  
jQuery.validator.addMethod("isTel", function(value, element) {  
  var tel = /^\d{3,4}-?\d{7,9}$/; //电话号码格式010-12345678  
  return this.optional(element) || (tel.test(value));  
}, "请正确填写您的电话号码");  
  
// 联系电话(手机/电话皆可)验证  
jQuery.validator.addMethod("isPhone", function(value,element) {  
  var length = value.length;  
  var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;  
  var tel = /^\d{3,4}-?\d{7,9}$/;  
  return this.optional(element) || (tel.test(value) || mobile.test(value));  
  
}, "请正确填写您的联系电话");  
   
// 邮政编码验证  
jQuery.validator.addMethod("isZipCode", function(value, element) {  
  var tel =/^[1-9]\d{5}$/;  
  return this.optional(element) || (tel.test(value));  
}, "请正确填写您的邮政编码"); 


//手机号码验证
jQuery.validator.addMethod("mobile", function(value, element) {
    var length = value.length;
    var mobile =  /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/
    return this.optional(element) || (length == 11 && mobile.test(value));
}, "手机号码格式错误");   

// 电话号码验证   
jQuery.validator.addMethod("phone", function(value, element) {
    var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
    return this.optional(element) || (tel.test(value));
}, "电话号码格式错误");

// 邮政编码验证   
jQuery.validator.addMethod("zipCode", function(value, element) {
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "邮政编码格式错误");

// QQ号码验证   
jQuery.validator.addMethod("qq", function(value, element) {
    var tel = /^[1-9]\d{4,9}$/;
    return this.optional(element) || (tel.test(value));
}, "qq号码格式错误");

// IP地址验证
jQuery.validator.addMethod("ip", function(value, element) {
    var ip = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    return this.optional(element) || (ip.test(value) && (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 256));
}, "Ip地址格式错误");

// 字母和数字的验证
jQuery.validator.addMethod("chrnum", function(value, element) {
    var chrnum = /^([a-zA-Z0-9]+)$/;
    return this.optional(element) || (chrnum.test(value));
}, "只能输入数字和字母(字符A-Z, a-z, 0-9)");

// 中文的验证
jQuery.validator.addMethod("chinese", function(value, element) {
    var chinese = /^[\u4e00-\u9fa5]+$/;
    return this.optional(element) || (chinese.test(value));
}, "只能输入中文");

// 下拉框验证
$.validator.addMethod("selectNone", function(value, element) {
    return value == "请选择";
}, "必须选择一项");

// 字节长度验证
jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {
    var length = value.length;
    for (var i = 0; i < value.length; i++) {
        if (value.charCodeAt(i) > 127) {
            length++;
        }
    }
    return this.optional(element) || (length >= param[0] && length <= param[1]);
}, $.validator.format("请确保输入的值在{0}-{1}个字节之间(一个中文字算2个字节)"));

  
//开始验证  
$('#submitForm').validate({  
  /**//* 设置验证规则 */  
  rules: {  
  username: {  
  required:true,  
  stringCheck:true,  
  byteRangeLength:[3,15]  
  },  
  email:{  
  required:true,  
  email:true  
  },  
  phone:{  
  required:true,  
  isPhone:true  
  },  
  IDcard:{
	required:true,
	isIdCardNo:true
  },

  address:{  
  required:true,  
  stringCheck:true,  
  byteRangeLength:[3,100]  
  }  
  },  
   
  /**//* 设置错误信息 */  
  messages: {  
  username: {  
  required: "请填写用户名",  
  stringCheck: "用户名只能包括中文字、英文字母、数字和下划线",  
  byteRangeLength: "用户名必须在3-15个字符之间(一个中文字算2个字符)"  
  },  
  email:{  
  required: "<font color=red>请输入一个Email地址</fond>",  
  email: "请输入一个有效的Email地址"  
  },

  IDcard:{
	  required:"请输入您的省份证号码",
	  isIdCardNo:"请输入一个有效的省份证号码"
  },
  phone:{  
  required: "请输入您的联系电话",  
  isPhone: "请输入一个有效的联系电话"  
  },  
  address:{  
  required: "请输入您的联系地址",  
  stringCheck: "请正确输入您的联系地址",  
  byteRangeLength: "请详实您的联系地址以便于我们联系您"  
  }  
  },  
   
  /**//* 设置验证触发事件 */  
  focusInvalid: false,  
  onkeyup: false,  
   
  /**//* 设置错误信息提示DOM */  
  errorPlacement: function(error, element) {  
  error.appendTo( element.parent());  
  },  
   
});  
  
});  
</script>
</head>
<body>  
  <form class="submitForm" id="submitForm" method="get" action="">
  <fieldset>  
  <legend>表单验证</legend>  
  <p>  
  用户名
  <input id="userName" name="username" size="25" />
  </p>
  <p>
  E-Mail
  <em>*</em><input id="email" name="email" size="25" />
  </p>  
  <p>  
  <label for="phone">联系电话</label>  
  <em>*</em><input id="phone" name="phone" size="25" value="" />
  </p> 
  <p>  
  <label for="IDcard">身份证号</label>  
  <em>*</em><input id="IDcard" name="IDcard" size="25" value="" />
  </p> 
   <p>  
  <label for="zipCode">邮政编码</label>  
  <em>*</em><input id="zipCode" name="zipCode" size="25" value="" />
  </p>  
  <p>  
  <label for="address">地址</label>  
  <em>*</em><input id="address" name="address" size="22">
  </p>
  <p>
  <input class="submit" type="submit" value="提交"/>
  </p>  
  </fieldset>  
  </form>  
  </body>  
</html>  