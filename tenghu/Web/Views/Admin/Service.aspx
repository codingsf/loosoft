<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.ServiceInfo>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加 销售 /售后 </title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    post: "required",
                    tel: "required",
                    addr: "required",
                    descr: "required"
                },
                messages: {
                    tel: {
                        required: "请输入电话"
                    },
                    addr: {
                        required: "请输入地址 "
                    },
                    descr: {
                        required: "请输入详细信息"
                    },
                    post: {
                        required: "请输入邮编"
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
                        <form method="post" action="/admin.aspx/service" id="form1">
                        <table>
                        <tr>
                        <td width="25"><img src="/images/arrow_r.png"> </td><td><a href="/admin.aspx/servicelist" class="lblack">查看销售/售后 列表</a></td>
                        </tr>
                        </table>
                        <div class="listbox">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">添加 销售/售后</span>
                                    </td>
                                </tr>
                                  <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        区域
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.DropDownList("areaid",Comm.Area)%>
                                        
                                    </td>
                                </tr>
                                  <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        类型
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.DropDownList("nettypeid",Comm.NetworkType)%>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        邮编
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.post, new { @class = "txs" })%>
                                        
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        电话
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.tel, new { @class = "txs" })%>
                                    <%=Html.HiddenFor(m=>m.id) %>
                                    </td>
                                </tr>
                                
                                     <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        名称
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.addr, new { @class = "txs" })%>
                                    </td>
                                </tr>
                                
                                     <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        经度
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.longitude, new { @class = "txs" })%>
                                    </td>
                                </tr>
                                
                                     <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        纬度 
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m => m.latitude, new { @class = "txs" })%>
                                    </td>
                                </tr>
                                
                                
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                       售后/销售
                                    </td>
                                    <td width="86%" class="boxta03">
                                    
                                     <%=Html.DropDownList("issale", new List<SelectListItem> {
    new SelectListItem { Text = "销售网络", Value = "true"},
                                                new SelectListItem { Text = "售后网络", Value = "false"}
                                                
                                                
                                                })%> 
                                                
                                    </td>
                                </tr>
                                               <tr>
                                    <td width="14%" align="right" class="boxta03">
                                       简短介绍
                                    </td>
                                    <td width="86%" class="boxta03">
                                    
                                    <%=Html.TextAreaFor(m => m.descr, new {style="width:460px"})%>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="添加" />
                                                                                       <input name="Submit2222" type="button" onclick="window.location.href='/admin.aspx/servicelist'"; class="bulbg" value="返回" />
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
