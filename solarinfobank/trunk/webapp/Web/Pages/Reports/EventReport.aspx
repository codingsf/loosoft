<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ReportConfig>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
           <div class="subrbox01">
            <%using (Html.BeginForm("SaveEventReport", "Reports", FormMethod.Post, new { name="eventForm"}))
              { %>
              <%=Html.Hidden("PlantId", ViewData["plantId"])%>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <% if (Model != null)
                 {

                     switch (Model.sendFormat)
                     {
                         case "html":
                     %>
                <tr>
                  <td width="20%" height="30" align="right"  style="padding-right:10px;"><%=Resources.SunResource.REPORT_SEND_FORMAT%>:</td>
                  <td width="80%" >
                  <input type="radio" checked="checked" name="sendFormat" value="html" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_HTML%>
  <%--<input type="radio" name="sendFormat" value="txt" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_TXT%>--%> </td>
                </tr>
                <%break;
                         case "txt": %>
                    <tr>
                  <td width="20%" height="30" align="right"  style="padding-right:10px;"><%=Resources.SunResource.REPORT_SEND_FORMAT%>:</td>
                  <td width="80%" ><input type="radio"  name="sendFormat" value="html" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_HTML%>
  <input type="radio" checked="checked" name="sendFormat" value="txt" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_TXT%> </td>
                </tr>
                <%break;
                     }
                 }
                 else
                 { %>
                 <tr>
                  <td width="20%" height="30" align="right"  style="padding-right:10px;"><%=Resources.SunResource.REPORT_SEND_FORMAT%>:</td>
                  <td width="80%" ><input type="radio" checked="checked"  name="sendFormat" value="html" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_HTML%>
  <%--<input type="radio" name="sendFormat" value="txt" />
 <%=Resources.SunResource.REPORT_SEND_FORMAT_TXT%> --%></td>
                </tr>
                <%} %>
                <tr>
                  <td align="right" valign="top"  style="padding-right:10px;" ><%=Resources.SunResource.REPORT_EMAIL%>:</td>
                  <td >
                  <textarea id="emails" name="email" id="email"  class="txtbu05" style="width:400px; font-size:12px; color:#999999; text-align:left;" cols="20"  rows="1"><%=(Model)== null ? "" : (Model).email%></textarea>
                     <div id="emailNote"><%=Resources.SunResource.REPROT_NOTE%>:<%=Resources.SunResource.REPORT_EMAIL_NOTE%></div>
                     
                     <%=Html.Hidden("idstr", Model == null ? 0 : Model.id) %>
                  </td>
                </tr>
              </table>
                <div>
            <table width="56%" height="80" border="0"  cellpadding="0" cellspacing="0">
              <tr>
              <td width="33%"> </td>
                <td width="33%">
                <%if (Cn.Loosoft.Zhisou.SunPower.Service.AuthService.isAllow(AuthorizationCode.EVENT_REPORT))
                  { %>
                
                <input name="Submit3" type="submit" class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_SAVE%>" />
   <%}
                  else
                  {%>
                  <input name="Submit3" type="button" class="txtbu06"  value="<%=Resources.SunResource.REPORT_BUTTON_SAVE%>" />
                  <%} %>
   
   
   </td>
                <td width="33%"><input name="Submit32" type="Button" onclick="backRunReport()" class="txtbu03" value="<%=Resources.SunResource.REPORT_BUTTON_CANCLE%>" /></td>
              </tr>
            </table>
         
          <%} %>
           
          
          </div>
           
             
        
        
       
