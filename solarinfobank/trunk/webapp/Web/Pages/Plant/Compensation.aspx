<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.ADMIN_USER_LIST_USER_LIST%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script>
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

        function edititem(type, date, data, cid) {
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

        function delitem(id) {
            $.post("/plant/delcompensation", { id: id },
                function(data) {
                    if (data == 'ok')
                        document.location.reload(true);
                });
        }

        $().ready(function() {
            $("input[name='radiobutton']").click(function() {
                type = $(this).val();
                $("#cid").val(0);
            });

            $("#btnsave").click(function() {
                $.post("/plant/savecompensation", { id: $("#cid").val(), type: type, plantid: $("#plantid").val(), deviceid: '0', value: $("#compensation").val(), date: getdate() },
                function(data, textStatus) {
                    if (data == 'ok')
                        document.location.reload(true);
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

        function initdata() {
            //  alert($("#compensation_energy" + type).val());
        }

    
        
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
                                        <img src="/images/sub/subico0120.gif" width="31" height="41" />
                                    </td>
                                    <td width="93%" class="pv0216">
                                        发电量补偿
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pv0212">
                                        Here you can display visual configuration. By clicking on the elements in the tree
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
                            <li><a href="#" class="onclick">电站</a></li>
                            <li></li>
                            <li><a href="#">设备</a></li>
                        </ul>
                    </div>
                    <div class="sb_mid">
                        <table width="90%" align="center" cellpadding="0" cellspacing="0" style="line-height: 24px;">
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <input type="hidden" id="Hidden1" value="0" />
                                    <label>
                                        选择设备</label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <label>
                                        <select>
                                            <%foreach (PlantUnit unit in Model.plantUnits)
                                              {
                                                  foreach (Device device in unit.displayDevices)
                                                  { %>
                                                    <option><%=device.fullName%></option>
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
                                        <input type="radio" name="radiobutton" value="0" />
                                        累计发电量补偿</label>
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
                                        年发电量补偿</label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy1" type="text" class="txtbu01 Wdate" value="" onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});changetype(1);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <input type="radio" name="radiobutton" value="2" />
                                        月发电量补偿
                                    </label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy2" type="text" class="txtbu01 Wdate" value="" onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});changetype(2);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" height="35" style="padding-left: 5px;">
                                    <label>
                                        <input type="radio" name="radiobutton" value="3" />
                                        日发电量补偿</label>
                                </td>
                                <td width="80%" style="padding-left: 5px;">
                                    <input id="compensation_energy3" type="text" class="txtbu01 Wdate" value="" onclick="WdatePicker({isShowClear:false,lang:'<%=  (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'});;changetype(3);"
                                        readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td height="35" style="padding-left: 5px;">
                                    <span style="padding-right: 5px;">补偿值(kWh)：</span>
                                </td>
                                <td style="padding-left: 5px;">
                                    <input name="compensation" type="text" class="txtbu01" value="" id="compensation" />
                                </td>
                            </tr>
                            <tr>
                                <td height="50" align="right" valign="top" style="padding-right: 5px;">
                                    &nbsp;
                                </td>
                                <td style="padding-left: 5px;">
                                    <input name="btnsave" type="submit" class="subbu01" id="btnsave" value="保存" />
                                    <input name="Submit232222" type="submit" class="subbu01" value="取消" />
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
                                    补偿记录
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
                        <form action="/plant/compensation" method="post">
                        <input type="hidden" name="id" value="<%=this.Model.id %>" />
                        <table width="100%" height="35" border="0" cellpadding="0" cellspacing="0" bgcolor="#F9F9F9"
                            style="border: 1px dotted #E0E0E0; margin-bottom: 10px;">
                            <tr>
                                <td width="8%" height="35">
                                    <span style="padding-left: 5px;">时间：</span>
                                </td>
                                <td width="22%">
                                    <select name="datetype" id="date_type_slt">
                                        <option value="0" selected="selected">全部</option>
                                        <option value="1">最近七天</option>
                                        <option value="2">一段时间</option>
                                    </select>
                                </td>
                                <td width="10%" height="35">
                                    <span style="padding-left: 5px;">电站名：</span>
                                </td>
                                <td width="20%" height="15">
                                    <%= Html.TextBox("plantname",ViewData["plantname"], new { @class="txtbu04", size="14"}) %>
                                </td>
                                <td width="10%" height="15">
                                    <span style="padding-left: 5px;">设备名：</span>
                                </td>
                                <td width="17%" height="15">
                                    <input name="devicename" type="text" class="txtbu04" size="14" />
                                </td>
                                <td width="13%">
                                    <input name="search" type="submit" class="subbu01" value="查询" />
                                </td>
                            </tr>
                            <tr id="data_container" style="display: none">
                                <td width="10%">
                                    <span style="padding-left: 5px;">起始日期：</span>
                                </td>
                                <td width="20%">
                                    <input name="startDate" type="text" class="txtbu04 Wdate" value="<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd") %>"
                                        size="14" />
                                </td>
                                <td width="11%">
                                    <span style="padding-left: 5px;">终止日期：</span>
                                </td>
                                <td width="16%">
                                    <input name="endDate" type="text" class="txtbu04 Wdate" size="14" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" />
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
                        </form>
                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                            <tr>
                                <td width="33%" height="25" class="subline02">
                                    <strong>各称</strong>
                                </td>
                                <td width="15%" class="subline02">
                                    <strong>补偿类型</strong>
                                </td>
                                <td width="18%" class="subline02">
                                    <strong>补偿时间</strong>
                                </td>
                                <td width="22%" class="subline02">
                                    <strong>补偿值</strong>
                                </td>
                                <td width="12%" class="subline02">
                                    <strong>操作</strong>
                                </td>
                            </tr>
                            <%foreach (var item in ViewData["compensations"] as IList<Compensation>)
                              { %>
                            <tr>
                                <td class="down_line01">
                                    <%=item.displayName%>
                                </td>
                                <td class="down_line01">
                                    <%=item.typeStr %>
                                </td>
                                <td class="down_line01">
                                    <%=item.DateStr %>
                                </td>
                                <td class="down_line01">
                                    <%=item.dataValue %>
                                    kWh
                                </td>
                                <td class="down_line01">
                                    <a href="javascript:edititem(<%=item.type %>,'<%=item.DateStr  %>','<%=item.dataValue %>',<%=item.id %>)">
                                        <img src="/images/sub/pencil.gif" width="16" height="16" border="0" /></a> &nbsp;
                                    <a href="javascript:delitem(<%=item.id %>)">
                                        <img src="/images/sub/cross.gif" width="16" height="16" border="0" /></a>
                                </td>
                            </tr>
                            <%} %>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
