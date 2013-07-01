<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.QA>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    FAQ - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script>
        function changePage(page) {
            window.location.href = '/admin/answer/' + page;
        }
        function recommend(id) {
            $.get("/admin/recommendanswer", { id: id }, function(data) {
                if (data == "ok") {
                    if ($("#answer_" + id).html().indexOf('取消') >=0)
                        $("#answer_" + id).html('发布');
                    else
                        $("#answer_" + id).html('取消');

                }
            });
        }
    </script>

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

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <%
            IList<AdminControllerAction> allActions = AdminControllerActionServices.GetInstance().GetList();
                            
        %>
        <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="100%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif" width="31" height="41" />
                            </td>
                            <td width="93%" class="pv0216">
                                FAQ
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
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/images/am/am_bg03.jpg"
                                style="border: 1px solid #DADADA; text-align: center; font-weight: bold;">
                                <tr>
                                    <td width="30%" align="center" class="lir">
                                        标题
                                    </td>
                                    <td width="30%" align="center" class="lir">
                                        内容
                                    </td>
                                    <td width="10%" align="center" class="lir">
                                        提问人
                                    </td>
                                    <td width="15%" align="center" class="lir">
                                        提问时间
                                    </td>
                                    <td width="10%" align="center" class="lir">
                                        操作
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <% int i = 0;
                       foreach (var item in Model)
                       {
                           i++;
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="30%" align="center" class="am_line0<%=i%2 %>" title="<%=item.title%>">
                                        <%=StringUtil.cutStr(item.title,30,"...") %>
                                    </td>
                                    <td width="30%" align="center" class="am_line0<%=i%2 %>" title="<%=item.descr%>">
                                        <%=StringUtil.cutStr(item.descr, 30, "...")%>
                                    </td>
                                    <td width="10%" align="center" class="am_line0<%=i%2 %>">
                                        <%=item.username%>
                                    </td>
                                    <td width="15%" align="center" class="am_line0<%=i%2 %>">
                                        <%=item.pubdate.ToString("yyyy-MM-dd HH:mm")%>
                                    </td>
                                    <td width="10%" align="center" class="am_line0<%=i%2 %>">
                                        <a href="/admin/postanswer/<%=item.id %>">
                                            <%=item.isanswered?"修改":"回答" %></a> 
                                            <%if (item.isanswered)
                                              { %>
                                            <a id="answer_<%=item.id %>" href="javascript:recommend('<%=item.id %>')"><%=item.isRecommend ? "取消" : "发布"%></a>
                                            <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    <tr>
                        <td height="36" colspan="5" background="/images/am/am_bg02.jpg">
                            <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="30%">
                                    </td>
                                    <td width="70%">
                                        <%Html.RenderPartial("mpage"); %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
