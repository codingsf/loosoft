<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Device>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    设备列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link media="screen" rel="stylesheet" href="http://colorpowered.com/colorbox/core/example1/colorbox.css" />
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">

        <script type="text/javascript">
            var pagesize = 1;
            var obfield = '';
            function cbxvalue(name) {
                var values = "";
                $("input[name='" + name + "']:checked").each(function() {
                    values += $(this).attr("ref") + ",";
                });
                return values == "" ? '-1,' : values;
            }

            $(document).ready(function() {
                $("input[ref='40']").attr('checked', 'checked');

                $.ajax({
                    type: "POST",
                    url: "/admin/devicemodel",
                    data: { id: 1 },
                    success: function(result) {
                        $('#d_m_c').empty();
                        $('#d_m_c').append(result);
                        loading_data();
                    }
                });
                $("#download").click(function() {
                    window.location.href = "/admin/down_device_inv?pname=" + $("#pname").val() + "&mcode=" + $("#deviceModelId").val() + "&showitems=" + cbxvalue("items") + "&design_power_start" + $("#design_power_start").val() + "&design_power_end" + $("#design_power_end").val() + "&orderby=" + obfield + "&estartdate=" + $("#estartdate").val() + "&eenddate=" + $("#eenddate").val();
                })
            });

            function load_inv_counter() {
                $.ajax({
                    type: "POST",
                    url: "/admin/load_device_counter",
                    data: { pname: $("#pname").val(), mcode: $("#deviceModelId").val(), showitems: cbxvalue("items"), design_power_start: $("#design_power_start").val(), design_power_end: $("#design_power_end").val(), pagesize: pagesize, orderby: obfield
                    ,
                        estartdate: $("#estartdate").val(),
                        eenddate: $("#eenddate").val()
                    },
                    success: function(result) {
                        $('#counter_container').empty();
                        $('#counter_container').append(result);
                    }
                    //                        ,
                    //                        beforeSend: function() {
                    //                            $('#counter_container').empty();
                    //                            $('#counter_container').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                    //                        }
                });
            }

            function loading_data() {
                $.ajax({
                    type: "POST",
                    url: "/admin/load_device_inv",
                    data: { pname: $("#pname").val(), mcode: $("#deviceModelId").val(), showitems: cbxvalue("items"), design_power_start: $("#design_power_start").val(), design_power_end: $("#design_power_end").val(), pagesize: pagesize, orderby: obfield
                    ,
                        estartdate: $("#estartdate").val(),
                        eenddate: $("#eenddate").val()
                    },
                    success: function(result) {
                        $('#detail_container').empty();
                        $('#detail_container').append(result);
                        if (pagesize == 1)
                            load_inv_counter();
                    },
                    beforeSend: function() {
                        $('#detail_container').empty();
                        $('#detail_container').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                        if (pagesize == 1) {
                            $('#counter_container').empty();
                            $('#counter_container').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                        }
                    }
                });
            }
            function changePage(index) {
                pagesize = index;
                loading_data();
            }


            function orderby(field) {
                obfield = field;
                changePage(pagesize)
            }
           
                
        </script>

        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">

                    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif"/>
                            </td>
                            <td width="93%" class="pv0216">
                                逆变器列表
                            </td>
                        </tr>
                        <tr>
                            <td>
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
                    <li><a id="A2" href="javascript: void(0);" class="onclick">逆变器</a></li>
                    <li><a id="Summarytab1" href="/admin/device_em">环境检测仪</a></li>
                    <li><a id="A1" href="/admin/device_hlx">汇流箱</a></li>
                    <li><a id="A3" href="/admin/device_cabinet">配电柜</a></li>
                    <li><a id="Detailtab1" href="/admin/device_ammeter">电表</a></li>
                </ul>
            </div>
            <div class="sb_mid">
                <div class="subrbox03" style="margin:0; padding:0;">
                   <%if (AuthService.isAllow("admin", "device_down"))
                     { %>
                    <div>
                        <table width="90%" height="25" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="4%" align="left">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="96%" class="dblack">
                                    <a href="#" id="download" class="dbl">导出Execl文件</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%} %>
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="5%" height="40">
                                电站
                            </td>
                            <td width="10%">
                                <input type="text" id="pname" />
                            </td>
                            <td width="7%" align="center">
                                型号
                            </td>
                            <td width="12%" id="d_m_c">
                            </td>
                            <td width="11%" align="center">
                                安装功率
                            </td>
                            <td width="3%" align="center">
                                从
                            </td>
                            <td width="10%">
                                <input id="design_power_start" type="text" class="txtbu01" style="width: 60px;" />
                            </td>
                            <td width="3%" align="center">
                                到
                            </td>
                            <td width="15%">
                                <input id="design_power_end" type="text" class="txtbu01" style="width: 60px;" />
                            </td>
                            <td width="24%" align="left">
                                <input id="loading" type="submit" class="subbu01" onclick="changePage(1);" value="查询" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding-top: 10px;">
                                <p>
                                    数<br />
                                    据<br />
                                    项</p>
                            </td>
                            <td colspan="8">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <%
                                            int index = 0;
                                            foreach (ManagerMonitorCode mmc in ViewData["mmcs"] as IList<ManagerMonitorCode>)
                                            { %>
                                        <td width="20%" height="20">
                                            <label>
                              <input type="checkbox" name="items" value="checkbox" ref="<%=mmc.id %>" />
                              <%=mmc.name %></label>
                                        </td>
                                        <%
                                
                                            if ((++index) % 5 == 0)
                                                Response.Write("</tr><tr>");
                                            } %>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <label>
                              <input name="items" value="checkbox" ref="43" type="checkbox">
                              累计发电量 </label>
                                            <input id="estartdate" name="estartdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                                readonly="readonly" size="13" type="text" value='<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd") %>'
                                                class="txtbu04 Wdate" />
                                            <input id="eenddate" name="eenddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                                readonly="readonly" size="13" type="text" value='<%=DateTime.Now.ToString("yyyy-MM-dd") %>'
                                                class="txtbu04 Wdate" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="10">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="detail_container" style="overflow-x: auto; width: 720px;">
                </div>
                <div id="counter_container" style="overflow-x: auto">
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>

        <script type="text/javascript" src="/script/jquery-1.3.2.min.js"></script>

        <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    </td>
</asp:Content>
