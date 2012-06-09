function jumpPage(pageNo){
	$("#pageNo").val(pageNo);
	$("#searchForm").submit();
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
		$("#searchForm").submit();
}

function search(){
	$("#order").val("");
	$("#orderBy").val("");
	$("#pageNo").val("1");
	$("#searchForm").submit();
}