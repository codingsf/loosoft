<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.DefineReport>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>报表列表
        <%= ViewData["logoName"]%></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script>
        function iFrameHeight() {
            //set current page title 
            document.title = (document.getElementById('mainFrame').contentWindow.document.title);
            var ifm = document.getElementById("mainFrame");
            var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }
    </script>

    <script>
        $(document).ready(function() {

        })

        //取得改行当前选择的时间，用于列表行的查看和导出操作
        function setChoiseTime(reportId, typeId) {
            if (typeId == 1) {
                $("#time").val($("#d_" + reportId).val());
            } else if (typeId == 2) {
                $("#time").val($("#w_" + reportId).val());
            } else if (typeId == 3) {
                var selectyear = $("#selectYear1_" + reportId).val();
                var selectmonth = $("#selectmonth_" + reportId).val();
                $("#time").val(selectyear + "-" + selectmonth);
            } else if (typeId == 4) {
                $("#time").val($("#selectyear_" + reportId).val());
            }

        }
        //弹出层查看报表
        function jumpviewReport(reportId, typeId) {
            setChoiseTime(reportId, typeId);
            viewReports("large_container", reportId, typeId);
        }


        function viewReports(curContainer, reportId, typeId) {
            $("#cTime").val($("#time").val());
            $("#tId").val(typeId);
            $("#pId").val($("#plantId").val());
            $("#rId").val(reportId);
            $("#viewReportForm").submit();
        }
    
    </script>

</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <%=Html.Hidden("plantId",ViewData["id"]) %>
    <%=Html.Hidden("time","") %>
    <%=Html.Hidden("typeId",Request.QueryString["tId"]) %>
    <%=Html.Hidden("eventreport", TempData["eventreport"])%>
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=ViewData["logoName"]%>
                </div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <form action="/portal/ViewReport" method="get" id="viewReportForm" target="_blank">
    <input name="rId" id="rId" type="hidden" value="" />
    <input name="cTime" id="cTime" type="hidden" value="" />
    <input name="tId" id="tId" type="hidden" value="" />
    <input name="pId" id="pId" type="hidden" value="" />
    </form>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div>
                <iframe scrolling="no" onload="iFrameHeight()" id="mainFrame" frameborder="0" width="100%" src="/reports/ViewReport?rId=<%=ViewData["rid"] %>&cTime=<%=ViewData["ctime"] %>&tId=<%=ViewData["tid"] %>&pId=<%=ViewData["pid"] %>">
                </iframe>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
            <div id='large_container' style="width: 95%; height: 550px; margin-left: 40px; margin-right: 40px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
