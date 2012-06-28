<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>  
<head>
<title>通知书设置</title>
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

 
function drag(o,s)  
{  
    if (typeof o == "string") o = document.getElementById(o);  
    o.orig_x = parseInt(o.style.left) - document.body.scrollLeft;  
    o.orig_y = parseInt(o.style.top) - document.body.scrollTop;  
    o.orig_index = o.style.zIndex;  
          
    o.onmousedown = function(a)  
    {  
        this.style.cursor = "move";  
        this.style.zIndex = 10000;  
        var d=document;  
        if(!a)a=window.event;  
        var x = a.clientX+d.body.scrollLeft-o.offsetLeft;  
        var y = a.clientY+d.body.scrollTop-o.offsetTop;  
        //author: www.longbill.cn  
        d.ondragstart = "return false;"  
        d.onselectstart = "return false;"  
        d.onselect = "document.selection.empty();"  
                  
        if(o.setCapture)  
            o.setCapture();  
        else if(window.captureEvents)  
            window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);  

        d.onmousemove = function(a)  
        {  
            if(!a)a=window.event;  
            o.style.left = a.clientX+document.body.scrollLeft-x;  
            o.style.top = a.clientY+document.body.scrollTop-y;  
            o.orig_x = parseInt(o.style.left) - document.body.scrollLeft;  
            o.orig_y = parseInt(o.style.top) - document.body.scrollTop;  
        }  

        d.onmouseup = function()  
        {  
            if(o.releaseCapture)  
                o.releaseCapture();  
            else if(window.captureEvents)  
                window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);  
            d.onmousemove = null;  
            d.onmouseup = null;  
            d.ondragstart = null;  
            d.onselectstart = null;  
            d.onselect = null;  
            o.style.cursor = "normal";  
            o.style.zIndex = o.orig_index;  
            check(o);
        }  
    }  
      
    if (s)  
    {  
        var orig_scroll = window.onscroll?window.onscroll:function (){};  
        window.onscroll = function ()  
        {  
            orig_scroll();  
            o.style.left = o.orig_x + document.body.scrollLeft;  
            o.style.top = o.orig_y + document.body.scrollTop;  
        }  
    }  
}  

function check(o){
	var idLeft = o.id + 'MoveLeft';
	var idTop = o.id + 'MoveTop';
	document.getElementById(idLeft).value=o.style.left;
	document.getElementById(idTop).value=o.style.top;
}
function save(){
   alert("保存成功！");
} 
</script>  
<div id="message"><s:actionmessage theme="custom"
	cssClass="success" /></div>
<IMG id="image" src="../images/notice/${fileFileName}" style="position:absolute; width:700px;" />


<div id="divs1" class="div1" style="left:710px;top:40px;">通知书编号:</div>  
<div id="divs2" class="div1" style="left:710px;top:70px;">姓名:</div>
<div id="divs3" class="div1" style="left:710px;top:100px;">院系:</div>
<div id="divs4" class="div1" style="left:710px;top:130px;">专业:</div>
<div id="divs5" class="div1" style="left:710px;top:160px;">年制:</div>
<div id="divs6" class="div1" style="left:710px;top:190px;">录取形式:</div>
<div id="divs7" class="div1" style="left:710px;top:220px;">工作导向:</div>
<div id="divs8" class="div1" style="left:710px;top:250px;">录取开始时间:</div>
<div id="divs9" class="div1" style="left:710px;top:280px;">录取结束时间:</div>
<div id="divs10" class="div1" style="left:710px;top:310px;">条形码:</div>

<div id="notice" class="div1" style="left:810px;top:40px;">201110232</div>  
<div id="name" class="div1" style="left:810px;top:70px;">张孟桐</div>
<div id="college" class="div1" style="left:810px;top:100px;">电子信息</div>
<div id="major" class="instutite" style="left:810px;top:130px;">电子技术与计算机科学</div>
<div id="year" class="year" style="left:810px;top:160px;">四</div>
<div id="work" class="luqu" style="left:810px;top:190px;">正取</div>
<div id="admit" class="company" style="left:810px;top:220px;">中天科技集团有限公司</div>
<div id="startDate" class="date" style="left:810px;top:250px;">8月20日</div>
<div id="endDate" class="date" style="left:810px;top:280px;">9月20日</div>
<div id="xingMa" class="div1" style="left:810px;top:310px;">条形码</div>
<form action="${ctx}/noticeBook/notice-book!save.action" method="post" id="dataForm">

	<div>
		<input type="hidden" id="id" name="id" value="${id}"/><br/>
		<input type="hidden" id="image" name="image" value="${fileFileName}"/><br/>
		<input type="hidden" id="noticeMoveLeft" name="noticeMoveLeft"/>
		<input type="hidden" id="noticeMoveTop" name="noticeMoveTop"/><br/>
		<input type="hidden" id="nameMoveLeft" name="nameMoveLeft"/>
		<input type="hidden" id="nameMoveTop" name="nameMoveTop"/><br/>
		<input type="hidden" id="collegeMoveLeft" name="collegeMoveLeft"/>
		<input type="hidden" id="collegeMoveTop" name="collegeMoveTop"/><br/>
		<input type="hidden" id="majorMoveLeft" name="majorMoveLeft"/>
		<input type="hidden" id="majorMoveTop" name="majorMoveTop"/><br/>
		<input type="hidden" id="yearMoveLeft" name="yearMoveLeft"/>
		<input type="hidden" id="yearMoveTop" name="yearMoveTop"/><br/>
		<input type="hidden" id="workMoveLeft" name="workMoveLeft"/>
		<input type="hidden" id="workMoveTop" name="workMoveTop"/><br/>
		<input type="hidden" id="admitMoveLeft" name="admitMoveLeft"/>
		<input type="hidden" id="admitMoveTop" name="admitMoveTop"/><br/>
		<input type="hidden" id="startDateMoveLeft" name="startDateMoveLeft"/>
		<input type="hidden" id="startDateMoveTop" name="startDateMoveTop"/><br/>
		<input type="hidden" id="endDateMoveLeft" name="endDateMoveLeft"/>
		<input type="hidden" id="endDateMoveTop" name="endDateMoveTop"/><br/>
		<input type="hidden" id="xingMaMoveLeft" name="xingMaMoveLeft"/>
		<input type="hidden" id="xingMaMoveTop" name="xingMaMoveTop"/>
	</div>
	
	<div id="save" class="div2" style="left:710px;top:340px;">
		<input name="submitbut" type="submit" class="btn" value="确 定" onclick="save()"/>
	</div>
	
	
</form>

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