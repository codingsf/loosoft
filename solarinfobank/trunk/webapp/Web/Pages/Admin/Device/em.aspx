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

        <script>
        
            var value=<%=Request.QueryString["mname"]==null?"''":Request.QueryString["mname"]  %>;
            var obfield='<%=Request.QueryString["orderby"]==null?"":Request.QueryString["orderby"]  %>';
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "/admin/devicemodel",
                    data: { id: 5 },
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
                    window.location.href = '/admin/down_device_em/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val()+'&orderby='+obfield;
                });
                
            });
            
            
            
            var isclick = <%=ViewData["isclick"]==null?"false":ViewData["isclick"] %>;

            function changePage(page) {
                if (!isclick)
                    window.location.href = '/admin/device_em/' + page;
                else
                    window.location.href = '/admin/load_device_em/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val()+'&psize='+page+'&orderby='+obfield;
            }
            
           function orderby(field)
           {
                var page=<%=(ViewData["page"] as Pager).PageIndex %>;
                window.location.href = '/admin/load_device_em/?pname=' +$("#pname").val()+'&mname='+$("#deviceModelId").val()+'&psize='+page+"&orderby="+field;
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
                                环境检测仪
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type='hidden' id="orderby" value="pltname" />
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
                    <li><a id="A2" href="/admin/devices">逆变器</a></li>
                    <li><a id="Summarytab1" href="/admin/device_em" class="onclick">环境检测仪</a></li>
                    <li><a id="A1" href="/admin/device_hlx">汇流箱</a></li>
                    <li><a id="Detailtab1" href="/admin/device_cabinet">配电柜</a></li>
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
                                        <strong>当前日照 (<%=MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_SUNLINGHT).unit %>)</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>当前风速 (<%=MonitorType.getMonitorTypeByCode(MonitorType.MIC_DETECTOR_WINDSPEED).unit%>)</strong>
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
                                        <%=d.getMonitorValueWithStatus(MonitorType.MIC_DETECTOR_SUNLINGHT)%>
                                    </td>
                                    <td width="10%" height="42" align="center">
                                        <%=d.getMonitorValueWithStatus(MonitorType.MIC_DETECTOR_WINDSPEED)%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="30%">
                   <%if (AuthService.isAllow("admin", "device_down"))
           { %>
                  <a href="javascript:void(0)" id="download" class="dbl"><img src="/images/am/ad_bu01.gif" width="131" height="28" /></a>
                    <%} %>
                    </td>
                    <td width="70%">
                    <%Html.RenderPartial("mpage"); %>
                    </td>
                  </tr>
                </table></td>
              </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
            <%Html.RenderPartial("page"); %>
        </div>

        <script type="text/javascript" src="/script/jquery-1.3.2.min.js"></script>

        <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    </td>
</asp:Content>
