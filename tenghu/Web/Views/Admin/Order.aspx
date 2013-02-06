<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.OrderInfo>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>订单列表</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    name: "required",
                    url:
                {
                    required: true
                }
                },
                messages: {
                    name: {
                        required: "请输入名称"
                    },
                    url: {
                        required: "请输入链接地址 "
                    }
                }

            });
        });
    
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
                                        名称
                                    </td>
                                    <td class="boxta02">
                                        型号
                                    </td>
                                    <td class="boxta02">
                                        地区
                                    </td>
                                     <td class="boxta02">
                                        采购时间
                                    </td>
                                         <td class="boxta02">
                                        付款方式
                                    </td>
                                         <td class="boxta02">
                                       联系人
                                    </td>
                                         <td class="boxta02">
                                        联系电话
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach (OrderInfo each in ViewData["orders"] as IList<OrderInfo>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.category.name) %>
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.product.name) %>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.areaname)%>
                                        
                                    </td>
                                    
                                      <td class="boxta04">
                                        <%=Html.Encode(each.time)%>
                                        
                                    </td>
                                      <td class="boxta04">
                                        <%=Html.Encode(each.payment)%>
                                        
                                    </td>
                                     <td class="boxta04">
                                        <%=Html.Encode(each.uname)%>
                                        
                                    </td>
                                     <td class="boxta04">
                                        <%=Html.Encode(each.tel)%>
                                        
                                    </td>
                                    <td class="boxta04">
                                    <a href="/admin.aspx/orderview/<%=each.id %>">
                                            <img src="/images/card.gif" title="查看订单" border="0" height="16" width="18"></a>
                                            
                                            <a href="/admin.aspx/delorder/<%=each.id %>" onclick="return confirm('是否确定删除?')"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0" title="删除订单" /></a>
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
