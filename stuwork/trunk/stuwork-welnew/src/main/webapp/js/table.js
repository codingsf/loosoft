function jumpPage(pageNo){
	$("#pageNo").val(pageNo);
	if($("#mainForm"))$("#mainForm").submit();
	if($("#searchForm"))$("#searchForm").submit();
}

/**
 * wsr
 * @return
 */
function ortherJumpPage(pageNo){
	$("#ortherPageNo").val(pageNo);
	if($("#mainForm"))$("#mainForm").submit();
	if($("#searchForm"))$("#searchForm").submit();
}
	
function sort(orderBy,defaultOrder){
	if($("#orderBy").val()==orderBy){
		if($("#order").val()==""){
			$("#order").val(defaultOrder);}
			else if($("#order").val()=="desc"){
			$("#order").val("asc");}
			else if($("#order").val()=="asc"){
			$("#order").val("desc");}
		}
		else{
			$("#orderBy").val(orderBy);
			$("#order").val(defaultOrder);
		}
		if($("#mainForm"))$("#mainForm").submit();
		if($("#searchForm"))$("#searchForm").submit();
}


/**
 * 提交搜索查询
 * @return
 */
function search(){
	$("#order").val("");
	$("#orderBy").val("");
	$("#pageNo").val("1");
	
	$("#ortherOrder").val("");
	$("#ortherOrderBy").val("");
	$("#ortherPageNo").val("1");
	
	if($("#mainForm"))$("#mainForm").submit();
	if($("#searchForm"))$("#searchForm").submit();
}
/**
 * 打印
 * @return
 */
function execPrint(){
    bdhtml = window.document.body.innerHTML;
   sprnstr = "<!--startprint-->";
   eprnstr = "<!--endprint-->";
   prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
   prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
   window.document.body.innerHTML = prnhtml;
   window.print();

}
/**
 * 移动div
 * @return
 */
function moveDiv(id) {
        var o = document.getElementById(id);

        o.onselectstart = function() {
            return (true);
        };

        o.onmousedown = function(e) {
            e = e || window.event;
            var x = e.layerX || e.offsetX;
            var y = e.layerY || e.offsetY;

            document.onmousemove = function(e) {
                e = e || window.event;
                o.style.left = (e.clientX - x) + "px";
                document.getElementById(id + "Left").value = o.style.left;
                o.style.top = (e.clientY - y) + "px";
                document.getElementById(id + "Top").value = o.style.top;
            };

            document.onmouseup = function() {
                document.onmousemove = null;
            };
        };
    }


    //点击某个按钮即显示相对的文本边框变成红色 
    //以免过多产生混淆
    function ButtonMove(obj) {

       if(navigator.userAgent.indexOf("MSIE")>0) { 
  
            if (document.getElementById(obj).style.border == "#7f9db9 1px solid") {
                document.getElementById(obj).style.border = "solid 1px red";
                document.getElementById(obj).style.cursor = "move";
                

            } else {
                document.getElementById(obj).style.border = "solid 1px #7F9DB9";

            }
         
                }
  else  if (navigator.userAgent.indexOf("Firefox") > 0) {
       
       if (document.getElementById(obj).style.border == "1px solid rgb(127, 157, 185)") {
           document.getElementById(obj).style.border = "solid 1px red";
           document.getElementById(obj).style.cursor = "move";
           

       } else {
           document.getElementById(obj).style.border = "solid 1px #7F9DB9";
       

       }
   } 

   else{
       if (document.getElementById(obj).style.border == "#7f9db9 1px solid") {
           document.getElementById(obj).style.border = "solid 1px red";
           
           

       } else {
           document.getElementById(obj).style.border = "solid 1px #7F9DB9";


       }
   }

}
