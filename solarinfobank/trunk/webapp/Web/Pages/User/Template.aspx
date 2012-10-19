<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
    模板设置
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .mbts
        {
            color: #EB5106;
            background: #FFF1CA;
            border: 1px solid #F6C97C;
            padding: 5px;
            line-height: 20px;
            margin-bottom: 10px;
        }
        .mblogo
        {
            border: 1px solid #D7D7D7;
            text-align: center;
            width: 250px;
        }
        .mblogo span
        {
            display: block;
            height: 20px;
            line-height: 20px;
            text-align: center;
            background: #EEEEEE;
        }
        .mblogo img
        {
            margin: 10px 0px;
        }
        .mbchange
        {
            margin-left: 35px;
            list-style: none;
            display: inline-table;
            margin-top: 25px;
        }
        .mbchange li
        {
            float: left;
            display: block;
            margin-right: 50px;
            height: 130px;
        }
        .mbchange li img
        {
            border: 3px solid #DFDFDF;
        }
        .mbchange li span
        {
            display: block;
            text-align: center;
            height: 25px;
            line-height: 25px;
        }
        .mbchange li input
        {
            vertical-align: middle;
        }
    </style>

    <script>

        function loadjscssfile(filename, filetype) {
            if (filetype == "js") {
                var fileref = document.createElement('script')
                fileref.setAttribute("type", "text/javascript")
                fileref.setAttribute("src", filename)
            }
            else if (filetype == "css") {
                var fileref = document.createElement("link")
                fileref.setAttribute("rel", "stylesheet")
                fileref.setAttribute("type", "text/css")
                fileref.setAttribute("href", filename)
            }
            if (typeof fileref != "undefined")
                parent.document.getElementsByTagName("head")[0].appendChild(fileref)
        }
        function refreshcss() {
            loadjscssfile("<%= UserUtil.curTemplete.cssFolder %>/style/css.css", "css")
            loadjscssfile("<%= UserUtil.curTemplete.cssFolder %>/style/sub.css", "css")
            loadjscssfile("<%= UserUtil.curTemplete.cssFolder %>/style/share.css", "css")
            loadjscssfile("<%= UserUtil.curTemplete.cssFolder %>/style/lc.css", "css")
        }

        $().ready(function() {
            var random = new Date().getMilliseconds();
            var src = '<%=UserUtil.UserLogo %>?' + random;
            $("#logo", window.parent.document).attr("src", src);
            $("#viewlogo").attr("src", src);
            refreshcss();


            $("#mainForm").validate({
                errorElement: "em",
                rules: {
                    sysName: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "sysName") {
                        $("#error_sysname").text('');
                        error.appendTo("#error_sysname");
                    }
                },
                messages: {
                    sysName: {
                        required: "<span class='error'>请输入系统名称 </span>"
                    }
                },
                success: function(em) {
                }
            });
        })
    </script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
                <table width="793" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
                    <tr>
                        <td width="8">
                            <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                        </td>
                        <td width="777">
                            <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="7%" rowspan="2" align="center">
                                        <img src="/images/kj/kjiico01.gif" width="36" height="44" />
                                    </td>
                                    <td width="93%" class="pv0216">
                                        模板设置
                                    </td>
                                </tr>
                                <tr>
                                    <td class="pv0212">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6" align="right">
                            <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                        </td>
                    </tr>
                </table>
                <form method="post" action="/user/template" enctype="multipart/form-data" id="mainForm">
                <div class="subrbox01">
                    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td class="f_14">
                                <strong>上传logo与修改名称</strong>
                            </td>
                        </tr>
                    </table>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <div class="mbts">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="8%" valign="top">
                                        <strong>请注意：</strong>
                                    </td>
                                    <td width="92%" valign="top">
                                        1、请上传不超过(宽200*高50),像素为72px的位图(支持jpg,png,gif)，为保证页面效果，最好是透明背景的gif ！<br />
                                        2、系统名称名称设定最好不要超过18个字符，多出字符将显示不出来！
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="18%" height="35" class="pr_10">
                                    上传Logo：
                                </td>
                                <td colspan="2">
                                    <input type="file" name="logopic" style="display: none" id="logopic" onchange="picpath.value=this.value" />
                                    <input name="picpath" id="picpath" type="text" class="txtbu01" />
                                    <input type="button" name="Submit32" value="上传" class="sc_btu" onclick="logopic.click();" />
                      
                                    <%= ViewData["error"]%>
                                </td>
                            </tr>
                            <tr>
                                <td height="80" class="pr_10">
                                    &nbsp;
                                </td>
                                <td>
                                    <div class="mblogo">
                                        <span>当前logo</span>
                                        <img src="<%= UserUtil.UserLogo %>" width="168" height="27" id="viewlogo" />
                                    </div>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td height="35" class="pr_10">
                                    系统名称：<span class="red">*</span>
                                </td>
                                <td>
                                    <input id="sysName" name="sysName" type="text" class="txtbu01" style="width: 250px;"
                                        value="<%=UserUtil.SysName %>" />
                                </td>
                                <td>
                                    <span id="error_sysname"></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <div class="subrbox01">
                    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td class="f_14">
                                <strong>选择模板</strong>
                            </td>
                        </tr>
                    </table>
                    <div class="sb_top">
                    </div>
                    <div class="sb_mid">
                        <ul class="mbchange">
                            <%foreach (Template template in ViewData["template"] as IList<Template>)
                              { %>
                            <li>
                                <img src="/images/<%=template.pic %>" width="102" height="85" />
                                <span>
                                    <input type="radio" name="template" <%=UserUtil.curTemplete.id.Equals(template.id)?"checked=checked ":""%>
                                        value="<%=template.id %>" />
                                    <%=template.name %>
                                </span></li>
                            <%} %>
                        </ul>
                    </div>
                    <div class="sb_down">
                    </div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="244" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="111">
                                        <input name="Submit2" type="submit" class="ok_greenbtu" value="<%=Resources.SunResource.MONITORITEM_SAVE%>" />
                                    </td>
                                    <td width="108">
                                        <input name="Submit3" type="submit" class="no_greybtu" value="<%=Resources.SunResource.MONITORITEM_RESET%>" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                </form>
            </td>
        </tr>
    </table>
</asp:Content>
