<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.LoginRecord>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    登录日志列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <style type="text/css">
            .am_line01
            {
                border-bottom: 1px solid #E9E9E9;
                line-height: 25px;
                background: #F7F7F7;
                text-align: center;
            }
            .am_line00
            {
                border-bottom: 1px solid #DFDFDF;
                line-height: 25px;
                background: #fff;
                text-align: center;
            }
            .lir
            {
                background: url(//images/am/ad_line.gif) right no-repeat;
            }
        </style>

        <script>

            var pindex = 1;
            $(document).ready(function() {
                $("#localZone").change(function() {
                    changePage(pindex);
                });
                var d = new Date();
                var localZone = d.getTimezoneOffset() / 60;
                localZone = 0 - localZone;
                $("#localZone option").each(function() {
                    if ($(this).val() == localZone) {
                        $(this).get(0).selected = true;
                    }
                });


                changePage(pindex);
            });


            function changePage(pageIndex) {
                pindex = pageIndex;
                $.post("/admin/recordlist", { "localZone": $("#localZone").val(), "pageIndex": pindex, "uname": $("#uname").val(), "sd": $("#startdate").val(), "ed": $("#enddate").val() }, function(data) {
                    $("#result_container").html(data);
                });
            }
            
        </script>
        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <%=Html.Hidden("pageNo", ViewData["pageNo"]) %>
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
                            <td width="93%" class="pv0216">
                                登录日志列表
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
        
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="10%" height="40">
                            登录时间
                        </td>
                        <td width="20%">
                           从: <input id="startdate" name="startdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["sd"]==null? DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd"):Request.QueryString["sd"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                        <td width="20%" id="country_ctl">
                            到:  <input id="enddate" name="enddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                readonly="readonly" size="13" type="text" value='<%=Request.QueryString["ed"]==null?DateTime.Now.ToString("yyyy-MM-dd"):Request.QueryString["ed"] %>'
                                class="txtbu04 Wdate" />
                        </td>
                        <td width="50%" rowspan="2" align="left" valign="bottom" style="padding-bottom: 5px;">
                            用户名: <input type="text" style="width: 100px;" class="txtbu01" id="uname" />
                        <input type="button" onclick="changePage(1);" value="查询" class="subbu01" id="checking"
                            name="Submit" />
                            
                        </td>
                    </tr>
                </table>
            <table width="100%">
                <tr>
                    <td width="50%">
                        <img src="/images/sub/subico010.gif" width="15" height="16" />
                        <span style="padding-left: 5px; line-height: 22px; font-weight: bold; font-size: 13px;">
                            所有用户共访问系统<font color="red">
                                <%=ViewData["RecordCount"] %></font> 次 ,现统计如下</span>
                    </td>
                    <td align="right" width="50%">
                    </td>
                </tr>
            </table>
            
            
                
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/images/am/am_bg03.jpg"
                                style="border: 1px solid #DADADA; text-align: center; font-weight: bold;">
                                <tr>
                                    <td width="33%" align="center" class="lir">
                                        用户名
                                    </td>
                                    <td width="33%" align="center" class="lir">
                                        登录时间
                                        <%=Html.DropDownList("localZone",Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.Data,new {@class="txtbu01"} )%>
                                    </td>
                                    <td width="33%" align="center" class="lir">
                                        IP 地址
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" colspan="3">
                            <div id="result_container">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
