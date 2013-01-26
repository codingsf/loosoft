<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background: url(<%=UserUtil.curTemplete.cssFolder %>/images/kj/rbg01.jpg) no-repeat right center;">
        <%if (Model.getDetectorWithRenderSunshine() != null || Model.hasFaultDevice)
          {%>
        <tr>
            <td height="50">
                <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7">
                            <img src="/images/sub/tll.gif" />
                        </td>
                       <%if (Model.getDetectorWithRenderSunshine()!= null)
                         { %>
                        <td width="200" valign="top">
                        
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif"
                                style="height: 34px">
                          
                                <tr>
                                    <td width="13%">
                                        <img src="/images/sub/kjjk.gif" width="16" height="16" />
                                    </td>
                                    <td width="75%" style="padding-right: 10px">
                                        <a target="_blank" href="/plantchart/prchart?pid=<%=Model.id %>" style="color: #E87006;
                                            text-decoration: underline;"><span style="white-space: nowrap">
                                                <%=Resources.SunResource.PLANT_OVERVIEW_PRCHART_TITLE%></span></a>
                                    </td>
                                    <td width="13%">
                                        <img src="/images/sub/tline.gif" width="3" height="34" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <%} %>
                        
                        <td valign="top">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif"
                                style="height: 34px;">
                                <tr>
                                    <td width="4%" style="padding-left: 5px;">
                                            <%if (Model.hasFaultDevice)
                                              { %>
                                        <img src="/images/sub/kjjh.gif" width="16" height="16" />
                                    <%} %>
                                    </td>
                                    <td width="96%">
                                    <%if (Model.hasFaultDevice)
                                    { %>
                                        <a target="_blank" href="/plant/warningfilter/?pid=<%=Model.id %>" style="color: #E87006;
                                            text-decoration: underline;">
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PR_WARNING%></a>
                                   
                                    <%} %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                        <td width="8">
                            <img src="/images/sub/tlr.gif" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%} %>
        <tr>
            <td>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/tyn.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY%><br />
                                <span class="sz_fb">
                                    <%=Model.DisplayTotalDayEnergy%></span>
                                <%=Model.TotalDayEnergyUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico02.gif" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TEMPERATURE%><br />
                                <span class="sz_fb">
                                <%if (Model.getFirstDetector() != null)
                                  {%>
                                <%=Model.getFirstDetector().getMonitorValue(MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE)%>
                                <%}
                                else
                              { %>
                                    <%=ViewData["temp"] != null ? ((ViewData["temp"] as float?).Equals(double.NaN) ? "" : ViewData["temp"].ToString()) : string.Empty%></span>
                               <%}%>
                                °<%=(Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser()).TemperatureType.ToUpper()%>
                               
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico05.gif" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_SOLAR_RADIATION_INTENSITY%>
                                <br />
                                <span class="sz_fb">
                                    <%=(Model.Sunstrength!=null)?Model.Sunstrength.ToString():""%></span> W/m2
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/ttyn.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL_ENERGRY%><br />
                                <span class="sz_fb">
                                    <% =ViewData["totalEnergy"]%></span>
                                <%=Model.TotalEnergyUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" height="43" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico03.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_CO2_AVOIDED%>
                                <br />
                                <span class="sz_fb">
                                    <%=Model.Reductiong %></span>
                                <%=Model.ReductiongUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" height="43" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico04.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_REVENUE%>
                                <br />
                                <%=Model.currencies %>
                                <span class="sz_fb">
                                    <%= Model.DisplayRevenue%></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>


