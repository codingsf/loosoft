////
//生成图表js，封装了highcharts控件的相关方法
//author:qhb
//变更应用export.js用于支持导出图表数据功能
////
//创建y轴
function createyAxis(num, max) {
    var yAxisText;
    if (num % 2 > 0) {
        yAxisText = {
            labels: {
                formatter: function() {
                    return this.value + 'Â°C';
                },
                style: {
                    color: ''
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    font: 'normal 10px Verdana, sans-serif',
                    color: ''
                }
            },
            opposite: true,
            min: 0,
            max: max,
            minorTickInterval: 'auto',
            maxPadding: 0.2,
            lineWidth: 1,
            endOnTick: true,
            tickWidth: 0,
            tickPixelInterval: 20
        }
    } else {
        yAxisText = {
            labels: {
                formatter: function() {
                    return this.value + 'Â°C';
                },
                fontweight: '100',
                style: {
                    //font: 'normal 10px Verdana, sans-serif',
                    color: ''
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    font: 'normal 10px Verdana, sans-serif',
                    color: ''
                }
            },
            min: 0,
            max: max,
            minorGridLineDashStyle: 'Solid',
            minorGridLineColor: '#E0E0E0',
            minorTickInterval: 'auto',
            tickWidth: 1,
            endOnTick: true,
            maxPadding: 0.2,
            lineWidth: 1,
            alternateGridColor: '#F7F7F7',
            tickPixelInterval: 40
        }
    }
    return yAxisText;
}

//创建图表序列
function createSerie() {
    var serie = {
        name: '',
        data: [],
        color: '',
        yAxis: '0',
        type: 'line'
    }
    return serie;

}

function createxAxis() {
    xAxis = {
        categories: [],
        labels: {
            align: 'center',
            fontweight: '100',
            style: {
                font: 'normal 10px Verdana, sans-serif',
                color: ''
            }
        },
        tickInterval: 1,
        startOnTick: false
    }
}

var chartTitle;
var globalCategories;
var globalOldYvalue = new Array(); //原始y轴的值，包括多维
var globalSeries = new Array(); //原始y轴序列，包括多维
//设置y轴属性
function setyAxis(data) {
    chartTitle = data.name;
    var names = data.names;
    var colors = data.colors;
    var units = data.units;
    globalCategories = data.categories;
    yAxisArr = new Array();
    var yAxisText
    for (var i = 0; i < names.length; i++) {
        var maxv = data.series[i].max;
        //找出后面最大值赋给第一个
        if (names.length==1 && i == 0 && data.series.length > 1) {
            for(var k=1;k<data.series.length;k++){
                if (data.series[k].max > maxv) {
                    maxv = data.series[k].max;
                }
            }
        }   
        yAxisText = createyAxis(i, maxv);
        if (names[i] == '' || names[i] == null)
            yAxisText.title.text = "[" + units[i] + "]";
        else
            yAxisText.title.text = names[i] + "[" + units[i] + "]";
        var maxValue = data.series[i].max;
        if (maxValue == 0 && units[i] == 'W/m2')
            yAxisText.labels.formatter = formatYLabellarge; //function() { return this.value};
        else if (maxValue < 10)
            yAxisText.labels.formatter = formatYLabelxiaoshu; //function() { return this.value};
        else
            yAxisText.labels.formatter = formatYLabelzhengshu; //function() { return this.value};
        if (names.length > 1) {
            //yAxisText.labels.style.color = colors[i];
            //yAxisText.title.style.color = colors[i];
        }
        yAxisArr.push(yAxisText);
    }
}

//格式化y轴数据，小于10的格式化为一位小数
function formatYLabellarge() {
    var tmpstr = this.value.toString();
    if (this.value == 0) return 0; //0不格式
    if (this.value < 10) {
        var newstr = (this.value + 0.00001).toString();
        return newstr.substring(0, newstr.indexOf('.') + 4) * 1000;
    } else {
        return this.value;
    }
}

///格式化一位小数
function formatBit(value) {
    var newstr = (value + 0.00001).toString();
    return newstr.substring(0, newstr.indexOf('.') + 2);
}

//格式化y轴数据，小于10的格式化为一位小数
function formatYLabelxiaoshu() {
    var tmpstr = this.value.toString();
    if (this.value == 0) return 0; //0不格式
    if (this.value < 10) {
        var newstr = (this.value + 0.00001).toString();
        return newstr.substring(0, newstr.indexOf('.') + 4);
    } else {
        return this.value;
    }
}

