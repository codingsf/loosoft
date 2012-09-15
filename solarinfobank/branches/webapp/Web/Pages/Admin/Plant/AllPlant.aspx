<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    电站列表 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">

        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif"  />
                            </td>
                            <td width="93%" class="pv0216">
                                所有电站列表
                            </td>
                        </tr>
                        <tr>
                            <td class="pv0212">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="6" align="right">
                    <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                </td>
            </tr>
        </table>

        <script>
            var pageIndex = 1;
            function changePage(index) {
                pageIndex = index;
                loading_data()
            }
            function cbxvalue(name) {
                var values = "";
                $("input[name='" + name + "']:checked").each(function() {
                    values += $(this).attr("ref") + ",";
                });
                return values == "" ? '-1,' : values;
            }

            function down_excel() {
                var url = "/admin/allplants_excel?country=" + $("#country").val() + "&city=" +
                            $("#city").val() + "&items=" + cbxvalue("items") + "&design_power_start=" + $("#design_power_start").val() + "&design_power_end=" + $("#design_power_end").val() + "&area=" + $("#area").val() + "&estartdate=" + $("#estartdate").val() + "&eenddate=" + $("#eenddate").val() + "&uname=" + $("#uname").val();
                window.location.href = url;
            }

            function recommend(id) {
                if (confirm('是否推荐为示例电站?')) {
                    $.ajax({
                        type: "GET",
                        url: "/admin/recommend/" + id,
                        data: {},
                        success: function(result) {
                            loading_data();
                        },
                        beforeSend: function() {

                        }
                    });
                }
            }

            function delrecommend(id) {
                $.ajax({
                    type: "GET",
                    url: "/admin/delrecommend/" + id,
                    data: {},
                    success: function(result) {
                        loading_data();
                    },
                    beforeSend: function() {

                    }
                });
            }

            function delnewplant(id) {
                $.ajax({
                    type: "GET",
                    url: "/admin/delnewplant/" + id,
                    data: {},
                    success: function(result) {
                        loading_data();
                    },
                    beforeSend: function() {

                    }
                });
            }

            function newplant(id) {
                if (confirm('是否确定添加到首页显示?')) {
                    $.ajax({
                        type: "GET",
                        url: "/admin/newplant/" + id,
                        data: {},
                        success: function(result) {
                            loading_data();
                        },
                        beforeSend: function() {

                        }
                    });
                }
            }

            function load_plant_counter() {
                $.ajax({
                    type: "POST",
                    url: "/admin/allplants_counter",
                    data: { area: $("#area").val(),
                        country: $("#country").val(),
                        city: $("#city").val(),
                        items: cbxvalue("items"),
                        design_power_start: $("#design_power_start").val(),
                        design_power_end: $("#design_power_end").val(),
                        index: pageIndex,
                        estartdate: $("#estartdate").val(),
                        uname: $("#uname").val(),
                        eenddate: $("#eenddate").val()
                    },
                    success: function(result) {
                        $("#counter_container").html(result);
                    },
                    beforeSend: function() {
                        $('#counter_container').empty();
                        $('#counter_container').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                    }
                });
            }

            function delplant(id) {
                if (confirm('是否确定要删除电站吗,删除将不可恢复!')) {
                    $.ajax({
                        type: "GET",
                        url: "/admin/delplant/" + id,
                        data: {},
                        success: function(result) {
                            loading_data();
                        },
                        beforeSend: function() {

                        }
                    });
                }
            }

            function anonymous(pid) {
                window.open("/admin/anonymous/" + pid)
            }

            function getcountries() {
                $.ajax({
                    type: "POST",
                    url: "/admin/allcities",
                    data: { name: $("#country").val() },
                    success: function(result) {
                        $("#city_ctl").html(result);
                    },
                    beforeSend: function() {

                    }
                });
            }


            $(document).ready(function() {
                $("input[ref='1']").attr('checked', 'checked');
                $('#area').change(function() {
                    $.ajax({
                        type: "POST",
                        url: "/admin/areacountries",
                        data: { area: $("#area").val() },
                        success: function(result) {
                            $("#country_ctl").html(result);
                        },
                        beforeSend: function() {

                        }
                    });
                });


                //$('#country').change();
                changePage(1);

            });

            function loading_data() {
                $.ajax({
                    type: "POST",
                    url: "/admin/allplants",
                    data: { area: $("#area").val(),
                        country: $("#country").val(),
                        city: $("#city").val(),
                        items: cbxvalue("items"),
                        design_power_start: $("#design_power_start").val(),
                        design_power_end: $("#design_power_end").val(),
                        index: pageIndex,
                        estartdate: $("#estartdate").val(),
                        uname: $("#uname").val(),
                        eenddate: $("#eenddate").val()
                    },
                    success: function(result) {
                        $("#plant_content1").html(result);
                        if (pageIndex == 1)
                            load_plant_counter();
                    },
                    beforeSend: function() {
                        $('#plant_content1').empty();
                        $('#plant_content1').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                        if (pageIndex == 1) {
                            $('#counter_container').empty();
                            $('#counter_container').append("<center><img src=\"../../Images/ajax_loading.gif\"/></center>");
                        }
                    }
                })
            }
           
        </script>

        <div class="subrbox01">
            <%if (AuthService.isAllow("admin", "allplants_excel"))
              { %>
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="4%" align="left">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="96%" class="dblack">
                            <a href="javascript:void(0)" onclick="down_excel();" class="dbl">导出Excel文件</a>
                        </td>
                    </tr>
                </table>
            </div>
            <%} %>
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="5%" height="40">
                        区域
                    </td>
                    <td width="10%"> <%=Html.DropDownList("area", new List<SelectListItem> {
                                                new SelectListItem { Text = "全部", Value = ""},
                                                new SelectListItem { Text = "亚洲", Value = "亚洲"},
                                                new SelectListItem { Text = "欧洲", Value = "欧洲"},
                                                new SelectListItem { Text = "北美洲", Value = "北美洲"},
                                                new SelectListItem { Text = "南美洲", Value = "南美洲"},
                                                new SelectListItem { Text = "非洲", Value = "非洲"},
                                                new SelectListItem { Text = "大洋洲", Value = "大洋洲"},
                                                new SelectListItem { Text = "南极洲", Value = "南极洲"}
                                                }, new { onchange = "getcountries()" })%>
                                                
                    </td>
                    <td width="5%" height="40">
                        国家
                    </td>
                    <td width="10%" id="country_ctl">
                        <%=Html.DropDownList("country",ViewData["countries"] as IList<SelectListItem>,new { style="width:180px"})  %>
                    </td>
                    <td width="5%" align="center">
                        城市
                    </td>
                    <td width="10%" id="city_ctl">
                        <select id="city" name="city">
                            <option value="">全部</option>
                        </select>
                    </td>
                    <td width="7%" align="center">
                        用户名
                    </td>
                    <td width="10%" align="center">
                        <input id="uname" type="text" class="txtbu01" style="width: 100px;" />
                    </td>
                    <td width="11%" align="center">
                        &nbsp;安装功率
                    </td>
                    <td width="10%">
                        <input id="design_power_start" type="text" class="txtbu01" style="width: 60px;" />
                    </td>
                    <td width="3%" align="center">
                        到
                    </td>
                    <td width="25%">
                        <input id="design_power_end" type="text" class="txtbu01" style="width: 60px;" />
                    </td>
                </tr>
            </table>
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="0">                
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
                                <td width="23%" height="22">
                                    <label>
                                        <input type="checkbox" name="items" value="checkbox" ref="<%=mmc.id %>" />
                                        <%=mmc.name %></label>
                                </td>
                                <%
                                
                                    if ((++index) % 4 == 0)
                                        Response.Write("</tr><tr>");
                                    } %>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <label>
                                        <input name="items" value="checkbox" ref="46" type="checkbox">
                                        累计发电量</label>
                                    <input id="estartdate" name="estartdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                        readonly="readonly" size="13" type="text" value='<%=DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd") %>'
                                        class="txtbu04 Wdate" />
                                    <input id="eenddate" name="eenddate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh-cn'})"
                                        readonly="readonly" size="13" type="text" value='<%=DateTime.Now.ToString("yyyy-MM-dd") %>'
                                        class="txtbu04 Wdate" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="14%" rowspan="2" align="center" valign="bottom" style="padding-bottom: 5px;">
                        <input name="Submit" id="checking" type="button" class="subbu01" value="查询" onclick="changePage(1);" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div id="plant_content1" style="overflow: auto; width: 720px;">
                </div>
                <div id="counter_container" style="overflow-x: auto">
                </div>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
