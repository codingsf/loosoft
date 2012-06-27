<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>学工管理系统</title>
</head>
<style>
.stuwork {
	background-image:url(images/stuwork.png); 
	width:147px; 
	height:43px; 
	padding-top:5px; 
	color:#FFFFFF; 
	margin-left:auto; 
	margin-right:auto; 
	display:inline-block;
	cursor:pointer;
	float:left;
}
.stuwork a{ padding-left:28px;}
</style>
<script>
	function toUrl(url)
	{
		window.location.href = url;
	}
</script>

<body style="background-color:#FFFFFF; font-size:12px; color:#333333">

<div style="position:relative; margin-left:auto; margin-right:auto; width:1000px">
  <div style="position:relative; margin-left:auto; margin-right:auto; width:1000px">
    
    <div style="position:absolute; z-index:2;"><img src="images/r1_c1.jpg" /></div>
    <div style="position:absolute; left: 431px; top: 12px;z-index:2;"><img src="images/r2_c2.jpg" /></div>

    <div style="position:absolute; left: 382px; top: 107px; z-index:2;"><img src="images/r3_c2.jpg" /> </div>
    <div style="position:absolute; left: 0px; top: 107px; width:100%; height:289px; z-index:1; background-image:url(images/r3_c4.jpg)"></div>
    <div style="position:absolute; left: 572px; top: 217px; z-index:2;"><img src="images/r4_c6.jpg" /> </div>
    <div style=" height:200px; padding-left:300px; margin-top:500px; position:absolute; z-index:100; ">
      
         
    <div class="stuwork" onclick="toUrl('/stuwork-backmanage/index.action')"><a>后台管理系统</a></div>
    <div class="stuwork" onclick="toUrl('http://localhost:8080/stuwork-welnew/index.action')"><a>迎新管理系统</a></div>
    <div class="stuwork" onclick="toUrl('http://localhost:8080/stuwork-stuinfo/index.action')"><a>学生信息管理系统</a></div>
    <div class="stuwork" onclick="toUrl('http://localhost:8080/stuwork-archives/index.action')"><a>学生档案管理系统</a></div> 
      
    </div>
      
    </div>
    <div style="position:absolute; left: 189px; top: 642px;">地址:九华路9号  邮编:100084  电话查号台:0550-6732041<br/>
      管理员信箱:zbahstu@126.com<br/>
      文保网安备案号:1101080011</div>
  </div>
</body>

</html>