//格式化y轴数据，小于10的格式化为一位小数
function formatYLabelzhengshu() {
    var tmpstr = this.value.toString();
    if (this.value == 0) return 0; //0不格式
    return this.value;
}

//格式化提示
function formatterFunc() {
    var name = this.series.name;
    var type = this.series.type;
    //区分pie图形和其他图形的格式方式
    if (type == "pie") {
        if (name.indexOf('[') > -1) {
            name = name.substring(0, name.indexOf('['));
        }
        return getOtherSeriesNamestr(this.point.name) + ":" + getOtherSeriesValuewithUnit(this.point.x) + "/" + formatBit(this.percentage) + ' %';
    }
    if (type == "scatter") {
        return this.x + ' W/㎡: ' + this.y +' kW';
    }
    else {
        return '' +
               this.x + ': ' + getOvalueByXName(this.x, name) + " " + getUnitsByName(name);
    }
}

//取得pie图形其他序列的名称串用“/”链接
function getOtherSeriesNamestr(pointName) {
    var str = "";
    var name = "";
    for (var i = 0; i < globalNames.length; i++) {
        name = globalNames[i];
        if (name.indexOf('[') > -1) {
            name = name.substring(0, name.indexOf('['));
        }
        str += "/" + pointName + name;
    }
    if (str.length > 0) {
        str = str.substring(1);
    }
    return str;
}

//取得所有序列的值，带单位
function getOtherSeriesValuewithUnit(x) {
    var str = "";
    for (var i = 0; i < globalSeries.length; i++) {

        str += "/" + formatBit(globalSeries[i][x]) + globalUnits[i];
    }
    if (str.length > 0) {
        str = str.substring(1);
    }
    return str;
}

//根据序列名称取得对应的单位
function getUnitsByName(name) {
    for (var i = 0; i < globalNames.length; i++) {
        if (globalNames[i] == name) return globalUnits[i];
    }
    return "";
}

//根据序列名称和序号取得对应的原始值
function getOvalueByXName(x, name) {
    var key = x + name;
    var keyvalue;
    for (var i = 0; i < globalOldYvalue.length; i++) {
        keyvalue = globalOldYvalue[i].split("*&");
        if (keyvalue[0] == key) {
            return keyvalue[1];
        }
    }
    return "";
}

//取得某个维度的最大值
function getMax(series, yAxis) {
    var tmpMax = 0;
    //先去的所有维度中同最大值
    for (var i = 0; i < series.length; i++) {
        var tmpSerie = series[i];
        if (yAxis == tmpSerie.yAxis && tmpSerie.max >= tmpMax)
            tmpMax = tmpSerie.max;
    }
    return tmpMax;
}

//取得某个维度的最小值
function getMin(series, yAxis) {
    var tmpMax = 0;
    //先去的所有维度中同最大值
    for (var i = 0; i < series.length; i++) {
        var tmpSerie = series[i];
        if (yAxis == tmpSerie.yAxis && tmpSerie.min <= tmpMax)
            tmpMax = tmpSerie.min;
    }
    return tmpMax;
}

//设置y序列
function setySeriesArr(series) {
    globalNames = new Array();
    globalUnits = new Array();
    seriesArr = new Array();
    globalOldYvalue = new Array();
    globalSeries = new Array();
    for (var i = 0; i < series.length; i++) {
        var tmpSerie = series[i];
        if (tmpSerie == 'null' || tmpSerie == null) continue;

        //如果是pie类型图表，那么一维序列之后的数据仅仅保存到全局数据不再呈现在图表中，用于组织数据的显示
        if (tmpSerie.type != 'pie' || i == 0) {
            var serie = createSerie();
            serie.color = tmpSerie.color;
            serie.name = tmpSerie.name;
            serie.data = comDataByCharttype(tmpSerie, series);
            serie.type = tmpSerie.type;
            serie.yAxis = tmpSerie.yAxis;
            seriesArr.push(serie);
        }
        globalSeries.push(tmpSerie.data);
        if (tmpSerie.min < yAxisArr[tmpSerie.yAxis].min)
            yAxisArr[tmpSerie.yAxis].min = tmpSerie.min;
        globalNames.push(tmpSerie.name);
        if(tmpSerie.name.indexOf('[')>-1){
            globalUnits.push(tmpSerie.name.substring(tmpSerie.name.indexOf('[')+1,tmpSerie.name.indexOf(']')))
        }else{
            globalUnits.push("");
        }

    }
}

