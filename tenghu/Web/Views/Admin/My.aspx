<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Manager>" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>我的资料</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
      <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    username: "required",
                    password:
                {
                    required: true
                }
                },
                messages: {
                    username: {
                        required: "请输入用户名"
                    },
                    password: {
                        required: "请输入密码 "
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
                        
                        
                        
                        <form method="post" action="/admin.aspx/my" id="form1">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">我的资料</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        用户名
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.username, new { @class = "txs" })%>
                                        <%=Html.HiddenFor(m=>m.id) %>
                                        <%=Html.HiddenFor(m=>m.issuper) %>
                                        <%=Html.HiddenFor(m=>m.islocked) %>

                                        
                                        
                                        
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        密码
                                    </td>
                                    <td width="86%" class="boxta03">
                                        <%=Html.TextBoxFor(m => m.password, new { @class="txs"})%>
                                    
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="更新" />
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
