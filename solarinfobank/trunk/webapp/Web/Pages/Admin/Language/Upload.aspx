<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<IEnumerable<Cn.Loosoft.Zhisou.SunPower.Domain.Language>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function CheckFileName() {
            var fileName = document.getElementById("uploadFile").value;
            //debugger;
            if (fileName == "") {
                alert(" 请选择一个扩展名为 resx 的文件");
                return false;
            }
            else if (fileName.split(".")[1].toUpperCase() == "RESX")
                return true;
            else {
                alert("扩展名 ." + fileName.split(".")[1] + " 非法. 只能是 resx 扩展名的文件");
                return false;
            }
            return true;
        }
    </script>

    
    
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">语言导入</td>
                </tr>
                <tr>
                  <td>&nbsp; </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox01">
            <div style="height: 20px; clear: both">
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="675" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                        <td width="30%" height="36" >
                        <% using (Html.BeginForm("/language_upload", "admin", FormMethod.Post, new { enctype = "multipart/form-data", @class = " :required" }))
                               {%>
                          <select id="Select1" name="language">
                      <% foreach (var item in Model)
                         { %>
                         <option value="<%=item.id %>"><%=item.name %></option>
                      <%} %>
                          
                          </select>
                        </td>
                        <td width="70%">
                            
                            <input name="uploadFile" id="uploadFile" type="file" size="40" onkeydown="return   false " onpaste="return   false " />&nbsp;&nbsp;
                            <input value="  上传  " type="submit" onclick="return CheckFileName();" />
                            <%} %>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    语言导入 - SolarInfoBank
</asp:Content>