//将通用坐标序列组成成符合pie图表类型的数据格式
//pie图表类型数据格式：[['Firefox/收益', 45.0],['IE', 26.8],{name: 'Chrome', y: 12.8},['Safari', 8.5],['Opera', 6.2],['Others', 0.7]];
function comDataByCharttype(tmpSerie, series) {
    if (tmpSerie.type == 'pie') {
        return comPieXyData(tmpSerie);
    } else {
        return handleMinData(tmpSerie.data, getMax(series, tmpSerie.yAxis), getMin(series, tmpSerie.yAxis), tmpSerie.name);
    }
}

//组织pie，cactter类型图片数据
function comPieXyData(tmpSerie) {
    var datastr = "[";
    for (var i = 0; i < tmpSerie.data.length - 1; i++) {
        if (globalCategories[i] == "0" || globalCategories[i] == null) continue;
        datastr += "['" + globalCategories[i] + "'," + tmpSerie.data[i] + "]" + (i == tmpSerie.data.length - 1 ? "" : ",");
    }
    datastr += "]";
    //var datastr = "[['Firefox/收益', 45.0],['IE', 26.8],{name: 'Chrome', y: 12.8},['Safari', 8.5],['Opera', 6.2],['Others', 0.7]];";
    return eval(datastr);
}

//组织pie，cactter类型图片数据
function comScatterXyData(tmpSerie) {
    var datastr = "[";
    var tmpx = 0;
    for (var i = 0; i < tmpSerie.data.length - 1; i++) {
        tmpx = globalCategories[i];
        if (tmpx == null || tmpx == "") tmpx = 0;
        if (tmpx == 0) continue;
        datastr += "[" + tmpx + "," + tmpSerie.data[i] + "]" + (i == tmpSerie.data.length - 1 ? "" : ",");
    }
    datastr += "]";
    //var datastr = "[[34, 45.0],[34, 26.8]];";
    return eval(datastr);
}

//对y轴数据的极小值进行放大树立，但是不影响显示真正的值
function handleMinData(ydata, yMax, yMin, name) {
    var keyvalue = "";
    var rate = 0.01;
    for (var i = 0; i < ydata.length; i++) {
        //先保留原始值
        keyvalue = globalCategories[i] + name + "*&" + ydata[i];
        
        globalOldYvalue.push(keyvalue);
        //当前值和最大值的比率，小于1%即增加到1%
        if (ydata[i] == 0) {
            ydata[i] = yMax * 0.005; //0值给放大点，以便能显示出来
            //if (ydata[i] == 0) ydata[i] = 0.1;
        } else if (ydata[i] != null && ydata[i] != "null" && ydata[i] > 0 && ydata[i] / yMax < rate) {
            ydata[i] = yMax * rate;
        } else if (ydata[i] != null && ydata[i] != "null" && ydata[i] < 0 && ydata[i] / yMin < rate) {
            ydata[i] = yMin * rate;
        }
    }
    return ydata;
}

var isLargeChart = false;
function setCategoriesWithInterval(categories, isLarge, tickInterval) {
    isLargeChart = isLarge;
    var rotationNum = isLarge ? 15 : 12;
    createxAxis();
    xAxis.categories = categories;
    //chart.xAxis[0].setCategories(categories);
    //计算隔花
    var rotation = 0;
    if (categories.length > rotationNum) {
        //        if (categories.length / rotationNum < 2) {
        //            rotation = -25;
        //            xAxis.labels.align = "right";
        //        } else if ((categories.length / rotationNum) < 3) {
        //            rotation = -45;
        //            xAxis.labels.align = "right";
        //        } else if ((categories.length / rotationNum) < 4) {
        //            rotation = -75;
        //            xAxis.labels.align = "right";
        //        } else {
        //            rotation = -90;
        //            xAxis.labels.align = "right";
        //        }
        rotation = -90;
        xAxis.labels.align = "right";
    }

    xAxis.tickInterval = tickInterval;
    xAxis.labels.rotation = rotation;
}

