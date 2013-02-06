<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Product>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加/编辑 产品</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
  <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        function loaddata() {
            $.getJSON("/admin.aspx/loadchildcategory?id=" + $('#mid').val(), function(data) {
                $("#pid").empty();
                for (var i = 0; i < data.length; i++) {
                    $("#pid").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
                }
            });
        }
        $().ready(function() {
            $("#mid").change(loaddata);
            loaddata();
            $("#form1").validate({
                rules: {
                    descr: "required",
                    name:
                {
                    required: true
                }
                },
                messages: {
                    descr: {
                        required: "请输入产品内容"
                    },
                    name: {
                        required: "请输入产品标题 "
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
                        
                        
                        <form action="/admin.aspx/addproduct" method="post" id="form1" enctype = "multipart/form-data">
                        
                        
                        <div class="listbox">
                        
                           <table width="300">
                        <tr>
                          <td width="25"><img src="/images/arrow_r.png" /> </td>
                         <td>
                                       <a href="/admin.aspx/categories?id=4" class="lblack">所有产品类别</a>
                         
                         </td>
                         
                        <td width="25"><img src="/images/arrow_r.png" /> </td>
                        <td><a href="/admin.aspx/products" class="lblack">查看产品型号</a></td>
                        </tr>
                        </table>
                        
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">发布产品</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right" class="boxta03">
                                        产品类别
                                    </td>
                                    <td width="70%" class="boxta03">
                                        <%=Html.DropDownList("mid", ViewData["selectlist"] as IList<SelectListItem>) %>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td width="30%" align="right" class="boxta03">
                                        产品小类别
                                    </td>
                                    <td width="70%" class="boxta03">
                                      <select id="pid" name="pid"><option>--请选择产品小类别--</option><option value="46">测试产品</option></select>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        产品名称
                                    </td>
                                    <td class="boxta03">
                                    <%=Html.TextBoxFor(m => m.name, new { @class = "txs" })%>
                                    <%=Html.HiddenFor(m => m.id, new { @class = "txs" })%>
                                    <%=Html.HiddenFor(m => m.pdfpath, new { @class = "txs" })%>
                                    
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        电子说明书地址
                                    </td>
                                    <td class="boxta03">
                                  <input type ="file" name="pdf" />
                                    
                                    </td>
                                </tr>
                                
                                   <tr style="display:none">
                                    <td align="right" valign="top" class="boxta03">
                                        是否显示
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.CheckBoxFor(m => m.isdisplay)%>
                                    
                                    </td>
                                </tr>
                                
                                
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        产品说明
                                    </td>
                                    <td class="boxta03">
                                    <%=Html.TextAreaFor(m => m.descr, new { @class = "txs" })%>
                                    
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
                                       
                                            <input name="Submit2223" type="submit" class="bulbg" value="新增产品" />
                                                                                        <input name="Submit2222" type="button" onclick="window.location.href='/admin.aspx/products'"; class="bulbg" value="返回" />
                                       
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
