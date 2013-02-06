<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Image>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>首页图片管理</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
      <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    picName: "required"
                },
                messages: {
                    picName: {
                        required: "请选择上传的图片"
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
                                        编号
                                    </td>
                                    <td class="boxta02" width="200">
                                        图片
                                    </td>
                                    <td class="boxta02">
                                        图片地址
                                    </td>
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach (DataLinq.Image each in ViewData["images"] as IList<DataLinq.Image>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.id) %>
                                    </td>
                                    <td class="boxta04">
                                       <img src="/upload/<%=(each.pic) %>" width="180" height="100" />
                                        
                                    </td>
                                    <td class="boxta04">
                                        <%=Html.Encode(each.url) %>
                                       
                                        
                                    </td>
                                    <td class="boxta04">
                                            <a href="/admin.aspx/delimg/<%=each.id %>" onclick="return confirm('是否确定删除?')"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0"  title="删除图片"/></a>
                                    </td>
                                </tr>
                                
                                <%} %>
                                
                            </table>
                        </div>
        <form id="form1" action="/admin.aspx/upload" enctype="multipart/form-data"
        method="post">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加图片</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        上传
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <input name="picName" id="picName" type="file" size="25" onkeydown= "return   false "   onpaste= "return   false " />
                                        
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
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="添加" />
                                                                                       
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
