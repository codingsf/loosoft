<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CustomChart>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>

<link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    function cancelUrl() {
        window.location.href = "/plant/includecustomcharts/" + $("#id").val();
    }

    function delitem(index) {
        if (confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE%>') == false)
            return;
        $.ajax({
            type: "POST",
            url: "/customreport/deletechart",
            data: { id: index },
            success: function(result) {
                if (result == "success")
                    $('#item_' + index).hide();
                else
                    alert('<%=Resources.SunResource.PLANT_LOG_ERROR%>');
                parent.window.location.href = "/plant/customchart/" + $("#id").val();
            }
        });
    }

    function single_hidden() {
        //if ($("#units").get(0).length == 1)
            $(".single_hidden").hide();
         //   else
             //   $(".single_hidden").show();
    }
    function large() {
        if (!CheckSubmit()) { return false; }
        else {

            var timeInterval = $('#timeInterval').val();
            if (timeInterval == 'Month') {
                $('#startTime').val($('#curYYYY').val() + "01");
                $('#endTime').val($('#curYYYY').val() + "12");
            } else if (timeInterval == 'Day') {
                $('#startTime').val($('#curYYYYMM').val() + "01");
                $('#endTime').val($('#curYYYYMM').val() + getMaxDate($('#curYYYY').val(), $('#curMM').val()));
            } else {
                $('#startTime').val($('#curYYYYMMDD').val() + "00");
                $('#endTime').val($('#curYYYYMMDD').val() + "23");
            }
            parent.displayChart($('#id').val(), $('userId').val(), $('#plantId').val(), $('#customType').val(), $('#groupId').val(),
                                $('#productName').val(), $('#reportName').val(), $('#timeSlot').val(), $('#tcounter').val(), $('#timeInterval').val(),
                                $('#product').val(), $('#times').val(), $("#ProIdType").val(), $("#valueType").val(), $("#units").val(),
                                $('#cVal').val(), $('#productList').val(), $('#selTimes').val(), $('#startTime').val(), $('#endTime').val());
        }
    }
</script>

<script src="../../Script/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

<script src="../../Script/SetChart.js" type="text/javascript"></script>

<script type="text/javascript">
        var energyMt = <%=MonitorType.PLANT_MONITORITEM_ENERGY_CODE %>;
        $(document).ready(function() {
            changeChartType(document.getElementById("timeInterval"));
            $('#btnPreview').click(function() {
                large()
            });

            $('#Save').click(function() {
                if (!CheckSubmit()) return false;
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/Save",
                    data: { id: $('#id').val(), userId: $('#userId').val(), plantId: $('#plantId').val(),
                        customType: $('#customType').val(), groupId: $('#groupId').val(), productName: $('#productName').val(),
                        reportName: $('#reportName').val(), timeSlot: $('#timeSlot').val(), tcounter: $('#tcounter').val(),
                        timeInterval: $('#timeInterval').val(), product: $('#product').val(), times: $('#times').val(), ProIdType: $('#ProIdType').val(),
                        valueType: $('#valueType').val(), units: $('#units').val(), cVal: $('#cVal').val(), productList: $('#productList').val(), selTimes: $('#selTimes').val(),cid:$("#cid").val()
                    },
                    success: function(result) {
                        if (result != '')
                            alert(result);
                        parent.window.location.href="/plant/customcharts/"+$("#id").val();
                    },
                    beforeSend: function() {
                    }
                })
            });

            $('#btnDelDevice').click(function() {
                var oSelect = document.getElementById("productList");
                if (oSelect != null) {
                    var strnew = " <select name='productList'  class='txtbu05' style='width: 360px; font-size: 12px;height: 222px; color: #999999;' id='productList' size='15' multiple='multiple' >";
                    for (var i = 0; i < oSelect.options.length; i++) {
                        if (!oSelect.options[i].selected) {
                            strnew = strnew + "<option value='" + oSelect.options[i].value + "'>" + oSelect.options[i].text + "</option>";
                        }
                    }
                    strnew += "</select>";
                    $('#divproductList').empty();
                    $('#divproductList').append(strnew);
                }
                CheckProduct2();
            });
            
            $('#btnAddDevice').click(function() {
                var pt = "-1";
                var oSelect = document.getElementById("productList");
                var proIdType = document.getElementById("ProIdType");
                
                if($("#ProIdType").val()==""){
                    alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_VALIDSELECTUNIT %>")
                    return;//选择单元是不做任何处理
                }
                var ti = $('#timeInterval').val();
                var subType = $("#hourTypeList").val();
                
                if(ti!="Hour"){
                    subType = $("#otherTypeList").val();
                }

                var vvalue = $("#ProIdType").val() + "," + $("#valueType").val() + "&valueType," + $("#units").val() + "&Unit," + $("#cVal").val() + "&cVal," + subType + "&subType";
                var vtext = "";
                var opsProIdType = document.getElementById("ProIdType").options;
                if (null == opsProIdType || opsProIdType.length == 0) {
                } else {
                    for (var i = 0; i < opsProIdType.length; i++)
                        if ($("#ProIdType").val() == opsProIdType[i].value) {
                        vtext = vtext + "[" + opsProIdType[i].text + "]";

                    }
                }
                var timeInterval = $('#timeInterval').val();

                //判断测点和时间类型是否匹配，只有发电量才能选择hour以外的时间类型
                if($("#valueType").val()!=energyMt && timeInterval!='Hour'){
                    alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_NOMATCH %>");
                    return;
                }
                
                var opsvalueType = document.getElementById("valueType").options;
                if (null == opsvalueType || opsvalueType.length == 0) {
                } else {
                    for (var i = 0; i < opsvalueType.length; i++)
                        if ($("#valueType").val() == opsvalueType[i].value) {
                        vtext = vtext + "[" + opsvalueType[i].text + "]";
                    }
                }
                
                
                var unitss = document.getElementById("units").options;
                if (null == unitss || unitss.length == 0) {
                } else {
                    for (var i = 0; i < unitss.length; i++)
                        if ($("#units").val() == unitss[i].value) {
                        vtext = vtext + "[" + unitss[i].text + "]";

                    }
                }
                
                //var cVals = document.getElementById("cVal").options;
                //if (null == cVals || cVals.length == 0) {
                //} else {
                  //  for (var i = 0; i < cVals.length; i++)
                    //    if ($("#cVal").val() == cVals[i].value) {
                      //  vtext = vtext + "[" + cVals[i].text + "]";

                    //}
                //}
                var subTypes = document.getElementById("hourTypeList").options;
                if(ti!="Hour"){
                    subTypes = document.getElementById("otherTypeList").options;
                }
                if (null == subTypes || subTypes.length == 0) {
                } else {
                    for (var i = 0; i < subTypes.length; i++)
                        if (subType == subTypes[i].value) {
                        vtext = vtext + "[" + subTypes[i].text + "]";

                    }
                }

                if (oSelect.options.length > 0) {
                    var tmpvalue;
                    for (var i = 0; i < oSelect.options.length; i++) {
                        tmpvalue = oSelect.options[i].value;
                        if (tmpvalue.substring(0,tmpvalue.indexOf('&v')) == vvalue.substring(0,vvalue.indexOf('&v'))) {
                            alert("<%=Resources.SunResource.CUSTOMREPORT_SAME_PARAMETERS %>");
                            return;
                        }
                    }
                }

                $('#productList').append("<option value='" + vvalue + "'>" + vtext + "</option>");

                CheckProduct2();
 
            });


            $('#ProIdType').change(function() {
                if($("#ProIdType").val()==""){
                    alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_VALIDSELECTUNIT %>")
                    return;//选择单元是不做任何处理
                }
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/DropDownList",
                    data: { selectvalue: $('#ProIdType').val(),timeInterval: $('#timeInterval').val(), selecttype: "IdType",lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>' },
                    success: function(result) {
                        $('#valueType').empty();
                        $('#valueType').append(result);
                        $('#valueType').change();
                    }
                });
            });

            $('#ProIdType').init(function() {
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/DropDownList",
                    data: { selectvalue: $('#ProIdType').val(),timeInterval: $('#timeInterval').val(), selecttype: "IdType" ,lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>'},
                    success: function(result) {
                        $('#valueType').empty();
                        $('#valueType').append(result);
                    }
                });
            });

            $('#valueType').init(function() {
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/DropDownList",
                    data: { selectvalue: $('#valueType').val(), timeInterval: $('#timeInterval').val(),selecttype: "ValueType" ,lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>'},
                    success: function(result) {
                        $('#units').empty();
                        $('#units').append(result);
                        single_hidden();
                        
                    }

                });
            });

            $('#valueType').change(function() {
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/DropDownList",
                    data: { selectvalue: $('#valueType').val(),timeInterval: $('#timeInterval').val(), selecttype: "ValueType" ,lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>' },
                    success: function(result) {
                        $('#units').empty();
                        $('#units').append(result);
                        single_hidden();
                        
                    }

                });
                

            });

            $('#valueType').ready(function() {
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/DropDownList",
                    data: { selectvalue: $('#valueType').val(),timeInterval: $('#timeInterval').val(), selecttype: "ValueType",lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>' },
                    success: function(result) {
                        $('#units').empty();
                        $('#units').append(result);
                        single_hidden();
                    }

                });
            });
        });

        function clearAllOptions(oSelect) {
            if (oSelect) {
                var ops = oSelect.options;
                while (ops.length > 0) {
                    oSelect.remove(ops.length - 1);
                }
            }
        }

        /*判断select是否有options*/
        function hasOptions(oSelect) {
            if (oSelect) {
                return oSelect.options.length > 0;
            }
            return false;
        }

        function CheckProduct2() {
            var onRight = document.getElementById("productList");
            var vvv = document.getElementById("product");
            var avalue = "";
            var tmpvalue;
            for (var i = 0; i < onRight.options.length; i++) {
                tmpvalue = onRight.options[i].value;
                avalue = avalue + tmpvalue + ";";
            }
            vvv.value = avalue;

            var vvvproductName = document.getElementById("productName");
            var avText = "";
            for (var i = 0; i < onRight.options.length; i++) {
                avText = avText + onRight.options[i].text + ";";
            }
            vvvproductName.value = avText;
        }

        //检测定义的时间类型和测点是否匹配
        function CheckTimeType() {
            var timeInterval = $('#timeInterval').val();
            var onRight = document.getElementById("productList");
            var vvv = document.getElementById("product");
            var monitor = "";
            var tmpvalue;
            for (var i = 0; i < onRight.options.length; i++) {
                tmpvalue = onRight.options[i].value;
                monitor = tmpvalue.substring(tmpvalue.indexOf(",")+1,tmpvalue.indexOf("&valueType"));
                //判断测点和时间类型是否匹配，只有发电量才能选择hour以外的时间类型
                if(monitor!=energyMt && timeInterval!='Hour'){
                    alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_NOMATCH %>");
                    return false;
                }
            }
            
            return true;
        }
        
        function CheckSubmit() {
            var reportName = $("#reportName").val();
            var fail=false;
            $(".chk").each(function() {
                if ((reportName==$(this).text())&&(reportName!=$("#o_r_n").val()))  {
                    $("#reportName").focus();
                    fail=true;
                   }
                });
                if(fail)
                {
                    alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_EXISTNAME%>");
                    return false;
                }
                
            if (reportName == "") {
                alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_NAME%>")
                $("#reportName").focus();
                return false;
            }

                
            if (!hasOptions(document.getElementById("productList"))) {
                alert("<%=Resources.SunResource.CUSTOMREPORT_SAVE_FAILED_NOANYITEM %>");
                return false;
            }


            if(!CheckTimeType())return ;
            
            CheckProduct2()
            
            return true;
        }
        
        ///更加时间类型改变图表类型
        function changeChartType(obj){
            if(obj.value=="Hour"){
                $("#hour_charttype").show();
                $("#other_charttype").hide();                
            }else{
                $("#hour_charttype").hide();
                $("#other_charttype").show();                     
            }
            $.ajax({
                type: "POST",
                url: "/CustomReport/DropDownList",
                data: { selectvalue: $('#ProIdType').val(),timeInterval: $('#timeInterval').val(), selecttype: "IdType",lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name%>' },
                success: function(result) {
                    $('#valueType').empty();
                    $('#valueType').append(result);
                        single_hidden();
                    $('#valueType').change();
                }
            });
        }
</script>

<style type="text/css">
    .style1
    {
        text-align: right;
        padding-right: 10px;
    }
</style>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td width="793" valign="top" background="/images/kj/kjbg01.jpg">
    <input type="hidden" value="" id="startTime" />
    <input type="hidden" value="" id="endTime" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyy") %>"
        id="curYYYY" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"MM") %>"
        id="curMM" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyyMM") %>"
        id="curYYYYMM" />
    <input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone((Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).timezone,"yyyyMMdd") %>"
        id="curYYYYMMDD" />
    <form method="post" action="/CustomReport/Save" id="formReportConfig">
    <%--<input id="product" name="product" type="hidden" />--%>
    <%=Html.HiddenFor(model => model.product) %>
    <%=Html.HiddenFor(model => model.productName) %>
    <%=Html.HiddenFor(model => model.times) %>
    <%=Html.HiddenFor(Model=>Model.userId) %>
    <%=Html.HiddenFor(Model=>Model.plantId) %>
    <%=Html.HiddenFor(Model=>Model.id) %>
    <%=Html.Hidden("cid",Request.QueryString["cid"]) %>
    <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
        <tr>
            <td width="8">
                <img src="/images/kj/kjico02.jpg" width="8" height="63" />
            </td>
            <td width="777">
                <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7%" rowspan="2" align="center">
                            <img src="/images/kj/kjiico01.gif"/>
                        </td>
                        <td class="pv0216">
                            <%=(this.Model == null || this.Model.id.Equals(0)) ? Resources.SunResource.CUSTOMREPORT_USER_DEFINED_CREATE : Resources.SunResource.CUSTOMREPORT_USER_DEFINED_EDIT%>
                        </td>
                        <td align="right" class="help_r">
                            <a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf"
                                target="_blank" style="color: #59903E; text-decoration: underline;">
                                <%=Resources.SunResource.MONITORITEM_HELP%>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td width="75%">
                            <%=Resources.SunResource.CUSTOMREPORT_USER_DEFINED_DETAIL%>&nbsp;
                        </td>
                        <td width="18%">
                        </td>
                    </tr>
                </table>
            </td>
            <td width="6" align="right">
                <img src="/images/kj/kjico03.jpg" width="6" height="63" />
            </td>
        </tr>
    </table>
    <div class="subrbox03">
        <table width="760" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="107" align="right" style="padding-right:10px"> 
                <span style=" white-space:nowrap"><%=Resources.SunResource.CUSTOMREPORT_CHART_NAME%></span>
                </td>
                <td width="160" align="left">
                     <%=Html.TextBoxFor(Mode => Model.reportName,new {@class="textsy05"})%>
                </td>
                <td width="80" align="right" style="padding-right:10px"> 
                    <%=Resources.SunResource.CUSTOMREPORT_CHART_TIME%>
                </td>
                <td align="left"><%  
                              List<SelectListItem> customTypelis = new List<SelectListItem>();
                              customTypelis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOM_CHART_HOUR, Value = "Hour" });
                              customTypelis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOM_CHART_DAY, Value = "Day" });
                              customTypelis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOM_CHART_MONTH, Value = "Month" });
                              customTypelis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOM_CHART_YEAR, Value = "Year" });                                   
                    %>
                    <%=Html.DropDownListFor(Model => Model.timeInterval, customTypelis, new { @class = "subselect02", onchange = "changeChartType(this)" })%>
                </td>
            </tr>
        </table>
    </div>
    <div class="subrbox01">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="3%" valign="top">
                    <table width="300" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="uup08">
                                <%=Resources.SunResource.CUSTOMREPORT_TYPE%>
                            </td>
                        </tr>
                        <tr>
                            <td height="200" style="background-image: url(/images/sub/uup09.gif)">
                                <table width="90%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="35" align="right" class="style1">
                                            <%=Resources.SunResource.CUSTOMREPORT_DEVICE%>
                                        </td>
                                        <td>
                                            <%=Html.DropDownList("ProIdType", (List<SelectListItem>)ViewData[ComConst.DeviceList], new { @class = "subselect02" })%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="35" align="right" class="style1">
                                            <%=Resources.SunResource.CUSTOMREPORT_MONITORING_POINT%>
                                            <%=Html.Hidden("o_r_n",this.Model.reportName) %>
                                        </td>
                                        <td>
                                            <%=Html.DropDownList("valueType", ViewData["MonitorItems"] as List<SelectListItem>, new { @class = "subselect02" })%>
                                        </td>
                                    </tr>
                                    <tr class="single_hidden">
                                        <td height="35" align="right" class="style1">
                                            <%=Resources.SunResource.CUSTOMREPORT_UNITS%>
                                        </td>
                                        <td height="40">
                                            <select id="units" class="subselect02">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td height="35" align="right" class="style1">
                                            <%=Resources.SunResource.CUSTOMREPORT_CVAL%>
                                        </td>
                                        <td>
                                            <%  List<SelectListItem> cVallis = new List<SelectListItem>();
                                                cVallis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOMREPORT_AVG, Value = ComputeType.Avg.ToString() });
                                                cVallis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOMREPORT_MAX, Value = ComputeType.Max.ToString() });
                                                cVallis.Add(new SelectListItem { Text = Resources.SunResource.CUSTOMREPORT_MIN, Value = ComputeType.Min.ToString() });
                                            %>
                                            <%=Html.DropDownList("cVal", cVallis, new { @class = "subselect02" })%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="35" align="right" class="style1">
                                            <%=Resources.SunResource.CUSTOMREPORT_CHART_TYPE%>
                                        </td>
                                        <td>
                                            <div id="hour_charttype">
                                                <%  List<SelectListItem> sublis = new List<SelectListItem>();
                                                    sublis.Add(new SelectListItem { Text = Resources.SunResource.USER_ENERGYYEARCOMPARE_LINE, Value = ComConst.Subtype_line });
                                                    sublis.Add(new SelectListItem { Text = Resources.SunResource.USER_ENERGYYEARCOMPARE_AREA, Value = ComConst.Subtype_area });
                                                %>
                                                <%=Html.DropDownList("hourTypeList", sublis, new { @class = "subselect02" })%>
                                            </div>
                                            <div id="other_charttype" style="display: none;">
                                                <%  List<SelectListItem> sublis2 = new List<SelectListItem>();
                                                    sublis2.Add(new SelectListItem { Text = Resources.SunResource.USER_ENERGYYEARCOMPARE_LINE, Value = ComConst.Subtype_line });
                                                    sublis2.Add(new SelectListItem { Text = Resources.SunResource.USER_ENERGYYEARCOMPARE_COLUMN, Value = ComConst.Subtype_column });
                                                %>
                                                <%=Html.DropDownList("otherTypeList", sublis2, new { @class = "subselect02" })%>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="11" style="background-image: url(/images/sub/uup010.gif)">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10%" valign="top" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="20" align="center">
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <div id="divAddDevice">
                                    <a href="javascript:void(0)" id="btnAddDevice" name="btnAddDevice">
                                        <img src="/images/sub/add.gif" width="18" height="18" border="0" /><br />
                                        <%=Resources.SunResource.MONITORITEM_ADD%></a></div>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td height="30" align="center" valign="top">
                                <br />
                                <br />
                                <div id="divDelDevice">
                                    <a href="javascript:void(0)" id="btnDelDevice" name="btnDelDevice">
                                        <img src="/images/sub/delete.gif" width="18" height="18" border="0" /><br />
                                        <%=Resources.SunResource.MONITORITEM_DELETE%></a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="30%" align="center" valign="top" style="padding-top: 10px;">
                    <div id="divproductList">
                        <select name="productList" class="txtbu05" style="width: 380px; font-size: 12px;
                            height: 222px; color: #999999;" id="productList" multiple="multiple" visible="false">
                            <% if (ViewData["ProductList"] != null)
                               {
                                   foreach (SelectListItem ss in ViewData["ProductList"] as List<SelectListItem>)
                                   { %>
                            <option value="<%=ss.Value %>">
                                <%=ss.Text%></option>
                            <%   }
                               }
                               else
                               { %>
                            <%   } %>
                        </select></div>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table width="350" height="80" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <input id="btnPreview" type="button" class="txtbu03" value="<%=Resources.SunResource.CUSTOMREPORT_PREVIEW %>" />
                </td>
                <td>
                    <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().username == Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.demousername)
                      { %>
                    <input name="Submit" type="button" class="txtbu06" value="<%=Resources.SunResource.MONITORITEM_SAVE %>" />
                    <%}
                      else
                      {%>
                    <input id="Save" type="button" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> "
                        class="txtbu03" name="Save" />
                    <%} %>
                </td>
                <td>
                    <input id="cancel" type="button" value=" <%=Resources.SunResource.MONITORITEM_CANCEL %> "
                        class="txtbu03" name="cancel" onclick="cancelUrl()" />
                </td>
            </tr>
        </table>
    </div>
    </form>
    
    <div style="display: none">
        <center>
            <div id='large_container_chart' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px;">
            </div>
        </center>
    </div>
    <br />
</td>

<script src="../../Script/jquery.colorbox.js" type="text/javascript"></script>
</tr>
</table>
