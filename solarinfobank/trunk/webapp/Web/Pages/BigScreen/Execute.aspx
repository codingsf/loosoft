<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Resources.SunResource.BIG_SCREEN_MENU%></title>

    <script src="/script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <link href="/bigscreen/css/css.css" rel="stylesheet" type="text/css" />
    <style type="text/css">.page{clear: both;width: 100%;}</style>
    <script language="javascript" type="text/javascript">
        var logo = '<%=ViewData["logo"] %>';
        var ajaxImgTop = 90;
        var pageCount = 4; //总的页面个数
        var cacheMinutes = '<%= ViewData["cacheminutes"] %>'; //数据缓存时间  分钟
        var interval = '<%= ViewData["pageinterval"] %>'; //每个页面显示时间  ms
        var lazyApplyData = false;
        var tryAgain = true; //是否重试
        var bigscreen = new function() {
            this.plantids = '<%=ViewData["plantIds"]%>',
            this.pageindex = 0,
            this.plantindex = 0,
            this.idarray = this.plantids.split(','),
            this.loadnextpage = function() {
                this.displaypage(); //显示页面
                if (++this.pageindex >= pageCount) {
                    this.pageindex = 0;
                    this.plantindex = this.plantindex >= this.idarray.length - 1 ? 0 : ++this.plantindex;
                }
                this.loadnextpagedata();
                if (tryAgain)
                    setTimeout("bigscreen.loadnextpage()", interval);
            },
            this.displaypage = function() {
                var plantid = this.idarray[this.plantindex];
                $(".plant").hide();
                $("#plant_" + plantid).show();
                $(".page").hide();
                $("#page_" + plantid + "_" + this.pageindex).show();
                if (lazyApplyData)
                    applyData(plantid, this.pageindex);
            },
            this.loadnextpagedata = function() {
                var tpageindex = this.pageindex;
                var tplantindex = this.plantindex;
                if (tpageindex >= pageCount) {
                    tpageindex = 0;
                    tplantindex = tplantindex >= this.idarray.length - 1 ? 0 : ++tplantindex;
                }
                var tplantid = this.idarray[tplantindex];
                var preDataStr = $("#cache_" + tplantid + "_page_" + tpageindex).val();
                if (((new Date() - Date.parse(preDataStr)) / 1000 / 60) > cacheMinutes || preDataStr == "") {
                    $.ajax({
                        type: "post",
                        url: "/bigscreen/loaddata",
                        data: { plantid: tplantid, datatype: tpageindex },
                        success: function(data) {
                            if (data == undefined || data == null || data == "") {
                                return false;
                            }
                            $("#data_" + tplantid + "_page_" + tpageindex).val(data);
                            $("#cache_" + tplantid + "_page_" + tpageindex).val(new Date());
                            if (!lazyApplyData)
                                applyData(tplantid, tpageindex);
                        },
                        error: function() {
                            if (preDataStr == "") {
                                tryAgain = false;
                                tryAgain = confirm("网络出现故障,是否重试");
                                if (tryAgain) bigscreen.loadnextpage();
                            }
                            return false;
                        }
                    });
                }
                if (!lazyApplyData)
                    applyData(tplantid, tpageindex);

            },
            this.play = function() {
                $.post("/bigscreen/loaddata", { plantid: this.idarray[0], datatype: 0 }, function(data) {
                    $("#data_" + bigscreen.idarray[0] + "_page_0").val(data);
                    $("#cache_" + bigscreen.idarray[0] + "_page_0").val(new Date());
                    if (!lazyApplyData)
                        applyData(bigscreen.idarray[0], 0);
                    bigscreen.loadnextpage();
                });
            }
        }

        //数据填充到页面上
        function applyData(tplantid, tpageindex) {
            var dataStr = $("#data_" + tplantid + "_page_" + tpageindex).val();
            if (dataStr == "") return false;
            var curContainer = "page_" + tplantid + "_" + tpageindex;
            if (tpageindex == 0)
                plantData(curContainer, dataStr);
            if (tpageindex == 1)
                dayChart(curContainer + "_chart", 70, true, dataStr);
            if (tpageindex == 2)
                monthChart(curContainer + "_chart", 70, true, dataStr);
            if (tpageindex == 3)
                yearChart(curContainer + "_chart", 70, true, dataStr);
        }

        //填充电站数据
        function plantData(curContainer, result) {
            var obj = eval("(" + result + ")");
            $("#" + curContainer + " label[id='name']").html(obj.plantName);
            $("#" + curContainer.replace("_0", "_1 label[id='name']")).html(obj.plantName);
            $("#" + curContainer.replace("_0", "_2 label[id='name']")).html(obj.plantName);
            $("#" + curContainer.replace("_0", "_3 label[id='name']")).html(obj.plantName);
            $("#" + curContainer + " img[id='imageurl']").attr("src", obj.imageArray);
            $("#" + curContainer + " label[id='installdate']").html(obj.installDate);
            $("#" + curContainer + " label[id='designpower']").html(obj.DesignPower);
            $("#" + curContainer + " label[id='location']").html(obj.Country + " " + obj.City);
            $("#" + curContainer + " label[id='organize']").html(obj.organize);
            $("#" + curContainer + " label[id='invertercount']").html(obj.inverterCount);
            $("#" + curContainer + " label[id='invertertypestr']").html(obj.inverterTypeStr);
            $("#" + curContainer + " label[id='dayenergy']").html(obj.dayEnergy);
            $("#" + curContainer + " label[id='dayenergyunit']").html(obj.dayEnergyUnit);
            $("#" + curContainer + " label[id='totalenergy']").html(obj.totalEnergy);
            $("#" + curContainer + " label[id='totalenergyunit']").html(obj.totalEnergyUnit);
            $("#" + curContainer + " label[id='curpower']").html(obj.curPower);
            $("#" + curContainer + " label[id='curpowerunit']").html(obj.curPowerUnit);
            $("#" + curContainer + " label[id='cq2reduce']").html(obj.CQ2reduce);
            $("#" + curContainer + " label[id='cq2reduceunit']").html(obj.CQ2reduceUnit);
            $("#" + curContainer + " label[id='solarintensity']").html(obj.solarIntensity);
            $("#" + curContainer + " label[id='solarintensityunit']").html(obj.solarIntensityUnit);
            $("#" + curContainer + " label[id='temprature']").html(obj.temprature);
            $("#" + curContainer + " label[id='tempratureunit']").html(obj.tempratureUnit);
        }

        //月日图表
        function monthChart(curContainer, ajaxImgTop, isLarge, result) {
            if (appendChartError(curContainer, result, ajaxImgTop)) {
                return;
            }
            var data = eval('(' + result + ')')
            setyAxis(data);
            setySeriesArr(data.series);
            setCategories(data.categories, isLarge);
            defineChart(curContainer);
        }
        //年月图表
        function yearChart(curContainer, ajaxImgTop, isLarge, result) {
            if (appendChartError(curContainer, result, ajaxImgTop)) {
                return;
            }
            var data = eval('(' + result + ')')
            setyAxis(data);
            setySeriesArr(data.series);
            setCategories(data.categories, isLarge);
            defineChart(curContainer);
            chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });

        }
        //功率图表
        function dayChart(curContainer, ajaxImgTop, isLarge, result) {
            if (appendChartError(curContainer, result, ajaxImgTop)) {
                return;
            }
            var data = eval('(' + result + ')')
            setyAxis(data);
            setySeriesArr(data.series);
            var intervalMins = 5;

            var interval = isLarge ? 60 / intervalMins : 120 / intervalMins;
            setCategoriesWithInterval(data.categories, isLarge, interval);
            defineChart(curContainer);
            //修改标题
            chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
        }

        $().ready(function() {
            $(".logo").attr("src", logo);
            bigscreen.play();
        })
    </script>

</head>
<body>
    <div id="container">
    </div>
    <%foreach (string plantid in (ViewData["plantArray"] as string[]))
      {
    %>
    <div id="plant_<%=plantid %>" style="display: none;" class="plant">
        <%for (int i = 0; i <= 3; i++)
          {%>
        <input type="hidden" id="cache_<%=plantid %>_page_<%=i %>" class="cache" />
        <input type="hidden" id="data_<%=plantid %>_page_<%=i %>" />
        <div class="page" id="page_<%=plantid %>_<%=i %>" style="display: none;">
            <% Html.RenderAction("renderpage", new { @id = i, @plantid = plantid });%>
        </div>
        <%}%></div>
    <% } %>

    <script src="/script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

    <script src="/Script/SetChart.js" type="text/javascript"></script>

</body>
</html>
