<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Device>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    设备列表 - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link media="screen" rel="stylesheet" href="http://colorpowered.com/colorbox/core/example1/colorbox.css" />
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">

        <script>
        
            var value='<%=Request.QueryString["mname"]==null?"":Request.QueryString["mname"]  %>';
            var obfield='<%=Request.QueryString["orderby"]==null?"":Request.QueryString["orderby"]  %>';

            
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "/admin/devicemodel",
                    data: { id: 7 },
                    success: function(result) {
                        $('#d_m_c').empty();
                        $('#d_m_c').append(result);
                        var count = $("#deviceModelId option").length;
                        for (var i = 0; i < count; i++) {
                            if ($("#deviceModelId").get(0).options[i].value == value) {
                                $("#deviceModelId").get(0).options[i].selected = true;

                            }
                        }
                    }
                });

                $("#ser").click(function() {
                    isclick=true;
                    changePage(1);
                });
                
                   $("#download").click(function() {
                    window.location.href = '/admin/down_device_cabinet/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val();
                });
                
                
            });
            
            
            
            var isclick = <%=ViewData["isclick"]==null?"false":ViewData["isclick"] %>;

            function changePage(page) {
                if (!isclick)
                    window.location.href = '/admin/device_cabinet/' + page;
                else
                    window.location.href = '/admin/load_device_cabinet/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val()+'&psize='+page;
            }

           
                
           function orderby(field)
           {
                var page=<%=(ViewData["page"] as Pager).PageIndex %>;
                window.location.href = '/admin/load_device_cabinet/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val()+'&psize='+page+"&orderby="+field;
           }
        </script>

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
                            <td width="93%" class="pv0216">
                                直流配电柜
                            </td>
                        </tr>
                        <tr>
                            <td>
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
         <%if (AuthService.isAllow("admin", "device_down"))
           { %>
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="4%" align="left">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="96%" class="dblack">
                            <a href="javascript:void(0)" id="download" class="dbl">导出Excel文件</a>
                        </td>
                    </tr>
                </table>
            </div>
            <%} %>
            <div class="bitab">
                <ul id="bitab">
                    <li><a id="A2" href="/admin/devices">逆变器</a></li>
                    <li><a id="Summarytab1" href="/admin/device_em">环境检测仪</a></li>
                    <li><a id="A1" href="/admin/device_hlx">汇流箱</a></li>
                    <li><a id="Detailtab1" href="/admin/device_cabinet" class="onclick">配电柜</a></li>
                    <li><a id="A3" href="/admin/device_ammeter">电表</a></li>
                    
                </ul>
            </div>
            <div class="sb_mid">
                <div class="find">
                    <div class="find_yqi">
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="33%">
                                    电站:
                                    <input type='text' id="pname" value="<%=Request.QueryString["pname"]==null?"":Request.QueryString["pname"] %>" />
                                </td>
                                <td width="33%">
                                    设备型号 : <span id="d_m_c"></span>
                                </td>
                                <td width="33%">
                                    <input type="button" value="查询" id="ser" class="subbu01" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <br />
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                                <tr>
                                    <td width="20%" align="center">
                                        <strong><a href="#" onclick="orderby('pltname')">所属电站</a> </strong>
                                       
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>名称</strong>
                                    </td>
                                    <td width="10%" align="center">
                                         <strong><a href="#" onclick="orderby('dtype')">设备型号</a> </strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>国家</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>城市</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>直流母线电压(<%=MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_DCUXVOLT).unit%>)</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>总电流(<%=MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_TOTALCURRENT).unit%>)</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>机内温度(<%=MonitorType.getMonitorTypeByCode(MonitorType.MIC_BUSBAR_JNTEMPRATURE).unit%>)</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                        int i = 0;
                        foreach (Device d in Model)
                        {
                            if (d.plant == null || d.plant.id <= 0)
                                continue;
                            i++; %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                                <tr>
                                    <td width="20%" height="42" align="center">
                                        <%=d.plant.name %>
                                    </td>
                                    <td width="10%" align="center">
                                        <%=string.IsNullOrEmpty( d.name)?d.fullName:d.name%>
                                    </td>
                                    <td width="10%" align="center">
                                        <%=d.xinhaoName %>
                                    </td>
                                    <td width="10%" height="42" align="center">
                                        <%=d.plant.country %>
                                    </td>
                                    <td width="10%" align="center">
                                        <%=d.plant.city %>
                                    </td>
                                    <td width="10%" align="center">
                                        <%=d.getMonitorValueWithStatus(MonitorType.MIC_BUSBAR_DCUXVOLT)%>
                                    </td>
                                    <td width="10%" height="42" align="center">
                                        <%=d.getMonitorValue(MonitorType.MIC_BUSBAR_TOTALCURRENT).ToString("0.00") %>
                                    </td>
                                    <td width="10%" height="42" align="center">
                                        <%=d.getMonitorValueWithStatus((MonitorType.MIC_BUSBAR_JNTEMPRATURE))%>
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

        <script type="text/javascript" src="/script/jquery-1.3.2.min.js"></script>

        <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    </td>
</asp:Content>
