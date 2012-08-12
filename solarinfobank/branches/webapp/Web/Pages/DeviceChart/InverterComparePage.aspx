<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--
<%=Resources.SunResource.INVERTERCOMPAREPAGE_INVERTER_COMPARE_PAGE%></asp:Content>
-->
<style type="text/css">
    /*模拟对角线*/
    .out
    {
        border-top: 40px #F2F4E1 solid; /*上边框宽度等于表格第一行行高*/
        width: 0px; /*让容器宽度为0*/
        height: 0px; /*让容器高度为0*/
        border-left: 80px #F7F7F7 solid; /*左边框宽度等于表格第一行第一格宽度*/
        position: relative; /*让里面的两个子容器绝对定位*/
    }
    b
    {
        font-style: normal;
        display: block;
        position: absolute;
        top: -35px;
        left: -45px;
        width: 35px;
        text-align:right;
    }
    em
    {
        font-style: normal;
        display: block;
        position: absolute;
        top: -20px;
        left: -75px;
        width: 55px;
    }
</style>

<script type="text/javascript">
        function readyinit() {
            $('#DayChart').click(displayDayChart);
            $('#MonthChart').click(displayMonthChart);
            $('#YearChart').click(displayYearChart);
            currentSel="#unit"+$("#id").val();
            $(currentSel+"_link").attr("href","javascript:void(0);");
            var id = "unit" + $("#uid").val();
            $("#"+id+"_link").addClass("current");
            displayDayChart();
            $("#unit<%=(ViewData["plantUnit"] as PlantUnit).id%>").show();
        }
        
        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }
        
        var curChart;
        function largeicp() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containericp" });
            //yearCompareChart("large_containericp", 160, true);
            if (curChart == "MonthChart")
                monthCompareChart("large_containericp", 160, true);
            else if (curChart == "YearChart") {
                yearCompareChart("large_containericp", 160, true);
            } else if (curChart == "DayChart") {
                dayCompareChart("large_containericp", 160, true);
            } 
        }
        
        function displayDayChart() {
            $('#intervalMins').val(60);
            curChart = "DayChart";
            dayCompareChart("container_unit", 150, false);
            $("#monthdatatable").hide();
            $("#yeardatatable").hide(); 
            changeALT();
        }

        function displayMonthChart() {
            $('#intervalMins').val(60);
            curChart = "MonthChart";
            monthCompareChart("container_unit", 150, false);
            $("#daydatatable").hide();
            $("#yeardatatable").hide();                   
            $("#monthdatadiv").html($("#monthdatadiv_html").html());
            changeALT();
        }
        function displayYearChart() {
            $('#intervalMins').val(60);
            curChart = "YearChart";
            yearCompareChart("container_unit", 160, false);
            $("#daydatatable").hide();
            $("#monthdatatable").hide();              
            $("#yeardatadiv").html($("#yeardatadiv_html").html());
            changeALT();
        }

        function dayCompareChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("DayChart");
            //改变类型，因为切换到设备的运行时数据时被篡改了，这时要恢复
            $("#chartType").val("line");
            $.ajax({
                type: "POST",
                url: "/deviceChart/CompareDaykWpChartByUnit",
                data: { uId: $("#uid").val(), startYYYYMMDDHH: $("#unitstartYYYYMMDDHH").val(), endYYYYMMDDHH: $("#unitendYYYYMMDDHH").val(), chartType: $("#chartType").val(), intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        $("#daydatadiv").html($("#daydatadiv_html").html());
                        $("#chart_tip").hide();
                        return;
                    }
                    
                    var data = eval('(' + result + ')');
                    //显示详细数据要放到绘制图表前面否则，绘制图表后会修改数据，导致不正确
                    if(!isLarge){
                        $("#monthdatatable").hide();
                        $("#yeardatatable").hide();
                        $("#daydatatable").show();
                        appendDayData(data);
                    }  
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0,8),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge); 
                    defineChartWithDetail(curContainer,false);
                    showDetails(result, $("#endYYYYMMDDHH").val());
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });

                    $("#chart_tip").show();
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        
        function monthCompareChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthChart");
            //改变类型，因为切换到设备的运行时数据时被篡改了，这时要恢复
            $("#chartType").val("line");
            $.ajax({
                type: "POST",
                url: "/deviceChart/CompareMonthkWpChartByUnit",
                data: { uId: $("#uid").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        $("#monthdatadiv").html($("#monthdatadiv_html").html());
                        $("#chart_tip").hide();
                        return;
                    }             
                    showDetails(result, $("#endYYYYMMDD").val());
                    var data = eval('(' + result + ')')
                    //显示详细数据要放到绘制图表前面否则，绘制图表后会修改数据，导致不正确  
                    if(!isLarge){
                        $("#daydatatable").hide();
                        $("#yeardatatable").hide();
                        $("#monthdatatable").show();
                        appendMonthData(data);
                    } 
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0,6),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChartWithDetail(curContainer,false);//提上去有问题，每次都是前一次的图表
                    
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
      
                    $("#chart_tip").show();          
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
       }
        
       function yearCompareChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearChart");
            //改变类型，因为切换到设备的运行时数据时被篡改了，这时要恢复
            $("#chartType").val("line");
            $.ajax({
                type: "POST",
                url: "/deviceChart/CompareYearkWpChartByUnit",
                data: { uId: $("#uid").val(), startYYYYMM: $("#year").val()+'01', endYYYYMM: $("#year").val()+'12', chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        $("#yeardatadiv").html($("#yeardatadiv_html").html());
                        $("#chart_tip").hiden();
                        return;
                    }               
                    showDetails(result);
                    //defineChartWithDetail(curContainer,false);  
                    var data = eval('(' + result + ')');
                    //显示详细数据要放到绘制图表前面否则，绘制图表后会修改数据，导致不正确  
                    if(!isLarge){
                        $("#daydatatable").hide();
                        $("#monthdatatable").hide();
                        $("#yeardatatable").show();
                        appendYearData(data);
                    }   
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val(),data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChartWithDetail(curContainer,false);//提上去有问题，每次都是前一次的图表,但是以前为何要提上去呢，忘了是啥原因
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    if(!isLarge){
                        $("#daydatatable").hide();
                        $("#monthdatatable").hide();
                        $("#yeardatatable").show();
                        appendYearData(data);
                    }   
                    $("#chart_tip").show();
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        var myDate = new Date(<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Year%>,<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Month%>
                    ,<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Day%>,<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Hour%>
                    ,<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Minute%>,<%=CalenderUtil.curDateWithTimeZone(Model.timezone).Second%>);
        function appendDayData(data){
            if(data.series.length<1) return;
            var selectDate = $("#startYYYYMMDDHH").val().substring(0,8);
            var curDate = $("#YYYYMMDD").val();
            $("#daydatadiv").html($("#daydatadiv_html").html());
            document.getElementById("daydatatable").border="1";
            //取得平均值数组
            var averageArr = data.series[data.series.length-1].data;
            for(var i=0;i<data.series.length;i++ ){
                var onedataArr = data.series[i].data;
                var pos = data.series[i].name.indexOf("[");
                var name =data.series[i].name.substring(0,pos);
                var trhtml="<tr><td height='22' bgcolor='#F7F7F7' class='line_b' title='"+name+"'>"+(name.length>15?(name.substring(0,15)+'..'):name)+"</td>";
                var h = myDate.getHours()-6;
                var bgcolor ="";
                if(i%2==1)bgcolor="#F7F7F7";
                for(var k=0;k<onedataArr.length;k++){
                    if(curDate<selectDate){
                        trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>&nbsp;</td>"
                        continue;
                    }
                    if(k<=h||curDate>selectDate){
                        if(onedataArr[k]==null || onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>None</td>"
                        else{
                            if(onedataArr[k]>(averageArr[k]*1.2+0.02)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8-0.02)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F' align='center'><span>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</td>"
                            } 
                        }
                    }else{
                        if(onedataArr[k]==null || onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>None</td>"
                        else{
                            if(onedataArr[k]>(averageArr[k]*1.2+0.02)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8-0.02)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F' align='center'><span>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</td>"
                            } 
                       }
                    }
                }                     
                trhtml+="</tr>";
                $("#daydatatable").append(trhtml) 
            }
        }
        
        function appendMonthData(data){
            if(data.series.length<1) return;
            var selectDate = $("#startYYYYMMDD").val().substring(0,6);
            var curDate = $("#month").val();

            //取得平均值数组
            var averageArr = data.series[data.series.length-1].data;

            for(var i=0;i<data.series.length;i++ ){
                var onedataArr = data.series[i].data;
                var pos = data.series[i].name.indexOf("[");
                var name =data.series[i].name.substring(0,pos);
                var trhtml="<tr><td height='22' bgcolor='#F7F7F7' class='line_b' title='"+name+"'>"+(name.length>15?(name.substring(0,15)+'..'):name)+"</td>";
                var bgcolor ="";
                var d = myDate.getDate();
                if(i%2==1)bgcolor="#F7F7F7";
                if(i==0){
                    for(var k=31;k>onedataArr.length;k--){
                        $("#col"+k).hide();
                    }
                }
                for(var k=0;k<onedataArr.length;k++){
                    if(curDate<selectDate){
                        trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                        continue;
                    }
                    if(k<d || curDate>selectDate){
                        if(onedataArr[k]==null|| onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>&nbsp;None&nbsp;</td>"
                        else{
                            if(onedataArr[k]>(averageArr[k]*1.2+0.02)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8-0.02)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F;' align='center'><span>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</td>"
                            } 
                        }
                    }else{
                       if(onedataArr[k]==null || onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>None</td>"
                       else{
                            if(onedataArr[k]>(averageArr[k]*1.2+0.02)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8-0.02)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F;' align='center'><span>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</td>"
                            } 
                        }
                    }
                }                     
                trhtml+="</tr>";
                $("#monthdatatable").append(trhtml) 
            }
        }
        function appendYearData(data){
            if(data.series.length<1) return;
            var selectDate = $("#year").val();
            var curDate = myDate.getFullYear();
            //取得平均值数组
            var averageArr = data.series[data.series.length-1].data;
            for(var i=0;i<data.series.length;i++ ){
                var onedataArr = data.series[i].data;
                var pos = data.series[i].name.indexOf("[");
                var name =data.series[i].name.substring(0,pos);
                var trhtml="<tr><td height='22' bgcolor='#F7F7F7' class='line_b' title='"+name+"'>"+(name.length>15?(name.substring(0,15)+'..'):name)+"</td>";
                var bgcolor ="";
                var m = myDate.getMonth();
                if(i%2==1)bgcolor="#F7F7F7";
                for(var k=0;k<onedataArr.length;k++){
                    if(curDate<selectDate){
                        trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                        continue;
                    }
                    if(k<m || curDate>selectDate){
                        if(onedataArr[k]==null || onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>&nbsp;None&nbsp;</td>"
                        else{
                            if(onedataArr[k]>(averageArr[k]*1.2+0.02)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8-0.02)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F' align='center'><span>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1")+"</td>"
                            }          
                        }
                    }else{
                       if(onedataArr[k]==null || onedataArr[k]>1.1)
                            trhtml+="<td class='line_b' style='color:#FF6A6A;background-color:"+bgcolor+"' align='center'>None</td>"
                       else{                    
                            if(onedataArr[k]>(averageArr[k]*1.2)){
                                trhtml+="<td class='line_b' style='background-color:#6495ED' align='center'><span style='color:white;'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else if(onedataArr[k]<(averageArr[k]*0.8)){
                                trhtml+="<td class='line_b' style='background-color:#FFDB2F' align='center'><span'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</span></td>"
                            }else{
                                trhtml+="<td class='line_b' style='background-color:"+bgcolor+"' align='center'>"+(onedataArr[k]==null?'&nbsp;&nbsp;&nbsp;&nbsp;':onedataArr[k].toString().replace(/^(\d+\.\d{2})\d*$/, "$1 "))+"</td>"
                            } 
                       }
                    }
                }                     
                trhtml+="</tr>";
                $("#yeardatatable").append(trhtml) 
            }
        }        
        
        function changeStyle(curId) {
       
            $("#MonthChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#DayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");
            $("#date_MonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_DayChart").hide();
            $("#date_" + curId).show();
        }
         function changePreDay(obj) {
            var d = obj.value;
            var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
            nextDay.setDate(nextDay.getDate() + 1);
            var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth()+1) + "-" + addZero(nextDay.getDate());
            $("#t").val(temp);
            changeDay(document.getElementById('t'));
        }
        
        
        function changeDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#unitstartYYYYMMDDHH").val(aimDay + "06")
            $("#unitendYYYYMMDDHH").val(aimDay + "20")
            displayDayChart();
              aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            $("."+obj.id).val(aimDay);   
        }

        function changeYear(obj) {
            $("#year").val(obj.value)
            displayYearChart();
        }
        
        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            $("#startYYYYMMDD").val(selectyear + selectmonth + "01")
            $("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
            displayMonthChart();
        }
        
        function PreviouNextChange(oper) {
            if (curChart == "DayChart") {
                changeDate(oper, "t");
                changeDay(document.getElementById("t"));
            }
            if (curChart == "MonthChart") {
                changeShowMonth(oper, "selectmonth", "selectyear");
                changeMonth();
            }
            if (curChart == "YearChart") {
                changeShowYear(oper, "selectYear1")
                changeYear(document.getElementById("selectYear1"));
            }
        }
