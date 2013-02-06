<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Job>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加/编辑 岗位</title>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
    <link href="../../css/css.css" rel="stylesheet" type="text/css" />
    
    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#form1").validate({
                rules: {
                    renshu:
                    {
                        required: true,
                        digits: true   
                    },
                    xshui:
                    {
                        required: true
                    },
                    zhuanye: "required",
                    name:
                {
                    required: true
                }
                },
                messages: {
                    descr: {
                        required: "请输入详细内容"
                    },
                    name: {
                        required: "请输入职位名称 "
                    },
                    xshui: {
                    required: "请输入职位薪水 ",
                        digits:"请输入一个整数"
                    },
                    renshu: {
                        required: "请输入招聘人数 ",
                        digits:"请输入一个整数"
                        
                    },
                    zhuanye: {
                        required: "请输入专业 "
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
                        
                        
                        
                        <form method="post" action="/admin/addjob" id="form1">
                        <div class="listbox">
                           <table width="600">
                        <tr>
                        <td width="25"><img src="/images/arrow_r.png" /> </td><td><a href="/admin/jobs" class="lblack">查看职位列表</a></td>
                        </tr>
                        </table>
                        
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxta">
                                <tr>
                                    <td height="31" colspan="2" class="boxta01">
                                        <span class="f14" style="float: left; line-height: 31px;">发布职位</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        职位名称
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.name,new {@class="txs"}) %>
                                    <%=Html.HiddenFor(m=>m.id,new {@class="txs"}) %>
                                    </td>
                                </tr>
                                
                                   <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        学历
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.DropDownList("xueli", Comm.Xueli) %>
                                   
                                     
                                    </td>
                                </tr>
                                
                                      <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        工作经验
                                    </td>
                                    <td width="86%" class="boxta03">
                                   
                                    <%=Html.DropDownList("jyan", Comm.Jyan)%>
                                       
                                    </td>
                                </tr>
                                           <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        招聘人数
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.renshu,new {@class="txs"} )%>
                                       
                                    </td>
                                </tr>
                                
                                           <tr>
                                    <td width="14%" align="right" class="boxta03">
                                        薪水
                                    </td>
                                    <td width="86%" class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.xshui,new {@class="txs"} )%>
                                       
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        专业
                                    </td>
                                    <td class="boxta03">
                                    <%=Html.TextBoxFor(m=>m.zhuanye,new {@class="txs"}) %>
                                        
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" valign="top" class="boxta03">
                                        详细内容
                                    </td>
                                    <td class="boxta03">
                                    <%=Html.TextAreaFor(m=>m.descr,new {@class="txs"}) %>
                                        
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right" class="boxta03">
                                        &nbsp;
                                    </td>
                                    <td class="boxta03">
                                            <input name="Submit222" type="submit" class="bulbg" value="发布" />
                                                 
                                                 
                                                     <script type="text/javascript">
                                                         window.onload = function() {
                                                         var editor = CKEDITOR.replace('descr');
                                                             CKFinder.SetupCKEditor(editor, '/ckfinder/');
                                                         };
                                            
                                        </script> 
                                        
                                                                              <input name="Submit2222" type="button" onclick="window.location.href='/admin/jobs'"; class="bulbg" value="返回" />
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
