<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.QA>"
    MasterPageFile="~/Pages/Shared/Index.Master" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="title" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Resources.SunResource.PAGE_QA_TITLE%>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../style/faq.css" rel="stylesheet" type="text/css" />
    <div class="lcbox">
        <div class="lcabout">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="9" height="9" background="/images/tc/tc01.gif">
                    </td>
                    <td background="/images/tc/tc02.gif">
                    </td>
                    <td width="9" height="9" background="/images/tc/tc03.gif">
                    </td>
                </tr>
                <tr>
                    <td background="/images/tc/tc04.gif">
                        &nbsp;
                    </td>
                    <td bgcolor="#FFFFFF">
                        <div class="faq_top">
                            <p>
                                <%=Resources.SunResource.PAGE_QA_TITLE%></p>
                            <span><%=Resources.SunResource.QA_SUBTITLE_DESCR%></span>
                        </div>
                        <form method="post" action="/qa/ask">
                        <div class="faq_search">
                            <%=Html.TextBox("kw",Request.Form["kw"],new {@class="stxinput" }) %>
                            <input type="submit" name="Submit" value="<%=Resources.SunResource.MONITORITEM_SEARCH%>" class="greenbtu" />
                        </div>
                        </form>
                        <div class="faq_list">
                            <span class="faq_list_wz"><a href="/qa/ask" class="green">Back Questions List >> </a>
                            </span>
                            <div class="lebo">
                                <h3>
                                    Question：</h3>
                            </div>
                            <div class="rebo">
                                <h3>
                                    <%=Model.title %></h3>
                                <p>
                                    <%=Model.descr %></p>
                            </div>
                        </div>
                        <div class="faq_answer">
                            <span class="pname"><strong>Answer</strong></span>
                            <%foreach (QA answer in this.Model.answerslist)
                              { %>
                            <div class="pmore">
                                <%=answer.descr %>
                            </div>
                            <%} %>
                        </div>
                    </td>
                    <td background="/images/tc/tc05.gif">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td><td background="/images/tc/tc07.gif"></td><td><img src="/images/tc/tc08.gif" width="9" height="9" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
