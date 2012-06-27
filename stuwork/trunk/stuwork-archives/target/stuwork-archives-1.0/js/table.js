function jumpPage(pageNo){
	$("#pageNo").val(pageNo);
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