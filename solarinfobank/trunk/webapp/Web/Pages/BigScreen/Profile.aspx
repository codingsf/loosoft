<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<div class="mainbox">
    <div class="header">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="34%">
                    <img class="logo" src="" />
                </td>
                <td width="66%" align="left">
                    <label id="name">
                    </label>
                </td>
            </tr>
        </table>
    </div>
    <div class="midbox">
        <div class="leftbox">
        <span> <%=Resources.SunResource.HOME_INDEX_BANK_OVERVIEW%></span>
            <img id="imageurl" src="" width="369" height="232" />
            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="ECAF0E"
                class="about">
                <tr>
                    <td width="36%" class="pr10">
                        <%=Resources.SunResource.BIG_SCREEN_INSTALL_DATE%>：
                    </td>
                    <td width="64%" class="pl10">
                        <label id="installdate">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="pr10">
                        <%=Resources.SunResource.PLANT_PROFILE_DESIGNPOWER%>：
                    </td>
                    <td class="pl10">
                        <label id="designpower">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="pr10">
                        <%=Resources.SunResource.BIG_SCREEN_LOCATION%>：
                    </td>
                    <td class="pl10">
                        <label id="location">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="pr10">
                        <%=Resources.SunResource.BIG_SCREEN_OWNER_UNIT%>：
                    </td>
                    <td class="pl10">
                        <label id="organize">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="pr10">
                        <%=Resources.SunResource.BIG_SCREEN_INVERTER_COUNT%>：
                    </td>
                    <td class="pl10">
                        <label id="invertercount">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="pr10">
                        <%=Resources.SunResource.BIG_SCREEN_INVERTER_TYPE%>：
                    </td>
                    <td class="pl10">
                        <label id="invertertypestr">
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="rightbox">
            <ul class="bt">
                <li><%=Resources.SunResource.USER_OVERVIEW_PLANT_TODAYENERGY%></li>
                <li><%=Resources.SunResource.HOME_INDEX_TOTAL_ENERGY%></li>
                <li><%=Resources.SunResource.PLANT_DEVICEMONITOR_CURRENT_POWER%></li>
            </ul>
            <ul class="tj">
                <li><font class="f34"><label id="dayenergy"></label></font><font class="f18"><label id="dayenergyunit"></label></font></li>
                <li><font class="f34"><label id="totalenergy"></label></font><font class="f18"><label id="totalenergyunit"></label></font></li>
                <li><font class="f34"><label id="curpower"></label></font><font class="f18"><label id="curpowerunit"></label></font></li>
            </ul>
            <div class="em">
            </div>
            <ul class="bt">
                <li><%=Resources.SunResource.DATAITEM_4111%></li>
                <li><%=Resources.SunResource.DEVICEMONITORITEM_15%></li>
                <li><%=Resources.SunResource.DEVICEMONITORITEM_505%></li>
            </ul>
            <ul class="tj">
                <li><font class="f34"><label id="cq2reduce"></label></font><font class="f18"><label id="cq2reduceunit"></label></font></li>
                <li><font class="f34"><label id="solarintensity"></label></font><font class="f18"><label id="solarintensityunit"></label></font></li>
                <li><font class="f34"><label id="temprature"></label></font><font class="f18">°<label id="tempratureunit"></label></font></li>
            </ul>
        </div>
    </div>
</div>
