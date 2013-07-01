<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background: url(<%=UserUtil.curTemplete.cssFolder %>/images/kj/rbg01.gif) no-repeat right center;">
        
        <%if (Model.hasFaultDevice)
          { %>
        <tr>
            <td height="50">
                <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7">
                            <img src="/images/sub/tll.gif" />
                        </td>
                        <td width="100%" valign=top>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" background="/images/sub/tlbg.gif" style="height:34px;">
                                <tr>
                                    <td width="5%">
                                    <img src="/images/sub/kjjh.gif" width="16" height="16" />
                                    </td>
                                    <td width="87%">
                                     <a target="_blank" href="/user/warningfilter/" style="color: #E87006;
                                            text-decoration: underline;">
                                            <%=Resources.SunResource.PLANT_OVERVIEW_PR_WARNING%></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="7">
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_TODAY_ENERGRY %><br />
                                <span class="sz_fb"><%=Model.DisplayTotalDayEnergy%></span>                                
                                <%=Model.TotalDayEnergyUnit %>
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_TOTAL_ENERGRY %><br />
                                <span class="sz_fb"><% = ViewData["totalEnergy"]%></span>                                                                
                                <%=Model.TotalEnergyUnit %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico10.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_TREES%>
                                <br />
                                <span class="sz_fb"><%=Model.TotalTrees%></span> <%=Resources.SunResource.PLANT_OVERVIEW_FAMILIES%>         
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="kjrb">
                    <table width="92%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="21%">
                                <img src="/images/sub/subico04.gif" width="60" height="55" />
                            </td>
                            <td width="79%" class="kjli">
                                <%=Resources.SunResource.PLANT_OVERVIEW_REVENUE%><br />
                                <%=Model.currencies %>
                                <span class="sz_fb"><%=Model.DisplayRevenue%></span>   
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
                                <%=Resources.SunResource.PLANT_OVERVIEW_CO2_AVOIDED %>
                                <br />
                                <span class="sz_fb"><%=StringUtil.formatDouble(Model.TotalReductiong) %></span> 
                                <%=Model.TotalReductiongUnit%>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

