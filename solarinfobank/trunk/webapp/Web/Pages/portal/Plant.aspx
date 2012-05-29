<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=ProtalUtil.isAutoLogin?"电站信息":"电站单元" %>
        <%=Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />
    <link href="/style/mhcss.css" rel="stylesheet" type="text/css" />
    <style> #structimg{ border:none;}</style>
    <script src="/script/jquery.js" type="text/javascript"></script>

    <script type="text/javascript" charset="utf-8" src="/script/jquery.hoverIntent.minified.js"></script>

    <script type="text/javascript" charset="utf-8" src="/script/jquery.bgiframe.min.js"></script>

    <!--[if IE]>
    <SCRIPT type="text/javascript" charset="utf-8" src="/script/excanvas.js"></SCRIPT>
    <![endif]-->

    <script type="text/javascript" charset="utf-8" src="/script/jquery.bt.min.js"></script>

    <!-- /STUFF -->
    <!-- cool easing stuff for animations -->

    <script type="text/javascript" charset="utf-8" src="/script/jquery.easing.1.3.js"></script>

    <script type="text/javascript">
        var exportXlsTitle = "<%=Resources.SunResource.CHART_EXPORT_XLS%>";
        var exportCsvTitle = "<%=Resources.SunResource.CHART_EXPORT_CSV%>";
        var exportPdfTitle = "<%=Resources.SunResource.CHART_EXPORT_PDF%>";
        var infoTitle = "<%=Resources.SunResource.CHART_EXPORT_DATA%>";
        var largeButtonTitle = "<%=Resources.SunResource.LARGEBUTTONTITLE %>"
        var exportButtonTitle = "<%=Resources.SunResource.EXPORTBUTTONTITLE %>"
        //请求预览
        function previewReports(userId, curContainer, dataitems, repType, rName, vTime, PlantId) {
            $("#outpreview").colorbox({ width: "100%", inline: true, href: "#large_container" });
            document.getElementById("outpreview").click();
            $.ajax({
                type: "POST",
                url: "/Reports/PreviewReport",
                data: "userId=" + userId + "&dataItem=" + dataitems + "&tId=" + repType + "&rName=" + rName + "&cTime=" + vTime + "&plantId=" + PlantId,
                success: function(result) {
                    $("#" + curContainer).html(result)
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../images/ajax_loading.gif\" style=\"margin-top: " + 150 + "px;\" /></center>");
                }
            });
        }
        //查看大图
        function previewImage(picname) {
            $.colorbox({ href: picname });
            //$("#outpreview").colorbox({ width: "100%", inline: true, href: "#image_container" });
            //document.getElementById("outpreview").click();
            //$('#image_container').html("<center><img src='"+picname+"' style='z-index:400000' /></center>")
        }

        //预览图表
        function displayChart(id, userId, plantId, customType, groupId,
                        productName, reportName, timeSlot, tcounter, timeInterval,
                        product, times, ProIdType, valueType, units,
                        cVal, productList, selTimes, startTime, endTime) {
            $("#outpreview").colorbox({ width: "100%", inline: true, href: "#large_container" });
            document.getElementById("outpreview").click();
            var ajaxImgTop = 90;
            $.ajax({
                type: "POST",
                url: "/CustomReport/Preview",
                data: { id: id, userId: userId, plantId: plantId,
                    customType: customType, groupId: groupId, productName: productName,
                    reportName: reportName, timeSlot: timeSlot, tcounter: tcounter,
                    timeInterval: timeInterval, product: product, times: times
                    , ProIdType: ProIdType, valueType: valueType, units: units
                    , cVal: cVal, productList: productList, selTimes: selTimes,
                    startTime: startTime, endTime: endTime
                },
                success: function(result) {
                    if (appendChartError("large_container", result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setyAxis(data);
                    setySeriesArr(data.series);
                    //var interval = 12;
                    //setCategoriesWithInterval(data.categories, true, interval);
                    setCategories(data.categories, true);
                    defineChart("large_container");
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#large_container').empty();
                    $('#large_container').append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        //ifame自适应高度,被包含的页面，内部有影响页面长度的要在页面中完成操作好再次调用这个方法。如:parent.iFrameHeight();
        function iFrameHeight() {
            //set current page title 
            document.title = (document.getElementById('mainFrame').contentWindow.document.title);
            var ifm = document.getElementById("mainFrame");
            var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }

        //弹出提示层
        function tips(id) {
            var newid = id;
            if (id.indexOf("-1") > -1) newid = id.substring(0, id.indexOf("-1"));
            $('#' + newid + '-content').hide();
            $('#' + id).bt({ contentSelector: "$('#" + newid + "-content').html()", /*get text of inner 
                content of hidden div*/
                width: 200, fill: 'white', strokeWidth: 1, /*no stroke*/strokeStyle: '#118529',
                spikeLength: 30, spikeGirth: 30, padding: 0, cornerRadius: 10, positions: ['top'],
                cssStyles: { fontFamily: '"lucida grande",tahoma,verdana,arial,sans-serif', fontSize: '15px' }
            });

        }
        $(document).ready(function() {
            var imgwidth = $("#structimg").attr("width");
            $("#planetmap").css("left", (635 - imgwidth) / 2);
            $("#planetmap").css("width", imgwidth);
        });
        
    </script>

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

    <script src="/script/Highcharts-2.1.3/js/modules/exporting.src.js" type="text/javascript"></script>

    <script src="/Script/SetChart.js" type="text/javascript"></script>

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <script type="text/javascript">

        function readyinit() {
            $('#DayChart').click(displayDayChart);
            $('#MonthChart').click(displayMonthDDChart);
            $('#YearChart').click(displayyearMMChart);
            $('#TotalChart').click(displayyearChart);
            displayDayChart();
        }

        function changeALT() {
            var ImageButtonLeft = document.getElementById("left");
            var ImageButtonRight = document.getElementById("right");
            ImageButtonLeft.title = "<%=Resources.SunResource.IMAGE_BUTTON_PREVIOUS%>";
            ImageButtonRight.title = "<%=Resources.SunResource.IMAGE_BUTTON_NEXT%>";
        }

        function displayDayChart() {
            $("#intervalMins").val($("#intervalSelect").val());
            curChart = "DayChart";
            dayChart("container", 70, false);
            $("#countDataDiv").empty();
            changeALT();
        }
        function displayMonthDDChart() {
            curChart = "MonthChart";
            monthChart("container", 70, false);
            $("#countDataDiv").empty();
            changeALT();
        }

        function displayyearMMChart() {
            curChart = "YearChart";
            yearChart("container", 70, false);
            $("#countDataDiv").empty();
            changeALT();
        }

        function displayyearChart() {
            curChart = "TotalChart";
            totalChart("container", 70, false);
            $("#countDataDiv").empty();
        }

        function showDetails(data, date) {
            h_data = data;
            h_date = date;
        }

        function loadCountData() {
            $("#countDataDiv").empty();
            $("#countDataDiv").html('<img src="/Images/ajax_loading_min.gif" style="margin-left:350px;" />');
            $.ajax({
                type: "GET",
                url: "/plant/PowerCount/?" + new Date().getMilliseconds(),
                data: { random: new Date().getMilliseconds(), id: $("#pid").val(), startYYYYMMDDHH: $("#endYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val() },
                success: function(result) {
                    $('#countDataDiv').empty();
                    $('#countDataDiv').html(result);
                }
            });
        }

        var curChart;
        function large() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_container_chart" });
            if (curChart == "MonthChart")
                monthChart("large_container_chart", 130, true);
            else if (curChart == "YearChart") {
                yearChart("large_container_chart", 130, true);
            } else if (curChart == "TotalChart") {
                totalChart("large_container_chart", 130, true);
            } else
                dayChart("large_container_chart", 130, true);
        }

        function monthChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("MonthChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/PlantMonthDDChart",
                data: { id: $("#pid").val(), startYYYYMMDD: $("#startYYYYMMDD").val(), endYYYYMMDD: $("#endYYYYMMDD").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDD").val().substring(0, 6) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result, $("#startYYYYMMDD").val());

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function yearChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("YearChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantYearMMChart",
                data: { id: $("#pid").val(), year: $("#year").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#year").val() + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result, $("#year").val());

                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function totalChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("TotalChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantYearChart",
                data: { id: $("#pid").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "" + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    showDetails(result);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function dayChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("DayChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/PlantDayChart",
                data: { pid: $("#pid").val(), startYYYYMMDDHH: $("#startYYYYMMDDHH").val(), endYYYYMMDDHH: $("#endYYYYMMDDHH").val(), chartType: 'area', intervalMins: $("#intervalMins").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, $("#startYYYYMMDDHH").val().substring(0, 8) + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    var intervalMins = $("#intervalMins").val();

                    var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
                    setCategoriesWithInterval(data.categories, isLarge, interval);
                    defineChart(curContainer);
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                    showDetails(result, $("#startYYYYMMDDHH").val());
                    //天数据统计加载
                    loadCountData();
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        function changeStyle(curId) {
            clearDetails();
            $("#MonthChart").attr("class", "noclick");
            $("#YearChart").attr("class", "noclick");
            $("#TotalChart").attr("class", "noclick");
            $("#DayChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");

            $("#date_MonthChart").hide();
            $("#date_YearChart").hide();
            $("#date_DayChart").hide();
            $("#date_" + curId).show();
            if (curId == "TotalChart") {
                document.getElementById("date_select_div").style.display = "none";
            } else {
                document.getElementById("date_select_div").style.display = "block";
            }
        }
        function addZero(val) {
            return val < 10 ? "0" + val : val;
        }
        function changePreDay(obj) {
            var d = obj.value;
            var nextDay = new Date(Date.parse(d.replace(/-/g, "/")));
            nextDay.setDate(nextDay.getDate() + 1);
            var temp = nextDay.getFullYear() + "-" + addZero(nextDay.getMonth() + 1) + "-" + addZero(nextDay.getDate());
            $("#t").val(temp);
            changeDay(document.getElementById('t'));
        }
        function changeDay(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#startYYYYMMDDHH").val(getBeforDay(aimDay) + "00");
            $("#endYYYYMMDDHH").val(aimDay + "23")
            displayDayChart();

            aimDay = getBeforDay(aimDay);
            aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
            if ($("." + obj.id) != undefined) {
                $("." + obj.id).val(aimDay);
            }
        }

        function changeYear(obj) {
            $("#year").val(obj.value)
            displayyearMMChart();
        }

        function changeMonth() {
            var selectyear = $("#selectyear").val();
            var selectmonth = $("#selectmonth").val();
            $("#startYYYYMMDD").val(selectyear + selectmonth + "01")
            $("#endYYYYMMDD").val(selectyear + selectmonth + getMaxDate(selectyear, selectmonth))
            displayMonthDDChart();
        }

        function changeInterval(obj) {
            displayDayChart();
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

</head>
<body>
    <input type="hidden" value="<%=Model.id%>" id="pid" />
    <input type="hidden" value="<%=System.DateTime.Now.Year%>" id="year" />
    <input type="hidden" value="column" id="chartType" />
    <input type="hidden" value="5" id="intervalMins" />
    <input type="hidden" value="<%=CalenderUtil.getBeforeDay(DateTime.Now,"yyyyMMdd")%>00"
        id="startYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+(DateTime.Now.Day).ToString("00") %>23"
        id="endYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>01"
        id="startYYYYMMDD" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+CalenderUtil.getCurMonthDays()%>"
        id="endYYYYMMDD" />
    <input type="hidden" value="<%=DateTime.Now.Year%>01" id="startYM" />
    <input type="hidden" value="<%=DateTime.Now.Year%>12" id="endYM" />
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=Model.name %></div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
            <div class="gf_dh">
                <div class="gf_dhl">
                    <table width="<%=ProtalUtil.isAutoLogin?"320":"520" %>" border="0" cellspacing="0"
                        cellpadding="0">
                        <tr>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico01.jpg" width="22" height="35" />
                            </td>
                            <td width="50">
                                <a href="/portal/index">首 页</a>
                            </td>
                            <td width="5">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <%if (!ProtalUtil.isAutoLogin)
                              { %>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico02.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a target="_blank" href="/portal/report/?plantId=<%=Model.id %>">报表获取</a>
                            </td>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico06.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a target="_blank" href="/portal/logs/?pid=<%=Model.id %>">日志获取</a>
                            </td>
                            <td width="5">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <%} %>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico03.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a href="<%= ViewData["url"] %>">返回上级</a>
                            </td>
                            <td width="5" align="right">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico05.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a href="/auth/loginout">退出</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="gf_dhr">
                    光伏电站监控</div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div class="plr">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
                    <tr>
                        <td width="290" valign="top">
                            <table width="281" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <img src="/images/gf/001.gif" width="281" height="24" />
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/003.gif">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <% 
                                                foreach (Hashtable hs in ViewData["icos"] as IList<Hashtable>)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <table width="93%" height="100" border="0" align="center" cellpadding="0" cellspacing="0"
                                                        class="geline">
                                                        <tr>
                                                            <td width="28%" align="center">
                                                                <img src="/images/gf/ico<%=hs["id"] %>.gif" width="60" height="55" /><br />
                                                                <%=hs["displayName"]%>
                                                            </td>
                                                            <td width="72%" class="tjxxtext">
                                                                <%=hs["data"] %>
                                                                <%=hs["unit"] %>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="/images/gf/002.gif" width="281" height="21" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="632" valign="top">
                            <%if (!ProtalUtil.isAutoLogin)
                              { %>
                            <div style="padding-bottom: 20px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center">
                                            <div class="cimg">
                                                <%string pic = Model.isVirtualPlant ? "/protalimg/" + (string.IsNullOrEmpty(Model.pic) ? "npr.jpg" : Model.pic) : "/ufile/" + (string.IsNullOrEmpty(Model.firstPic) ? "nopic/nopico02.jpg" : Model.firstPic); %>
                                                <img src="<%=pic %>" width="268" height="170" />
                                            </div>
                                        </td>
                                        <td valign="top" align="center">
                                            <table width="43%" border="0" cellspacing="0" cellpadding="0">
                                                <%if (ProtalUtil.isAutoLogin)
                                                  { %>
                                                <tr>
                                                    <td width="50%" height="35">
                                                        <input name="Submit2" type="submit" onclick="window.open('/portal/plantunit/<%=Model.id %>')"
                                                            class="xbgbut" value="电站单元查看 " />
                                                    </td>
                                                </tr>
                                                <%}
                                                  else
                                                  { %>
                                                <tr>
                                                    <td width="50%" height="35">
                                                        <input name="Submit2" type="submit" onclick="window.open('/portal/plantinfo/<%=Model.id %>')"
                                                            class="xbgbut" value="电站信息查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%" height="35">
                                                        <input name="Submit2" type="submit" onclick="window.open('/portal/plantunit/<%=Model.id %>')"
                                                            class="xbgbut" value="电站单元查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input name="Submit23" onclick="window.open('/portal/fault/<%=Model.id %>')" type="submit"
                                                            class="xbgbut" value="设备故障查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input onclick="window.open('/portal/deviceData/<%=Model.id %>')" name="Submit22"
                                                            type="submit" class="xbgbut" value="设备数据查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input onclick="window.open('/portal/prchart?pid=<%=Model.id %>')" name="Submit24"
                                                            type="submit" class="xbgbut" value="设备性能分析 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input onclick="window.open('/portal/devicestatus/<%=Model.id %>')" name="Submit22"
                                                            type="submit" class="xbgbut" value="设备状态查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input onclick="window.open('/portal/devicerelation?pid=<%=Model.id %>')" name="Submit24"
                                                            type="submit" class="xbgbut" value="设备接线图查看 " />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="35">
                                                        <input onclick="window.open('/portal/video?id=<%=Model.id %>')" name="Submit24" type="submit"
                                                            class="xbgbut" value="视频监控 " />
                                                    </td>
                                                </tr>
                                                <%} %>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style="clear: both;">
                            </div>
                            <div>
                                <div style="text-align: center">
                                    <div class="gftb">
                                        <div style="height: 10px;">
                                        </div>
                                        <div class="subico01" style="padding-left: 10px;">
                                            <ul id="change">
                                                <li style="cursor: pointer;"><a id="DayChart" class="onclick" href="javascript: void(0);">
                                                    <%=Resources.SunResource.PLANT_OVERVIEW_DAY %></a></li>
                                                <li style="cursor: pointer;"><a id="MonthChart" class="onclick" href="javascript:void(0);">
                                                    <%=Resources.SunResource.PLANT_OVERVIEW_MONTH %></a></li>
                                                <li style="cursor: pointer;"><a id="YearChart" class="noclick" href="javascript:void(0);">
                                                    <%=Resources.SunResource.PLANT_OVERVIEW_YEAR %></a></li>
                                                <li style="cursor: pointer;"><a id="TotalChart" class="noclick" href="javascript:void(0);">
                                                    <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL %></a></li>
                                            </ul>
                                        </div>
                                        <div style="text-align: center">
                                            <div class="z_big">
                                                <a id="toLargeChart" href="javascript:void(0)" onclick="large()" onfocus="javascript:this.blur();">
                                                </a>
                                            </div>
                                            <div>
                                                <div id="chartDiv">
                                                    <div id="dayIntervalDiv" style="display: none;">
                                                        <%=Resources.SunResource.PLANT_OVERVIEW_INTERVAL_MINS %>:
                                                        <select name="select" id="intervalSelect" onchange="changeInterval()">
                                                            <option value="5" style="text-align: left;">5<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                                            <option value="15" style="text-align: left;">15<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                                            <option value="30" style="text-align: left;">30<%=Resources.SunResource.PLANT_OVERVIEW_MINS %></option>
                                                            <option value="60" style="text-align: left;">1<%=Resources.SunResource.PLANT_OVERVIEW_HOUR %></option>
                                                        </select>
                                                    </div>
                                                    <div id='container' style='width: 95%; height: 320px; margin-left: 2px; margin-right: 2px;'>
                                                    </div>
                                                </div>
                                                <div style="display: none">
                                                    <center>
                                                        <div id='large_container_chart' style="width: 90%; height: 400px; margin-left: 50px;
                                                            margin-right: 50px; text-align: center;">
                                                        </div>
                                                    </center>
                                                </div>
                                                <div class="date_sel" id="date_select_div">
                                                    <div id="selectTable" style="margin-top: 20px; text-align: center;">
                                                        <table border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="24">
                                                                    <img src="/images/chartLeft.gif" id="left" width="24" height="21" onclick="PreviouNextChange('left')"
                                                                        style="cursor: pointer;" alt="Previous" />
                                                                </td>
                                                                <td>
                                                                    <div id="date_DayChart" style="display: none;">
                                                                        <input type="text" class="t" size="12" onclick="WdatePicker({onpicked:function(){changePreDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=DateTime.Parse( CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>'})"
                                                                            readonly="readonly" value="<%=DateTime.Parse(CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")).AddDays(-1).ToString("yyyy-MM-dd")%>"
                                                                            style="text-align: center;" />
                                                                        -
                                                                        <input name="t" type="text" id="t" size="12" class="indate" onclick="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                                            readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
                                                                            style="text-align: center;" />
                                                                        <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                                        <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                                                                    </div>
                                                                    <div id="date_YearChart">
                                                                        <%=Html.DropDownList("selectYear1",(IList<SelectListItem>)ViewData["plantYear"], new { id="selectYear1" ,onchange="changeYear(this)"}) %>
                                                                    </div>
                                                                    <div id="date_MonthChart" style="display: none;">
                                                                        <div style="float: left;">
                                                                            <%=Html.DropDownList("selectyear", (IList<SelectListItem>)ViewData["plantYear"], new { style="width:60px;", id = "selectyear", onchange = "changeMonth(this)" })%>
                                                                        </div>
                                                                        <div style="float: right;">
                                                                            <select style="width: 50px;" onchange="changeMonth(this)" id="selectmonth">
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
                                                                    <img src="/images/chartRight.gif" width="24" height="21" id="right" onclick="PreviouNextChange('right')"
                                                                        style="cursor: pointer;" alt="Next" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div id="chart_detail_grid" style="width: 100%; margin-top: 15px; overflow: hidden;
                                                    clear: both;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="xxtab0">
                                    <span class="xxtab"><span class="sbu">
                                        <input name="Submit3" type="submit" class="yellowbu" value="详细数据" onclick="window.open('/portal/fgpjData?id=<%=Model.id %>')" />
                                        <!--<input name="Submit26" type="submit" class="bulebu" value="导 出" />-->
                                    </span></span>
                                </div>
                                <div class="fgp">
                                    <table width="100%" border="1" cellpadding="1" cellspacing="0" bordercolor="#C0C7CE"
                                        bgcolor="#FFFFFF" style="border-collapse: collapse; line-height: 24px; color: #424242;
                                        text-align: center;">
                                        <tr>
                                            <td width="20%" rowspan="2" bgcolor="#F5F6F7">
                                                &nbsp;
                                            </td>
                                            <td colspan="5" bgcolor="#F5F6F7">
                                                <strong>发电量(kWh) </strong>
                                            </td>
                                            <td colspan="5" bgcolor="#F5F6F7">
                                                <strong>收入(元)</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                峰
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                谷
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                平
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                尖
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                总
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                峰
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                谷
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                平
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                尖
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                总
                                            </td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 日</strong>
                                            </td>
                                            <%foreach (float value in ViewData["daydatas"] as float?[])
                                              { %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 月</strong>
                                            </td>
                                            <%foreach (float value in ViewData["monthdatas"] as float?[])
                                              { %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 年</strong>
                                            </td>
                                            <%foreach (float value in ViewData["yeardatas"] as float?[])
                                              { 
                                            %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <%} %>
                            <%if (ProtalUtil.isAutoLogin)
                              { %>
                            <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="4%" align="center">
                                        <img src="/images/gf/gf_ico03.gif" width="15" height="15" />
                                    </td>
                                    <td width="14%" class="xxtab01">
                                        单元分布图
                                    </td>
                                    <td width="42%">
                                        &nbsp;
                                    </td>
                                    <td width="40%" align="right" class="xxtab03">
                                        点击图片可查看单元详细信息
                                    </td>
                                </tr>
                            </table>
                            <div id="planetmap" style="position: relative;">                                
                                 <% string path=Server.MapPath("~");
                               if (System.IO.File.Exists(string.Format("{0}/ufile/{1}", path, Model.structPic)) == false)
                               { Response.Write("<center><font color='red'>未上传分布图</font></center>"); }
                               else
                               { %>
                                <img id="structimg" src="/ufile/<%=Model.structPic %>" alt=""/>
                                <%} %>
                                
                                
                                
                                
                                
                                <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
                                  {
                                      PlantUnit unit = Model.plantUnits.Where(m => m.id.ToString().Equals(point.id)).FirstOrDefault<PlantUnit>();
                                      if (unit == null) unit = new PlantUnit();
                                %>
                                <div style="top: <%=point.y %>px; left: <%=point.x %>px; position: absolute;">
                                   
                                        <img src="/images/map/touming.gif" border="0" style="cursor: pointer;" alt="<%=point.displayName %>"
                                            id="plant_tip_<%=point.id %>" onmouseover="tips('plant_tip_<%=point.id %>');" />
                                </div>
                                <div id="plant_tip_<%=point.id %>-content" style="display: none; background-color: Red;">
                                    <!--  
                                            <div style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#D7F4CB,endColorStr=#ffffff); height:0px; width:200px;">
                                            -->
                                    <div style="line-height: 20px; padding-left: 10px;">
                                        <font size="3"><strong>
                                            <%=point.displayName %></strong></font></div>
                                    <div style="line-height: 20px; padding-left: 10px;">
                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:
                                        <%=unit.TodayPower(Model.timezone)%>
                                        kW
                                    </div>
                                    <div style="line-height: 20px; padding-left: 10px;">
                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>:
                                        <%=unit.TodayEnergy(Model.timezone)%>
                                        kWh
                                    </div>
                                    <div style="line-height: 20px; padding-left: 10px;">
                                        累计发电: 
                                        <%=unit.displayTotalEnergyDigtal%>
                                        <%=unit.displayTotalEnergyUnit%>
                                    </div>
                                    <!--
                                            </div>
                                            <div style="background:-moz-linear-gradient(top,#D7F4CB,#ffffff); height:60px; width:200px;">
                                            
                                            </div>
                                            -->
                                </div>
                                <%} %>
                            </div>
                            <div>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="15%" height="26">
                                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="17%" align="center">
                                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                                    </td>
                                                    <td width="83%">
                                                        <strong>单元列表</strong>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                                        </td>
                                        <td background="/images/gf/tci/tc02.gif">
                                        </td>
                                        <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td background="/images/gf/tci/tc04.gif">
                                            &nbsp;
                                        </td>
                                        <td bgcolor="#FFFFFF">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <% int j = 0;
                                                       int cindex = 1;
                                                       foreach (PlantUnit plantUnit in Model.plantUnits)
                                                       {
                                                           ++j;
                                                    %>
                                                    <td width="50%" class="down_line0<%=cindex%2+1 %>">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="8%" height="60" align="center">
                                                                    <%
                                                                        if (plantUnit.collector.runData != null)
                                                                        {
                                                                            if (!plantUnit.isWork(Model.timezone))
                                                                            {%>
                                                                    <img src="/images/gf/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                                    <% }
                                                                            else
                                                                            {%>
                                                                    <img src="/images/gf/line_on.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_WORKING %>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_WORKING %>" />
                                                                    <%}
                                                                        }
                                                                        else
                                                                        { %>
                                                                    <img src="/images/gf/line_off.gif" width="26" height="32" alt="<%=Resources.SunResource.MONITORITEM_STOPPED %>"
                                                                        title="<%=Resources.SunResource.MONITORITEM_STOPPED %>" />
                                                                    <%} %>
                                                                </td>
                                                                <td width="92%">
                                                                    <span class="xxbox_tt">
                                                                        <%=plantUnit.displayname%></span>
                                                                    <br />
                                                                    <%if (plantUnit.collector.runData != null)
                                                                      { %>
                                                                    <span class="lbl">
                                                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>:
                                                                        <%=plantUnit.TodayPower(Model.timezone)%>
                                                                        kW
                                                                        <br />
                                                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>:
                                                                        <%=plantUnit.TodayEnergy(Model.timezone)%>
                                                                        kWh
                                                                        <br />
                                                                        累计发电:
                                                                        <%=plantUnit.displayTotalEnergyDigtal%>
                                                                        <%=plantUnit.displayTotalEnergyUnit%>
                                                                    </span>
                                                                    <%}
                                                                      else
                                                                      {%>
                                                                    <span class="lbl">
                                                                        <%=Resources.SunInfoResource.USER_OVERVIEW_PLANT_CURRENT_POWER%>: 0 kW
                                                                        <br />
                                                                        <%=Resources.SunInfoResource.PLANT_OVERVIEW_TODAY_ENERGRY%>: 0 kWh
                                                                        <br />
                                                                        累计发电: 0 kW </span>
                                                                    <%}%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <%if (j % 2 == 0) { Response.Write("</tr><tr>"); cindex++; }
                                                       } if (j % 2 != 0)
                                                       { %>
                                                    <td width="50%" class="down_line0<%=cindex%2+1 %>">
                                                    </td>
                                                    <%} %>
                                                </tr>
                                            </table>
                                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                            </table>
                                        </td>
                                        <td background="/images/gf/tci/tc05.gif">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="9" height="9">
                                            <img src="/images/gf/tci/tc06.gif" width="9" height="9" />
                                        </td>
                                        <td background="/images/gf/tci/tc07.gif">
                                        </td>
                                        <td>
                                            <img src="/images/gf/tci/tc08.gif" width="9" height="9" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%} %>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both;">
            </div>
            <div style="height: 30px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    <%if (ProtalUtil.isAutoLogin)
      { %>
    <map name="unitmap" id="unitmap">
        <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
          {%>
        <area shape="circle" coords="<%=point.x %>,<%=point.y %>,15" href="javascript:void(0);"
            target="_blank" title="<%=point.displayName %>" />
        <%} %>
    </map>
    <%} %>
</body>
</html>

<script>
    readyinit();
</script>

