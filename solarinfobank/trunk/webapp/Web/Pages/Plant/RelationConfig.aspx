<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<IList<Hashtable>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    <%=Resources.SunResource.DEVICE_RELATION_MENU%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <script type="text/javascript">
                    function iFrameHeight() {
                        var ifm = document.getElementById("mainFrame");
                        var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
                        if (ifm != null && subWeb != null) {
                            ifm.height = subWeb.body.scrollHeight;
                        }
                    }

                    function iFrameHeight1() {
                        var ifm = document.getElementById("mainFrame1");
                        var subWeb = document.frames ? document.frames["mainFrame1"].document : ifm.contentDocument;
                        if (ifm != null && subWeb != null) {
                            ifm.height = subWeb.body.scrollHeight;
                        }
                    }


                    var movetype = 1;
                    var leftId = undefined;
                    var rightId = undefined;
                    var leftisUnit = false;
                    var rightisUnit = false;
                    var leftunitId = undefined;
                    var rightunitId = undefined;

                    function setLeft(lid, isunit, unitid) {
                        leftId = lid;
                        leftisUnit = isunit;
                        leftunitId = unitid;
                    }

                    function setRight(rlid, isunit, unitid) {
                        rightId = rlid;
                        rightisUnit = isunit;
                        rightunitId = unitid;
                    }
                    function lefttoright() {
                        movetype = 1;
                        postdata();
                    }

                    function righttoleft() {
                        movetype = 2;
                        postdata();
                    }

                    function postdata() {
                        if (leftId == undefined) { alert(" <%=Resources.SunResource.DEVICE_RELATION_NOTICE1%>"); return false; };
                        if (rightId == undefined) { alert("<%=Resources.SunResource.DEVICE_RELATION_NOTICE2%>"); return false; };
                        if (leftId == rightId) { alert("<%=Resources.SunResource.DEVICE_RELATION_NOTICE3%>"); return false; };
                        if (leftisUnit && movetype == 1) { alert("<%=Resources.SunResource.DEVICE_RELATION_NOTICE4%>"); return false; };
                        if (rightisUnit && movetype == 2) { alert("<%=Resources.SunResource.DEVICE_RELATION_NOTICE4%>"); return false; };
                        $.post("/plant/move", { leftid: leftId, leftunitId: leftunitId, rightid: rightId, rightunitId: rightunitId, leftisunit: leftisUnit, rightisunit: rightisUnit, movetype: movetype},
                        function(data) {
                        if (data == "ok")
                            window.location.reload();
                        else 
                            alert(data);
                        });
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
                                        <img src="/images/kj/kjiico01.gif" />
                                    </td>
                                    <td class="pv0216">
                                    <%=Resources.SunResource.DEVICE_RELATION_MENU%>
                                    </td>
                                    <td align="right" class="help_r">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="75%">
                                    &nbsp;
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
                    <table width="760" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="107" align="right" style="padding-right: 10px">
                            </td>
                            <td width="160" align="left">
                            </td>
                            <td width="80" align="right" style="padding-right: 10px">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="subrbox01">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="40%" valign="top">
                                <div id='dtree' class='dtree'>
                                </div>
                                <iframe src="/plant/leftrelation/<%=ViewData["plantId"] %>" scrolling="no" frameborder="0" id="mainFrame1">
                                </iframe>
                            </td>
                            <td width="20%" valign="top" align="center">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="160" align="center">
                                            <div id="divAddDevice">
                                                <a href="javascript:void(0)" id="A1" name="btnAddDevice" onclick="lefttoright()">
                                                <img src="/images/sub/add.gif" border="0" width="18" height="18" alt=""/><br>
                                                <%=Resources.SunResource.RELATION_MOVE_RIGHT%>
                                                </a>                                         
                                             </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="160" align="center" valign="top">
                                            <div id="divDelDevice">
                                                <a href="javascript:void(0)" id="btnDelDevice" name="btnDelDevice" onclick="righttoleft()">
                                                <img src="/images/sub/reduce.gif" border="0" width="18" height="18" alt=""/><br>
                                                <%=Resources.SunResource.RELATION_MOVE_LEFT%>
                                                </a>                                                    
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="40%" valign="top">
                                <iframe src="/plant/rightrelation/<%=ViewData["plantId"] %>" scrolling="no" frameborder="0" id="mainFrame">
                                </iframe>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>