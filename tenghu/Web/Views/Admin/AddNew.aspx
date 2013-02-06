<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.News>" validateRequest="false"   %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>发布/编辑 新闻</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
       <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                 
                    title:
                {
                    required: true
                }
                },
                messages: {
                    descr: {
                        required: "请输入新闻内容"
                    },
                    title: {
                        required: "请输入新闻标题 "
                    }
                }

            });
            $("#cadd").click(function() {
                $.ajax({
                    type: "GET",
                    url: "/admin.aspx/category?id=3&cname=" + $("#cname").val(),
                    data: {},
                    success: function(result) {
                        alert(result);
                        location.reload();
                    },
                    beforeSend: function() {
                    }
                });
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
                        
                        <form action="/admin.aspx/addnew" method="post" id="form1">
                        
                        
                        <div class="listbox">
                        
                          <table width="600">
                        <tr>
                        <td width="25"><img src="/images/arrow_r.png" /> </td><td><a href="/admin.aspx/news" class="lblack">查看新闻列表</a></td>
                        </tr>
                        </table>
                        
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">发布新闻</span>
                                    </td>
                                </tr>
                                
                                    <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        新闻类别
                                    </td>
                                    <td width="86%" class="boxta03">
                                        
                                               <%=Html.DropDownList("categoryid", new List<SelectListItem> {
                                                new SelectListItem { Text = "企业新闻", Value = "11"},
                                                new SelectListItem { Text = "产品新闻", Value = "12"}
                                                })%> 
                                                <input name="name" value="" id="cname" style=" display:none" />
                                    <input type="button" value="添加" id="cadd"  style=" display:none" />
                                    
                                    
                                        
                                        
                                    </td>
                                </tr>
                                
                                
                                
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        新闻标题
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m=>m.title,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.id,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m => m.ishot, new { @class = "txs" })%>
                                        <%=Html.HiddenFor(m => m.publictime, new { @class = "txs" })%>
                                        <%=Html.HiddenFor(m => m.publicuser, new { @class = "txs" })%>
                                        <%=Html.HiddenFor(m => m.sortorder, new { @class = "txs" })%>
                                        
                                        
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        详细内容
                                    </td>
                                    <td class="boxta03">
                                        <%=Html.TextAreaFor(m=>m.descr,new {@class="txs"}) %>

                                        <script type="text/javascript">
                                            window.onload = function() {
                                            var editor = CKEDITOR.replace('descr');
                                                CKFinder.SetupCKEditor(editor, '/ckfinder/');
                                            };
                                            
                                        </script> 
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="发布新闻" />
                                                                                       <input name="Submit2222" type="button" onclick="window.location.href='/admin.aspx/news'"; class="bulbg" value="返回" />
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
