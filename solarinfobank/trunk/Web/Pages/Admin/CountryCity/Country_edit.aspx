<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CountryCity>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">

        <script src="/script/jquery.js" type="text/javascript"></script>

        <script src="/script/jquery.validate.js" type="text/javascript"></script>

        <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

        <script type="text/javascript">

            $().ready(function() {
                $("#addForm").validate({
                    errorElement: "em",
                    rules: {
                        name: {
                            required: true
                        },
                        //                        start: {
                        //                            required: true
                        //                        },
                        //                        end: {
                        //                            required: true
                        //                        },
                        hours: {
                            number: true,
                            min: 0
                        }
                    },
                    errorPlacement: function(error, element) {
                        if (element.attr("name") == "name") {
                            $("#name_code").text('');
                            error.appendTo("#name_code");
                        }
                        if (element.attr("name") == "start") {
                            $("#start_code").text('');
                            error.appendTo("#start_code");
                        }
                        if (element.attr("name") == "end") {
                            $("#end_code").text('');
                            error.appendTo("#end_code");
                        }
                        if (element.attr("name") == "hours") {
                            $("#days_code").text('');
                            error.appendTo("#days_code");
                        }
                    },

                    messages: {
                        name: {
                            required: "<span class='error'>&nbsp;请输入国家名称</span>"
                        },
                        start: {
                            required: "<span class='error'>&nbsp;请输入开始时间</span>"
                        },
                        end: {
                            required: "<span class='error'>&nbsp;请输入结束时间</span>"
                        },
                        hours: {
                            number: "<span class='error'>&nbsp;请输入数字</span>"
                        }

                    },
                    success: function(em) {
                        //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                    }
                });

            });
        </script>

        <% using (Html.BeginForm((Model != null && Model.id > 0) ? "country_edit" : "country_add", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
           {%>
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
                                <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>国家
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
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="94%" class="f_14">
                            <strong>
                                <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>国家</strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    提示:*为必填项</div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            区域：
                        </td>
                        <td width="36%">
                            <%=Html.DropDownList("weather_code", new List<SelectListItem> {
                                                new SelectListItem { Text = "全部", Value = "", Selected=Model.weather_code.Equals("")},
                                                new SelectListItem { Text = "东亚", Value = "东亚", Selected=Model.weather_code.Equals("东亚")},
                                                new SelectListItem { Text = "东南亚", Value = "东南亚", Selected=Model.weather_code.Equals("东南亚")},
                                                new SelectListItem { Text = "南亚", Value = "南亚", Selected=Model.weather_code.Equals("南亚")},
                                                new SelectListItem { Text = "中亚", Value = "中亚", Selected=Model.weather_code.Equals("中亚")},
                                                new SelectListItem { Text = "西亚", Value = "西亚", Selected=Model.weather_code.Equals("西亚")},
                                                new SelectListItem { Text = "北非", Value = "北非", Selected=Model.weather_code.Equals("北非")},
                                                new SelectListItem { Text = "非洲", Value = "非洲", Selected=Model.weather_code.Equals("非洲")},
                                                new SelectListItem { Text = "东欧", Value = "东欧", Selected=Model.weather_code.Equals("东欧")},
                                                new SelectListItem { Text = "西欧", Value = "西欧", Selected=Model.weather_code.Equals("西欧")},
                                                new SelectListItem { Text = "北亚", Value = "北亚", Selected=Model.weather_code.Equals("北亚")},
                                                new SelectListItem { Text = "北美", Value = "北美", Selected=Model.weather_code.Equals("北美")},
                                                new SelectListItem { Text = "拉丁美洲", Value = "拉丁美洲", Selected=Model.weather_code.Equals("拉丁美洲")},
                                                new SelectListItem { Text = "大洋洲", Value = "大洋洲", Selected=Model.weather_code.Equals("大洋洲")},
                                                new SelectListItem { Text = "南极洲", Value = "南极洲", Selected=Model.weather_code.Equals("南极洲")}
                                                
                                                }) %>
                        </td>
                        <td width="35%">
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            国家：
                        </td>
                        <td width="36%">
                            <%=Html.HiddenFor(model=>model.id) %>
                            <%= Html.TextBoxFor(model => model.name, new { @class = "txtbu01", @size = "30" })%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="name_code"></span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <div>
            <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <input name="Submit" type="submit" class="txtbu03" value="保存 " />
                    </td>
                    <td>
                        <input name="Submit2" onclick="window.location='/admin/countries/'" type="button"
                            class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    添加国家 - SolarInfoBank
</asp:Content>
