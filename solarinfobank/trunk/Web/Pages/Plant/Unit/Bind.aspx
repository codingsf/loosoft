<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        $().ready(function() {
            $("#collector_code").get(0).focus();
            $("#bindForm").validate({
                errorElement: "em",
                rules: {
                    displayname: {
                        required: true,
                        remote: {
                            type: "POST",
                            url: "/unit/check",
                            data: {
                                pid: function() { return $("#h_id").val(); },
                                uname: function() { return $("#displayname").val(); },
                                uid: 0

                            }

                        }
                    },
                    "collector.code": {
                        required: true
                    },
                    "collector.password": {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "displayname") {
                        $("#error_displayname").text('');
                        error.appendTo("#error_displayname");
                        parent.iFrameHeight();
                        
                    }
                    if (element.attr("name") == "collector.code") {
                        $("#error_collector_code").text('');
                        error.appendTo("#error_collector_code");
                        parent.iFrameHeight();
                        
                    }
                    if (element.attr("name") == "collector.password") {
                        $("#error_collector_password").text('');
                        error.appendTo("#error_collector_password");
                        parent.iFrameHeight();
                        
                    }
                },
                messages: {
                    displayname: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_UNIT_BIND_DISPLAYNAME_REQUIRED%></span>",
                        remote: "<span class='error'>&nbsp;<%=Resources.SunResource.AJAX_CHACKING_UNIT_NAME%></span>"
                    },
                    "collector.code": {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_CODE_REQUIRED%></span>"
                    },
                    "collector.password": {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_PASSWORD_REQUIRED%></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

            $("#collector_code").blur(putUnitName);

        });

        function putUnitName() {
            $("#displayname").val($("#collector_code").val());
        }
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <%=Html.HiddenFor(m => m.id, new { @id="h_id"}) %>
                <form id="bindForm" action="/unit/Save?plantid=<%=Model.id%>" enctype="multipart/form-data"
                method="post">
                <input name="fromurl" type="hidden" value="<%=Request["fromurl"]%>" />
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
                                        <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_BIND %>
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
                                        <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_BIND_DETAIL %>&nbsp;
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
                <div class="subrbox01">
                    <div>
                        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="94%" class="f_14">
                                    <strong>
                                        <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_BIND %></strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div class="note01">
                            <%=Resources.SunResource.MONITORITEM_NOTE %>:*
                            <%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM %></div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="pr_10" height="35">
                                    <%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_ID %>:
                                </td>
                                <td>
                                    <%= Html.TextBoxFor(PlantUnit => (ViewData["unit"] as PlantUnit).collector.code, new { @class = "txtbu04", @size = "25",style="width:185px" })%>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td colspan="2">
                                    <span id="error_collector_code"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="pr_10" height="35">
                                    <%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_PASSWORD %>:
                                </td>
                                <td>
                                    <%= Html.PasswordFor(PlantUnit => (ViewData["unit"] as PlantUnit).collector.password, new { @class = "txtbu04", @size = "25" ,style="width:185px"})%>
                                    <span class="red">*</span>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td colspan="2">
                                    <span id="error_collector_password"></span>
                                </td>
                            </tr>
                            <tr>
                                <td width="30%" height="36" class="pr_10">
                                    <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_NAMES %>:
                                </td>
                                <td width="30%">
                                    <%= Html.HiddenFor(PlantUnit=> (ViewData["unit"] as PlantUnit).collector.id) %>
                                    <%= Html.TextBoxFor(PlantUnit => (ViewData["unit"] as PlantUnit).displayname, new { @class = "txtbu04", @size = "25" ,style="width:185px"})%>
                                    <span class="red">*</span>
                                </td>
                                <td width="40%">
                                    <span class="tip">
                                        <%=Resources.SunResource.PLANT_UNIT_BIND_COLLECTOR_NAME_TIP%></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td colspan="2">
                                    <span id="error_displayname"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td colspan="2">
                                    <div style="text-align: left; color: Red; padding-left: 0px; padding: 0px;">
                                        <%= Html.ValidationMessage("Error", "", new { id = "errormessage" })%></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div>
                    <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <input name="button" type="submit" class="txtbu03" id="Submit2" value=" <%=Resources.SunResource.PLANT_UNIT_BIND_BIND %> " />
                            </td>
                            <td>
                                <%if (Request["fromurl"] != null && !Request["fromurl"].Equals(""))
                                  {%>
                                <input onclick="window.location='<%=Request["fromurl"]%>'" name="button2" type="button"
                                    class="txtbu03" id="button2" value=" <%=Resources.SunResource.MONITORITEM_CANEL %> " />
                                <%}
                                  else
                                  {%>
                                <input onclick="window.location='/unit/list/<%=Model.id %>'" name="button2" type="button"
                                    class="txtbu03" id="button1" value=" <%=Resources.SunResource.MONITORITEM_CANEL %> " />
                                <%} %>
                            </td>
                        </tr>
                    </table>
                </div>
                </form>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Model.name %>
    <%=Resources.SunResource.PLANT_UNIT_BIND_UNIT_BIND %>
</asp:Content>
