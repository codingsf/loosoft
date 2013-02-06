<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Zhuanli>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加/编辑 专利</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>

  <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    name: "required",
                    num:
                {
                    required: true
                },
                    type: "required"
                },
                messages: {
                    name: {
                        required: "请输入名称"
                    },
                    num: {
                    required: "请输入申请号 "
                    },
                    type: {
                        required: "请输入专利类型"
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
                        <% Html.RenderPartial("adminmenu"); %>
                        
                        
                        
                        <form method="post" action="/admin/zhuanli" id="form1">
                        <div class="listbox">
                        <table width="600">
                        <tr>
                        <td width="25"><img src="/images/arrow_r.png" /> </td><td><a href="/admin/zhuanlilist" class="lblack">查看专利列表</a></td>
                        </tr>
                        </table>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">发布专利</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        专利名称
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.name,new {@class="txs"}) %>
                                    <%=Html.HiddenFor(m=>m.id,new {@class="txs"}) %>
                                    
                                      
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        申请号
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.num,new {@class="txs"}) %>
                                    </td>
                                </tr>
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        专利类型
                                    </td>
                                    <td width="86%" class="boxta03">
                                   
                                      <%=Html.DropDownList("type", new List<SelectListItem> {
                                                new SelectListItem { Text = "实用新型专利", Value = "19"},
                                                new SelectListItem { Text = "发明专利", Value = "20"},
                                                })%>
                                                
                                                <%--<a href="/admin/category?zhuanli" target="_blank">添加专利类型</a>--%>
                                 
                                       
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                      地址
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.url, new { @class = "txs" })%>
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
                                            <input name="Submit222" type="submit" class="bulbg" value="发布" />
                                                                                       <input name="Submit2222" type="button" onclick="window.location.href='/admin/zhuanlilist'"; class="bulbg" value="返回" />
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