function setCategories(categories, isLarge) {
    isLargeChart = isLarge;
    var tickNum = isLarge ? 31 : 31;
    //计算隔花
    var tickInterval = 1;
    if (categories.length > tickNum) {
        var zv = Math.round(categories.length / tickNum);
        tickInterval = zv;
    }
    setCategoriesWithInterval(categories, isLarge, tickInterval);
}
var curUrl;
var curSerieNo;
var curFilename;
var curChartname;
//设置导出参数
function setExportChart(url, serieNo, filename, chartname) {
    curUrl = url;
    curSerieNo = serieNo;
    curFilename = filename;
    curChartname = chartname;
}

var globalUnits = new Array();
var globalNames = new Array();
var yAxisArr = new Array();
var seriesArr = new Array();
var xAxis;
var chart;


var extbuttons = {
    //    largeButton: {
    //        enabled: true,
    //        symbol: 'url(/images/sub/amp.gif)',
    //        height: 20,
    //        width: 20,
    //        symbolSize: 20,
    //        symbolX: 0,
    //        symbolY: 0,
    //        x: -40,
    //        align: 'right',
    //        symbolFill: 'white',
    //        hoverSymbolFill: 'white',
    //        _titleKey: 'largeButton',
    //        onclick: function() {
    //            document.getElementById("toLargeChart").click();
    //        }
    //    }
    largeButton: {
        enabled: true,
        symbol: 'square',
        x: -36,
        symbolFill: '#B5C9DF',
        hoverSymbolFill: '#779ABF',
        _titleKey: 'largeButton',
        onclick: function() {
            document.getElementById("toLargeChart").click();
        }
    }
};

var exportButtonNoDetail = {
    menuItems: [{
        textKey: 'downloadPNG',
        onclick: function() {
            this.exportChart({
                serieNo: curSerieNo,
                type: 'application/xls',
                filename: curFilename,
                chartname: curChartname
            });
        }
    }, {
        textKey: 'downloadJPEG',
        onclick: function() {
            this.exportChart({
                serieNo: curSerieNo,
                type: 'text/csv',
                filename: curFilename,
                chartname: curChartname
            });
        }
    }, {
        textKey: 'downloadPDF',
        onclick: function() {
            /* this.exportChart({
            serieNo: curSerieNo,
            type: 'application/pdf',
            filename: curFilename,
            chartname: curChartname
            });*/
            exportpdfchart();

        }
    }
            ],
    enabled: true
}

var exportButtonDetail = {
    menuItems: [{
        textKey: 'downloadPNG',
        onclick: function() {
            this.exportChart({
                serieNo: curSerieNo,
                type: 'application/xls',
                filename: curFilename,
                chartname: curChartname
            });
        }
    }, {
        textKey: 'downloadJPEG',
        onclick: function() {
            this.exportChart({
                serieNo: curSerieNo,
                type: 'text/csv',
                filename: curFilename,
                chartname: curChartname
            });
        }
    }, {
        textKey: 'downloadPDF',
        onclick: function() {
            /* this.exportChart({
            serieNo: curSerieNo,
            type: 'application/pdf',
            filename: curFilename,
            chartname: curChartname
            });*/
            exportpdfchart();
        }
    }, {
        textKey: 'downloadSVG',
        onclick: function() {
            openDetailInfo();
        }
    }
    ],
    enabled: true
}


function defineChart(curContainer) {
    defineChartWithDetail(curContainer, true);
}

