<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    编辑用户
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        $(document).ready(function() {
            $("#btnsaveconfig").click(function() {
                $.get('/user/relationconfig/',
                  {
                      uid: '<%=Request["id"] %>',
                      relationId: 0,
                      relationType: '<%=RelationConfig.AllPlant %>',
                      width: $("#config1").val(),
                      height: $("#config2").val(),
                      config3: $("#config3").val(),
                      config4: $("#config4").val()
                  },
                  function(data) {
                      if (data == "ok")
                          window.location.reload(true);
                  });
            });
        });
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
                                            <img src="/images/kj/kjiico01.gif" width="31" height="41" />
                                        </td>
                                        <td class="pv0216">
                                            结构图配置
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
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PLANT_OVERVIEW_DETAIL %>&nbsp;
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
                    <table width="750">
                        <tr height="30">
                            <td align="right">
                                宽度
                            </td>
                            <td>
                                <input id="config1" type="text" style="width: 60px" class="txtbu01" value="<%=(ViewData["config"] as RelationConfig).width %>" />
                                <input type="hidden" id="relationid" name="0" />
                            </td>
                            <td align="right">
                                高度
                            </td>
                            <td>
                                <input id="config2" style="width: 60px" class="txtbu01" type="text" value="<%=(ViewData["config"] as RelationConfig).height %>" />
                            </td>
                            <td align="right">
                                同胞间隔
                            </td>
                            <td>
                                <input id="config3" class="txtbu01" style="width: 60px" type="text" value="<%=(ViewData["config"] as RelationConfig).config3 %>" />
                            </td>
                            <td align="right">
                                子树间隔
                            </td>
                            <td>
                                <input id="config4" class="txtbu01" style="width: 60px" type="text" value="<%=(ViewData["config"] as RelationConfig).config4 %>" />
                            </td>
                            <td width="200">
                                <input type="button" id="btnsaveconfig" value="保存" class="subbu01" />
                                <input type="button" onclick="window.location.href='/user/portaluser'" value="返回"
                                    class="subbu01" />
                            </td>
                        </tr>
                    </table>
                    <div class="subrbox01">
                        <div class="sb_top">
                        </div>
                        <div class="sb_mid">
                            <iframe src="/user/portalstructchart?id=<%= ViewData["id"] %>" width="100%" scrolling="auto"
                                height="500" frameborder="0"></iframe>
                        </div>
                        <div class="sb_down">
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
