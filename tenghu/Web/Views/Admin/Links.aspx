<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.Link>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>友情链接</title>
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
                                        地址
                                    </td>
                                    <td class="boxta02">
                                        显示
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach(Link each in ViewData["links"] as IList<Link>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.name) %>
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.url) %>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.isdisplay ? "是" : "否")%>
                                        
                                    </td>
                                    <td class="boxta04">
                                        <a href="/admin/links/<%=each.id %>">
                                            <img src="/images/e01.gif" width="18" height="16" border="0"  title="编辑链接"/></a>
                                            
                                            <a href="/admin/dellink/<%=each.id %>" onclick="return confirm('是否确定删除?')"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0"  title="删除链接"/></a>
                                    </td>
                                </tr>
                                
                                <%} %>
                                
                            </table>
                        </div>
                        <form method="post" action="/admin/addlink" id="form1">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加链接</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        名称
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.name, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        地址
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.url, new { @class = "txs" })%>
                                    <%=Html.HiddenFor(m=>m.id) %>
                                    </td>
                                </tr>
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                       显示
                                    </td>
                                    <td width="86%" class="boxta03">
                                    
                                    <%=Html.CheckBoxFor(m=>m.isdisplay) %>
                                    </td>
                                </tr>
                                     
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="添加" />
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
