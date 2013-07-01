<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.ProductPicture>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ProductPicture List - SolarInfoBank</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="/style/colorbox.css" rel="stylesheet" type="text/css" />
    <script src="/Script/jquery.colorbox.js" type="text/javascript"></script>

    <script>
        function showBigPic(id, picName) {
            $("#showlargepic_" + id).attr("href", "/ProductPic/" + picName)
            $("#showlargepic_" + id).colorbox();
        }
        
    </script>
    <script>
        function changePage(page) {
            window.location.href = '/admin/ProductPicList/' + page;
        }
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">

        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">产品图片列表</td>
                </tr>
                <tr>
                  <td>  </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div>
                <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" align="center">
                            <a href="/admin/UploadProductPic/" class="dbl">
                                <img src="/images/sub/subico016.gif" width="15" height="16" /></a>
                        </td>
                        <td width="94%">
                            <a href="/admin/UploadProductPic/" class="dbl">添加</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                                <tr>
                                    <td width="10%" align="center">
                                        <strong>编号</strong>
                                    </td>
                                    <td width="35%" align="center">
                                        <strong>图片</strong>
                                    </td>
                                    <td width="35%" align="center">
                                        <strong>链接地址</strong>
                                    </td>
                                    <td width="20%" align="center">
                                        <strong>操作</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%int i =1;
                        foreach (var item in ViewData["list"] as IList<ProductPicture>)
                        {
                    %>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr>
                                    <td width="10%" height="42" align="center">
                                        <%=i++ %>
                                    </td>
                                    <td width="35%" style=" padding-left:70px;">
                                        <div class="upload_pic" style="text-align: center;">
                                            <div class="upload_picimg">
                                                <img style="width: 84px; height: 73px;" src="/ProductPic/<%=item.picName %>" /></div>
                                            <div class="upload_piczi">
                                                <a id="showlargepic_<%=item.id %>" href="javascript:void(0)" onclick="showBigPic('<%=item.id %>','<%=item.picName %>')">
                                                    查看大图</a></div>
                                        </div>
                                    </td>
                                    <td width="35%" align="center">
                                        <%=item.picUrl %>
                                    </td>
                                    <td width="20%" align="center">
                                        <a href="/admin/EditProductPic/<%=item.id %>">
                                            <img src="/images/sub/pencil.gif" width="16" height="16" border="0" title="编辑"
                                                alt="编辑" /></a> <a href="/admin/DelProductPic/?id=<%=item.id %>&picName=<%=item.picName %>"
                                                    onclick="return confirm('确认删除吗?')">
                                                    <img src="/images/sub/cross.gif" width="16" height="16" border="0" alt="删除" title="删除" /></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%} %>
             
                </table>
            </div>
            <div class="sb_down">
            </div> <%Html.RenderPartial("page"); %>
        </div>
    </td>
</asp:Content>