//是否有详细数据菜单
function defineChartWithDetail(curContainer, isDetail) {
    var exportButton;
    if (isDetail)
        exportButton = exportButtonDetail;
    else
        exportButton = exportButtonNoDetail;

    chart = new Highcharts.Chart({
        chart: {
            renderTo: curContainer,
            defaultSeriesType: 'line',
            marginTop: 70
        },
        title: {
            text: '',
            align: 'center',
            x: 0,
            floating: true
        },
        subtitle: {
            text: '',
            x: 10,
            align: 'left'
        },
        xAxis: xAxis,
        yAxis: yAxisArr,
        tooltip: {
            formatter: formatterFunc
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            x: 0,
            y: -10,
            borderWidth: 1,
            margin: 20
        },
        plotOptions: {
            area: {
                shadow: false,
                lineWidth: 0,
                brightness: 0.3,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            symbol: 'diamond',
                            radius: 3,
                            lineWidth: 1
                        }
                    }
                }
            },
            line: {
                shadow: false,
                lineWidth: 1,
                brightness: 0.2,
                marker: {
                    enabled: true,
                    symbol: 'diamond',
                    radius: 1,
                    brightness: 0.1,
                    states: {
                        hover: {
                            enabled: false,
                            symbol: 'diamond',
                            radius: 3,
                            lineWidth: 1
                        }
                    }
                }
            },
            column: {
                shadow: false,
                lineWidth: 1,
                brightness: 0.2,
                marker: {
                    enabled: true,
                    symbol: 'diamond',
                    radius: 0,
                    brightness: 0.2,
                    states: {
                        hover: {
                            enabled: true,
                            symbol: 'diamond',
                            radius: 3,
                            lineWidth: 1
                        }
                    }
                }
            },
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    formatter: formatterFunc
                },
                showInLegend: true
            },
            scatter: {
                marker: {
                    radius: 5,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{series.name}</b><br>',
                    pointFormat: '{point.x} cm, {point.y} kg'
                }
            },
            series: {
                shadow: false
            }
        },
        exporting: {
            filename: curFilename,
            url: curUrl,
            buttons: {
                exportButton: exportButton,
                printButton: {
                    enabled: false
                }
            }
        },
        navigation: {
            buttonOptions: {
                verticalAlign: 'top',
                horizontalAlign: 'right',
                y: 5,
                x: -10
            }
        },
        series: seriesArr
    }, function(chart) {
        if (!isLargeChart) {
            for (n in extbuttons) {
                chart.addButton(extbuttons[n]);
            }
        }
        chart.setTitle({ text: chartTitle, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
        // fix the position issue (#185 on github)
        //if (!isLargeChart)//不是大图表要重置尺寸，否则显示不出来新增的按钮
        //chart.setSize(chart.chartWidth, chart.chartHeight);
    });
}

