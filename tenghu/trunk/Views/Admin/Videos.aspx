<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>视频资料列表</title>
    <link href="/css/css.css" rel="stylesheet" type="text/css" />
    <script>
        function changePage(index) {
            window.location.href = '/admin/videos/'+index;
        }
    </script>
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
                                        类别
                                    </td>
                                    <td class="boxta02">
                                        显示
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach (Video each in ViewData["videos"] as IList<Video>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.name) %>
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.category.name) %>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.isdisplay?"是":"否")%>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <a href="/admin/video/<%=each.id %>">
                                            <img src="/images/e01.gif" width="18" height="16" border="0"  title="编辑视频"/></a>
                                            <a onclick="return confirm('确定要删除吗?')" href="/admin/delvideo/<%=each.id %>"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0"  title="删除视频"/></a>
                                    </td>
                                </tr>
                                
                                <%} %>
                                
                                		   <tr>
          <td colspan="4" style="border-top: 1px solid rgb(211, 208, 208);" background="images/right_bg01.jpg" height="32">
          <span style="float: left;">
            <input onclick="window.location.href='/admin/video'" name="Submit22" class="bulbg" value="新增视频/资料" type="submit">
          </span>
          <% Html.RenderPartial("page"); %>
            </td>

          </tr>
                                
                            </table>
                        </div>
                        
                        
                       
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
