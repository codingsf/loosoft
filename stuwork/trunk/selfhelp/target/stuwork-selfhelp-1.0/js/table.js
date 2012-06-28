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