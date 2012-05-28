<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    导入采集器 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function CheckFileName() {
            var fileName = document.getElementById("uploadFile").value;
            //debugger;
            if (fileName == "") {
                alert(" 请选择扩展名是：XLS/XLSX 的文件");
                return false;
            }
            else if (!(fileName.split(".")[1].toUpperCase() == "XLS" || fileName.split(".")[1].toUpperCase() == "XLSX")) {
                alert("扩展名 ." + fileName.split(".")[1] + " 错误. 只能是以 xls /xlsx 的文件");
                return false;
            }
            else {
                var reg = /Logger-SN\sIpmort\sBank\sP\d+$/;
                var r = fileName.split(".")[0].match(reg);
                if (r == null) {
                    alert("导入的文件名不合法！");
                    return false;
                }
                return true;
            }

        }
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
            <tr>
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif" />
                            </td>
                            <td width="93%" class="pv0216">
                                导入采集器
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
            <a href="/admin/download/">下载采集器模板</a>
            <div style="height: 20px; clear: both">
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="20%" height="36">
                            选择路径：
                        </td>
                        <td width="63%">
                            <% using (Html.BeginForm("collector_excel", "admin", FormMethod.Post, new { enctype = "multipart/form-data", @class = " :required" }))
                               {%>
                            <input name="uploadFile" id="uploadFile" type="file" size="40" onkeydown="return   false "
                                onpaste="return   false " />&nbsp;&nbsp;
                            <input value="导入" type="submit" onclick="return CheckFileName();" />
                            <%} %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <font color="red">
                                <%=  ViewData["result"]%></font>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_down">
            </div>
        </div>
        <br />
        <% var faildRecords = ViewData["faildRecord"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.Collector>;%>
        <%if (faildRecords != null && faildRecords.Count > 0)
          {
              Response.Write("<table width=\"755\" style=\"margin:0 auto; border:solid 1px #ccc;\"><tr height=\"39\">");
              Response.Write("<td width=\"15%\"align=\"center\"><strong>SN</strong></td>");
              Response.Write("<td width=\"15%\"align=\"center\"><strong>PASS</strong></td>");
              Response.Write("<td width=\"10%\"align=\"center\"><strong>MAC</strong></td>");
              Response.Write("<td width=\"15%\"align=\"center\"><strong>PNO</strong></td>");
              Response.Write("<td width=\"10%\"align=\"center\"><strong>ENCRYPTION</strong></td>");
              Response.Write("<td width=\"15%\"align=\"center\"><strong>DATE</strong></td>");
              Response.Write("<td width=\"20%\"align=\"center\"><strong>ERROR</strong></td></TR>");
              foreach (var item in faildRecords)
              { %>
        <tr height="39">
            <td width="15%" align="center" title="<%=item.code %>">
                <%= StringUtil.cutStr(item.code,12,"...") %>
            </td>
            <td width="15%" align="center" title="<%=item.password %>">
                <%= StringUtil.cutStr(item.password, 12, "...")%>
            </td>
            <td width="10%" align="center" title="<%=item.MAC %>">
                <%= StringUtil.cutStr(item.MAC, 12, "...")%>
            </td>
            <td width="15%" align="center" title="<%=item.PNO %>">
                <%= StringUtil.cutStr(item.PNO, 12, "...")%>
            </td>
            <td width="10%" align="center" title="<%=item.Encryption %>">
                <%= StringUtil.cutStr(item.Encryption, 12, "...")%>
            </td>
            <td width="20%" align="center" title="<%=item.Date %>">
                <%=item.Date%>
            </td>
            <td width="20%" align="center" >
                <font color="red">
                    <%=item.Descr%></span>
            </td>
        </tr>
        <%}
              Response.Write("</table>");
          }%>
    </td>
</asp:Content>
