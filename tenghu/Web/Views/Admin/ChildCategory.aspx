<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Category>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加子分类</title>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    name: "required"
                },
                messages: {
                    name: {
                        required: "请输入名称"
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
                        <form method="post" action="/admin.aspx/categories" id="form1">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加/编辑产品类别</span>
                                    </td>
                                </tr>
                                
                                  <tr>
                                    <td width="14%" align="right" class="boxta03">
                                       主类别
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.Encode((ViewData["category"] as Category).name)%>
                                    <%=Html.Hidden("pid",(ViewData["category"] as Category).id)%>
                                    
                                    
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        子类别
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.name, new { @class = "txs" })%>
                                    <%=Html.Hidden("iid", Request.QueryString["cid"] == null ? "0" : Request.QueryString["cid"]) %>
                                    <%=Html.HiddenFor(m=>m.sortOrder) %>
                                    </td>
                                </tr>
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                       显示
                                    </td>
                                    <td width="86%" class="boxta03">
                                    
                                    <%=Html.CheckBoxFor(m=>m.isDisplay) %>
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
