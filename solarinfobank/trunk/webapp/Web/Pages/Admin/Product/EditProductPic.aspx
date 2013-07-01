<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ProductPicture>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   编辑产品图片 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <script>
     function CheckFileName() {
         var fileName = document.getElementById("picName").value;
         //debugger;
         if (fileName == "") {
             alert(" Please choose extension jpg / gif / png / jpeg Extension files ");
             return false;
         }
         else if (fileName.split(".")[1].toUpperCase() == "JPG" || fileName.split(".")[1].toUpperCase() == "GIF" || fileName.split(".")[1].toUpperCase() == "PNG" || fileName.split(".")[1].toUpperCase() == "JPEG")
             return true;
         else {
             alert("extension ." + fileName.split(".")[1] + " illegality. only jpg / gif / png / jpeg Extension files");
             return false;
         }
         return true;
     }
    </script>
    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <form id="bindForm" action="/admin/EditProductPic" enctype="multipart/form-data"
        method="post">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">编辑产品图片</td>
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
                            <img src="/images/sub/subico010.gif" width="18" height="19" />
                        </td>
                        <td width="94%" class="f_14">
                            <strong>
                                编辑产品图片</strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                     提示:* 为必填项</div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                        </td>
                        <td width="36%">
                            <%=Html.HiddenFor(model=>model.id) %>
                            <%=Html.HiddenFor(model => model.picName, new { @Readonly = "true" })%>
                            <img src="/ProductPic/<%=Model.picName %>" alt="" style="height:150px; width:150px" />
                        </td>
                        <td width="35%">
                            <span id="error_displayname"></span>
                        </td>
                    </tr>
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            链接地址:
                        </td>
                        <td width="36%">
                            <%=Html.TextBoxFor(model=>model.picUrl) %>
                        </td>
                        <td width="35%">
                            <span id="error_url"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="2">
                            <div style="text-align: left; color: Red; padding-left: 0px; padding: 0px;">
                                <%= Html.ValidationMessage("Error", "", new { id = "errormessage" })%></div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <div>
            <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <input name="button" type="submit" class="txtbu03" id="Submit2" value=" 保存" onclick="return CheckFileName();"/>
                    </td>
                    <td>
                        <input onclick="window.location='/admin/ProductPicList'" name="button2" type="button"
                            class="txtbu03" id="button2" value=" 取消" />
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </td>
</asp:Content>
