//显示查看报表的时间选择框
function showTimeDIV() {
    var tId = $("#tId").val();
    if ($("#pre").val() == "pre") {
        $("#dload").hide();
    } else {
        $("#dload").show();
    }
    if (tId == 1) {
        $("#date_DayChart").show();
    }
    else if (tId == 2) {
        $("#date_weekChart").show();
        $("#date_weekChart1").show();
    }
    else if (tId == 3) {
        $("#date_MonthDDChart").show();
        $("#date_MonthDDChart1").show();
    }
    else if (tId == 4) {
        $("#date_YearMMChart").show();
        $("#date_YearMMChart1").show();
    } else {
        $("#Div1").hide();
        $("#date_select_div").hide();
    }
}
function downLoadReports() {
    window.location.href = "/DataDownLoad/DownLoadReport/" + $("#plantId").val() + "?reportId=" + $("#reportId").val() + "&cTime=" + $("#time").val();
}

//改变天
function changeDay(obj) {
    var aimDay = obj.value;
    if (aimDay) {
        aimDay = aimDay.replace("-", "").replace("-", "");
    }
    document.getElementById("time").value = document.getElementById("t").value;

    if ($("#pre").val() == "preview") {
        document.getElementById("mainFrame").contentWindow.viewPreview('itemName', 'reportType', $("#time").val());
    } else {
        window.location.href = "/reports/ViewReport/?rId=" + $("#reportId").val() + "&cTime=" + $("#time").val() + "&tId=" + $("#tId").val() + "&pId=" + $("#plantId").val();
    }
}

//改变周
function changeWeek(obj) {
    var aimDay = obj.value;
    $("#time").val(aimDay);
    if ($("#pre").val() == "preview") {
        document.getElementById("mainFrame").contentWindow.viewPreview('itemName', 'reportType', $("#time").val());
    } else {
        window.location.href = "/reports/ViewReport/?rId=" + $("#reportId").val() + "&cTime=" + $("#time").val() + "&tId=" + $("#tId").val() + "&pId=" + $("#plantId").val();
    }
}

//改变单纯的年度
function changeYear(obj) {
    $("#time").val(obj.value);
    if ($("#pre").val() == "preview") {
        document.getElementById("mainFrame").contentWindow.viewPreview('itemName', 'reportType', $("#time").val());
    } else {
        window.location.href = "/reports/ViewReport/?rId=" + $("#reportId").val() + "&cTime=" + $("#time").val() + "&tId=" + $("#tId").val() + "&pId=" + $("#plantId").val();
    }
}

//改变月份
function changeMonth(obj) {

    var selectyear = $("#selectyear").val();
    var selectmonth = obj.value;
    $("#time").val(selectyear + "-" + selectmonth);
    if ($("#pre").val() == "preview") {
        document.getElementById("mainFrame").contentWindow.viewPreview('itemName', 'reportType', $("#time").val());
    } else {
        window.location.href = "/reports/ViewReport/?rId=" + $("#reportId").val() + "&cTime=" + $("#time").val() + "&tId=" + $("#tId").val() + "&pId=" + $("#plantId").val();
    }
}
//改变月年
function changeMonthYear(obj) {
    var selectyear = obj.value;
    var selectmonth = $("#selectmonth").val();
    $("#time").val(selectyear + "-" + selectmonth);
    if ($("#pre").val() == "preview") {
        document.getElementById("mainFrame").contentWindow.viewPreview('itemName', 'reportType', $("#time").val());
    } else {
        window.location.href = "/reports/ViewReport/?rId=" + $("#reportId").val() + "&cTime=" + $("#time").val() + "&tId=" + $("#tId").val() + "&pId=" + $("#plantId").val();
    } 
}

//左右切换
function PreviouNextChange(oper) {
    if ($("#tId").val() == 1) {
        changeDate(oper, "t");
        changeDay(document.getElementById("t"));
    }
    if ($("#tId").val() == 2) {
        changeDate(oper, "t1");
        changeWeek(document.getElementById("t1"));
    }
    if ($("#tId").val() == 3) {
        changeShowMonth(oper, "selectmonth", "selectyear");
        changeMonth(document.getElementById("selectmonth"));
    }
    if ($("#tId").val() == 4) {
        changeShowYear(oper, "selectYear1")
        changeYear(document.getElementById("selectYear1"));
    }
}