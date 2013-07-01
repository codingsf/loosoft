<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Inside.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
     <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %> <%=Resources.SunResource.DEVICE_DEVICE_LOGS %> - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
		    <script src="/script/jquery.multiSelect.js" type="text/javascript"></script>
    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <link href="/style/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
 <script>
     $(document).ready(function() {
         $('#load').click(function() {
             $.ajax({
                 type: "POST",
                 url: "/device/log",
                 data: { t: $("#t").attr("value"), state: $("#state").val(), plant: $("#plant").val(), pindex: "1", errorType: cbxvalue('errorCode'), logList: cbxvalue('cbx'), ctype: $("#ctype").val() },
                 success: function(result) {
                     $('#loading').hide();
                     $('#result').append(result);
                 },
                 beforeSend: function() {
                     $('#result').empty();
                     $('#loading').show();
                 }
             });
         });
         $("#errorCode").multiSelect();
     });

     function cbxvalue(name) {
         var values = "";
         $("input[name='" + name + "']:checked").each(function() {
             values += $(this).val() + ",";
         });
         return values == "" ? '-1,' : values;
     }
     
    </script>
  <td width="793" valign="top" background="/images/kj/kjbg01.gif">
    <%=Html.Hidden("dId",Request.QueryString["dId"]) %>
    		<table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td lass="pv0216">Device Logs</td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"> classHere you can display visual configuration. By clicking on the elements in the tree </td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
		  <div class="subline01"><strong style="font-size:14px;">Preparation by screening</strong></div>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="24%">Turned to: </td>
              <td width="23%">State:</td>
              
              <td width="21%">Error</td>
              <td width="9%" valign="bottom">&nbsp;</td>
            </tr>
            <tr>
              <td height="36"><table width="160" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                  
                  <input id="t" name="t" onclick="WdatePicker()" readonly="readonly" size="18" type="text"
                                                value='<%=DateTime.Now.ToString("yyyy-MM-dd") %>' class="txtbu04" />
                  
                  
                  </td>
                  <td></td>
                </tr>
              </table></td>
              <td>
                     <select name="state" id="state" class="subselect02">
                          <option value="1">
                                        <%=Resources.SunResource.USER_LOG_CONFIRMED %></option>
                                    <option value="0">
                                        <%=Resources.SunResource.USER_LOG_NO_CONFIRM %></option>
                               
                                    <option value="-1">
                                        <%=Resources.SunResource.USER_LOG_ALL %></option>
                                </select>
              </td>
             
              <td>
                     <select id="errorCode" multiple="multiple" name="errorCode" size="5" style="width:110px">
                                    <option value="">
                                        <%=Resources.SunResource.USER_LOG_SELECT %>
                                    </option>
                                    <% foreach (ErrorType errorType in ViewData["errorTypes"] as ICollection<ErrorType>)
                                       { %>
                                    <option value="<%=errorType.code %>"><%=errorType.name%></option>
                                    <%} %>
                                </select>
              
              
              </td>
              <td width="9%" align="right">
                 <input name="load" class="subbu01" id="load" value="<%=Resources.SunResource.MONITORITEM_SEARCH %>"type="button" />
              
              </td>
            </tr>
          </table>
		</div>
    
		
		
		
		<div class="subrbox01" id="loading">
		  <div class="sb_top"></div>
		<div class="sb_mid">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                <tr>
                  <td width="9%" align="center"><strong><input type="checkbox" /></strong></td>
                  <td width="14%" align="center"><strong><%=Resources.SunResource.USER_LOG_DEVICE %></strong> </td>
                  <td width="24%" align="center"><strong> <%=Resources.SunResource.USER_LOG_SEND_DATE %></strong></td>
                  <td width="19%" align="center"><strong><%=Resources.SunResource.USER_LOG_DESCRIPTION %></strong></td>
                  <td width="14%" align="center"><strong> <%=Resources.SunResource.USER_LOG_ERROR_TYPE %></strong></td>
                  <td width="20%" align="center"><strong>  <%=Resources.SunResource.USER_LOG_STATE %></strong></td>
                  </tr>
              </table></td>
            </tr>
            
                     <tr>
                     <td colspan="6" align="center">   <img src="../../images/ajax_loading_min.gif" /></td>
                     </tr>                        
              
          </table>
		</div>
		<div class="sb_down"></div>
		</div>
		<div id="result">

                <script>
                    $.ajax({ type: "POST", url: "/device/loadlog", data: { userId: <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id%>,dId: $("#dId").attr("value") }, success: function(result) {
                    
                        $('#result').empty();
                        $('#loading').hide();
                        $('#result').append(result);
                    }
                    });
                </script>
            </div>
		</td>
</asp:Content>
