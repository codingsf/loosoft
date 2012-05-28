<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/UserInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.PlantUser>" ValidateRequest="false"  %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">
        $().ready(function() {
            $("#bindForm").validate({
                errorElement: "em",
                rules: {
                    username: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "username") {
                        $("#error_username").text('');
                        error.appendTo("#error_username");
                    }
                },

                messages: {
                    username: {
                    required: "<span class='error'>&nbsp; <%=Resources.SunResource.AUTH_REG_USERNAME_REQUIRED %></span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.MONITORITEM_SUCCESS %></span>');
                }
            });

        });
        function checkChar() {
            var InString = document.getElementById("username").value;
            var RefString = "<";
            var RefString2 = "%";
            var RefString3 = "\"";
            var RefString4 = ">";
            var RefString5 = "~";
            var RefString6 = "&";
            var RefString7 = "?";
            var RefString8 = "'";
            for (Count = 0; Count < InString.length; Count++) {
                 TempChar = InString.substring(Count, Count + 1);
                 if ((RefString.indexOf(TempChar, 0) == 0) || (RefString2.indexOf(TempChar, 0) == 0) || (RefString3.indexOf(TempChar, 0) == 0) || (RefString4.indexOf(TempChar, 0) == 0) || (RefString5.indexOf(TempChar, 0) == 0) || (RefString6.indexOf(TempChar, 0) == 0) || (RefString7.indexOf(TempChar, 0) ==0) || (RefString8.indexOf(TempChar, 0) == 0)) {
                     alert("There is an invalid character<,\,%,> ,~,&,?,'");
                          return (false);
                     }
                 }
           return (true);
      } 
    </script>

   <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <form id="bindForm" action="/user/openplant" enctype="multipart/form-data" method="post">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.USER_OPENPLANT_OPEN_PLANT  %></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.USER_OPENPLANT_OPEN_PLANT_DETAIL  %>&nbsp;</td>
                  <td width="18%"></td>
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
                            <img src="/images/sub/subico010.gif" width="18" height="19" alt="<%=Resources.SunResource.MONITORITEM_EDIT  %>" title="<%=Resources.SunResource.MONITORITEM_EDIT  %>" />
                        </td>
                        <td width="94%" class="f_14">
                            <strong><%=Resources.SunResource.USER_OPENPLANT_OPEN_PLANT  %></strong>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sb_top">
            </div>
            <div class="sb_mid">
                <div class="note01">
                    <%=Resources.SunResource.MONITORITEM_NOTE  %>:* <%=Resources.SunResource.MONITORITEM_FOR_MUST_FILL_IN_THE_ITEM  %></div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="29%" height="36" class="pr_10">
                            <%=Resources.SunResource.USER_OPENPLANT_USERNAME  %>:
                        </td>
                        <td width="36%">
                            <%= Html.HiddenFor(model => model.plantID)%>
                            <%= Html.TextBoxFor(model => model.username, new { @class = "txtbu04", @size = "25" })%>
                            <span class="red">*</span>
                        </td>
                        <td width="35%">
                            <span id="error_username"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="2">
                            <div style="text-align: left; color: Red; padding-left: 0px; padding: 0px;">
                                <%= Html.ValidationMessage("Error", "", new { id = "errormessage" })%> </div>
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
                        <input name="button" type="submit" class="txtbu03" id="Submit2" value="<%=Resources.SunResource.MONITORITEM_SAVE  %>" title="<%=Resources.SunResource.MONITORITEM_SAVE  %>" onclick="return checkChar()" />
                    </td>
                    <td>
                        <input onclick="window.location='/user/allplants'" name="button2" type="button"
                            class="txtbu03" id="button2" value="<%=Resources.SunResource.MONITORITEM_CANEL  %>" title="<%=Resources.SunResource.MONITORITEM_CANEL  %>" />
                    </td>
                </tr>
            </table>
        </div>
        </form>
        
        
        <div class="subrbox01">
          
            <div class="sb_top">
            </div>
            <div class="sb_mid">

                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tbody><tr>
                        <td>
                            <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0" height="25">
                                <tbody><tr>
                                    <td width="28%" align="center">
                                        <strong><%=Resources.SunResource.USER_OPENPLANT_NAME  %></strong>
                                    </td>

                                    <td width="25%" align="center">
                                        <strong><%=Resources.SunResource.USER_OPENPLANT_USER  %></strong>
                                    </td>
                                     <td width="15%" align="center">
                                        <strong><%=Resources.SunResource.USER_OPENPLANT_USER_NICKNAME %></strong>
                                    </td>
                                    <td width="10%" align="center">
                                        <strong><%=Resources.SunResource.MONITORITEM_OPERATION  %></strong>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
<%foreach(var item in (ViewData["data"] as IList<PlantUser>))
  {if(item.userID==(Session["User"] as User).id)
      continue;
       %>
  <tr>
                        <td>
                            <table class="down_line01" width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tbody><tr style=""  >
                                    <td width="28%" align="center" height="42">
                                     <div style="width: 200px; overflow: hidden;" title="<%=item.plant.name %>"> <a href="/plant/Profile/112" class="dbl"><%=item.plant.name %></a></div>
                                    </td>
                                    <td width="25%" align="center">

                                     <div style="width: 200px; overflow: hidden;" title="<%=item.User.username %>"><%=item.User.username%></div>
                                    </td>
                                    <td width="15%" align="center">

                                     <div style="width: 100px; overflow: hidden;" title="<%=item.User.fullname %>"><%=item.User.fullname%></div>
                                    </td>
                                    
                                    <td width="10%" align="center">
                                    <a onclick="return confirm('<%=Resources.SunResource.MONITORITEM_SURE_DELETE%>')" href="/user/closeplant/<%=item.plant.id %>/?uid=<%=item.User.id %>">
                                                    <img src="/images/sub/cross.gif" alt="<%=Resources.SunResource.MONITORITEM_DELETE  %>" title="<%=Resources.SunResource.MONITORITEM_DELETE  %>" width="16" border="0" height="16"></a>
                                        
                                    </td>
                                    
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
  
 <%} %>         
                    
                 
                    
                </tbody></table>
            </div>
            <div class="sb_down">

            </div>
            
            </div>
            
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>   <%=Resources.SunResource.USER_OPENPLANT_OPEN_PLANT  %> 
</asp:Content>
