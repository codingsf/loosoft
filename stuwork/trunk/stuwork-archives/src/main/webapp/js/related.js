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
		var majorName =$("#majorselect").find("option:selected").text();
		$("#majorName").val(majorName);
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
	
	
	$("#areaselect").bind("change",function() {
		//取得区域下的排
		var area = $("#areaselect").val();
		var areaText =$("#areaselect").find("option:selected").text(); 
		$("#areaText").val(areaText);	
		if(area) {
			$.getJSON("../store/storechange!rankList.action",{"areaValue":areaText},function(data) {
				$("#rankselect option[value!='']").remove();
				var areaJson = eval(data.rank);
				if(areaJson.length == 0) return;
				for(var i = 0 ;i < areaJson.length; i++) {
					$("#rankselect").append("<option value='"+areaJson[i].rank+"'>"+areaJson[i].rank+"</option>");
				}
			});
		}else {
			$("#rankselect option[value!='']").remove();
		}
	});
	
	
	$("#rankselect").bind("change",function() {
		//取得排下的行
		var rankText =$("#rankselect").val();
		var areaText =$("#areaselect").find("option:selected").text();
		$("#rankText").val(rankText);
		if(rankText) {
			$.getJSON("../store/storechange!rowList.action",{"areaValue":areaText,"rankValue":rankText},function(data) {
				$("#rowselect option[value!='']").remove();
				
				var rowcolumnJson = eval(data.row);
				if(rowcolumnJson.length == 0) return;
				for(var i = 0 ;i < rowcolumnJson[0].storow; i++) {
					$("#rowselect").append("<option value='"+rowcolumnJson[0].storow+"'>"+parseInt(i+1)+"</option>");
				}
			});
		}else {
			$("#rowselect option[value!='']").remove();
		}
	});
	
	
	$("#rowselect").bind("change",function() {
		//取得行下的列
		var columnValue = $("#rowselect").val();
		var areaText =$("#areaselect").find("option:selected").text();
		var rankText =$("#rankselect").val();
		var rowText =$("#rowselect").find("option:selected").text();
		$("#rowText").val(rowText);
		if(columnValue) {
			$.getJSON("../store/storechange!columnList.action",{"areaValue":areaText,"rankValue":rankText,"rowValue":columnValue},function(data) {
				$("#columnselect option[value!='']").remove();
				
				var rowcolumnJson = eval(data.column);
				if(rowcolumnJson.length == 0) return;
				for(var i = 0 ;i < rowcolumnJson[0].stocolumn; i++) {
					$("#columnselect").append("<option value='"+rowcolumnJson[0].id+"'>"+parseInt(i+1)+"</option>");
				}
			});
		}else {
			$("#columnselect option[value!='']").remove();
		}
	});
	
	$("#columnselect").bind("change",function() {
		//取得列的文本赋值
		var columnText =$("#columnselect").find("option:selected").text(); 
		$("#columnText").val(columnText);
		
	});
})