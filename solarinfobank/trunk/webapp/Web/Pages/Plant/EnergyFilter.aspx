<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/ContentInside.Master"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>"%>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>  <%=Resources.SunResource.USER_LOG_ALL_PLANT_LOGS %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var pageNo = 1;
        var plantId = -1;
        $(document).ready(function() {
            parent.iFrameHeight();
            $("#load").click(function() { search(); });
        });
        
        function search() {
            plantId = $("#plant").val();
            window.location.href="/plant/energyFilter?uid=<%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().id %>&id=<%=Model.id %>"+"&yyyyMMdd="+$("#endDate").attr("value");
        }
        var ttl1 = ' <%= Resources.SunResource.USER_LOG_SELECT_ALL%>';
        var ttl2 = ' <%= Resources.SunResource.PLANT_LOG_SELECT%>';
        var ttl3 = '% <%= Resources.SunResource.USER_LOG_SELECTED%> ';
    </script>

    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <table cellpadding=0 cellspacing=0 border=0>
    <tr>
    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
    
       <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td class="pv0216"><%=Resources.SunResource.SHARED_INSIDEMASTERPAGE_ENERGYWARN%></td>
                  <td align="right" class="help_r"><a href="/help/<%=(Session["Culture"] as CultureInfo).Name%>/SolarInfo Bank User Manual.pdf" target="_blank" style="color:#59903E; text-decoration:underline;">
                      <%=Resources.SunResource.MONITORITEM_HELP%> </a></td>
                </tr>
                <tr>
                  <td width="75%"><%=Resources.SunResource.USER_LOG_ALL_PLANT_LOGS_DETAIL %>&nbsp;</td>
                  <td width="18%"></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="subrbox03">
            <table width="100%">
                <tr>
                    <td width="6%" align="center">
                        <img src="/images/sub/subico010.gif" width="18" height="19" />
                    </td>
                    <td>
                        <div>
                            <strong style="font-size: 14px;"><%=Resources.SunResource.USER_LOG_PREPARATION_BY_SCREENING %></strong></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="10%" align=right>
                        <%=Resources.SunResource.REPORT_TIME%>:
                    </td>
                    <td width="10%">
                    <input id="endDate" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'<%= (Session["Culture"] as System.Globalization.CultureInfo).Name.ToLower()%>'})" readonly="readonly" size="15" type="text"
                        value='<%=ViewData["yyyyMMdd"]%>' class="txtbu04 Wdate" />
                    </td>
                    <td width="10%"  align=right>
                        &nbsp;
                    </td>
                    <td width="15%">
                        &nbsp;                       
                    </td>
                    <td width="45%">
                        &nbsp;
                    </td>
                    <td width="10%" valign="bottom">
                     <input name="load" class="subbu01" id="load" value="<%=Resources.SunResource.MONITORITEM_SEARCH %>"
                            type="button" />
                    </td>
                </tr>
            </table>
        </div>
        
        <div id="result">
            <div class="subrbox01">
		            <div class="sb_top"></div>
		            <div class="sb_mid">
		              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="subline02">
                            <tr>
                              <td width="100" align="center"><strong><%=Resources.SunResource.USER_LOG_DEVICE %></strong> </td>
                              <td width="150" align="center"><strong><%=Resources.SunResource.USER_OVERVIEW_ENERGY%></strong></td>
                              <td width="70" align="center"><strong><%=Resources.SunResource.CUSTOMREPORT_AVG%></strong></td>
                              <td width="175" align="center"><strong> <%=Resources.SunResource.ENERGYWARN_PERCENT%></strong></td>
                              </tr>
                          </table></td>
                        </tr>
                        
                         <%
                         int i=0;
                         foreach (Hashtable data in ViewData["datas"] as IList<Hashtable>)
                         {
                             i++;
                         %>        
                         <tr>
                          <td>
                          <table width="730" style="word-break:break-all;word-wrap:break-word; line-height:24px;"  border="0" cellpadding="0" cellspacing="0" class="down_line0<%=i%2 %>">
                            <tr>                         
                              <td width="100" align="center">
                                    <%=data["deviceName"]%>
                              </td>
                              <td width="150" align="center"> <%=data["energy"]%></td>
                              <td width="70" align="center"><%=data["average"]%></td>                  
                              <td width="175" align="center">
                               <%=data["prate"]%>
                              </td>
                              </tr>
                          </table>
                          </td>
                        </tr>
                        <%}
                             if (i == 1)
                             {
                             %>    
                             <tr>
                             
                             <td>
                              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="down_line01">
                                <tr>
                                <td height="35" align="center" colspan="7">
                                <%=Resources.SunResource.USER_LOG_NO_DATA%>
                                </td>
                                </tr>
                                </table>
                             </td>
                             </tr>
                             <%} %>    
                          
                      </table>
		            </div>      
		            <div class="sb_down"></div>
		            <br/>
		            </div>		            
        </div>
   </div>
   </td>
	</tr>
</table>
</asp:Content>
