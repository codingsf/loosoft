<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/UserInside.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script>
   function cbxvalue(name) {
            var values = "";
            $("input[name='" + name + "']:checked").each(function() {
                values += $(this).val() + ",";
            });
            return values == "" ? '-1,' : values;
        }
        function showtemplate(obj) {
            var name = $("#reportType").val();
            $("#" + obj.id).attr("href", "/user/reportview?pid=" + cbxvalue('plants') + "&type=user&index=" + $("#reportType").get(0).selectedIndex + "&name=" + escape(name));
        $("#" + obj.id).colorbox();
    }
</script>

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#editForm").validate({
                errorElement: "em",
                rules: {
                    plants: "required",
                    interval: {
                        required: true,
                        digits: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "interval") {
                        $("#error_interval").text('');
                        error.appendTo("#error_interval");
                       
                    }
                    if (element.attr("name") == "plants") {
                        $("#error_plants").text('');
                        error.appendTo("#error_plants");
                    }
                },

                messages: {
                    plants: "<span class='error'><%=Resources.SunResource.MUST_CHOOSE_ONE %></span>",
                    interval: {
                        required: "<span class='error'><%=Resources.SunResource.USER_REPORTCONFIG_INTERVAL_REQUIRED%></span>",
                        digits: "<span class='error'><%=Resources.SunResource.PLANT_ADDPLANT_LATITUDE_DIGITS%></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success"><%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
    </script>
    <link media="screen" rel="stylesheet" href="http://colorpowered.com/colorbox/core/example1/colorbox.css" />

    <script>
        function delitem(index) {
            if (confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE%>') == false)
                return;
            $.ajax({
                type: "POST",
                url: "/user/delreport",
                data: { id: index },
                success: function(result) {
                    if (result == "success")
                        $('#item_' + index).hide();
                    else
                        alert('error');
                }
            });
        }
       
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
    
     <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_CONFIGURATION%></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank"style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_CONFIGURATION_DETAIL%>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
                            <% using (Html.BeginForm("ReportSaves", "user", FormMethod.Post, new { @id = "editForm", name = "editForm" }))
                       {%>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <% int i = 0; foreach (var item in Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().displayPlants)
                       {
                           i++;%>
                    <td width="20%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="14%">
                                    <input type="checkbox" name="plants" id="Checkbox1" value="<%=item.id %>" checked="checked" />
                                </td>
                                <td width="86%">
                                    <%=item.name%>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%if (i % 5 == 0)
                      {
                          %>
                </tr>
                <tr>
                    <%} 
                           %>
                    <%} %>
                    
                    <%
                        for (int j = 0; j < 5- i % 5; j++)
                        {%>
                      <td></td>
                      <%
                        }   %>
                </tr>
                <tr>
                <td colspan="5">
                <span id="error_plants">&nbsp;</span>
                </td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
                <tr>
                    <td width="39%" valign="top">
                        <table width="264" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="bgz01">
                                    <%=Resources.SunResource.USER_REPORTCONFIG_ERROR_TYPE%>
                                </td>
                            </tr>
                            <tr>
                                <td height="215" background="/images/sub/up02.gif">
                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td height="40">
                                                <%=Resources.SunResource.USER_REPORTCONFIG_TEMPLATE%> :
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select name="errorType" id="errorType">
                                                    <option value="Error template1"><%=Resources.SunResource.USER_REPORTCONFIG_ERROR_TEMPLATE%>1</option>
                                                </select>  <a id="error_href" href="javascript:void(0);" onclick="showtemplate(this);"><%=Resources.SunResource.USER_REPORTCONFIG_VIEW%></a>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td height="40">
                                                <%=Resources.SunResource.USER_REPORTCONFIG_MAIL%>:   (<%=Resources.SunResource.USER_REPORTCONFIG_SEPARATED_BY_COMMAS%>)
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <textarea name="errorEmail" class="txtbu05" id="erroremail" style="width: 230px;"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="11" background="/images/sub/up03.gif">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="61%" valign="top">
                        <table width="451" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="bgz02">
                                    <%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TYPE%>
                                </td>
                            </tr>
                            <tr>
                                <td height="215" background="/images/sub/up05.gif">
                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="49%" height="40">
                                                <%=Resources.SunResource.USER_REPORTCONFIG_TEMPLATE%> :
                                            </td>
                                            <td height="40" colspan="2">
                                                <%=Resources.SunResource.USER_REPORTCONFIG_INTERVAL%> :
                                               
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select name="reportType" id="reportType">
                                                    <option value="<%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE1%>"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE1%></option>
                                                 <%--<option value="<%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE2%>"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE2%></option>--%>
                                                 <%--<option value="<%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE3%>"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE3%></option>--%>
                                                 <option value="<%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE4%>"><%=Resources.SunResource.USER_REPORTCONFIG_REPORT_TEMPLATE4%></option>
                                                </select>  <a id="report_template" href="javascript:void(0);" onclick="showtemplate(this);"><%=Resources.SunResource.USER_REPORTCONFIG_VIEW%></a>
                                                </td>
                                            <td width="34%">
                                                <label>
                                                    <%= Html.TextBox("interval", "", new { @size = "18", @class = "txtbu04" })%>
                                                </label></td>
                                            <td width="17%">
                                                <select name="data_format" id="data_format">
                                                    <option><%=Resources.SunResource.PLANT_OVERVIEW_MINS%></option>
                                                    <option><%=Resources.SunResource.PLANT_OVERVIEW_MONTH%></option>
                                                    <option><%=Resources.SunResource.CUSTOMREPORT_DAY%></option>
                                                    
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="40" colspan="3">
                                               <div>
                                                <div style="float:left; width:200px;">
                                                <%=Resources.SunResource.USER_REPORTCONFIG_MAIL%>: (<%=Resources.SunResource.USER_REPORTCONFIG_SEPARATED_BY_COMMAS%>) &nbsp;&nbsp;                                              
                                                </div>
                                                <div style="float:left;">
                                                <span id="error_interval"></span>
                                                </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <textarea name="reportEmail" class="txtbu05" id="reportEmail" style="width: 400px;"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="11" background="/images/sub/up06.gif">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                    <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().username == Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.demousername)
                      { %>
                      <input name="Submit" type="button"  class="txtbu06" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" />
              <%}
                      else
                      {
                          if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().displayPlants.Count <= 0)
                          {
                          %>
                            <input name="Submit" type="button"  class="txtbu06" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>" />
                        <%}
                          else
                          { %>
                            <input name="Submit" type="submit" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_SUBMIT%>"  />
                        <%}
                      }%>
                    </td>
                  
                    <td>
                    <script>
                        function canel() {
                            $("#interval").attr("value", "");
                            $("#reportEmail").attr("value", "");
                            $("#erroremail").attr("value", "");
                        }
                    </script>
                        <input name="Submit3" type="button" class="txtbu03" value="<%=Resources.SunResource.MONITORITEM_RESET%>" onclick="canel()" />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
        <div class="subrbox01">
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="94%" class="f_14">
                            <strong> <%=Resources.SunResource.USER_REPORTCONFIG_REPORT_CONFIG_LIST%> </strong>
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
                                    <td width="25%" align="center">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_PLANT%> </strong>
                                    </td>
                                    <td width="17%" align="center">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_CONFIG_TYPE%></strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_INTERVAL%></strong>
                                    </td>
                                    <td width="33%" align="center">
                                        <strong><%=Resources.SunResource.USER_REPORTCONFIG_EMAIL%></strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong><%=Resources.SunResource.MONITORITEM_OPERATION%></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                  
                             <% foreach (var item in ViewData["reportList"] as IList<ReportConfig>)
                                           { %>
                                           
                                           <tr id="item_<%= item.id%>">
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr>
                                    <td width="25%" height="42" align="center" style="overflow:hidden">
                                        <%foreach (var plant in item.plants)
                                          { %>
                                          <%=plant.name %><br />
                                          <%} %>
                                    </td>
                                    <td width="17%" align="center" style="overflow:hidden">
                                            <%=item.type%>
                                    </td>
                                    <td width="15%" align="center" style="overflow:hidden">
                                    <% if (item.interval == 0)
                                       { %>
                                       <%=Resources.SunResource.USER_REPORTCONFIG_REAL_TIME%>
                                       <%}
                                       else
                                       {%>
                                             <%=item.interval%> <font color="#ccc" size="1">(<%=item.intervalFormat%>)</font>
                                        <%} %>
                                    </td>
                                    <td width="33%" align="center">
                                    <div style="width:250px; overflow:auto">   <%=item.receiveEmail%></div>
                                    </td>
                                    <td width="10%" align="center">
                                    <%if (Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().username == Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.demousername)
                                      { %>
                                        <%}
                                      else
                                      { %>
                                        <a href="javascript:void(0)"onclick="delitem('<%=item.id %>')"><%=Resources.SunResource.MONITORITEM_DELETE%></a>
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                                           <%} %>
                  
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
	    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script> 
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
     <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.USER_REPORTCONFIG_REPORT_CONFIGURATION%></asp:Content>
