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

    <script>
        function changePage(page) {
        <%if(String.IsNullOrEmpty(Request["kw"]))
        { %>
            window.location.href = '/qa/ask/?page=' + page;
         <%}else
         { %>
         window.location.href = '/qa/ask/?kw=<%=Request["kw"] %>&page=' + page;
         <%} %>
        }
        
        function checkwords(obj) {
            var content = obj.value;
            var length = 500 - content.length;
            if (length <= 0) {
                obj.value = content.substr(0, 500);
                length = 0;
            }
            document.getElementById("wordLength").innerHTML = length;

        }
        function checkform() {
            if (document.getElementById("title").value.length == 0) {
                alert("请输入标题");
                document.getElementById("title").focus();
                return false;
            }
            if (document.getElementById("descr").value.length == 0) {
                alert("请输入提问内容");
                document.getElementById("descr").focus();
                return false;
            }
            return true;
        }
    </script>

    <%QA qa = ViewData["qa"] as QA; %>
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
                        <form method="post" action="/qa/ask">
                        <div class="faq_search">
                            <%=Html.TextBox("kw",Request["kw"],new {@class="stxinput" }) %>
                            <input type="submit" name="Submit" value="搜索" class="greenbtu" />
                        </div>
                        </form>
                        <div class="faq_list">
                            <ul>
                                <%if (Model != null)
                                      foreach (QA item in Model)
                                      {%>
                                <li><a href="/qa/showask/<%=item.id %>" target="_blank">
                                    <%=item.title%></a></li>
                                <%} %>
                            </ul>
                            <%Html.RenderPartial("page"); %>
                        </div>
                        <div class="faq_ask">
                            <span class="tname"><strong>请在下面填写您的问题</strong> (<font class="redzi">* </font>为必填项)</span>
                            <form action="/qa/postask" method="post">
                            <table width="640" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="82" height="70" align="right">
                                        <font class="redzi">* </font><strong>标题：</strong>
                                    </td>
                                    <td width="558">
                                        <input type="text" name="title" id="title" class="faq_input01" value="<%=qa==null?"":qa.title %>" />
                                        <input type="hidden" name="id" value="<%=qa==null?0:qa.id %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top" style="padding-top: 8px;">
                                        <font class="redzi">* </font><strong>内容：</strong>
                                    </td>
                                    <td>
                                        <span class="changimg"></span>
                                        <textarea id="descr" name="descr" rows="6" class="faq_input02" onkeyup="checkwords(this);"><%=qa==null?"":qa.descr %></textarea>
                                        <span class="tszs">您还可以输<span id="wordLength">500</span>个字</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="60" align="right">
                                        &nbsp;
                                    </td>
                                    <td height="50">
                                        <input type="submit" onclick="return checkform();" name="Submit2" value="<%=qa==null?"提问":"修改"%>"
                                            class="greenbtu" />
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
                    <td width="9" height="9">
                        <img src="/images/tc/tc06.gif" width="9" height="9" />
                    </td>
                    <td background="/images/tc/tc07.gif">
                    </td>
                    <td>
                        <img src="/images/tc/tc08.gif" width="9" height="9" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
