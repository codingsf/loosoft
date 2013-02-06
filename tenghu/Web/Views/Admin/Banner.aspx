<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>页面Banner</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
      <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    
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
                        
        <form id="form1" action="/admin.aspx/banner" enctype="multipart/form-data"
        method="post">
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">上传Banner (只限.jpg 格式)</span>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        分类
                                    </td>
                                    <td width="86%" class="boxta03">
                                       <%=Html.DropDownList("pid",ViewData["items"] as IList<SelectListItem>) %>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        上传
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <input name="image" id="image" type="file" size="25" onkeydown= "return   false "   onpaste= "return   false " />
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="添加" />
                                                 <%=ViewData["result"] %>                                      
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
