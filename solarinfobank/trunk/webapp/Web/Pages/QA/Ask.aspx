<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.QA>>"
    MasterPageFile="~/Pages/Shared/Index.Master" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="title" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Resources.SunResource.PAGE_QA_TITLE%>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../../style/lc.css" rel="stylesheet" type="text/css" />
    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />
    <link href="../../style/kj.css" rel="stylesheet" type="text/css" />
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
                                有问有答</p>
                            <span>You are in our troubleshooting system for all service queries. By entering a search
                                query, you can receive useful information and valuable tips on our inverters, communication
                                products and software programs. </span>
                        </div>
                        <form method="post" action="/qa/search">
                        <div class="faq_search">
                            <%=Html.TextBox("kw",Request.Form["kw"],new {@class="stxinput" }) %>
                            <input type="submit" name="Submit" value="搜索" class="greenbtu" />
                        </div>
                        </form>
                        <div class="faq_list">
                            <ul>
                                <%if (Model != null)
                                      foreach (QA qa in Model)
                                      {%>
                                <li><a href="/qa/showask/<%=qa.id %>" target="_blank">
                                    <%=qa.title%></a></li>
                                <%} %>
                            </ul>
                        </div>
                        <div class="faq_ask">
                            <span class="tname"><strong>请在下面填写您的问题</strong> (<font class="redzi">* </font>为必填项)</span>
                            <form action="/qa/ask" method="post">
                            <table width="640" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="82" height="70" align="right">
                                        <font class="redzi">* </font><strong>标题：</strong>
                                    </td>
                                    <td width="558">
                                        <input type="text" name="title" class="faq_input01" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top" style="padding-top: 8px;">
                                        <font class="redzi">* </font><strong>内容：</strong>
                                    </td>
                                    <td>
                                        <span class="changimg"></span>
                                        <textarea name="descr" rows="6" class="faq_input02"></textarea>
                                        <span class="tszs">您还可以输500个字</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="60" align="right">
                                        &nbsp;
                                    </td>
                                    <td height="50">
                                        <input type="submit" name="Submit2" value="提问" class="greenbtu" />
                                    </td>
                                </tr>
                            </table>
                            </form>
                        </div>
                        <div class="faq_ask">
                            <span class="succok">
                                <%=ViewData["message"] %></span>
                        </div>
                        <p>
                            &nbsp;</p>
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
