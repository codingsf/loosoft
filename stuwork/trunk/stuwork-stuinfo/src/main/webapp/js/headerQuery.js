$(document).ready(function() {
	$("#mainformreset").bind("click", function() {
			$("#resetbutton").click();
		}
	),
	$("#mainformsearch").bind("click", function () {
			$("#order").val("");
			$("#orderBy").val("");
			$("#pageNo").val("1");
			if($("#mainForm"))$("#mainForm").submit();
			if($("#searchForm"))$("#searchForm").submit();
		}
	)
})