<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/UserInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ChartGroup>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content3" ContentPlaceHolderID="TitleContent" runat="server">
  <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.CUSTOMREPORT_REPORT_GROUP%></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomHead" runat="server">
    <link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../Scripts/iepngfix_tilebg.js"></script>

    <script type="text/javascript">

        function large(id) {
            $("#largeview_"+id).colorbox({ width: "100%", inline: true, href: "#large_container" });
            dispalyChart(id);
        }
        function dispalyChart(id) {
            $.ajax({
                type: "POST",
                url: "/CustomReport/ChartView",
                data: { id: id },
                success: function(result) {
                    var data = eval('(' + result + ')')
                    setyAxis(data);
                    setySeriesArr(data.series);
                    setCategories(data.categories, true);
                    defineChart("large_container");
                    //修改标题
                    chart.setTitle({ text: data.name, x: 0, align: 'center' }, { text: '', x: 0, align: 'center' });
                },
                beforeSend: function() {
                    $('#large_container').empty();
                    $('#large_container').append("<img src=\"../../Images/ajax_loading.gif\" style=\"margin-left: 160px;margin-top: 70px;\" />");
                }
            });
        }
    </script>

    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />

    <script src="../../Scripts/Highcharts-2.1.3/js/highcharts.js" type="text/javascript"></script>

    <script src="../../Script/SetChart.js" type="text/javascript"></script>

    <script>
        function deletecustom(id) {
            if (confirm("<%=Resources.SunResource.CUSTOMREPORT_CONFIRM_DELETE_GROUP%>?") == 0) {
                return false;
            } else {
                window.location.href = "/CustomReport/Delete?id=" + id + "&returnUrl=%2FCustomReport%2FCreateGroup";
            }
        }
        function deleteGroup(id) {
            if (confirm("<%=Resources.SunResource.CUSTOMREPORT_DELETE_GROUP%>?") == 0) {
                return false;
            } else {
                window.location.href = "/CustomReport/DeleteGroup?id=" + id + "&returnUrl=%2FCustomReport%2FCreateGroup";
            }
        }             
    </script>

    <script>
        $(document).ready(function() {
            $('#btnSave').click(function() {
                $.ajax({
                    type: "POST",
                    url: "/CustomReport/SaveGroup",
                    data: { id: $('#id').val(), userId: $('#userId').val(), groupName: $('#groupName').val() },
                    success: function(result) {
                        if ("<%=Resources.SunResource.CUSTOMREPORT_SAVE_SUCCESSFULLY%>!" == result) {
                            alert(result);
                            window.location.href = "/CustomReport/CreateGroup";
                        } else {
                            alert(result);
                        }
                    }
                });
            });
        });
    </script>

    <script>
        function sild(id) {
            $('#divgroup' + id).slideToggle();
        }                            
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form method="post" action="/CustomReport/SaveGroup" id="formReportConfig">
        <%=Html.HiddenFor(Model=>Model.id) %>
        <%=Html.HiddenFor(Model=>Model.userId) %>
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
                                <%=Resources.SunResource.CUSTOMREPORT_USER_DEFINED%>
                            </td>
                            <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                        </tr>
                        <tr>
                            <td width="75%">
                                <%=Resources.SunResource.CUSTOMREPORT_USER_DEFINED_DETAIL%>&nbsp;
                            </td>
                            <td width="18%"></td>
                        </tr>
                    </table>
                </td>
                <td width="6" align="right">
                    <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                </td>
            </tr>
        </table>
        <div class="subrbox03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11%">
                        <%=Resources.SunResource.CUSTOMREPORT_ADD_GROUP%>
                    </td>
                    <td width="21%">
                        <%=Html.TextBoxFor(Model => Model.groupName, new { @class = "subtextsy02" })%>
                    </td>
                    <td width="68%" style="color: #459001;">
                        <input name="btnSave" type="button" class="subbu01" id="btnSave" value="<%=Resources.SunResource.MONITORITEM_SAVE %> " />
                    </td>
                </tr>
            </table>
        </div>
        <% if (Session[ComConst.ChartGroup] != null)
           {
               foreach (ChartGroup group in Session[ComConst.ChartGroup] as IList<ChartGroup>)
               {
                                             
        %>
        <div class="subrbox01">
            <div onclick="sild(<%=group.id%>)" alt="Click to show or hide">
                <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="73%" class="f_14">
                            <strong>
                                <%=group.groupName %></strong>
                        </td>
                        <td width="21%" align="right" class="f_14" style="font-size: 11px; color: #999;">
                            <a href="/CustomReport/CreateGroup/<%=group.id %>" class="dblack">
                                <%=Resources.SunResource.MONITORITEM_EDIT %></a> | <a href="/CustomReport/Defined?groupId=<%=group.id %>"
                                    class="dblack">
                                    <%=Resources.SunResource.CUSTOMREPORT_ADD_CHART %></a> | <a onclick="deleteGroup(<%=group.id %>)"
                                        href="javascript:void(0)" class="dblack">
                                        <%=Resources.SunResource.MONITORITEM_DELETE %></a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid" id="divgroup<%= group.id%>">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <% for (int i = 0; i < group.CustomReports.Count; i++)
                           {
                               CustomChart cc = new CustomChart();
                               cc = group.CustomReports[i];                                               
                        %>
                        <%if (i > 0 && i % 3 == 0)
                          { %>
                    </tr>
                    <tr>
                        <%} %>
                        <td height="36">
                            <a href="/CustomReport/Defined/<%=cc.id %>" class="dbl">
                                <%=cc.reportName %></a> <span class="fg">〈&lt;<a href="/CustomReport/Defined/<%=cc.id %>"
                                    class="dgreen"><%=Resources.SunResource.MONITORITEM_EDIT %></a> | <a href="javascript:void(0)"
                                        class="dgreen" id="largeview_<%=cc.id %>" onclick="large(<%=cc.id %>)">
                                        <%=Resources.SunResource.CUSTOMREPORT_VIEW %></a> | <a href="javascript:void(0)"
                                            class="dgreen" onclick="deletecustom(<%=cc.id %>)">
                                            <%=Resources.SunResource.MONITORITEM_DELETE %></a>&gt;〉</span>
                        </td>
                        <%} %>
                    </tr>
                </table>
                <div class="Desc">
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <%}%>
        <%} %>
        <div class="subrbox01">
            <div onclick="sild(0)" alt="Click to show or hide">
                <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="73%" class="f_14">
                            <strong>
                                <%=Resources.SunResource.ChartGroup_Default%></strong>
                        </td>
                        <td width="21%" align="right" class="f_14" style="font-size: 11px; color: #999;">
                            <span class="lbl">
                                <%=Resources.SunResource.MONITORITEM_EDIT %></span> | <a href="/CustomReport/Defined?groupId=0"
                                    class="dblack">
                                    <%=Resources.SunResource.CUSTOMREPORT_ADD_CHART %></a> | <span class="lbl">
                                        <%=Resources.SunResource.MONITORITEM_DELETE %></span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid" id="divgroup0">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <% IList<CustomChart> listCReports = Session[ComConst.ChartGroupDefault] as IList<CustomChart>;

                           if (listCReports != null && listCReports.Count > 0)
                           {
                           
                        %>
                        <% for (int i = 0; i < listCReports.Count; i++)
                           {
                               CustomChart cc = new CustomChart();
                               cc = listCReports[i];                                               
                        %>
                        <%if (i > 0 && i % 3 == 0)
                          { %>
                    </tr>
                    <tr>
                        <%} %>
                        <td height="36">
                            <a href="/CustomReport/Defined/<%=cc.id %>" class="dbl">
                                <%=cc.reportName%></a> <span class="fg">〈&lt;<a href="/CustomReport/Defined/<%=cc.id %>"
                                    class="dgreen"><%=Resources.SunResource.MONITORITEM_ADD %></a> | <a href="javascript:void(0)"
                                        class="dgreen" id="largeview_<%=cc.id %>" onclick="large(<%=cc.id %>)">
                                        <%=Resources.SunResource.CUSTOMREPORT_VIEW %></a> | <a href="javascript:void(0)"
                                            class="dgreen" onclick="deletecustom(<%=cc.id %>)">
                                            <%=Resources.SunResource.MONITORITEM_DELETE %></a>&gt;〉</span>
                        </td>
                        <%}
                           } %>
                    </tr>
                </table>
                <div class="Desc">
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
        </form>
    </td>
        <script src="../../Script/jquery.colorbox.js" type="text/javascript"></script>

    <div style="display: none">
        <center>
            <div id='large_container' style="width: 90%; height: 450px; margin-left: 40px; margin-right: 40px;">
            </div>
        </center>
    </div>
</asp:Content>
