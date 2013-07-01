<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.MonitorItem>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Edit MonitorItem - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<td width="793" valign="top" background="/images/kj/kjbg01.gif">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">Edit MonitorItem</td>
                </tr>
                <tr>
                  <td> Here you can display visual configuration. By clicking on the elements in the tree </td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="find_yqi">
            <% using (Html.BeginForm("add", "monitoritem", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
               {%>
            <table width="688" border="0" align="center" cellspacing="0">
                <tr>
                    <td class="bzico_01">
                        Edit Device Model
                    </td>
                </tr>
                <tr>
                    <td class="bzptb">
                        <table width="90%" border="0" align="center" cellspacing="0">
                            <tr>
                        <td width="37%" height="36" class="tdflr">
                            Point Code：
                        </td>
                        <td width="63%">
                            <%= Html.TextBoxFor(model => model.code, new { @class = "subtxtsy", @size = "30" })%><span
                                id="error_code"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="tdflr">
                            Notename：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.noteName, new { @class = "subtxtsy", @size = "30" })%>
                            <span id="error_name"></span>
                        </td>
                    </tr>
                   <tr>
                        <td height="36" class="tdflr">
                            Unit：
                        </td>
                        <td>
                            <%= Html.TextBoxFor(model => model.unit, new { @class = "subtxtsy", @size = "30" })%>
                            <span id="Span3"></span>
                        </td>
                    </tr>                    
                    <tr>
                        <td height="36" class="tdflr">
                            ProtocolType：
                        </td>
                        <td>
                            <%=Html.DropDownListFor(model => model.protocolTypeCode, ViewData["selectProtocolTypes"] as IList<SelectListItem>, new { @class = "select200",@onChange="setCodeAffix()"})%>
                            <span id="error_modelType"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="tdflr">
                            IsCount：
                        </td>
                        <td>
                            <%= Html.CheckBox("isCount", new { @class = "subtxtsy", @size = "30" })%>
                            <span
                                id="Span1"></span>
                        </td>
                    </tr>   
                    <tr>
                        <td height="36" class="tdflr">
                            IsDisplay：
                        </td>
                        <td>
                            <%= Html.CheckBox("isDisplay", new { @class = "subtxtsy", @size = "30" })%>
                            <span id="Span2"></span>
                        </td>
                    </tr>                                     
                    <tr>
                        <td height="40" class="tdflr" align="right">
                            <input name="Submit" type="submit" class="subbu01" value=" <%=Resources.SunResource.MONITORITEM_SAVE %> " />&nbsp;
                        </td>
                        <td>
                            &nbsp;<a href="/monitoritem/list">
                                <input name="Submit2" type="button" class="subbu01" value=" <%=Resources.SunResource.MONITORITEM_CANEL %>" /></a>
                        </td>
                    </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <%} %>
        </div>
    </td>
</asp:Content>
