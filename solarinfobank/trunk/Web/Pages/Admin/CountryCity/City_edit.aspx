<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.CountryCity>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
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
                        }
                    },
                    errorPlacement: function(error, element) {
                        if (element.attr("name") == "name") {
                            $("#name_code").text('');
                            error.appendTo("#name_code");
                        }
                    },

                    messages: {
                        name: {
                            required: "<span class='error'>&nbsp;请输入名称</span>"
                        }
                    },
                    success: function(em) {
                        //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                    }
                });

            });
        </script>

        <% using (Html.BeginForm((Model != null && Model.id > 0) ? "city_edit" : "city_add", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
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
                                <img src="/images/kj/kjiico01.gif" />
                            </td>
                            <td width="93%" class="pv0216">
                                <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>城市
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
                                <%=(Model!=null&&Model.id>0)?"编辑":"添加" %>城市</strong>
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
                            选择国家：
                        </td>
                        <td width="36%">
                            <select id="pid" name="pid" class="txtbu01">
                                <%
                                    int pid = 0;
                                    string cid = Request.QueryString["cid"] == null ? "0" : Request.QueryString["cid"];
                                    int.TryParse(cid, out pid);
                                    foreach (CountryCity country in ViewData["countries"] as IList<CountryCity>)
                                    {
                                        if (country.id.Equals(this.Model == null ? pid : Model.pid))
                                        {
                                %>
                                <option value="<%=country.id %>" selected="selected">
                                    <%=country.name%></option>
                                <%}
                                        else
                                        { %>
                                <option value="<%=country.id %>">
                                    <%=country.name%></option>
                                <%} %>
                                <%} %>
                            </select>
                        </td>
                        <td width="35%">
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            城市名称：
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
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            雅虎天气Code：
                        </td>
                        <td width="70%" colspan="2">
                            <%=Html.TextBoxFor(model=>model.weather_code, new { @class = "txtbu01", @size = "30"})%>
                            在<a href="http://weather.yahoo.com/" target="_blank" style="color: Blue">雅虎天气</a>中输入城市查询后，在地址栏中获取相应的Code
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            夏令时开始：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model => model.startdate, new { @class = "txtbu01 Wdate", @size = "30", onclick = "WdatePicker({dateFmt:'MM-dd HH:00:00',isShowClear:true,lang:'zh-cn'})", @readonly = "readonly" })%>
                        </td>
                        <td width="35%">
                            <span id="start_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            夏令时结束：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model => model.enddate, new { @class = "txtbu01 Wdate", @size = "30", onclick = "WdatePicker({dateFmt:'MM-dd HH:00:00',isShowClear:true,lang:'zh-cn'})", @readonly = "readonly" })%>
                        </td>
                        <td width="35%">
                            <span id="end_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            提前小时：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model=>model.hours, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td width="35%">
                            <span id="days_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            经度：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model=>model.lon, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td width="35%">
                            <span id="Span1"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            纬度：
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model=>model.lat, new { @class = "txtbu01", @size = "30" })%>
                        </td>
                        <td width="35%">
                            <span id="Span2"></span>
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
                        <input name="Submit2" onclick="window.location='/admin/cities/<%= Model==null?pid:Model.pid%>'"
                            type="button" class="txtbu03" value=" 取消 " />
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    添加编辑城市 - SolarInfoBank
</asp:Content>
