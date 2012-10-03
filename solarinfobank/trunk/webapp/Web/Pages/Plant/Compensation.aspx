<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.ENERGY_RATE_TITLE%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script>
        function changePage(page)
        {
            search(page);
        }
        var plantid=<%=Model.id %>;
        var isplant=true;
        var type = 0;
        function getdate() {
            if ($("#compensation_energy" + type).get(0))
                return $("#compensation_energy" + type).val();
            return '';
        }

        function changetype(t) {
            $("input[name='radiobutton']").each(function() {
                if ($(this).val() == t) {
                    $(this).attr("checked", "checked");
                    type = t;
                }
            })
        }

        function edititem(t, date, data, cid,plant,plantid) {
            $("#tabplant").click();
            type=t;
            if(plant=='False')
            {
                $("#tabdevice").click();
                isplant=false;
                $("#plantid").val(plantid);
                $("#sltdevice").val(plantid);
            }
            $("input[name='radiobutton']").each(function() {
                if ($(this).val() == type) {
                    $(this).attr("checked", "checked");
                    $("#compensation_energy" + type).val(date);
                    $("#compensation").val(data);
                    $("#cid").val(cid);
                }
                window.parent.scroll(0, 0);
            })
        }
        function checkform()
        {
            if(!($("#compensation").val()>0))
            {
                $("#error_compensation").html("<em><span class='error'>&nbsp;<%=Resources.SunResource.PAGECONFIG_MENU_ERROR1%></span></em>");
                return false;
            }
            $("#error_compensation").html('');
            return true;
        }

        function delitem(id) {
            if (confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>')) {
                $.post("/plant/delcompensation", { id: id },
                function(data) {
                    if (data == 'ok')
                        search();
                });
            }
        }

         function search(page)
         {
           $.post("/plant/searchcompensation", {page:page,plantid:plantid, datetype:$("#date_type_slt").val(), searchtype:$("#searchtype").val(),deviceid:$("#searchdevice").val(),startDate:$("#startDate").val(),endDate:$("#endDate").val()},
                function(data) {
                    $("#list_container").html(data);
                    parent.iFrameHeight();
            });
         }

        $().ready(function() {
        
         $("#btnreset").click(function(){
                    $("#compensation").val('');
         });
            search();
            $("#tabplant").click(function(){
                $(this).addClass('onclick');
                $("#tabdevice").removeClass('onclick');
                $("#plantid").val(plantid);
                isplant=true;
                $("#device_container").hide();
                parent.iFrameHeight();
                $("#cid").val(0);
            });
            $("#searchtype").change(function(){
                $("#searchdevice").attr("disabled",false);
                if($(this).val()=='1')
                {   
                    $("#searchdevice").attr("disabled",true);
                }
            })
            $("#searchtype").change();
            $("#tabdevice").click(function(){
                $(this).addClass('onclick');
                $("#tabplant").removeClass('onclick');
                $("#device_container").show();
                parent.iFrameHeight();
                $("#cid").val(0);
                isplant=false;
                $("#plantid").val(0)
            });
        
            $("input[name='radiobutton']").click(function() {
                type = $(this).val();
                $("#cid").val(0);
            });

            $("#sltdevice").change(function(){
                isplant=false;
                $("#plantid").val($(this).val())
            });
            
            $("#btnsave").click(function() {
            if(!checkform())
            return false;
                $.post("/plant/savecompensation", { id: $("#cid").val(), type: type, isplant:isplant, plantid: $("#plantid").val(), value: $("#compensation").val(), date: getdate() },
                function(data, textStatus) {
                    if (data == 'ok')
                    {
                      alert('<%=Resources.SunResource.ENERGY_RATE_ADD_SUCCESS%>');
                      search();
                      }
                      else
                      alert(data);
                });
            });


            $("#date_type_slt").change(function() {
                if ($(this).val() == "2")
                    $("#data_container").show();
                else
                    $("#data_container").hide();
                parent.iFrameHeight();
            });
        })
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
                                        <%=Resources.SunResource.ENERGY_RATE_TITLE%>
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
                    <div class="bitab">
                        <ul id="bitab">
                            <li><a id="tabplant" href="javascript:void(0)" class="onclick">
                                <%=Resources.SunResource.PLANT_CODE%></a></li>
                            <li></li>
                            <li><a id="tabdevice" href="javascript:void(0)">
                                <%=Resources.SunResource.PLANT_LOG_DEVICE%></a></li>
                        </ul>
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
                                        <select name="sltdevice" id="sltdevice">
                                            <option selected="selected">
                                                <%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%></option>
                                            <%foreach (PlantUnit unit in Model.plantUnits)
                                              {%>
                                            <optgroup label="<%=unit.displayname%>">
                                            </optgroup>
                                            <% foreach (Device device in unit.displayDevices)
                                               { %>
                                            <option value="<%=device.id %>">&nbsp;&nbsp;<%=device.fullName%></option>
                                            <%}
                                              } %>
                                        </select>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <input type="hidden" id="cid" value="0" />
                                    <label>
                                        <input type="radio" name="radiobutton" value="0" checked="checked" />
                                        <%=Resources.SunResource.TOTAL_COMPENSATION_ENERGY%></label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <label>
                                        <input type="hidden" id="plantid" value="<%=this.Model.id %>" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <input type="radio" name="radiobutton" value="1" />
                                        <%=Resources.SunResource.YEAR_COMPENSATION_ENERGY%></label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy1" type="text" class="txtbu01 Wdate" value="<%=DateTime.Now.Year %>"
                                        onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});changetype(1);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <input type="radio" name="radiobutton" value="2" />
                                        <%=Resources.SunResource.MONTH_COMPENSATION_ENERGY%>
                                    </label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy2" type="text" class="txtbu01 Wdate" value="<%=DateTime.Now.ToString("yyyy-MM") %>"
                                        onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});changetype(2);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <input type="radio" name="radiobutton" value="3" />
                                        <%=Resources.SunResource.DAY_COMPENSATION_ENERGY%></label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy3" type="text" class="txtbu01 Wdate" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>"
                                        onclick="WdatePicker({isShowClear:false,lang:'<%=(Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});;changetype(3);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td height="35" style="padding-left: 5px;">
                                    <span style="padding-right: 5px;">
                                        <%=Resources.SunResource.COMPENSATION_VALUE%>(kWh): <span class="red">*</span></span>
                                </td>
                                <td style="padding-left: 5px;">
                                    <input name="compensation" type="text" class="txtbu01" value="" id="compensation" />
                                    <span id="error_compensation"></span>
                                </td>
                            </tr>
                            <tr>
                                <td height="50" align="right" valign="top" style="padding-right: 5px;">
                                    &nbsp;
                                </td>
                                <td style="padding-left: 5px;">
                                    <%if (UserUtil.getCurUser().username != UserUtil.demousername)
                                      { %>
                                    <input name="btnsave" type="submit" class="subbu01" id="btnsave" value="<%=Resources.SunResource.PLANT_ADDPLANT_SAVE%>" />
                                    <%}
                                      else
                                      { %>
                                    <input name="btnsave" type="submit" class="subbu09" value="<%=Resources.SunResource.PLANT_ADDPLANT_SAVE%>" />
                                    <%} %>
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
                        <input type="hidden" name="id" value="<%=this.Model.id %>" />
                        <table width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F9F9F9"
                            style="border: 1px dotted #E0E0E0; margin-bottom: 10px;">
                            <tr>
                                <td width="8%" height="35">
                                    <span style="padding-left: 5px;">
                                        <%=Resources.SunResource.CUSTOMREPORT_TIME%>:</span>
                                </td>
                                <td width="22%">
                                    <select name="datetype" id="date_type_slt">
                                        <option value="0" selected="selected">
                                            <%=Resources.SunResource.PLANT_LOG_ALL%></option>
                                        <option value="1">
                                            <%=Resources.SunResource.COMPENSATION_LAST_SEVEN_DAYS%></option>
                                        <option value="2">
                                            <%=Resources.SunResource.COMPENSATION_PREIOD_TIME%></option>
                                    </select>
                                </td>
                                <td width="10%" height="35">
                                    <span style="padding-left: 5px;">
                                        <%=Resources.SunResource.COMPENSATION_TYPE%>:</span>
                                </td>
                                <td width="20%" height="15">
                                    <select id="searchtype">
                                        <option value="1">
                                            <%=Resources.SunResource.DEVICETYPE_0%></option>
                                        <option value="0">
                                            <%=Resources.SunResource.PLANT_LOG_DEVICE%></option>
                                    </select>
                                </td>
                                <td width="10%" height="15">
                                    <span style="padding-left: 5px;">
                                        <%=Resources.SunResource.PLANT_DEVICE_NAME%>:</span>
                                </td>
                                <td width="17%" height="15">
                                    <select name="sltdevice" id="searchdevice">
                                        <option selected="selected" value="0">
                                            <%=Resources.SunResource.UDEVICE_PAGE_SELECT_DEVICE%></option>
                                        <%foreach (PlantUnit unit in Model.plantUnits)
                                          {%>
                                        <optgroup label="<%=unit.displayname%>">
                                        </optgroup>
                                        <% foreach (Device device in unit.displayDevices)
                                           { %>
                                        <option value="<%=device.id %>">&nbsp;&nbsp;<%=device.fullName%></option>
                                        <%}
                                          } %>
                                    </select>
                                </td>
                                <td width="13%">
                                    <%if (UserUtil.getCurUser().username != UserUtil.demousername)
                                      { %>
                                    <input name="search" type="button" onclick="search();" class="subbu01" value="<%=Resources.SunResource.MONITORITEM_SEARCH%>" />
                                    <%}
                                      else
                                      { %>
                                    <input name="search" type="button" class="subbu09" value="<%=Resources.SunResource.MONITORITEM_SEARCH%>" />
                                    <%} %>
                                </td>
                            </tr>
                            <tr id="data_container" style="display: none">
                                <td width="10%">
                                    <span style="padding-left: 5px;">
                                        <%=Resources.SunResource.USER_LOG_STARTDAY%>：</span>
                                </td>
                                <td width="20%">
                                    <input name="startDate" id="startDate" onclick="WdatePicker({isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});"
                                        type="text" class="txtbu04 Wdate" value="<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd") %>"
                                        size="14" />
                                </td>
                                <td width="11%">
                                    <span style="padding-left: 5px;">
                                        <%=Resources.SunResource.USER_LOG_ENDDAY%>：</span>
                                </td>
                                <td width="16%">
                                    <input name="endDate" id="endDate" type="text" class="txtbu04 Wdate" onclick="WdatePicker({isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});"
                                        size="14" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" />
                                </td>
                                <td width="13%">
                                    &nbsp;
                                </td>
                                <td width="8%" height="35">
                                </td>
                                <td width="22%">
                                </td>
                            </tr>
                        </table>
                        <div id="list_container">
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="33%" height="25" class="subline02">
                                        <strong>
                                            <%=Resources.SunResource.COMPENSATION_OBJ_NAME%></strong>
                                    </td>
                                    <td width="15%" class="subline02">
                                        <strong>
                                            <%=Resources.SunResource.COMPENSATION_TYPE%></strong>
                                    </td>
                                    <td width="18%" class="subline02">
                                        <strong>
                                            <%=Resources.SunResource.COMPENSATION_TIME%></strong>
                                    </td>
                                    <td width="22%" class="subline02">
                                        <strong>
                                            <%=Resources.SunResource.COMPENSATION_VALUE%></strong>
                                    </td>
                                    <td width="12%" class="subline02">
                                        <strong>
                                            <%=Resources.SunResource.MONITORITEM_OPERATE%></strong>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
