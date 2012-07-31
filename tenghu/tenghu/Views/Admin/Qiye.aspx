<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.Category>" validateRequest="false"   %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>其他信息设置</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
       <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    
</head>
<body>
    <div class="mainbox">
        
        <%int cid = 0;
          int.TryParse(Request.QueryString["cid"], out cid);%>
        
        <%Html.RenderPartial("adminheader"); %>
        
        <div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="208" valign="top" background="/images/left_bg01.jpg">
                     <%Html.RenderPartial("adminleft"); %>
                       
                    </td>
                    <td valign="top" bgcolor="#F1F1F1">
                        
                     <%Html.RenderPartial("adminmenu"); %>
                        
                        <form action="/admin/qiye" method="post" id="form1">
                        
                        
                        <div class="listbox">
                        
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">其他信息</span>
                                    </td>
                                </tr>
                                
                                    <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        信息类别
                                    </td>
                                    <td width="86%" class="boxta03" >
                                    <%=Html.DropDownList("categoryid", new List<SelectListItem> {
                                    new SelectListItem { Text = "--选择--", Value = "-1" , Selected=cid.Equals(-1)},
                                    new SelectListItem { Text = "公司简介", Value = "8", Selected=cid.Equals(8)},
                                    new SelectListItem { Text = "公司文化", Value = "9" , Selected=cid.Equals(9)},
                                    new SelectListItem { Text = "管理团队", Value = "10" , Selected=cid.Equals(10)},
                                    new SelectListItem { Text = "动力系统", Value = "28" , Selected=cid.Equals(28)},
                                    new SelectListItem { Text = "液压系统", Value = "29" , Selected=cid.Equals(29)},
                                    new SelectListItem { Text = "润滑系统", Value = "30" , Selected=cid.Equals(30)},
                                    new SelectListItem { Text = "其他系统", Value = "31" , Selected=cid.Equals(31)},
                                    new SelectListItem { Text = "技术简介", Value = "18" , Selected=cid.Equals(18)},
                                    new SelectListItem { Text = "联系我们", Value = "7" , Selected=cid.Equals(7)}
                                    
                                    }, new { onchange = "window.location.href='/admin/qiye?cid='+$('#categoryid').val()" })%>
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        详细内容
                                    </td>
                                    <td class="boxta03">
                                        <%=Html.TextAreaFor(m=>m.descr,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.id,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.isDisplay,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.name,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.pid,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.sortOrder,new {@class="txs"}) %>
                                        <%=Html.HiddenFor(m=>m.url,new {@class="txs"}) %>
                                        

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
                                            <input name="Submit222" type="submit" class="bulbg" value="发布信息" />
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
