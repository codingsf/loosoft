<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
      <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   <%=Resources.SunResource.MONITORITEM_SUCCESS %> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="mainbox">
        <div class="qbox">
            <table width="100%" height="222" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="13" background="/images/qimg/qbg01.jpg">
                        &nbsp;
                    </td>
                    <td width="728" background="/images/qimg/qbg03.jpg">
                        <table width="90%" height="133" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="17%" rowspan="2" valign="top">
                                    <img src="/images/qimg/qico01.gif" width="62" height="83" />
                                </td>
                                <td width="83%" height="73" valign="top" style="font-size: 20px; color: #333333;" colspan="2">
                                    <%=Resources.SunResource.AUTH_SUCCESS %>
                                    <br />
                                    <%=Resources.SunResource.AUTH_REMEMBER %> :<br />
                                     <%=TempData[ComConst.User]!=null? (TempData[ComConst.User] as User).username:string.Empty%>
                                </td>
                            </tr>
                            <tr >           
                                         
                                <td valign="middle" width="53%" style="font-size: 14px; color: #333333;">
                                  <img src="/Images/tzimh.gif" />  <%=Resources.SunResource.AUTH_NOW_YOU_CAN %> : <a href="/user/addoneplant" class="green" style="text-decoration: underline;"><%=Resources.SunResource.AUTH_ADD_PLANT %> </a>
                                    <a href="/user/addoneplant"><img title="<%=Resources.SunResource.PLANT_ADDPLANT_ADD_PLANT %> " alt="<%=Resources.SunResource.PLANT_ADDPLANT_ADD_PLANT %> " style="border:none" src="/Images/lightbulb.gif"  /></a> 
                                </td>
                                <td valign="middle" width="15%" align="left" style="font-size: 14px; color: #333333;">
                                </td>
                            </tr>
                        </table>                      
                    </td>
                    <td width="13" background="/images/qimg/qbg02.jpg">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
</asp:Content>
