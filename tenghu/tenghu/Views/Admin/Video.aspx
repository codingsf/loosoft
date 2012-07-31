<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.Video>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>视频/资料 设置</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
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
                     <table width="600">
                           <tr>
                        <td width="25"><img src="/images/arrow_r.png" /> </td><td><a href="/admin/videos" class="lblack">查看所有视频/资料</a></td>
                        </tr>
                        </table>
                        
                         
                        <form method="post" action="/admin/video" id="form1" enctype = "multipart/form-data">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                        
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加视频</span>
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        选择类型
                                    </td>
                                    <td width="86%" class="boxta03">
                                     <%=Html.DropDownList("category.id", new List<SelectListItem> {
                                                new SelectListItem { Text = "保养视频", Value = "23"},
                                                new SelectListItem { Text = "原理视频", Value = "39"},
                                                new SelectListItem { Text = "视频新闻", Value = "13"},
                                                new SelectListItem { Text = "保养资料", Value = "24"}
                                                })%> 
                                        
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
                                    <td align="right" valign="top" class="boxta03">
                                        上传文件
                                    </td>
                                    <td class="boxta03">
                                  <input type ="file" name="image" />
                                    
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        详细内容
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextAreaFor(m => m.descr, new { @class = "txs" })%>
                                    <%=Html.HiddenFor(m=>m.id) %>
                                    
                                     <script type="text/javascript">
                                            window.onload = function() {
                                            var editor = CKEDITOR.replace('descr');
                                                CKFinder.SetupCKEditor(editor, '/ckfinder/');
                                            };
                                            
                                        </script> 
                                        
                                    </td>
                                </tr>
                                
                                      <tr style="display:none;">
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
                                                                                       <input name="Submit2222" type="button" onclick="window.location.href='/admin/videos'"; class="bulbg" value="返回" />
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
