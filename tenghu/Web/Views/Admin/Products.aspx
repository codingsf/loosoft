﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>产品列表</title>
    <link href="/css/css.css" rel="stylesheet" type="text/css" />
    <script>
        function changePage(index) {
            window.location.href = '/admin.aspx/products/'+index;
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
                                        标题
                                    </td>
                                    <td class="boxta02">
                                        大类别
                                    </td>
                                      <td class="boxta02">
                                        小类别
                                    </td>
                                    
                                    <td class="boxta02">
                                        是否显示
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach (Product each in ViewData["products"] as IList<Product>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03" width="230">
                                        <%=Html.Encode(each.name) %>
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.mainCategoryName) %>
                                        
                                    </td>
                                      <td class="boxta04">
                                        <%=Html.Encode(each.childCategoryName) %>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.isdisplay?"是":"否")%>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <a href="/admin.aspx/addproduct/<%=each.id %>">
                                            <img src="/images/e01.gif" width="18" height="16" border="0" title="编辑产品" /></a><a onclick="return confirm('确定要删除吗?')" href="/admin.aspx/delproduct/<%=each.id %>"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0" title="删除产品" /></a>
                                    </td>
                                </tr>
                                
                                <%} %>
                                
                                		   <tr>
          <td colspan="4" style="border-top: 1px solid rgb(211, 208, 208);" background="images/right_bg01.jpg" height="32">
          <span style="float: left;">
            <input onclick="window.location.href='/admin.aspx/addproduct'" name="Submit22" class="bulbg" value="新增产品" type="submit">
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
