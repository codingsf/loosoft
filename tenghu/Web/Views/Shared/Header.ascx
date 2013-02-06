<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="DataLinq" %>

<script src="/script/dropdowntabs.js" type="text/javascript"></script>
<link href="/css/bluetabs.css" rel="stylesheet" type="text/css" />
<div class="top">
    <div class="top_l">
        <img src="/img/logo.jpg" width="347" height="64" /></div>
    <div class="top_r">
        <table width="180" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td align="right">
            <select name="lang">
                    <option value="zh-cn">中文</option>
                    <%--<option value="en-us">英文</option>--%>
                    </select>
            </td>
                <td align="right">
                 
                        <select name="lang">
                    <option value="zh-cn">-公司子网站-</option>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <div class="dh">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="5">
                    <img src="/img/dh01.jpg" width="5" height="35" />
                </td>
                <td background="/img/dh02.jpg">
                    <div>
                        <div id="bluemenu" class="dh_l">
                                <ul id="head">
                                    <% int i = 0;
                                        foreach (Category category in ViewData["categories"] as IList<Category>)
                                       { %>
                                    <li><a rel="dropmenu<%=++i %>_b" href="<%=category.url %>">
                                        <%=category.name %></a></li>
                                    <%} %>
                                </ul>
                        </div>

                        <script src="../../script/jquery.js" type="text/javascript"></script>

                        <div class="search">
                            <table width="88%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right">
                                        <input name="keyword" type="text" class="searchsy" id="keyword" value="<%=Request.QueryString["keyword"]==null?"":Request.QueryString["keyword"] %>"
                                            size="12" />
                                        <a href="#"></a>
                                    </td>
                                    <td align="left" valign="top">
                                        <input type="image" src="/img/go.jpg" onclick="window.location.href='/home.aspx/search?keyword='+$('#keyword').val();" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
                <td width="8" background="/img/dh03.jpg">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
</div>


<%     i = 0;
    foreach (Category category in ViewData["categories"] as IList<Category>)
                                       { %>
                                   <div id="dropmenu<%=++i %>_b" class="dropmenudiv_b" style="width: 150px;">
                                   
                                   <%foreach (Category cate in category.ChildCategory)
                                     { %>
                                   <a href="<%=cate.url %>"><%=cate.name %></a>
                                   <%} %>
                                      </div>
                                    <%} %>


<script type="text/javascript">
    //SYNTAX: tabdropdown.init("menu_id", [integer OR "auto"])
    tabdropdown.init("bluemenu")
</script>

<script>
    $(document).ready(function() {
        $(":a").each(function() {
            if (window.location.href.indexOf($(this).attr("href")) != -1) {
                $(this).addClass("hover");
            }
        });
    });
</script>

