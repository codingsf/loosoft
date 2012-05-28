<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Cn.Loosoft.Zhisou.SunPower.Domain.LoginRecord>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.PAGE_USER_LOGINRECORD%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">

        <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

        <script>
            var pindex = 1;
            $(document).ready(function() {
                $("#localZone").change(function() {
                    changePage(pindex);
                });
                var d = new Date();
                var localZone = d.getTimezoneOffset() / 60;
                localZone = 0 - localZone;
                $("#localZone option").each(function() {
                    if ($(this).val() == localZone) {
                        $(this).get(0).selected = true;
                    }
                });

                changePage(pindex);
            });

            function changePage(pageIndex) {
                window.parent.scroll(0,0);
                pindex = pageIndex;
                $.post("/user/recordlist", { "localZone": $("#localZone").val(), "pageIndex": pindex }, function(data) {
                    $("#result_container").html(data);
                });
            }
        </script>

        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
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
                                    <td class="pv0216">
                                        <%=Resources.SunResource.PAGE_USER_LOGINRECORD%>
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
                                        <%=Resources.SunResource.USER_ALLPLANTS_ALL_PLANTS_DETAIL%>&nbsp;
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
                <div class="subrbox01" style="height: 780px">
                    <div>
                        <table width="98%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="5%" align="center">
                                    <img src="/images/sub/subico010.gif" width="15" height="16" />
                                </td>
                                <td width="34%">
                                <%=string.Format(Resources.SunResource.PAGE_USER_LOGIN_MESSAGE, ViewData["loginCount"])%>
                                </td>
                                <td width="60%" align="right">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                        <tr>
                                            <td width="70%" align="center">
                                                <strong><%=Resources.SunResource.PAGE_USER_LOGINTIME%> </strong>
                                                <%=Html.DropDownList("localZone",Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.Data,new {@class="txtbu01"} )%>
                                            </td>
                                            <td width="30%" align="center">
                                                <strong><%=Resources.SunResource.PAGE_USER_IPADDRESS%> </strong>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" id="result_container">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
