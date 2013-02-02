<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.Tenghu.Domain.OrderInfo>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加/编辑 产品</title>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
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
                        
                        
                        <form action="/admin/addproduct" method="post" id="form1" enctype = "multipart/form-data">
                        
                        
                        <div class="listbox">
                        
                           <table width="300">
                        <tr>
                        <td width="25"><img src="/images/arrow_r.png" /> </td>
                        <td><a href="/admin/order" class="lblack">查看订单列表</a></td>
                        </tr>
                        </table>
                        
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">订单详情</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right" class="boxta03">
                                        区域
                                    </td>
                                    <td width="70%" class="boxta03">
                                    <%=Html.Encode(Model.areaname) %>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td width="30%" align="right" class="boxta03">
                                        产品大类别
                                    </td>
                                    <td width="70%" class="boxta03">
                                    <%=Html.Encode(Model.category.name) %>
                                      
                                      </td>
                                </tr>
                                
                                
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        产品型号
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.product.name)%>
                                    
                                    
                                    </td>
                                </tr>
                                 <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        采购性质
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.type)%>
                                    
                                    </td>
                                </tr>
                                  <tr>
                                    <td align="right" valign="top" class="boxta03">
                                       采购时间
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.time)%>
                                    
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        付款方式
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.payment)%>
                                    
                                    </td>
                                </tr>
                                 
                                   <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        姓名
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.uname)%>
                                    
                                    </td>
                                </tr>
                                
                                 
                                   <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        公司
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.company)%>
                                    
                                    </td>
                                </tr>
                                
                                
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        联系电话
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.tel)%>
                                    
                                       
                                    </td>
                                </tr>
                                
                                 
                                   <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        E-mail
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.email)%>
                                    
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td align="right" valign="top" class="boxta03">
                                       联系地址
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.address)%>
                                    
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        留言/备注
                                    </td>
                                    <td class="boxta03">
                                   <%=Html.Encode(Model.comment)%>
                                    
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
