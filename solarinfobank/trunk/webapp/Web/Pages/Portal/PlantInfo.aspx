<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>电站信息 <%=this.Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/slide.js" type="text/javascript"></script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
    <link href="../../style/lrtk.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=this.Model.name %></div>
                <div class="gf_toptittlel">
                    <a href="/portal/index">
                        <img src="/protalimg/<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div>
            </div>
            <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%" height="26">
                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="17%" align="center">
                                        <img src="/images/gf/subico010.gif" width="18" height="19" />
                                    </td>
                                    <td width="83%">
                                        <strong>电站信息</strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="683" style="padding-bottom: 10px;">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                                    </td>
                                    <td background="/images/gf/tci/tc02.gif">
                                    </td>
                                    <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/tci/tc04.gif">
                                        &nbsp;
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="230" height="28" align="right" class="gfpr">
                                                    <strong>名称 : </strong>
                                                </td>
                                                <td width="435" class="gfgreen">
                                                    <%=Html.DisplayFor(m=>m.name) %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>安装日期 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Model.installdate.ToString("yyyy-MM-dd") %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>设计功率 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m=>m.design_power) %>
                                                    kWp
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td background="/images/gf/tci/tc05.gif">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                                </tr>
                            </table>
                        </td>
                        <td width="320" rowspan="2" align="right" valign="top">
                            <img src="<%=string.IsNullOrEmpty(Model.firstPic)?"/images/gf/nopico02.gif":"/ufile/"+Model.firstPic %>"
                                width="310" height="315" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 10px;">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                                    </td>
                                    <td background="/images/gf/tci/tc02.gif">
                                    </td>
                                    <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/tci/tc04.gif">
                                        &nbsp;
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="230" height="28" align="right" class="gfpr">
                                                    <strong>位置 :</strong>
                                                </td>
                                                <td width="435" class="gfgreen">
                                                    <%=Html.DisplayFor(m=>m.location) %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>经度 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m=>m.long1) %>°
                                                    <%=Html.DisplayFor(m=>m.long2) %>'
                                                    <%=Html.DisplayFor(m=>m.long3) %>"
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>纬度 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m=>m.lat1) %>°
                                                    <%=Html.DisplayFor(m=>m.lat2) %>'
                                                    <%=Html.DisplayFor(m=>m.lat3) %>"
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>制造商 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.manufacturer)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>模块型号 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.module_type)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>角度 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.angle)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>时区 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Cn.Loosoft.Zhisou.SunPower.Common.TimeZone.GetText(Model.timezone) %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td background="/images/gf/tci/tc05.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-bottom: 10px;">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                                    </td>
                                    <td background="/images/gf/tci/tc02.gif">
                                    </td>
                                    <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/tci/tc04.gif">
                                        &nbsp;
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="230" height="28" align="right" class="gfpr">
                                                    <strong>操作员 :</strong>
                                                </td>
                                                <td width="755" class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.operater)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>国家 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.country)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>城市 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.city)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>街道 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.street)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>邮编 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.postcode)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>电话号码 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.phone)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>邮箱 :</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.email)%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="28" align="right" class="gfpr">
                                                    <strong>收入/货币:</strong>
                                                </td>
                                                <td class="gfgreen">
                                                    <%=Html.DisplayFor(m => m.revenueRate)%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td background="/images/gf/tci/tc05.gif">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-bottom: 10px;">
                            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="9" height="9" background="/images/gf/tci/tc01.gif">
                                    </td>
                                    <td background="/images/gf/tci/tc02.gif">
                                    </td>
                                    <td width="9" height="9" background="/images/gf/tci/tc03.gif">
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/tci/tc04.gif">
                                        &nbsp;
                                    </td>
                                    <td bgcolor="#FFFFFF">
                                        <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="230" align="right" class="gfpr" style="padding-top: 10px; padding-bottom: 10px;">
                                                    <strong>描述:</strong>
                                                </td>
                                                <td width="755" style="padding-top: 10px; padding-bottom: 10px;">
                                                    <%=Model.description==null?"":Model.description.Replace("script", string.Empty)%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td background="/images/gf/tci/tc05.gif">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="9" height="9"><img src="/images/gf/tci/tc06.gif" width="9" height="9" /></td><td background="/images/gf/tci/tc07.gif"></td><td><img src="/images/gf/tci/tc08.gif" width="9" height="9" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-bottom: 10px;">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <%Html.RenderPartial("footer"); %>
    

</body>
</html>
