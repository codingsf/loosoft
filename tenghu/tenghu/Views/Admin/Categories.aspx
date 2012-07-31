<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.Category>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>产品分类</title>
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
                    
                        
                        <div class="listbox">
                           <table width="300">
                        <tr>
                          <td width="25"><img src="/images/arrow_r.png" /> </td>
                         <td>
                                       <a href="/admin/categories?id=4" class="lblack">所有产品类别</a>
                         
                         </td>
                         
                        <td width="25"><img src="/images/arrow_r.png" /> </td>
                        <td><a href="/admin/products" class="lblack">查看产品型号</a></td>
                        </tr>
                        </table>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" class="boxta01">
                                        名称
                                    </td>
                               
                                    <td class="boxta02">
                                        操作
                                    </td>
                                </tr>
                                
                                <%foreach (Category each in ViewData["categories"] as IList<Category>)
                                  { %>
                                
                                <tr>
                                    <td class="boxta03">
                                        <%=Html.Encode(each.name)%>
                                    </td>
                           
                        
                                    <td class="boxta04">
                                        <a href="/admin/childcategory/<%=each.id %>">
                                            <img src="/images/card.gif" width="18" height="16" border="0" title="添加子类别" /></a>
                                            
                                            <a href="/admin/categories/4?cid=<%=each.id %>">
                                            <img src="/images/e01.gif" width="18" height="16" border="0" title="编辑类别" /></a>
                                            
                                            <a href="/admin/delcategory/4?cid=<%=each.id %>" title="删除类别" onclick="return confirm('是否确定删除?')"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0" /></a>
                                    </td>
                                </tr>
                                <%foreach (Category cath in each.ChildCategory)
                                  { %>
                                  
                                  <tr>
                                    <td class="boxta03" style="padding-left:35px">
                                     <font color="blue"><%=Html.Encode(each.name)%> >> <%=Html.Encode(cath.name)%></font>  
                                    </td>
                           
                                    <td class="boxta04">
                                    <img src="/images/card01.gif" width="18" height="16" border="0" title="添加子类别" />
                                    <img src="/images/e001.gif" width="18" height="16" border="0" />
                                            <a href="/admin/delcategory/4?cid=<%=cath.id %>" onclick="return confirm('是否确定删除?')"><img
                                                src="/images/e02.jpg" width="18" height="16" border="0"  title="删除类别"/></a>
                                    </td>
                                </tr>
                                  
                                <%}
                               }%>
                                
                            </table>
                        </div>
                        
                        
                        <form method="post" action="/admin/categories" id="form1">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加/编辑产品类别</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        主分类
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.name, new { @class = "txs" })%>
                                           <%=Html.Hidden("iid", Request.QueryString["cid"] == null ? "0" : Request.QueryString["cid"]) %>
                                    <%=Html.Hidden("pid",4) %>
                                    <%=Html.HiddenFor(m=>m.sortOrder) %>
                                    </td>
                                </tr>
                                
                                      <tr style="display:none">
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
