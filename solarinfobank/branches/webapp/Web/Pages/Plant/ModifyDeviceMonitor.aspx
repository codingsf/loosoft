<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Device>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title> <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.PLANT_DEVICEMONITOR_DEVICE_MONITOR%></title>
  <script>
      function aaa() {
          document.form1.submit();
          setTimeout("window.close()", 1000);
      }
  </script>
</head>
<body onunload="window.opener.location.reload();" >
    <div>
    <%using (Html.BeginForm("UpdateDeviceMonitor", "plant", FormMethod.Post, new { id="form1",name="form1"}))
      {%>
       <table class="subline02" width="100%" border="0" cellpadding="0" cellspacing="0" height="25">
                               <%=Html.Hidden("pid", Request.QueryString["pid"])%>
                                <tr>                              
                                 
                                    <td width="150px" align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_NAME%></strong>
                                    </td>
                                     <td width="100px">
                                           
                                            <%=Html.HiddenFor(m => m.id)%>
                                            
                                            <%=Html.TextBox("name", Model.name == null ? Model.fullName : Model.name)%>
                                            </td>
                                                                </tr>
                                    <tr>
                                    <tr><td>&nbsp;</td></tr>
                                    <td width="150px"align="center">
                                        <strong><%=Resources.SunResource.PLANT_DEVICEMONITOR_INSTAL_POWER%> <span class="f11">(kW)</span></strong>
                                    </td>
                                     <td width="100px">
           
            <%=Html.TextBox("currentPower", Model.designPower.ToString())%>
            </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td align="right" colspan="2"><input type="button" value="save" onclick="aaa();" /></td></tr>
            </table>
            <%} %>
    </div>
</body>
</html>
