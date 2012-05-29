<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>电站分布图
        <%=Model.name %></title>
    <link href="/style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script type="text/javascript" charset="utf-8" src="/script/jquery.hoverIntent.minified.js"></script>

    <script type="text/javascript" charset="utf-8" src="/script/jquery.bgiframe.min.js"></script>

    <!--[if IE]>
    <SCRIPT type="text/javascript" charset="utf-8" src="/script/excanvas.js"></SCRIPT>
    <![endif]-->

    <script type="text/javascript" charset="utf-8" src="/script/jquery.bt.min.js"></script>

    <!-- /STUFF -->
    <!-- cool easing stuff for animations -->

    <script type="text/javascript" charset="utf-8" src="/script/jquery.easing.1.3.js"></script>

    <script>
        function changePage(pg) {
            $(".navall").each(function() {
                var pgindex = $(this).attr("rel");
                $(".navpg" + pgindex).html('<a href="javascript:void(0);" onclick="changePage(' + pgindex + ');">' + pgindex + '</a>');
            });
            $(".all").hide();
            $(".pg" + pg).show();
            $(".navpg" + pg).html(pg);
        }
        $().ready(function() {
            changePage(1);
        });

        //弹出提示层
        function tips(id) {
            var newid = id;
            if (id.indexOf("-1") > -1) newid = id.substring(0, id.indexOf("-1"));
            $('#' + newid + '-content').hide();
            $('#' + id).bt({ contentSelector: "$('#" + newid + "-content').html()", /*get text of inner 
                content of hidden div*/
                width: 200, fill: 'white', strokeWidth: 1, /*no stroke*/strokeStyle: '#118529',
                spikeLength: 30, spikeGirth: 30, padding: 0, cornerRadius: 10, positions: ['top'],
                cssStyles: { fontFamily: '"lucida grande",tahoma,verdana,arial,sans-serif', fontSize: '15px' }
            });

        }
    </script>

