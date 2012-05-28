<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--
      <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %>  <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_YEARS_COMPARED%> 
-->

    <script type="text/javascript">
        function readyinit() {
            $('#EYearChart').click(displayYearEChart);
            $('#kwpYearChart').click(displayYearKwpChart);
            displayYearEChart();
        }
        
        function displayYearEChart() {
            yearECompareChart("container", 40, false);
            curChart = "EYearChart";
        }
        
        function displayYearKwpChart() {
            yearKwpCompareChart("container", 40, false);
            curChart = "kwpYearChart";
        }

        function largeycp() {
            $("#toLargeChart").colorbox({ width: "100%", inline: true, href: "#large_containerycp" });
            if (curChart == "EYearChart")
                yearECompareChart("large_containerycp", 130, true);
            else if (curChart == "kwpYearChart") {
                yearKwpCompareChart("large_containerycp", 130, true);
            } 
        }
        function yearECompareChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("EYearChart");
            $.ajax({
                type: "POST",
                url: "/plantChart/PlantYearCompare",
                data: { id: $("#pid").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, isLarge);
                    defineChart(curContainer);
                    //修改标题
                    showDetails(result);
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }

        function yearKwpCompareChart(curContainer, ajaxImgTop, isLarge) {
            changeStyle("kwpYearChart");
            $.ajax({
                type: "POST",
                url: "/plantchart/PlantYearPCompareChart",
                data: { id: $("#pid").val(), chartType: $("#chartType").val() },
                success: function(result) {
                    if (appendChartError(curContainer, result, ajaxImgTop)) {
                        return;
                    }
                    var data = eval('(' + result + ')')
                    setExportChart('<%=Request.Url.Scheme + "://" + Request.Url.Host + ":" + Request.Url.Port %>/DataExport/ExportChart', data.serieNo, "" + "<%=Model.name%>", data.name);
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategoriesWithInterval(data.categories, isLarge);
                    defineChart(curContainer);
                    //修改标题
                    showDetails(result);
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#' + curContainer).empty();
                    $('#' + curContainer).append("<center><img src=\"../../Images/ajax_loading.gif\" style=\"margin-top: " + ajaxImgTop + "px;\" /></center>");
                }
            });
        }
        function changeStyle(curId) {
            clearDetails();
            $("#EYearChart").attr("class", "noclick");
            $("#kwpYearChart").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");

            $("#date_EYearChart").hide();
            $("#date_kwpYearChart").hide();
            $("#date_" + curId).show();
        }

        function changeYearE(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#estartYYYYMMDDHH").val(aimDay + "00")
            $("#eendYYYYMMDDHH").val(aimDay + "23")
            displayEDayChart();
        }

        function changeYearKwp(obj) {
            var aimDay = obj.value;
            if (aimDay) {
                aimDay = aimDay.replace("-", "").replace("-", "");
            }
            $("#pstartYYYYMMDDHH").val(aimDay + "00")
            $("#pendYYYYMMDDHH").val(aimDay + "23")
            displayPDayChart();
        }
    </script>
    

    <input type="hidden" value="<%=Model.id%>" id="pid" />
    <input type="hidden" value="<%=DateTime.Now.Year%>" id="year" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")%>" id="month" />     
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>00" id="estartYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>23" id="eendYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>00" id="pstartYYYYMMDDHH" />
    <input type="hidden" value="<%=DateTime.Now.Year+DateTime.Now.Month.ToString("00")+DateTime.Now.Day.ToString("00") %>23" id="pendYYYYMMDDHH" />
    <input type="hidden" value="column" id="chartType" />
    
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_YEARS_COMPARED%></td>
                </tr>
                <tr>
                  <td><%=Resources.SunResource.CHART_ENERGY_YEAR_COMPARE_DETAIL%>&nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="subico01">
                    <ul id="change">
                        <li style="cursor: pointer;"><a id="EYearChart" class="onclick"  href="javascript:void(0)"><%=Resources.SunResource.CHART_ENERGY_YEAR_COMPARE%></a></li>
                        <li style="cursor: pointer;"><a id="kwpYearChart" class="noclick" href="javascript:void(0)"><%=Resources.SunResource.CHART_INVESTMENT_INCOME_COMPARE%></a></li>
                    </ul>
                </div>
                <div class="z_big">
                    <a id="toLargeChart" href="javascript:void(0)" onclick="largeycp()" onfocus="javascript:this.blur();">
                    </a></div>
                <div class="chart">
                    <div class="chart_box">
                        <div id="chartDiv">
                            <div id='container' style='width: 100%; height: 300px; margin-left: 2px; margin-right: 2px;'>
                            </div>
                        </div>

                            <div id="chart_detail_grid" style=" width:100%; margin-top:15px; overflow:hidden;">
                                
                            </div>
                        <div style="display: none">
                            <center>
                                <div id='large_containerycp' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px;">
                                </div>
                            </center>
                        </div>
                    </div>
                    <div class="chart_down">
                    </div>
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>

<script>    document.title = '<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_YEARS_COMPARED %>'</script>
