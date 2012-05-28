<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Adpic>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    宣传图片 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />

    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <script>
        function showBigPic(id, picName, language) {
            $("#showlargepic_" + id).attr("href", "/DepartmentPic/" + language + "/" + picName)
            $("#showlargepic_" + id).colorbox();
        }
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">

        <script>
            function changePage(page) {
                window.location.href = '/admin/DepartmentList/' + page;
            }
        </script>

        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif"/>
                            </td>
                            <td width="93%" class="pv0216">
                                宣传图片列表
                            </td>
                        </tr>
                        <tr>
                            <td>
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
        <div class="subrbox01">
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0"  background="/images/am/am_bg03.jpg" style="border:1px solid #DADADA; text-align:center; font-weight:bold;">
                            
                                <tr>
                                    <td width="10%" align="center">
                                        <strong>编号</strong>
                                    </td>
                                    <td width="25%" align="center">
                                        <strong>图片</strong>
                                    </td>
                                    <td width="35%" align="center">
                                        <strong>链接地址</strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong>语言</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%int i = 1;
                      foreach (var item in ViewData["list"] as IList<Adpic>)
                      {
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr>
                                    <td width="10%" height="42" align="center">
                                        <%=i++ %>
                                    </td>
                                    <td width="25%" style="padding-left: 30px;">
                                        <div class="upload_pic" style="text-align: center;">
                                            <div class="upload_picimg">
                                                <img style="width: 84px; height: 73px;" src="/DepartmentPic/<%=item.language %>/<%=item.picName %>" /></div>
                                            <div class="upload_piczi">
                                                <a id="showlargepic_<%=item.id %>" href="javascript:void(0)" onclick="showBigPic('<%=item.id %>','<%=item.picName %>','<%=item.language %>')">
                                                    查看大图</a></div>
                                        </div>
                                    </td>
                                    <td width="35%" align="center">
                                        <%=item.picUrl %>
                                    </td>
                                    <td width="10%" align="center">
                                        <%=item.langInstance.displayName %>
                                    </td>
                                    <td width="20%" align="center">
                                        <%if (AuthService.isAllow("admin", "editadpic"))
                                          { %>
                                        <a href="/admin/EditAdpic/<%=item.id %>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" title="编辑" alt="编辑" /></a>
                                        <%} %>
                                        <%if (AuthService.isAllow("admin", "deldepartmentpic"))
                                          { %>
                                        <a href="/admin/DelDepartmentPic/<%=item.id %>" onclick="return confirm('确认删除?')">
                                            <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="删除" title="删除" /></a>
                                        <%}
                                          else
                                          {%>
                                        <img src="/images/sub/nodelete.gif" width="16" height="16" border="0" alt="删除" title="删除" />
                                        <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
                    
                    <tr>
                <td height="36" colspan="5" background="/images/am/am_bg02.jpg"><table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="30%">
                    <%if (AuthService.isAllow("admin", "uploadadpic"))
              { %>
                    <a href="/admin/UploadAdpic/"> <img src="/images/am/ad_bu09.gif" width="131" height="28" /></a>
                    <%} %>
                    </td>
                    <td width="70%">
                    <%Html.RenderPartial("mpage"); %>
                    </td>
                  </tr>
                </table></td>
                
                
              </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
