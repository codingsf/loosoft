<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/contentInside.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
      <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=this.Model.name %>  <%=Resources.SunResource.PLANT_EDIT_DEVICE%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<table cellpadding=0 cellspacing=0 border=0>
<tr>
<td background="/images/kj/kjbg01.gif" valign="top" width="793">
<script src="/script/jquery.js" type="text/javascript"></script>
 <script src="/script/jquery.validate.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript">
      $().ready(function() {
          $("#editForm").validate({
              errorElement: "em",
              rules: {
                  name: {
                      required: true,
                      minlength: 2,
                      maxlength: 30
                 }
              },
              errorPlacement: function(error, element) {
                  if (element.attr("name") == "name") {
                      $("#error_name").text('');
                      error.appendTo("#error_name");
                  }
                  if (element.attr("name") == "currentPower") {
                      $("#error_currentPower").text('');
                      error.appendTo("#error_currentPower");
                  }
              },

              messages: {
                  name: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.DEVICE_EDIT_ERROR_NAME %></span>",
                      minlength: "<span class='error'>&nbsp;<%=Resources.SunResource.DEVICE_EDIT_ERROR_NAME_MINLENGTH %></span>",
                      maxlength: "<span class='error'>&nbsp;<%=Resources.SunResource.DEVICE_EDIT_ERROR_NAME_MAXLENGTH %></span>"
                      
                  },
                  currentPower: {
                      required: "<span class='error'>&nbsp;<%=Resources.SunResource.DEVICE_EDIT_ERROR_POWER_REQUIRED %></span>",
                  number: "<span class='error'>&nbsp;<%=Resources.SunResource.AUTH_REG_REVENUE_NUMBER %></span>"
                  }
              },
              success: function(em) {
              }
          });

      });
    </script>

<table background="/images/kj/kjbg02.jpg" border="0" cellpadding="0" cellspacing="0" height="63" width="793">
          <tbody><tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" height="63" width="8"></td>
            <td width="777">

            <% Device device = ViewData["device"] as Device;%>
            
            <table border="0" cellpadding="0" cellspacing="0" height="45" width="98%">
                <tbody><tr>
                  <td rowspan="2" align="center" width="7%"><img src="/images/kj/kjiico01.gif" ></td>
                  <td class="pv0216"><%=Resources.SunResource.PLANT_EDIT_DEVICE%></td>
                  <td class="help_r" align="right"><a href="#" style="color: rgb(89, 144, 62); text-decoration: underline;">
                      Help </a></td>
                </tr>

                <tr>
                  <td width="75%">  &nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </tbody></table>
            
            </td>
            <td align="right" width="6"><img src="/images/kj/kjico03.jpg" height="63" width="6"></td>
          </tr>

        </tbody></table>
        <form action="/plant/inverteredit" method="post" id="editForm">
          <div class="subrbox01">

            <div>
              <table border="0" cellpadding="0" cellspacing="0" height="30" width="90%">
                <tbody><tr>
                  <td align="center" width="6%"><img src="/images/sub/subico010.gif" height="19" width="18"></td>
                  <td class="f_14" width="94%"><strong><%=Resources.SunResource.PLANT_EDIT_DEVICE%></strong></td>

                </tr>
              </tbody></table>
            </div>

            <div class="sb_top"></div>
            <div class="sb_mid">
              <div></div>
              <div class="note01" style="margin-bottom: 10px;"><%=Resources.SunResource.REPROT_NOTE%> :*<%=Resources.SunResource.USER_ADDPLANT_FOR_MUST_FILL_IN_THE_ITEM%></div>
              <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">

                <tbody>
                
                
                <tr>
                  <td class="pr_10" height="35" width="30%"><span><%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%>:</span></td>
                  <td width="30%">
                  <%=Html.TextBox("name", string.IsNullOrEmpty(device.name) ? device.fullName : device.name, new { @class = "txtbu01" })%> <span class="red">*</span>
                 
                 <%=Html.Hidden("didStr",device.id) %>
                 <%=Html.Hidden("pid",Model.id) %>
                </td>
                <td align="left"><span id="error_name"></span></td>
                  </tr>                  
                    <tr>

                  <td class="pr_10" height="35"><strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_LASTED_UPDATED_TIME%>:</strong></td>
                  <td>
                  
                  <%=device.runData.updateTime.ToString("yyyy-MM-dd HH:mm:ss")%></td>
                  </tr>
                  
                    
              </tbody></table>
              
            </div>
            <div class="sb_down"></div>
          </div>
          <table align="center" border="0" cellpadding="0" cellspacing="0" height="60" width="244">
            <tbody><tr>

              <td width="111"><input name="addUser" class="txtbu03" value="<%=Resources.SunResource.PLANT_EDIT_SAVE%>" type="submit"></td>
              <td width="108"><input name="Submit32" class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_CANCLE%>" onclick="window.location.href='/plant/devicemonitor/<%=Model.id %>'" type="button"></td>
            </tr>
          </tbody></table>
         </form>
          
          </td>
          </tr>
          </table>          
</asp:Content>
