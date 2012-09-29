<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
        <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Model.name %> <%=Resources.SunResource.USER_LOG_ALL_PLANT_LOGS %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        var pageNo = 1;
        var plantId = '<%=Model.id%>';
        var Year = '<%=DateTime.Now.ToString()%>';
        $(document).ready(function() {
            changePage(1);
            $("#errorCode").multiSelect();
            $("#load").click(function() { changePage(1); });
        });


        function cbxvalue(name) {
            var values = "";
            $("input[name='" + name + "']:checked").each(function() {
                values += $(this).val() + ",";
            });
            return values == "" ? '-1,' : values;
        }
        
        function changePage(no) {

            pageNo = no;
            Year = $("#t").attr("value");
            $.ajax({
                type: "POST",
                url: "/user/log",
                data: {userId:'0', year: $("#year").attr("value"), startDate: $("#startDate").attr("value"), endDate: $("#endDate").attr("value"), state: $("#state").val(), plant: <%=Model.id%>, pindex: pageNo, errorType: cbxvalue('errorCode'), logList: cbxvalue('cbx'), ctype: $("#ctype").val() },
                success: function(result) {
                    $('#loading').hide();
                    $('#result').append(result);
                    parent.iFrameHeight();
                },
                beforeSend: function() {
                    $('#result').empty();
                    $('#loading').show();
                }
            });
        }
        var ttl1 = ' <%= Resources.SunResource.USER_LOG_SELECT_ALL%>';
        var ttl2 = ' <%= Resources.SunResource.PLANT_LOG_SELECT%>';
        var ttl3 = '% <%= Resources.SunResource.USER_LOG_SELECTED%> ';
        
    </script>

    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>
<table cellpadding=0 cellspacing=0 border=0>
<tr>
   <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.USER_LOG_ALL_PLANT_LOGS %></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.USER_LOG_ALL_PLANT_LOGS_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox03">
            <table width="100%">
                <tr>
                    <td width="6%"  align="center">
                        <img src="/images/sub/subico010.gif" width="18" height="19" />
                    </td>
                    <td>
                        <div>
                            <strong style="font-size: 14px;"><%=Resources.SunResource.USER_LOG_PREPARATION_BY_SCREENING %></strong></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                     <td width="20%">
                        <%=Resources.SunResource.USER_LOG_STARTDAY%>:
                    </td>
                     <td width="20%">
                          <%=Resources.SunResource.USER_LOG_ENDDAY%>:
                    </td>
                    <td width="20%">
                        <%=Resources.SunResource.USER_LOG_STATE %>:
                    </td>
                    <td width="20%">
                        <%=Resources.SunResource.USER_LOG_ERROR %>:
                    </td>
                    <td width="20%" valign="bottom">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    
                    <td height="36">
                        <table width="60" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <input id="startDate" name="startDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})" readonly="readonly" size="15" type="text"
                                        value='<%=DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd") %>' class="txtbu04 Wdate" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="36">
                        <table width="60" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <input id="endDate" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})" readonly="readonly" size="15" type="text"
                                        value='<%=DateTime.Now.ToString("yyyy-MM-dd") %>' class="txtbu04 Wdate" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <select name="state" id="state" class="txtbu01" style="width:120px">
                        <option value="0">
                                <%=Resources.SunResource.USER_LOG_NO_CONFIRM %></option>
                                
                                                    <option value="1">
                                <%=Resources.SunResource.USER_LOG_CONFIRMED %></option>
                            

                            <option value="-1">
                                <%=Resources.SunResource.USER_LOG_ALL %></option>
                        </select>
                    </td>
                    <td>
                        <select id="errorCode" multiple="multiple" name="errorCode" class="txtbu01" size="5" style="width: 110px">
                            <option value="">
                                <%=Resources.SunResource.USER_LOG_SELECT %>
                            </option>
                            <% foreach (ErrorType errorType in ViewData["errorTypes"] as ICollection<ErrorType>)
                               { %>
                            <option value="<%=errorType.code %>">
                                <%=errorType.name%></option>
                            <%} %>
                        </select>
                    </td>
                    <td width="9%" align="right" style="padding-left:10px">
                    <%if (Cn.Loosoft.Zhisou.SunPower.Service.AuthService.isAllow(AuthorizationCode.LOGS_SELECT))
                      { %>
                        <input name="load" class="subbu01" id="load" value="<%=Resources.SunResource.MONITORITEM_SEARCH %>"
                            type="button" />
                            <%}
                      else
                      {%>
                      
                      <input class="subbu09" value="<%=Resources.SunResource.MONITORITEM_SEARCH %>"
                            type="button" />
                            
                      <%} %>
                    </td>
                </tr>
            </table>
        </div>
        <div class="subrbox01" id="loading">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr>
                                    <td width="5%" align="center">
                                        <strong>
                                            <input type="checkbox" /></strong>
                                    </td>
                                    <td width="12%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.PLANT_DEVICEMONITOR_UNIT%></strong>
                                    </td>
                                    
                                    <td width="12%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.USER_LOG_DEVICE %></strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.USER_LOG_SEND_DATE %></strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.USER_LOG_DESCRIPTION %></strong>
                                    </td>
                                    <td width="15%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.USER_LOG_ERROR_TYPE %></strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>
                                            <%=Resources.SunResource.USER_LOG_STATE %></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">
                            <img src="../../images/ajax_loading_min.gif" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <div id="result">
        </div>

        <script src="../../script/jquery.multiSelect.js" type="text/javascript"></script>

        <link href="../../style/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
    </td>
	</tr>
</table>      
</asp:Content>
