//用于学员列表页 的级联查询取数据
$(document).ready(function() {
	
	$("#collegeselect").bind("change",function() {
		//取得学院下的专业
		var collegeCode = $("#collegeselect").val();
		if(collegeCode) {
			$.getJSON("../related/related!majorList.action",{"collegeCode":collegeCode},function(data) {
				$("#majorselect option[value!='']").remove();
				var majors = eval(data.majors);
				if(majors.length == 0) return;
				for(var i = 0 ;i < majors.length ; i++) {
					$("#majorselect").append("<option value='"+majors[i].code+"'>"+majors[i].name+"</option>");
				}
			});
		}else {
			$("#majorselect option[value!='']").remove();
		}
	});
	
	$("#majorselect").bind("change",function() {
		//取得专业下的班级
		var majorCode = $("#majorselect").val();
		if(majorCode) {
			$.getJSON("../related/related!clazzList.action",{"majorCode":majorCode},function(data) {
				$("#clazzselect option[value!='']").remove();
				var clazzs = eval(data.clazzs);
				if(clazzs.length == 0) return;
				for(var i = 0 ;i < clazzs.length ; i++) {
					$("#clazzselect").append("<option value='"+clazzs[i].code+"'>"+clazzs[i].name+"</option>");
				}
			});
		}else {
			$("#clazzselect option[value!='']").remove();
		}
	});
	
	$("#battalionselect").bind("change",function() {
		var battalionId = $("#battalionselect").val();
		if(battalionId) {
			$.getJSON("../related/related!getStudent.action",{"examineeNo":examineeNo},function(data) {
				$("#companyselect option[value!='']").remove();
				var tempcompany = eval(data.companys);
				if(tempcompany.length == 0) return;
				for(var i = 0 ;i < tempcompany.length ; i++) {
					$("#companyselect").append("<option value='"+tempcompany[i].id+"'>"+tempcompany[i].name+"</option>");
				}
			});
		}else {
			$("#companyselect option[value!='']").remove();
		}
	});
})