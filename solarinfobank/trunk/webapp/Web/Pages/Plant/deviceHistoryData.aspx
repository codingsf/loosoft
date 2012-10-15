<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>

<script type="text/javascript">

    var opened = false;
    //dom加载完成时执行
    $(function() {
        //input获取焦点时在其旁边显示div
        $('#devicename').click(function() {
            if (opened == false) {
                var input = $(this);
                var offset = input.offset();
                //先后设置div的内容、位置，最后显示出来（渐进效果）
                $('#device_div')
	            .css('left', offset.left + 'px')
	            .css('top', offset.top + input.height() + 'px')
	            .fadeIn();
                opened = true;
            } else {
                $('#device_div').css('display', 'none');
                opened = false;
            }
        });

    });

    function readyinit() {
        // plantDeviceInit();

    }

    //初始化电站设备
    function plantDeviceInit() {
        var pid = $('#plantID').val();
        $.ajax({
            type: "POST",
            url: "/device/plantDevice",
            data: { pid: pid },
            success: function(result) {
                $('#dce_control').html(result);
                getFirstDevice();
                if (curDeviceId != -1)
                    loadHistoryRunData(curDeviceId)
            },
            beforeSend: function() {
            }
        });
    }

    //切换设备
    function changeDevice() {
        curDeviceId = $("#dces").val();
        //初始化时间
        $("#curYYYYMMDD").val($("#initCurYYYYMMDD").val());
        var aimDay = $("#curYYYYMMDD").val();
        aimDay = aimDay.substring(0, 4) + "-" + aimDay.substring(4, 6) + "-" + aimDay.substring(6, 8);
        $("#t").val(aimDay);

        if (curDeviceId != -1)
            loadHistoryRunData(curDeviceId)
    }

    function getFirstDevice() {
        curDeviceId = -1;
        $("#dces option").each(
          function() {
              if (curDeviceId == -1 && $(this).val() != -1) {
                  curDeviceId = $(this).val();
                  $(this).attr("selected", "true")
              }
          }
        );
    }

    var curDeviceId;
    function loadHistoryRunData(deviceId) {
        var yyyyMMdd = $("#curYYYYMMDD").val();
        curDeviceId = deviceId;
        $.ajax({
            type: "GET",
            url: "/device/historyRundata",
            data: { deviceId: deviceId, yyyyMMdd: yyyyMMdd, rad: Math.random() },
            success: function(result) {
                $("#history_container").empty();
                $('#history_container').html(result);
            }
        });
    }

    function loadRunData(deviceId) {
        $('#devicename').click();
        $('#dces').val(deviceId);
        loadHistoryRunData(deviceId);
    }

    function PreviouNextChange(oper) {
        changeDate(oper, 't');
        changeDay(document.getElementById('t'));
    }

    //改变天
    function changeDay(obj) {
        var aimDay = obj.value;
        if (aimDay) {
            aimDay = aimDay.replace("-", "").replace("-", "");
        }
        $("#curYYYYMMDD").val(aimDay)
        curDeviceId = $("#dces").val();
        if (curDeviceId != -1)
            loadHistoryRunData(curDeviceId)
    }

    function downLoadData() {
        curDeviceId = $("#dces").val();
        var yyyyMMdd = $("#curYYYYMMDD").val();
        window.open("/DataDownLoad/DownLoadRundata?deviceId=" + curDeviceId + "&yyyyMMdd=" + yyyyMMdd + "&type=" + $("#type").val());
    }
     
</script>

<input type="hidden" value="<%=Model.id%>" id="plantID" />
<input type="hidden" value="5,5" id="intervalMins" />
<input type="hidden" value="" id="monitorCode" />
<input type="hidden" value="area" id="chartType" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="curYYYYMMDD" />
<input type="hidden" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyyMMdd")%>"
    id="initCurYYYYMMDD" />
<table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
    <tr>
        <td width="8">
            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
        </td>
        <td width="777">
            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="7%" rowspan="2" align="center">
                        <img src="/images/kj/kjiico01.gif" />
                    </td>
                    <td width="93%" class="pv0216">
                        <%=Resources.SunResource.DEVICE_DEVICE_HISTORYRUN_DATA%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%=Resources.SunResource.CHART_DAY_COMPARE_DETAIL%>&nbsp;
                    </td>
                </tr>
            </table>
        </td>
        <td width="6" align="right">
            <img src="/images/kj/kjico03.jpg" width="6" height="63" />
        </td>
    </tr>
</table>
<div class="subrbox01">
    <div class="gf_midbody" style="padding-left: 0px; padding-top: 0px; padding-right: 0px;">
        <div class="gf_boxb">
            <div style='display: block'>
                <center>
                    <div>
                        <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="auto" height="30" align="right">
                                    <span style="white-space: nowrap">
                                        <%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%>:</span>
                                </td>
                                <td width="auto" align="left" style="padding-left: 5px" id="dce_control">
                                    <%-- <select name="dces" id="dces" class="subselect02" style="width:150px">
                          <option><%=Resources.SunResource.UDEVICE_PAGE_PLEASESELECT%></option>
                          </select> --%>
                                    <input type="hidden" id="dces" />
                                    <input type="text" style="width: 150px" id="devicename" />
                                    <div id="device_div" style="display: none; position: absolute; z-index: 999; border:solid 1px #ccc;">
                                        <iframe id="iframe1" name="iframe1" src="/plant/inverterstructtree/<%=Model.id %>"
                                            width="150" scrolling="auto" frameborder="0" height="500"></iframe>
                                    </div>
                                </td>
                                <td width="30%" class="f_14">
                                    <div class="date_sel" id="Div1" style="padding-bottom: 0px; padding-right: 100px;">
                                        <table border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <img src="/images/chartLeft.gif" id="Img1" width="24" height="21" onclick="PreviouNextChange('left')"
                                                        style="cursor: pointer;" />
                                                </td>
                                                <td>
                                                    <input name="t" type="text" id="t" size="12" class="indate" onfocus="WdatePicker({onpicked:function(){changeDay(this);},skin:'whyGreen',lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>',isShowClear:false,minDate:'<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value+"-01-01" %>',maxDate: '<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>'})"
                                                        readonly="readonly" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>"
                                                        style="text-align: center;" />
                                                    <input type="hidden" id="minDate" value="<%=((IList<SelectListItem>)ViewData["plantYear"])[0].Value%>-01-01" />
                                                    <input type="hidden" id="maxDate" value="<%=CalenderUtil.curDateWithTimeZone(Model.timezone,"yyyy-MM-dd")%>" />
                                                </td>
                                                <td>
                                                    <img src="/images/chartRight.gif" width="24" height="21" id="Img2" onclick="PreviouNextChange('right')"
                                                        style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td width="10%">
                                    <select name="type" id="type">
                                        <option value="csv">csv</option>
                                        <option value="xls">xls</option>
                                        <option value="pdf">pdf</option>
                                    </select>
                                </td>
                                <td width="10%" class="f_14">
                                    <input name="Submit" id="dload" type="button" onclick="downLoadData()" class="subbu01"
                                        value="<%=Resources.SunResource.RUN_REPORT_DOWNLOAD%>" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id='history_container' style="width: 100%; margin-left: 0px; margin-right: 20px;">
                    </div>
                </center>
            </div>
        </div>
    </div>
</div>

<script>    document.title = '<%=Model.name %> <%=Resources.SunResource.DEVICE_DEVICE_HISTORYRUN_DATA %>'</script>

