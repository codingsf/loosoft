<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.INSIDE_ENERGY_RATE%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/jquery.js" type="text/javascript"></script>

    <script src="/script/countrycity.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        function reset() {
            $("#confirmPassword").val('');
            $("#password").val('');
            $("#oldPassword").val('');
        }

        $().ready(function() {
            $("#rateEnable").change(function() {
                //$("#btnsubmit").removeClass("txtbu03");
                //$("#btnsubmit").removeClass("txtbu06");
                $(".txtbu01").attr("disabled", true);
                //$("#btnsubmit").attr("disabled", true);
                if ($(this).val() == "true") {
                    $(".txtbu01").attr("disabled", false);
                    //$("#btnsubmit").attr("disabled", false);
                    //$("#btnsubmit").addClass("txtbu03");

                } else {
                    //$("#btnsubmit").addClass("txtbu06");
                }
            });
            $("#rateEnable").change();
            $("#energyRate").get(0).focus();
            $("#userform").validate({
                errorElement: "em",
                rules: {
                    energyRate: {
                        required: true,
                        number: true,
                        min: 0
                    },
                    maxEnergyRate: {
                        required: true,
                        number: true,
                        min: 0
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "energyRate") {
                        $("#error_energyrate").text('');
                        error.appendTo("#error_energyrate");
                        parent.iFrameHeight();
                    }
                    if (element.attr("name") == "maxEnergyRate") {
                        $("#error_maxEnergyRate").text('');
                        error.appendTo("#error_maxEnergyRate");
                        parent.iFrameHeight();
                    }
                },

                messages: {
                    energyRate: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>"
                    },
                    maxEnergyRate: {
                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        number: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>",
                        min: "<span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span>"
                    }
                },
                success: function(em) {
                }
            });
        });
    </script>

    <script type="text/javascript">
        function clearMessage() {
            $("#errormessage").hide();
        }
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <form id="userform" name="userform" method="post" action="/plant/saveenergyrate">
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
                                        <%=Resources.SunResource.INSIDE_ENERGY_RATE%>
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
                                       <%=Resources.SunResource.PLANT_ENERGYFILTER_SUBTITLE%>
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
                                        <%=Resources.SunResource.INSIDE_ENERGY_RATE%></strong>
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
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Resources.SunResource.INSIDE_ENERGY_RATE%>：
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Html.DropDownListFor(model => model.rateEnable, new List<SelectListItem>(){
                            new SelectListItem(){ Text= Resources.SunResource.PLANT_EDIT_ENABLE, Value="true"},
                            new SelectListItem(){ Text= Resources.SunResource.PLANT_EDIT_DISABLE, Value="false"}
                            })%>
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Resources.SunResource.LOW_RATE%>：
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Html.HiddenFor(m=>m.id) %>
                                    <%=Html.TextBoxFor(m => m.energyRate, new { @class = "txtbu01", style = "width:150px;" })%>
                                    <span class="red">*</span>
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <span id="error_energyrate"></span>
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Resources.SunResource.HIGHT_RATE%>：
                                </td>
                            </tr>
                            <tr align="left">
                                <td height="35" class="" align="left">
                                    <%=Html.TextBoxFor(m => m.maxEnergyRate, new { @class = "txtbu01", style = "width:150px;" })%>
                                    <span class="red">*</span>
                                </td>
                            </tr>
                            <tr align="left">
                                <td align="left">
                                    <span id="error_maxEnergyRate"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="" align="left">
                                    <%= ViewData["error"] %>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div>
                    <table width="244" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="111">
                                <%
                                    if (AuthService.isAllow(AuthorizationCode.USER_CHANGE_PASSWORD))
                                    { %>
                                <input name="Submit2" type="submit" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> "
                                    id="btnsubmit" />
                                <%}
                                    else
                                    { %>
                                <input name="Submit2" type="button" class="txtbu06" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />
                                <%} %>
                            </td>
                            <td width="108">
                                <input id="cancel" type="button" onclick="reset();" class="txtbu03" value=" <%=Resources.SunResource.MONITORITEM_RESET %> " />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </div>
                </form>
            </td>
        </tr>
    </table>
</asp:Content>
