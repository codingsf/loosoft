//用于学员列表页 的级联查询取数据
$(document).ready(function() {
	
	$("#collegeselect").bind("change",function() {
		//取得学院下的专业
		var collegeCode = $("#collegeselect").val();
		var collegeName =$("#collegeselect").find("option:selected").text();
		$("#collegeName").val(collegeName);
		if(collegeCode) {
			$.getJSON("../related/related!majorList.action",{"collegeCode":collegeCode},function(data) {
				$("#majorselect option[value!='']").remove();
				var majors = eval(data.majors);
				if(majors.length == 0) return;
				for(var i = 0 ;i < majors.length ; i++) {
					$("#majorselect").append("<option value='"+majors[i].code+"'>"+majors[i].code+"-"+majors[i].name+"</option>");
				}
			});
		}else {
			$("#majorselect option[value!='']").remove();
		}
	});
	
	$("#batchselect").bind("change",function() {
		//取得批次下的班级
		var comname = $("#batchselect").val();
		var majorCode=$("#majorselect").val()
		if(majorCode==""){
			alert('请先选择专业,在选批次');
			return;
		}
		//var majorName =$("#majorselect").find("option:selected").text();
		//$("#majorName").val(majorName);
		if(comname) {
			$.getJSON("../related/related!clazzList.action",{"comname":comname,"majorCode":majorCode},function(data) {
				$("#clazzlist").remove();
				var clazzs = eval(data.clazzs);
				if(clazzs.length == 0) return;
				$("#clazzdiv").append("<div id='clazzlist'></div>");
				for(var i = 0 ;i < clazzs.length ; i++) {
					//$("#clazzselect").append("<option value='"+clazzs[i].code+"'>"+clazzs[i].code+"-"+clazzs[i].name+"</option>");
					$("#clazzlist").append("<input type='checkbox' name='clazzCodeList' value='"+clazzs[i].code+"' />"+clazzs[i].name+"&nbsp;");
				}
			});
		}else {
			$("#clazzlist").remove();
		}
	});
	
	
	$("#clazzselect").bind("change",function() {
		//取得专业下的班级
		var className =$("#clazzselect").find("option:selected").text();
		$("#className").val(className);

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