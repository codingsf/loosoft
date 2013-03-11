<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>给门户用户分配电站
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/jquery.colorbox.js" type="text/javascript"></script>

    <link href="../../style/colorbox.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        function getPageScroll() {
            var yScroll;
            if (self.pageYOffset) {
                yScroll = self.pageYOffset;
            } else if (document.documentElement && document.documentElement.scrollTop) {
                yScroll = document.documentElement.scrollTop;
            } else if (document.body) {
                yScroll = document.body.scrollTop;
            }
            return yScroll;
        }

        var JPos = {};
        (function($) {
            $.$getAbsPos = function(p) {
                var _x = 0;
                var _y = 0;
                while (p.offsetParent) {
                    _x += p.offsetLeft;
                    _y += p.offsetTop;
                    p = p.offsetParent;
                }

                _x += p.offsetLeft;
                _y += p.offsetTop;

                return { x: _x, y: _y };
            };

            $.$getMousePos = function(evt) {
                var _x, _y;
                evt = evt || window.event;
                if (evt.pageX || evt.pageY) {
                    _x = evt.pageX;
                    _y = evt.pageY;
                } else if (evt.clientX || evt.clientY) {
                    _x = evt.clientX + document.body.scrollLeft - document.body.clientLeft;
                    _y = evt.clientY + document.body.scrollTop - document.body.clientTop;
                } else {
                    return $.$getAbsPos(evt.target);
                }
                return { x: _x, y: _y };
            }
        })(JPos);
        var x; var y;
        function vControl(pChoice) {
            switch (pChoice) {
                case "GETMOUSEPOSINPIC":
                    var mPos = JPos.$getMousePos(arguments[2]);
                    var iPos = JPos.$getAbsPos(arguments[1]);
                    x = mPos.x - iPos.x;
                    y = mPos.y - iPos.y;
                    if (! +[1, ])
                        y += getPageScroll();
                    //parent.
                    $("#items").show();
                    $.colorbox({ width: "auto", height: "auto", inline: true, href: "#items" });
                    break;
            }
        }

        $(document).ready(function() {
            $("#cboxClose").click(function() {
            $("#items").hide();
                var obj = $('input:radio[name="item"]:checked');
                if (obj.length == 0)
                    return;
                var rel = obj.attr("rel");
                var id = obj.val();
                var cat = $("#cat").val();
                $("." + cat + id).hide();
                $("#container").append('<div class="' + cat + id + '" style="position: absolute; top: ' + y + 'px; left: ' + x + 'px; color: Red;">' + rel + '</div>');
                $.get("/plant/savestructpic", { x: x, y: y, cat: $("#cat").val(), pid: <%=Model.id %>, id: id }, function(data) {
                    //alert(data);
                });
            })
            
            var imgwidth=$("#structimg").attr("width");
            $("#container").css("width",imgwidth);
            $("#container").css("left",(750-imgwidth)/2);
            
        })
    </script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td background="/images/kj/kjbg01.jpg" valign="top" width="793">
                <table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0"
                    width="793" height="63">
                    <tbody>
                        <tr>
                            <td width="8">
                                <img src="/images/kj/kjico02.jpg" width="8" height="63">
                            </td>
                            <td width="777">
                                <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="7%" rowspan="2" align="center">
                                            <img src="/images/kj/kjiico01.gif" />
                                        </td>
                                        <td class="pv0216">
                                        
                                            <%=Model.isVirtualPlant?"电站":"单元" %>分布图设置
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
                                            在分布图的某一位置双击鼠标，在弹出框中选择某个<%=Model.isVirtualPlant?"电站":"单元" %>，该<%=Model.isVirtualPlant?"电站":"单元" %>将被配置在分布图的当前位置
                                        </td>
                                        <td width="18%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right" width="6">
                                <img src="/images/kj/kjico03.jpg" width="6" height="63">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="subrbox01">
                    <div>
                        <table width="98%" height="25" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="3%" align="center">
                                    <img src="/images/sub/subico010.gif" width="18" height="19" />
                                </td>
                                <td width="97%" align="left">
                                    <%=Model.isVirtualPlant?"电站":"单元" %>分布图设置
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid" style="overflow: hidden; clear: both; height: 1000px;">
                        <div style="position:relative;" id="container">
                            
                            <% string path=Server.MapPath("~");
                               if (System.IO.File.Exists(string.Format("{0}/ufile/{1}", path, Model.structPic)) == false)
                               { Response.Write("<center><font color='red'>未上传分布图</font></center>"); }
                               else
                               { %>
                               <img src="/ufile/<%=Model.structPic %>" alt="" ondblclick="vControl('GETMOUSEPOSINPIC',this,event)" id="structimg" />
                                <%} %>
                                  <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
                                  {%>
                                    <div class="<%=Model.isVirtualPlant?StructPoint.typeCodePlant:StructPoint.typeCodeUnit %><%=point.id %>" style="position: absolute; top:<%=point.y %>px; left:<%=point.x %>px; color: Red;"><%=point.displayName %></div>
                                <%} %>
                        </div>
                        <center>
                        <br />
                            <input name="Submit23" class="subbu01" value="返回" style="margin-left: 50px;" onclick="history.go(-1);"
                                type="button"></center>
                        <div id="items" style="display: none">
                            <%if (Model.isVirtualPlant)
                              {
                                  foreach (Plant plant in Model.childs)
                                  { %>
                            <input type="radio" value="<%=plant.id %>" name="item" rel="<%=plant.name %>" /><%=plant.name %><br />
                            <%}
                              }
                              else
                              {
                                  foreach (PlantUnit unit in Model.plantUnits)
                                  {%>
                            <input type="radio" value="<%=unit.id %>" name="item" rel="<%=unit.displayname %>" /><%=unit.displayname %><br />
                            <%}
                              } %>
                        </div>
                        <input type="hidden" id="cat" value="<%=Model.isVirtualPlant?StructPoint.typeCodePlant:StructPoint.typeCodeUnit %>" />
                    </div>
                    <div class="sb_down">
                    </div>
                    <br />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
