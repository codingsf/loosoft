<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>后台首页</title>
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
                     <%Html.RenderPartial("adminmenu"); %>
                    
                        
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" class="boxta01">
                                        新闻标题
                                    </td>
                                    <td class="boxta02">
                                        发布时间
                                    </td>
                                    <td class="boxta02">
                                        最后修改时间
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach(News each in ViewData["news"] as IList<News>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.title) %>
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.publictime) %>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.publictime)%>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <a href="/admin/addnew/<%=each.id %>"  title="编辑新闻" /></>
                                            <img src="/images/e01.gif" width="18" height="16" border="0" title="编辑新闻" /></a>
                                            <a onclick="return confirm('确定要删除吗?')" href="/admin/delnew/<%=each.id %>" title="删除新闻"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0"  title="删除新闻"/></a>
                                    </td>
                                </tr>
                                
                                <%} %>
                                
                            </table>
                        </div>
                        
                        
                       
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
