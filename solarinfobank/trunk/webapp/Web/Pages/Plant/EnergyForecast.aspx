<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.ENERGY_FORECAST_VALUE%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
      function checkform()
        {
            if(!($("#value").val()>0))
            {
                $("#error_value").html("<em><span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span></em>");
                $("#value").val('');
                $("#value").get(0).focus();
                return false;
            }
            $("#error_value").html('');
            return true;
        }
    var plantid=<%=Model.id %>;
    function changePage(page)
        {
            search(page);
        }
     function search(page)
         {
           $.post("/plant/searchforecast", {page:page,plantid:plantid},
                function(data) {
                    $("#list_container").html(data);
                    parent.iFrameHeight();
            });
            
         }
    
           function delitem(id) {
            if (confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>')) {
                $.post("/plant/delforecast", { id: id },
                function(data) {
                    if (data == 'ok')
                        search(1);
                });
            }
        }
        
        $().ready(function() {

             $("#btnreset").click(function() {
                $("#value").val('');
                $("#value").get(0).focus();
             })
             
            $("#btnsave").click(function() {
                 if(!checkform())
                    return false;
                $.post("/plant/energyforecast", { plantid: <%=this.Model.id %>, datakey: $("#date").val(), datavalue: $("#value").val() },
                function(data, textStatus) {
                    if (data == 'ok') {
                        alert('<%=Resources.SunResource.ENERGY_RATE_ADD_SUCCESS%>');
                        search(1);
                    }
                    else
                        alert(data);
                });
            });
        });
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                        </td>
                        <td width="777">
                            <table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td width="93%" class="pv0216">
                                        <%=Resources.SunResource.ENERGY_FORECAST_VALUE%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pv0212">
                                        &nbsp;
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
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="90%" align="center" cellpadding="0" cellspacing="0" style="line-height: 24px;">
                            <tr id="device_container" style="display: none">
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <input type="hidden" id="Hidden1" value="0" />
                                    <label>
                                        <%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%></label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <label>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <%=Resources.SunResource.PLANT_MONTH_DESC%> :
                                    </label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="date" type="text" class="txtbu01 Wdate" value="<%=DateTime.Now.ToString("yyyy-MM") %>"
                                        onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false,lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td height="35" style="padding-left: 5px;">
                                    <span style="padding-right: 5px;"><%=Resources.SunResource.PLANT_ENERGY_FORECAST_VALUE%> : <span class="red">*</span></span>
                                </td>
                                <td style="padding-left: 5px;">
                                    <input name="compensation" type="text" class="txtbu01" value="" id="value" /> (kWh)
                                    <span id="error_value"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="50" align="right" valign="top" style="padding-right: 5px;">
                                    &nbsp;
                                </td>
                                <td style="padding-left: 5px;">
                                    <input name="btnsave" type="submit" class="subbu01" id="btnsave" value="<%=Resources.SunResource.PLANT_ADDPLANT_SAVE%>" />
                                    <input id="btnreset" type="button" class="subbu01" value="<%=Resources.SunResource.MONITORITEM_RESET%>" /> 
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <p>
                    &nbsp;</p>
                <div class="subrbox01">
                    <div>
                        <table width="98%" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="2%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="8%" align="left">
                                    <%=Resources.SunResource.COMPENSATION_RECORD%>
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div id="list_container">
                            <% Html.RenderAction("searchforecast", new { plantid = this.Model.id, page = 1 }); %>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