//scatter类型chat定义
function defineChartWithScatter(curContainer, isDetail, data) {
    var exportButton;
    if (isDetail)
        exportButton = exportButtonDetail;
    else
        exportButton = exportButtonNoDetail;

    //准备数据
    globalCategories = data.categories;
    seriesArr = new Array();
    for (var i = 0; i < data.series.length; i++) {
        var tmpSerie = data.series[i];
        if (tmpSerie == 'null' || tmpSerie == null) continue;

        var serie = createSerie();
        serie.color = tmpSerie.color;
        serie.name = "";
        serie.data = comScatterXyData(tmpSerie);
        serie.type = tmpSerie.type;
        serie.yAxis = tmpSerie.yAxis;
        seriesArr.push(serie);
    }
    var names = data.names;
    var units = data.units;
    var xAxisName = names[0] + "[" + units[0] + "]";
    var yAxisName = names[1] + "[" + units[1] + "]";
    chart = new Highcharts.Chart({
        chart: {
            renderTo: curContainer,
            type: 'scatter',
            zoomType: 'xy'
        },
        title: {
            text: '',
            align: 'center',
            x: 0,
            floating: true
        },
        subtitle: {
            text: '  '
        },
        tooltip: {
            formatter: formatterFunc
        },
        xAxis: {
            title: {
                enabled: true,
                text: xAxisName,
                style: {
                    font: 'normal 10px Verdana, sans-serif',
                    color: ''
                }
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true
        },
        yAxis: {
            title: {
                text: yAxisName,
                style: {
                    font: 'normal 10px Verdana, sans-serif',
                    color: ''
                }
            }
        },
        legend: {
            enabled: false,
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            x: 0,
            y: -10,
            borderWidth: 1,
            margin: 20
        },
        plotOptions: {
            scatter: {
                marker: {
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{series.name}dfd</b><br>',
                    pointFormat: '{point.x} cm, {point.y} kg'
                }
            }
        },
        exporting: {
            filename: curFilename,
            url: curUrl,
            buttons: {
                //exportButton: exportButton,
                printButton: {
                    enabled: false
                }
            }
        },
        navigation: {
            buttonOptions: {
                verticalAlign: 'top',
                horizontalAlign: 'right',
                y: 5,
                x: -10
            }
        },
        series: seriesArr
    }, function(chart) {
        if (!isLargeChart) {
            for (n in extbuttons) {
                chart.addButton(extbuttons[n]);
            }
        }
        //chart.setTitle({ text: chartTitle, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
        // fix the position issue (#185 on github)
        //if (!isLargeChart)//不是大图表要重置尺寸，否则显示不出来新增的按钮
        //chart.setSize(chart.chartWidth, chart.chartHeight);
    });
}

//取得年月的最大天数
function getMaxDate(y, m) {
    //计算下个月的年份(y)、月份值(m)
    if (m == 12) {
        y++;
        m = 1;
    }
    else {
        m++;
    }
    //生成下个月1日的Date值
    var dt = new Date(y, m - 1, 1);  //月份值0--11
    //一天差值=86400000，将下月1日转换成数值，再相减，得上月最后一天Date值
    var n = Date.parse(dt);
    n -= 86400000;
    var dt1 = new Date(n);
    //输出当月最后一天日期字符串
    return dt1.getDate();
}

//取得当天20110901的前一天，包括跨月情况
function getBeforDay(aimDay) {
    var day = aimDay.substring(6, 8);
    var month = aimDay.substring(4, 6);
    var year = aimDay.substring(0, 4);
    if (day == "01") {
        month = (month - 1);
        if (month < 10) month = "0" + month;
    }

    if (month == "00") {
        month = 12;
        year = year - 1;
    }
    if (day == "01") {
        day = getMaxDate(year, month);
    } else {
        day = day - 1;
    }
    if (day < 10) day = "0" + day;
    return year + "" + month + "" + day;
}


//将错误或无数据提示 显示出来
function appendChartError(curContainer, result, ajaxImgTop) {

    if (result.indexOf("error:") > -1 || result.indexOf("Error:") > -1) {
        $('#' + curContainer).empty();
        $('#' + curContainer).append("<center><div style='padding-top:" + (ajaxImgTop + 40) + "px;  font-size: large;' >" + result.substring(result.indexOf("Error:") + 7) + "</div></center>");
        $("#chart_detail_grid").empty();
        return true;
    } else {
        var data = eval('(' + result + ')');
        if (!data.isHasData) {
            $('#' + curContainer).empty();
            $('#' + curContainer).append("<center><div style='padding-top:" + (ajaxImgTop + 40) + "px;  font-size: large;' >" + data.errorDesc + "</div></center>");
            $("#chart_detail_grid").empty();
            return true;
        }
    }
    return false;
}

function getCurdata() {
    var curDate = new Date();
}

function changeDate(oper, inputname) {
    // alert(oper);
    //alert($("#inputname").val());
    var smallDate = $("#minDate").val();
    var largeDate = $("#maxDate").val();
    // alert(smallDate+","+largeDate);
    var iniDate = $("#" + inputname).val();
    if (oper == "right") {

        var date = iniDate.split("-");
        var myDate = new Date(date[0], (date[1] - 1), date[2]);
        var uom = new Date(myDate - 0 + 1 * 86400000);
        uom = uom.getFullYear() + "-" + ((uom.getMonth() + 1) < 10 ? ("0" + (uom.getMonth() + 1)) : (uom.getMonth() + 1)) + "-" + (uom.getDate() < 10 ? ("0" + uom.getDate()) : uom.getDate());

        if (uom > smallDate && uom < largeDate) {

            document.getElementById(inputname).value = uom;
        } else {
            document.getElementById(inputname).value = largeDate;
        }
    }
    if (oper == "left") {

        var date = iniDate.split("-");

        var myDate = new Date(date[0], (date[1] - 1), date[2]);
        var uom = new Date(myDate - 0 + (-1) * 86400000);
        uom = uom.getFullYear() + "-" + ((uom.getMonth() + 1) < 10 ? ("0" + (uom.getMonth() + 1)) : (uom.getMonth() + 1)) + "-" + (uom.getDate() < 10 ? ("0" + uom.getDate()) : uom.getDate());

        if (uom > smallDate && uom < largeDate) {
            document.getElementById(inputname).value = uom;
        } else {

            document.getElementById(inputname).value = smallDate;
        }
        //alert(document.getElementById(inputname).value)
    }
    //    var aimDay = document.getElementById(inputname).value;
    //    if (aimDay) {
    //        aimDay = aimDay.replace("-", "").replace("-", "");
    //    }
    //    aimDay = getBeforDay(aimDay);
    //    aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
    //   // $("." + inputname).val(aimDay);
}

function changeShowMonth(oper, monthinput, yearinput) {

    var index1 = document.getElementById(monthinput).selectedIndex;
    var index2 = document.getElementById(yearinput).selectedIndex;
    if (oper == "right") {
        var stryears = "";
        $('#' + yearinput + ' option').each(function() {
            stryears += $(this).val() + ",";
        });
        var years = stryears.split(",");
        var month = $("#" + monthinput).val();
        var year = $("#" + yearinput).val();
        var max = years[0], min = years[0];

        var m = document.getElementById(monthinput);
        var y = document.getElementById(yearinput);

        for (var i = 0; i < years.length - 1; i++) {
            if (max < years[i]) {
                max = years[i];
            }
            if (min > years[i]) {
                min = years[i];
            }
        }

        if (month != 12) {
            if (month < 9) {
                if (year != max) {
                    month++;
                    document.getElementById(monthinput).options[index1 + 1].selected = true;
                    document.getElementById(monthinput).options[index1 + 1].innerHTML = "0" + month;

                } else if (month != 12) {

                    month++;
                    document.getElementById(monthinput).options[index1 + 1].selected = true;
                    document.getElementById(monthinput).options[index1 + 1].innerHTML = "0" + month;
                    document.getElementById(yearinput).options[index2].selected = true;
                    document.getElementById(yearinput).options[index2].innerHTML = max;
                } else {
                    document.getElementById(yearinput).options[0].selected = true;
                    document.getElementById(yearinput).options[0].innerHTML = min;
                    document.getElementById(monthinput).options[0].selected = true;
                    document.getElementById(monthinput).options[0].innerHTML = "01";

                }
            } else {
                if (year != max) {
                    month++;
                    document.getElementById(monthinput).options[index1 + 1].selected = true;
                    document.getElementById(monthinput).options[index1 + 1].innerHTML = month;
                } else if (month != 12) {

                    month++;
                    document.getElementById(monthinput).options[index1 + 1].selected = true;
                    document.getElementById(monthinput).options[index1 + 1].innerHTML = month;
                    document.getElementById(yearinput).options[index2].selected = true;
                    document.getElementById(yearinput).options[index2].innerHTML = max;
                } else {

                    document.getElementById(yearinput).options[0].selected = true;
                    document.getElementById(yearinput).options[0].innerHTML = min;
                    document.getElementById(monthinput).options[0].selected = true;
                    document.getElementById(monthinput).options[0].innerHTML = "01";

                }
            }
        } else if (year != max) {
            document.getElementById(monthinput).options[0].selected = true;
            document.getElementById(monthinput).options[0].innerHTML = "01";
            year++;
            document.getElementById(yearinput).options[index2 + 1].selected = true;
            document.getElementById(yearinput).options[index2 + 1].innerHTML = year;
        } else {
            document.getElementById(yearinput).options[0].selected = true;
            document.getElementById(yearinput).options[0].innerHTML = min;
            document.getElementById(monthinput).options[0].selected = true;
            document.getElementById(monthinput).options[0].innerHTML = "01";
        }

    }

    if (oper == "left") {
        var stryears = "";
        $('#' + yearinput + ' option').each(function() {
            stryears += $(this).val() + ",";
        });
        //alert(stryears);
        var years = stryears.split(",");
        var month = $("#" + monthinput).val();
        var year = $("#" + yearinput).val();
        var max = years[0], min = years[0];

        var m = document.getElementById(monthinput);
        var y = document.getElementById(yearinput);

        for (var i = 0; i < years.length - 1; i++) {
            if (max < years[i]) {
                max = years[i];
            }
            if (min > years[i]) {
                min = years[i];
            }
        }
        if (month != 1) {
            if (month < 9) {
                if (year != min) {
                    month--;
                    document.getElementById(monthinput).options[index1 - 1].selected = true;
                    document.getElementById(monthinput).options[index1 - 1].innerHTML = "0" + month;

                } else if (month != 1) {
                    month--;
                    document.getElementById(monthinput).options[index1 - 1].selected = true;
                    document.getElementById(monthinput).options[index1 - 1].innerHTML = "0" + month;
                    document.getElementById(yearinput).options[index2].selected = true;
                    document.getElementById(yearinput).options[index2].innerHTML = min;
                } else {
                    document.getElementById(yearinput).options[0].selected = true;
                    document.getElementById(yearinput).options[0].innerHTML = min;
                    document.getElementById(monthinput).options[0].selected = true;
                    document.getElementById(monthinput).options[0].innerHTML = "01";
                    1010707
                }
            } else {
                if (year != min) {
                    month--;
                    document.getElementById(monthinput).options[index1 - 1].selected = true;
                    document.getElementById(monthinput).options[index1 - 1].innerHTML = month;
                } else if (month != 1) {
                    month--;

                    document.getElementById(monthinput).options[index1 - 1].selected = true;
                    if (month <= 9)
                        document.getElementById(monthinput).options[index1 - 1].innerHTML = "0" + month;
                    else
                        document.getElementById(monthinput).options[index1 - 1].innerHTML = month;
                    document.getElementById(yearinput).options[index2].selected = true;
                    document.getElementById(yearinput).options[index2].innerHTML = min;

                } else {
                    document.getElementById(yearinput).options[0].selected = true;
                    document.getElementById(yearinput).options[0].innerHTML = min;
                    document.getElementById(monthinput).options[0].selected = true;
                    document.getElementById(monthinput).options[0].innerHTML = "01";

                }
            }
        } else if (year != min) {
            if (month == 1) {
                document.getElementById(monthinput).options[11].selected = true;
                document.getElementById(monthinput).options[11].innerHTML = "12";
            }
            else {
                document.getElementById(monthinput).options[0].selected = true;
                document.getElementById(monthinput).options[0].innerHTML = "01";
            }
            year--;
            document.getElementById(yearinput).options[index2 - 1].selected = true;
            document.getElementById(yearinput).options[index2 - 1].innerHTML = year;
        } else {
            document.getElementById(yearinput).options[0].selected = true;
            document.getElementById(yearinput).options[0].innerHTML = min;
            document.getElementById(monthinput).options[0].selected = true;
            document.getElementById(monthinput).options[0].innerHTML = "01";
        }
    }
}

function changeShowYear(oper, inputname) {
    var stryears = "";
    var index = document.getElementById(inputname).selectedIndex;
    $('#' + inputname + ' option').each(function() {
        stryears += $(this).val() + ",";
    });
    var years = stryears.split(",");

    var year = parseInt($("#" + inputname).val());
    var max = years[0], min = years[0];


    for (var i = 0; i < years.length - 1; i++) {
        if (max < years[i]) {
            max = years[i];
        }
        if (min > years[i]) {
            min = years[i];
        }
    }
    if (oper == "right") {
        if (year != max) {
            year++;
            document.getElementById(inputname).options[index + 1].selected = true;
            document.getElementById(inputname).options[index + 1].innerHTML = year;
        }
    }
    if (oper == "left") {
        if (year != min) {
            year--;
            document.getElementById(inputname).options[index - 1].selected = true;
            document.getElementById(inputname).options[index - 1].innerHTML = year;
        }
    }
}

function showDetails(data, date) {
    //    $.ajax({
    //        type: "POST",
    //        url: "/plantchart/usermonthdetail",
    //        data: { data: data, date: date },
    //        success: function(result) {
    //            $("#chart_detail_grid").html(result);
    //            //alert(parent)
    //            //if (parent!=null && parent != undefined)
    //               // parent.iFrameHeight();
    //        }
    //    });

    h_data = data;
    h_date = date;

}

function clearDetails() {
    $("#chart_detail_grid").empty();
    //  $("#chart_detail_grid").html("<img src=\"/Images/ajax_loading_min.gif\" style=\"margin-left:48%\"/>");
}


var h_date = null;
var h_data = null;
function openDetailInfo() {
    var f = document.createElement("form");
    document.body.appendChild(f);
    f.action = "/plantchart/chartdetailhtml";
    f.target = "_blank";
    f.method = "post";
    var h1 = document.createElement("input");
    h1.type = "hidden";
    h1.value = h_date;
    h1.name = "date";
    h1.id = "date";
    f.appendChild(h1);
    var h2 = document.createElement("input");
    h2.type = "hidden";
    h2.value = h_data;
    h2.name = "data";
    h2.id = "data";
    f.appendChild(h2);
    f.submit();
}

function exportpdfchart() {
    var f = document.createElement("form");
    document.body.appendChild(f);
    f.action = "/dataexport/exportpdfchart";
    f.target = "_blank";
    f.method = "post";
    var h1 = document.createElement("input");
    h1.type = "hidden";
    h1.value = h_date;
    h1.name = "date";
    h1.id = "date";
    f.appendChild(h1);
    var h2 = document.createElement("input");
    h2.type = "hidden";
    h2.value = h_data;
    h2.name = "data";
    h2.id = "data";
    f.appendChild(h2);


    var h3 = document.createElement("input");
    h3.type = "hidden";
    h3.value = curFilename;
    h3.name = "fileName";
    h3.id = "fileName";
    f.appendChild(h3);

    f.submit();
}
    
    