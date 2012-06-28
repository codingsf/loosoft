<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>  
<head>
<title>通知书预览</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/jscss.jsp" %> 
<style>  
	body   
	{  
	    font-size:12px;  
	    color:#333333;  
	    border : 0px solid blue;  
	}  
	.div1  
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 80px;  
	    height:10px;  
	}  
	.year  
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 15px;  
	    height:10px;  
	}  
	.luqu  
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 25px;  
	    height:10px;  
	}  
	.instutite 
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 120px;  
	    height:10px;  
	}  
	.company 
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 120px;  
	    height:10px;  
	}  
	.date 
	{  
	    position : absolute;  
	    background-color : #c3d9ff;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 45px;  
	    height:10px;  
	}  
	.div2  
	{  
	    position : absolute;  
	    margin : 0px;  
	    padding : 5px;  
	    border : 5px;  
	    width : 100px;  
	    height:10px;  
	}  
</style>  
</head>  
<body>  
<script> 


window.onload=function()//用window的onload事件，窗体加载完毕的时候
{
   
}


</script>  
<IMG id="image" src="../images/notice/${mn.imageName}" style="position:absolute; width:700px;" />

<div id="notice" class="div1" style="left:${mn.noticeMoveLeft};top:${mn.noticeMoveTop};">201110232</div>  
<div id="name" class="div1" style="left:${mn.nameMoveLeft};top:${mn.nameMoveTop};">张孟桐</div>
<div id="college" class="div1" style="left:${mn.collegeMoveLeft};top:${mn.collegeMoveTop};">电子信息</div>
<div id="major" class="instutite" style="left:${mn.majorMoveLeft};top:${mn.majorMoveTop};">电子技术与计算机科学</div>
<div id="year" class="year" style="left:${mn.yearMoveLeft};top:${mn.yearMoveTop};">四</div>
<div id="work" class="luqu" style="left:${mn.workMoveLeft};top:${mn.workMoveTop};">正取</div>
<div id="admit" class="company" style="left:${mn.admitMoveLeft};top:${mn.admitMoveTop};">中天科技集团有限公司</div>
<div id="startDate" class="date" style="left:${mn.startDateMoveLeft};top:${mn.startDateMoveTop};">8月20日</div>
<div id="endDate" class="date" style="left:${mn.endDateMoveLeft};top:${mn.endDateMoveTop};">9月20日</div>
<div id="xingMa" class="div1" style="left:${mn.xingMaMoveLeft};top:${mn.xingMaMoveTop};">条形码</div>



<script>  
drag("notice");  
drag("name");   
drag("college");  
drag("major");   
drag("year");  
drag("work");  
drag("admit");  
drag("startDate");  
drag("endDate");  
drag("xingMa"); 
</script>  
 
</body> 

</html>