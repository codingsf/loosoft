<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Model.name %>
    <%=Resources.SunResource.PLANT_MONITOR_VIDEO_MONITOR  %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        $(document).ready(function() {
            $('#monitor').change(function() {
                var url = this.value;
                if (url.indexOf("61.190.35.174") != -1) {
                    url += "?cnname=1&cnpwd=1";
                    var now = new Date();
                    now.setTime(now.getTime() + 1000 * 60 * 30);
                    var nameValue = escape("1" + "#N1" + "1" + "#N2" + "61.190.35.174" + "#N3" + "sz160sa120sb116sc0");
                    document.cookie = "ID=" + nameValue + ";expires=" + now.toGMTString();
                }
                if (url.indexOf("http:") == -1 && url.indexOf('/') != 0)
                    url = '/' + url;
                $('#monitorwindow').attr('src', url);
            });
            $('#monitormenu').show();
            $('#mdelete').click(function() {
                if (confirm('<%=Resources.SunResource.PLANT_MONITOR_CONFIRM_DELETE  %>') == false)
                    return;
                $.ajax({
                    type: "POST",
                    url: "/plant/monitor_delete",
                    data: { key: $("#monitor").find("option:selected").attr('key') },
                    success: function(result) {
                        $("li[hel='" + $("#monitor").find("option:selected").attr('text') + "']").each(function() {
                            $(this).hide();
                        });
                        $("#monitor").find("option:selected").remove();
                        alert('<%=Resources.SunResource.PLANT_MONITOR_DELETE_SUCCESS  %> ');
                        $('#monitorwindow').attr('src', $("#monitor").val() == null ? "" : $("#monitor").val());
                        parent.location.href = '/plant/monitor/' + $("#id").val();

                    }
                })
            });
            function checkurlFormat(url) {
                var strRegex = "^((https|http|ftp|rtsp|mms)://)?[a-z0-9A-Z]{3}\.[a-z0-9A-Z][a-z0-9A-Z]{0,61}?[a-z0-9A-Z]\.com|net|cn|cc (:s[0-9]{1-4})?/$";
                var re = new RegExp(strRegex);
                if (re.test(url)) {
                    return true;
                } else {
                    alert("请输入正确的URL地址");
                    return false;
                }
            }

            $('#btnadd').click(function() {
                if ($("#tboxname").val() == "") {
                    alert("<%=Resources.SunResource.PLANT_MONITOR_PLEASE_ENTER_NAME  %>");
                    $("#tboxname")[0].focus()
                    return;
                }
                if ($("#tboxip").val() == "") {
                    alert("<%=Resources.SunResource.PLANT_MONITOR_PLEASE_ENTER_URL  %>");
                    $("#tboxip")[0].focus();
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "/plant/monitor_add",
                    data: { plantId: $("#id").val(), name: $("#tboxname").val(), url: $("#tboxip").val(), folder: $("#folder").val(), videofolder: $("#videofolder").val() },
                    success: function(result) {
                        alert("<%=Resources.SunResource.PLANT_MOITOR_ADD_SUCCESS  %>");
                        parent.location.href = '/plant/monitor/' + $("#id").val();
                    }
                })
            })

            var firstUrl = $("#monitor").val();
            if (firstUrl.indexOf("http:") == -1 && firstUrl.indexOf('/') != 0)
                firstUrl = '/' + firstUrl;
            $('#monitorwindow').attr('src', firstUrl == null ? "" : firstUrl);
        })
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.gif">
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
                                    <td class="pv0216">
                                        <%=Resources.SunResource.PLANT_MONITOR_VIDEO_MONITOR  %>
                                    </td>
                                    <td align="right" class="help_r">
                                        <a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf"
                                            target="_blank" style="color: #59903E; text-decoration: underline;">
                                            <%=Resources.SunResource.MONITORITEM_HELP%>
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="75%">
                                        <%=Resources.SunResource.PLANT_MONITOR_VIDEO_MONITOR_DETAIL  %>
                                    </td>
                                    <td width="18%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6" align="right">
                            <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                        </td>
                    </tr>
                </table>
                <div class="subrbox03">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="40%">
                                <select id="monitor" name="monitor" class="subselect02" style="width: 280px; height: 20px;
                                    line-height: 20px;">
                                    <%foreach (var item in ViewData["data"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.VideoMonitor>)
                                      { %>
                                    <option value="<%=item.url %>" key="<%=item.id %>" <%=(Request.QueryString["id"]==item.id.ToString())?"selected='selected'":"" %>>
                                        <%=item.name %></option>
                                    <%} %>
                                </select>
                            </td>
                            <td width="60%" style="color: #459001;">
                                <%if (!AuthService.isAllow(AuthorizationCode.DELETE_MONITOR) || UserUtil.isDemoUser)
                                  { %><%=Resources.SunResource.PLANT_MONITOR_DELETE%>
                                |
                                <%=Resources.SunResource.PLANT_MONITOR_ADD%>
                                <%}
                                  else
                                  {%>
                                <a id="mdelete" href="javascript:void(0)" class="green">
                                    <%=Resources.SunResource.PLANT_MONITOR_DELETE%></a> | <a href="javascript:void(0)"
                                        class="green" onclick="javascript:$('#add_container').toggle();$('#tboxname').get(0).focus();">
                                        <%=Resources.SunResource.PLANT_MONITOR_ADD%></a>
                                <%} %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="subrbox01" id="add_container" style="display: none">
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="8%" align="right">
                                    <%=Resources.SunResource.PLANT_MONITOR_NAME  %>
                                </td>
                                <td width="25%" style="padding-left: 5px;">
                                    <%=Html.HiddenFor(Model=>Model.id) %>
                                    <input type="text" id="tboxname" size="25" class="txtbu04" />
                                </td>
                                <td width="25%" align="right">
                                    <%=Resources.SunResource.PLANT_MONITOR_URL  %>
                                </td>
                                <td width="20%" style="padding-left: 5px;">
                                    <input type="text" id="tboxip" size="25" class="txtbu04" />
                                </td>
                                <td width="20%" align="right">
                                       <%if (!ProtalUtil.isBigCustomer())
                                         { %>
                                    <input type="button" id="btnadd" value="<%=Resources.SunResource.USER_MONITOR_VIDEO_SUBMIT %>"
                                        class="subbu01" />
                                        <%} %>
                                </td>
                            </tr>
                            <%if (ProtalUtil.isBigCustomer())
                              { %>
                            <tr>
                                <td colspan="5" height="10">
                                </td>
                            </tr>
                            <tr>
                                <td width="8%" align="right">
                                    文件夹
                                </td>
                                  <td width="25%" style="padding-left: 5px;">
                                    <input type="text" id="folder" size="25" class="txtbu04" />
                                </td>
                                 <td width="25%" align="right">
                                   视频文件夹
                                </td>
                                <td width="20%" style="padding-left: 5px;">
                                    <input type="text" id="videofolder" size="25" class="txtbu04" />
                                </td>
                                      <td width="20%" align="right">
                                    <input type="button" id="btnadd" value="<%=Resources.SunResource.USER_MONITOR_VIDEO_SUBMIT %>"
                                        class="subbu01" />
                                </td>
                            </tr>
                            <%} %>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div class="subrbox01">
                    <div>
                        <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" alt="<%=Resources.SunResource.MONITORITEM_EDIT  %>"
                                        title="<%=Resources.SunResource.MONITORITEM_EDIT  %>" />
                                </td>
                                <td width="94%" class="f_14">
                                    <strong>
                                        <%=Resources.SunResource.PLANT_MONITOR_VIDEO_MONITOR %></strong>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <iframe id="monitorwindow" src="" width="98%" style="margin: 0 auto; border: none;
                            margin-top: 10px;" height="800"></iframe>
                        <div class="Desc">
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                    <br/>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