</head>
<body>
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=Model.name %></div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
            <div class="gf_dh">
                <div class="gf_dhl">
                    <table width="<%=ProtalUtil.isAutoLogin?"320":"520" %>" border="0" cellspacing="0"
                        cellpadding="0">
                        <tr>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico01.jpg" width="22" height="35" />
                            </td>
                            <td width="50">
                                <a href="/portal/index">首 页</a>
                            </td>
                            <td width="5">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <%if (!ProtalUtil.isAutoLogin)
                              { %>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico02.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a target="_blank" href="/portal/report/?plantId=<%=Model.id %>">报表获取</a>
                            </td>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico06.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a target="_blank" href="/portal/logs/?pid=<%=Model.id %>">日志获取</a>
                            </td>
                            <td width="5">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <%} %>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico03.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a href="<%=ViewData["url"] %>">返回上级</a>
                            </td>
                            <td width="5" align="right">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico05.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a href="/auth/loginout">退出</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="gf_dhr">
                    光伏电站监控</div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div class="plr">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
                    <tr>
                        <td width="290" valign="top">
                            <table width="281" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <img src="/images/gf/001.gif" width="281" height="24" />
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/images/gf/003.gif">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <% 
                                                foreach (Hashtable hs in ViewData["icos"] as IList<Hashtable>)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <table width="93%" height="100" border="0" align="center" cellpadding="0" cellspacing="0"
                                                        class="geline">
                                                        <tr>
                                                            <td width="28%" align="center">
                                                                <img src="/images/gf/ico<%=hs["id"] %>.gif" width="60" height="55" /><br />
                                                                <%=hs["displayName"]%>
                                                            </td>
                                                            <td width="72%" class="tjxxtext">
                                                                <%=hs["data"] %>
                                                                <%=hs["unit"] %>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="/images/gf/002.gif" width="281" height="21" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <div>
                                <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="4%" align="center">
                                            <img src="/images/gf/gf_ico03.gif" width="15" height="15" />
                                        </td>
                                        <td width="14%" class="xxtab01">
                                            电站分布图
                                        </td>
                                        <td width="42%">
                                            &nbsp;
                                        </td>
                                        <td width="40%" align="right" class="xxtab03">
                                            点击图片可查看电站详细信息
                                        </td>
                                    </tr>
                                </table>
                                <%--<div>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr class="pg1 all">
                                            <%
                                                int i = 0;
                                                int pg = 1;
                                                int pgIndex = 1;
                                                foreach (Plant item in ViewData["childPlants"] as IList<Plant>)
                                                {
                                                    string pic = item.isVirtualPlant ? "/protalimg/" + (string.IsNullOrEmpty(item.pic) ? "npr.jpg" : item.pic) : "/ufile/" + (string.IsNullOrEmpty(item.firstPic) ? "nopic/nopico02.jpg" : item.firstPic);
                                                    string urlaffix = item.isVirtualPlant ? "virtual" : "plant";
                                                    i++;
                                                    if (i > 2)
                                                    {
                                                        if (pgIndex++ % 2 == 0)
                                                            pg++;
                                                        Response.Write(string.Format("</tr><tr class='pg{0} all'>", pg));
                                                        i = 1;
                                                    }%>
                                            <td width="50%">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td align="center">
                                                            <div class="cimg">
                                                                <a href="/portal/<%=urlaffix %>/<%=item.id%>" class="cimgl">
                                                                    <div style="background: url(<%=pic%>) no-repeat center; cursor: pointer; width: 268px;
                                                                        height: 28px; margin: auto; padding-top: 142px;">
                                                                        <div class="cimgk">
                                                                            <%=item.name %></div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <div class="tpsm">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td width="50%" align="left" class="ltp">
                                                                            当前功率:
                                                                        </td>
                                                                        <td width="50%" align="right" class="ltp">
                                                                            <%=item.DisplayTodayTotalPower %>
                                                                            <%=item.TodayTotalPowerUnit %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" class="ltp">
                                                                            今日发电:
                                                                        </td>
                                                                        <td align="right" class="ltp">
                                                                            <%=item.DisplayTotalDayEnergy %>
                                                                            <%=item.TotalDayEnergyUnit %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" class="ltp">
                                                                            累计发电:
                                                                        </td>
                                                                        <td align="right" class="ltp">
                                                                            <%=item.DisplayTotalEnergy %>
                                                                            <%=item.TotalEnergyUnit %>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <%}
                                                if (i++ % 3 > 0)
                                                {
                                                    Response.Write("<td width=\"50%\"></td>");
                                                } %>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="fystyle">
                                                    <ul>
                                                        <%for (int p = 1; p <= pg; p++)
                                                          { %>
                                                        <li class="navall navpg<%=p %>" rel="<%=p %>"><a href="javascript:void(0);" onclick="changePage(<%=p %>);">
                                                            <%=p %></a></li>
                                                        <%} %>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>--%>
                                <div id="planetmap" style="position: relative">
                                            <% string path=Server.MapPath("~");
                               if (System.IO.File.Exists(string.Format("{0}/ufile/{1}", path, Model.structPic)) == false)
                               { Response.Write("<font color='red'>未上传分布图</font>"); }
                               else
                               { %>
                                <center><img src="/ufile/<%=Model.structPic %>" alt="" ondblclick="vControl('GETMOUSEPOSINPIC',this,event)" /></center>
                                <%} %>
                                
                                    
                                    
                                    <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
                                      {
                                          Plant plant = PlantService.GetInstance().GetPlantInfoById(int.Parse(point.id));
                                    %>
                                    <div style="top: <%=point.y %>px; left: <%=point.x %>px; position: absolute;">
                                       <a href="<%=point.targetUrl %>" target="_blank"><span> <img src="/images/map/touming.gif" border="0" style="cursor: pointer;" alt="<%=point.displayName %>"
                                            id="plant_tip_<%=point.id %>" onmouseover="tips('plant_tip_<%=point.id %>');" /></span></a>
                                    </div>
                                    <div id="plant_tip_<%=point.id %>-content" style="display: none; background-color: Red;">
                                        <!--  
                                            <div style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#D7F4CB,endColorStr=#ffffff); height:0px; width:200px;">
                                            -->
                                        <div style="line-height: 20px; padding-left: 10px;">
                                            <font size="3"><strong>
                                                <%=point.displayName %></strong></font></div>
                                        <div style="line-height: 20px; padding-left: 10px;">
                                            当前功率：<%=plant.DisplayTodayTotalPower%>
                                            <%=plant.TodayTotalPowerUnit%></div>
                                        <div style="line-height: 20px; padding-left: 10px;">
                                            今日发电：<%=plant.DisplayTotalDayEnergy %>
                                            <%=plant.TotalDayEnergyUnit%></div>
                                        <div style="line-height: 20px; padding-left: 10px;">
                                            累计发电：<%=plant.DisplayTotalEnergy %>
                                            <%=plant.TotalEnergyUnit%></div>
                                        <!--
                                            </div>
                                            <div style="background:-moz-linear-gradient(top,#D7F4CB,#ffffff); height:60px; width:200px;">
                                            
                                            </div>
                                            -->
                                    </div>
                                    <%} %>
                                </div>
                            </div>
                            <%if (!ProtalUtil.isAutoLogin)
                              { %>
                            <div>
                                <div style="height: 20px;">
                                </div>
                                <div class="xxtab0">
                                    <span class="xxtab"><span class="sbu">
                                        <input name="Submit3" type="submit" class="yellowbu" value="详细数据" onclick="window.open('/portal/fgpjData?id=<%=Model.id %>')" />
                                    </span></span>
                                </div>
                                <div class="fgp">
                                    <table width="100%" border="1" cellpadding="1" cellspacing="0" bordercolor="#C0C7CE"
                                        bgcolor="#FFFFFF" style="border-collapse: collapse; line-height: 24px; color: #424242;
                                        text-align: center;">
                                        <tr>
                                            <td width="20%" rowspan="2" bgcolor="#F5F6F7">
                                                &nbsp;
                                            </td>
                                            <td colspan="5" bgcolor="#F5F6F7">
                                                <strong>发电量（MWh） </strong>
                                            </td>
                                            <td colspan="5" bgcolor="#F5F6F7">
                                                <strong>收入（万元）</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                峰
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                谷
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                平
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                尖
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                总
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                峰
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                谷
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                平
                                            </td>
                                            <td bgcolor="#F5F6F7">
                                                尖
                                            </td>
                                            <td width="8%" bgcolor="#F5F6F7">
                                                总
                                            </td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 日</strong>
                                            </td>
                                            <%foreach (double value in ViewData["daydatas"] as double?[])
                                              { %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 月</strong>
                                            </td>
                                            <%foreach (double value in ViewData["monthdatas"] as double?[])
                                              { %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 年</strong>
                                            </td>
                                            <%foreach (double value in ViewData["yeardatas"] as double?[])
                                              { %>
                                            <td>
                                                &nbsp;<%=value.ToString("0.0")%>
                                            </td>
                                            <%} %>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <%} %>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="height: 20px;">
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    <map name="structmap" id="structmap">
        <%foreach (StructPoint point in ViewData["points"] as List<StructPoint>)
          {%>
        <area shape="circle" coords="<%=point.x %>,<%=point.y %>,15" href="<%=point.targetUrl %>"
            target="_blank" alt="<%=point.displayName %>" onmouseover="tips('plant_tip_<%=point.id %>');" />
        <%} %>
    </map>
</body>
</html>
