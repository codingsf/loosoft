<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Webconfig>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>网站设置</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="mainbox">
        
        
        
        <%Html.RenderPartial("adminheader"); %>
        
        <div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="208" valign="top" background="/images/left_bg01.jpg">
                     <%Html.RenderPartial("adminleft"); %>
                       
                    </td>
                    <td valign="top" bgcolor="#F1F1F1">
                        <% Html.RenderPartial("adminmenu"); %>
                        
                        <form method="post" action="/admin/updateconfig">
                        
                        
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">网站设置</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        网站标题
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.HiddenFor(m => m.id, new { @class = "txs" })%>
                                    
                                        <%=Html.TextBoxFor(m => m.name, new { @class = "txs" })%>
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        网站域名
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.domain, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        网站备案号
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.beian, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                         <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        电话
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.tel, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                
                                           <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        首页title
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.title, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                           <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        首页keywords
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.keyword, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        首页description
                                    </td>
                                    <td class="boxta03">
                                       <%=Html.TextAreaFor(m => m.descr, new { @class="txs"})%>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="更新" />
                                                                                       <input name="Submit2222" type="button" onclick="window.location.href='/admin'"; class="bulbg" value="返回" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                        
                        </form>
                        
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