</script>
<input type="hidden" value="<%=(ViewData["plantUnit"] as PlantUnit).id%>" id="uid" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy")%>" id="year" />
<input type="hidden" value="<%=ChartType.line %>" id="chartType" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>"
    id="month" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="YYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>06"
    id="unitstartYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>20"
    id="unitendYYYYMMDDHH" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")%>01"
    id="startYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMM")+CalenderUtil.getCurMonthDays(Model.timezone)%>"
    id="endYYYYMMDD" />
    
<input type="hidden" value="60" id="intervalMins" />


<%--<div class="subrbox03">
		  
</div>--%>
		
<div class="subrbox01">
   <div class="bitab">
        <ul id="bitab">
            <li><a href="javascript:void(0);" class="onclick" onclick="loadInvertCompare(1);" >
                <%=Resources.SunResource.DEVICETYPE_1 %></a></li>
                <%if (bool.Parse(ViewData["hashlx"].ToString()))
                  { %>
            <li><a href="javascript:void(0);" onclick="loadInvertCompare(2);">
                <%=Resources.SunResource.DEVICETYPE_3%></a></li>
                <%} %>
        </ul>
    </div>
  
    <div class="sb_mid">
        <div class="subico01">
            <ul id="change">
                <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript:void(0)">
                    <%=Resources.SunResource.PLANT_OVERVIEW_DAY%></a></li>
                <li style="cursor: pointer;"><a id="MonthChart" class="noclick" href="javascript:void(0)">
                    <%=Resources.SunResource.PLANT_OVERVIEW_MONTH%></a></li>
                <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0)">
                    <%=Resources.SunResource.PLANT_OVERVIEW_YEAR%></a></li>
            </ul>
        </div>
        <div class="z_big">
            <a id="toLargeChart" href="javascript:void(0)" onclick="largeicp()" onfocus="javascript:this.blur();">
            </a>
        </div>
        <div class="chart">
            <div class="chart_box">
                <div id="chartDiv">
                    <div id='container_unit' style='width: 100%; height: 550px; margin-left: 2px; margin-right: 2px;'>
                    </div>
                </div>
                <div id="chart_tip" style="display: none; margin-left: 20px;">
                    <%=Resources.SunResource.CHART_HIDDEN_TIP%></div>
                <div style="display: none">
                    <center>
                        <div id='large_containericp' style="width: 90%; height: 650px; margin-left: 50px;
                            margin-right: 50px; text-align:center;">
                        </div>
                    </center>
                </div>
                <div class="date_sel">
                    <div id="selectTable" style="margin-top: 20px;">
                        <table border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="24">
                                    <img src="/images/chartLeft.gif" width="24" height="21" onclick="PreviouNextChange('left')"
                                        style="cursor: pointer;" id="left" />
                                </td>
                                <td>
                                    <div id="date_DayChart">
                                        <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                            readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
                                            style="text-align: center;" />
                                        <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                        <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                                    </div>
                                    <div id="date_YearChart" style="display: none;">
                                        <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                    </div>
                                    <div id="date_MonthChart" style="display: none;">
                                        <div style="float: left;">
                                            <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:65px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                        </div>
                                        <div style="float: right;">
                                            <select style="width: 65px;" onchange="changeMonth(this)" id="selectmonth">
                                                <%
                                                    for (int i = 1; i <= 12; i++)
                                                    {
                                                        if (i == int.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone, "MM")))
                                                        {
                                                %>
                                                <option value="<%=i.ToString("00")%>" selected="selected">
                                                    <%=i.ToString("00")%></option>
                                                <%}
                                                            else
                                                            { %>
                                                <option value="<%=i.ToString("00")%>">
                                                    <%=i.ToString("00")%></option>
                                                <%}
                                                        }%>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                                <td width="24">
                                    <img src="/images/chartRight.gif" width="24" height="21" onclick="PreviouNextChange('right')"
                                        style="cursor: pointer;" id="right" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="chart_down">
            </div>
        </div>
        <!-- count data-->
        <div style="padding: 20px 0px; width: 730px; overflow: auto;" id="countDataDiv">
            <div id="daydatadiv">
            </div>
            <div id="daydatadiv_html" style="display: none;">
                <table width="100%" border="0" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0"
                style="color: #525252; border-collapse: collapse;" id="Table1">
                <tr>
                    <td colspan="10" width="8%" height="25" style="border:none">
                        <%=Resources.SunResource.INVEST_INCOME_COMPARE_CHART_TWO%>
                    </td>
                </tr>
                </table>
                <table width="100%" border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0"
                    style="color: #525252; border-collapse: collapse;" id="daydatatable">
                    <tr>
                        <td width="8%" height="24" bgcolor="#F2F4E1" class="line_b">
                            <div class="out">
                                <b>
                                    <%=Resources.SunResource.CUSTOMREPORT_TIME %></b> <em>
                                        <%=Resources.SunResource.CUSTOMREPORT_DEVICE %></em>
                            </div>
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            6:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            7:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            8:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            9:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            10:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            11:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            12:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            13:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            14:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            15:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            16:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            17:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            18:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            19:00
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b">
                            20:00
                        </td>
                    </tr>
                </table>
            </div>
            <div id="monthdatadiv">
            </div>
            <div id="monthdatadiv_html" style="display: none;">
                <!--
               <table border="0" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0" style="color: #525252;
                border-collapse: collapse;" id="Table2">
                   <tr>
                   <td colspan="10" width="8%" height="25">
                   <%=Resources.SunResource.INVEST_INCOME_COMPARE_CHART_TWO%>
                   </td>
                   </tr>
               </table>
               -->
                <table border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0" style="color: #525252;
                    border-collapse: collapse;" id="monthdatatable">
                    <tbody>
                        <tr>
                          <td width="8%" height="24" bgcolor="#F2F4E1" class="line_b">
                            <div class="out">
                            <b><%=Resources.SunResource.CUSTOMREPORT_TIME %></b>
                            <em><%=Resources.SunResource.CUSTOMREPORT_DEVICE %></em>
                            </div>
                          </td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;5&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;6&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;7&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;8&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;&nbsp;9&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;10&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;11&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;12&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;13&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;14&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;15&nbsp;&nbsp;&nbsp;</td>   
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;16&nbsp;&nbsp;&nbsp;</td>                                                                                                                                                 
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;17&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;18&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;19&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;20&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;21&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;22&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;23&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;24&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;25&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;26&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center>&nbsp;&nbsp;&nbsp;27&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center id="col28">&nbsp;&nbsp;&nbsp;28&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center id="col29">&nbsp;&nbsp;&nbsp;29&nbsp;&nbsp;&nbsp;</td>
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center id="col30">&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;</td> 
                          <td width="3%" height="24" bgcolor="#F2F4E1" class="line_b" align=center id="col31">&nbsp;&nbsp;&nbsp;31&nbsp;&nbsp;&nbsp;</td> 
                        </tr>    
                        </tbody>
                </table>
            </div>
            <div id="yeardatadiv">
            </div>
            <div id="yeardatadiv_html" style="display: none;">
                <!--
                <table width="100%" border="0" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0"
                style="color: #525252; border-collapse: collapse;" id="Table3">
                    <tr>
                        <td colspan="10" width="8%"  height="25" style="border:none">
                            <%=Resources.SunResource.INVEST_INCOME_COMPARE_CHART_TWO%>
                        </td>
                    </tr>
                </table>
                 -->
                <table width="100%" border="1" bordercolor="#A8A8A8" cellpadding="0" cellspacing="0"
                    style="color: #525252; border-collapse: collapse;" id="yeardatatable">
                    <tr>
                        <td width="8%" height="24" bgcolor="#F2F4E1" class="line_b">
                            <div class="out">
                                <b>
                                    <%=Resources.SunResource.CUSTOMREPORT_TIME %></b> <em>
                                        <%=Resources.SunResource.CUSTOMREPORT_DEVICE %></em>
                            </div>
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            1
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            2
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            3
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            4
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            5
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            6
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            7
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            8
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            9
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            10
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            11
                        </td>
                        <td width="6%" height="24" bgcolor="#F2F4E1" class="line_b" align="center">
                            12
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="padding-top: 5px;">
            <span style="background-color: #FF6A6A; width: 30px; padding-left: 15px">&nbsp;</span>
            &nbsp;<%=Resources.SunResource.NODATA%>
            &nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #6495ED; width: 30px; padding-left: 15px">&nbsp;</span>&nbsp;<%=Resources.SunResource.ABOVEAVERAGE%>&nbsp;20%
            &nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #FFDB2F; width: 30px; padding-left: 15px;">&nbsp;</span>&nbsp;<%=Resources.SunResource.BELOWAVERAGE%>&nbsp;20%
        </div>
    </div>
    <div class="sb_down">
    </div>
</div>
<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_DEVICE_LIST %>'</script>
