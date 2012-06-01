<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Hashtable>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    设备接线图
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />

    <script>
         var ttl1 = ' <%= Resources.SunResource.USER_LOG_SELECT_ALL%>';
        var ttl2 = ' <%= Resources.SunResource.PLANT_LOG_SELECT%>';
        var ttl3 = '% <%= Resources.SunResource.USER_LOG_SELECTED%> ';
        $(document).ready(function() {
            $("#btnsaveconfig").click(function() {
            $.get('/user/relationconfig/',
                  {
                      relationId: <%=ViewData["pid"] %>,
                      relationType: '<%=RelationConfig.DeviceType %>',
                      width: $("#config1").val(),
                      height: $("#config2").val(),
                      config3: $("#config3").val(),
                      config4: $("#config4").val(),
                      config5:$("#name").val()
                  },
                  function(data) {
                      if (data == "ok")
                          window.location.reload(true);
                  });
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $("#deviceId").change(function() {
                $.get("/plant/getdevicemonitor", { id: $("#deviceId").val() }, function(data) {
                    $("#mt").html(data);
                    $("#monitorCode").multiSelect();
                });

                $.get("/plant/getchilddevice", { id: $("#deviceId").val(), pid: $("#plantId").val() }, function(data) {
                    $("#cd").html(data);
                    $("#btnsubmit").attr("disabled", false);
                });
            });

            var did = '<%=TempData["hdndid"] %>';
            $("#parentDeviceId option").each(function() {
                if ($(this).val() == did) {
                    $(this).get(0).selected = true;
                }
            })

            $("#deviceId").change();

            var error = '<%=TempData["error"]==null?"":TempData["error"] %>';
            if (error.length > 0)
                alert(error);

        })

        function iFrameHeight(obj) {
            document.title = (obj.contentWindow.document.title);
            var ifm = obj;
            var subWeb = document.frames ? obj.document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }

        function confirmsubmit() {
            if ($("#name").val().trim() == "") {
                alert('请输入接线图名称');
                return false;
            }
        }
        
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td background="/images/kj/kjbg01.jpg" valign="top" width="793">
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
                                        设备接线图
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
                <div class="subrbox03">
                    <form method="post" action="/plant/savedevicerelation">
                    <table width="97%" height="40" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="8%" align="right">
                                名称
                            </td>
                            <td width="12%">
                                <%=Html.TextBox("name", TempData["name"] == null ? (Request["name"] == null ? string.Empty : Request["name"]) : TempData["name"], new { style = "width:80px;", @class = "txtbu01" })%>
                            </td>
                            <td width="8%" align="right">
                                当前设备
                            </td>
                            <td width="12%">
                                <%=Html.DropDownList("deviceId", ViewData["dces"] as IList<SelectListItem>)%>
                                <%=Html.Hidden("plantId", ViewData["pid"])%>
                            </td>
                            <td width="8%" align="right">
                                上级设备
                            </td>
                            <td width="12%" id="cd">
                                <%=Html.DropDownList("parentDeviceId", ViewData["parentdces"] as IList<SelectListItem>)%>
                            </td>
                            <td width="8%" align="right">
                                测点
                            </td>
                            <td width="12%">
                                <div id="mt">
                                </div>
                            </td>
                            <td width="200" align="right">
                                <input name="Submit" type="submit" disabled="disabled" class="subbu01" value="确定"
                                    id="btnsubmit" onclick="return confirmsubmit()" />
                            </td>
                        </tr>
                        <tr height="40">
                            <td align="right" width="8%">
                                宽度
                            </td>
                            <td width="12%">
                                <input id="config1" type="text" style="width: 80px" class="txtbu01" value="<%=(ViewData["config"] as RelationConfig).width %>" />
                                <input type="hidden" id="relationid" name="0" />
                            </td>
                            <td align="right" width="8%">
                                高度
                            </td>
                            <td width="12%">
                                <input id="config2" style="width: 80px" class="txtbu01" type="text" value="<%=(ViewData["config"] as RelationConfig).height %>" />
                            </td>
                            <td width="8%" align="right">
                                同胞间隔
                            </td>
                            <td width="12%">
                                <input id="config3" class="txtbu01" style="width: 80px" type="text" value="<%=(ViewData["config"] as RelationConfig).config3 %>" />
                            </td>
                            <td width="8%" align="right">
                                子树间隔
                            </td>
                            <td width="12%">
                                <input id="config4" class="txtbu01" style="width: 80px" type="text" value="<%=(ViewData["config"] as RelationConfig).config4 %>" />
                            </td>
                            <td align="right" width="200">
                                <input type="button" id="btnsaveconfig" value="保存" class="subbu01" />
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
                <div class="subrbox01">
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid" style="height: 700px">
                        <div style="float: left; width: 20%; overflow: hidden;">

                            <script type="text/javascript">
		<!--

                            d = new dTree('d');
                            d.add(0, -1, '设备接线图');
                            <% IList<DeviceRelation> relations= ViewData["group"] as IList<DeviceRelation>;
                             int i = 1;
                           foreach (DeviceRelation relation in relations)
                           { %>
                            d.add(<%=i++ %>, 0, '<%=relation.name%>', '/plant/devicerelation/<%=ViewData["pid"] %>?name=<%=relation.name%>' ,'', '', '/images/tree/folder.gif');
                            <%} %>
                            document.write(d);

		//-->
                            </script>

                            <%string firstGroup = relations.Count > 0 ? relations[0].name : string.Empty; %>
                        </div>
                        <div style="float: right; width: 80%; overflow: hidden;">
                            <iframe src="/plant/relationchart/<%=ViewData["pid"] %>?name=<%=Request["name"]==null?firstGroup:Request["name"]%>"
                                width="100%" height="500" scrolling="auto" frameborder="0"></iframe>
                        </div>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <script src="../../script/jquery.multiSelect2.js" type="text/javascript"></script>

    <link href="../../style/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
</asp:Content>
