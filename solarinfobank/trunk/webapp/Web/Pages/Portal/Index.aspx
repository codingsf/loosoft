<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Protal>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>首页<%=Model.name %></title>
    <link href="/style/mhcss.css" rel="stylesheet" type="text/css"/>
    <script src="/script/jquery.js" type="text/javascript"></script>

    <SCRIPT type="text/javascript" charset="utf-8" src="/script/jquery.hoverIntent.minified.js"></SCRIPT>

    <SCRIPT type="text/javascript" charset="utf-8" src="/script/jquery.bgiframe.min.js"></SCRIPT>
    <!--[if IE]>
    <SCRIPT type="text/javascript" charset="utf-8" src="/script/excanvas.js"></SCRIPT>
    <![endif]-->
    <SCRIPT type="text/javascript" charset="utf-8" src="/script/jquery.bt.min.js"></SCRIPT>
    <!-- /STUFF --><!-- cool easing stuff for animations -->
    <SCRIPT type="text/javascript" charset="utf-8" src="/script/jquery.easing.1.3.js"></SCRIPT>
    <!-- /easing --><!-- just for demo -->    
    <script type="text/javascript">
        $(document).ready(function() {
            $('#maptab').click(clickMap);
            $('#treetab').click(clickTree);
        });

        function clickMap() {
            changeStyle("maptab");
        }
        function clickTree() {
            changeStyle("treetab");
            $("#mainFrame").attr("src", "/plant/portalStructChart");
            // loadContent('container_treetab', '/plant/portalStructChart', 'iframe', 'GET');
        }
        function changeStyle(curId) {
            $("#maptab").attr("class", "noclick");
            $("#treetab").attr("class", "noclick");
            $("#" + curId).attr("class", "onclick");

            $("#container_maptab").hide();
            $("#container_treetab").hide();
            $("#container_" + curId).show();
        }

        //加载右边内容
        function loadContent(curContainer, url, type, method) {
            if (url.indexOf("?") > -1)
                url = url + "&rnd=" + Math.random();
            else {
                url = url + "?rnd=" + Math.random();
            }
            if (type == "ajax") {
                $.ajax({
                    type: method,
                    url: url,
                    data: {},
                    success: function(result) {
                        $('#' + curContainer).html(result);
                        readyinit();
                    },
                    beforeSend: function() {
                        $('#' + curContainer).empty();
                    }
                });
            } else {
                var ifurl = "<iframe src='" + url + "' id='mainFrame' name='mainFrame'onLoad='iFrameHeight()'  frameborder='0' width='900' height='435' scrolling=no style='text-align:center;overflow: hidden;'> </iframe>";
                $('#' + curContainer).html(ifurl);
            }
        }
        //ifame自适应高度,被包含的页面，内部有影响页面长度的要在页面中完成操作好再次调用这个方法。如:parent.iFrameHeight();
        function iFrameHeight() {
            //set current page title 
            var ifm = document.getElementById("mainFrame");
            var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }
        
        //弹出提示层
        function tips(id) {
            var newid = id;
            if (id.indexOf("-1") > -1) newid = id.substring(0, id.indexOf("-1"));
            $('#'+newid+'-content').hide();
            $('#'+id).bt({ contentSelector: "$('#"+newid+"-content').html()", /*get text of inner 
                content of hidden div*/width: 200, fill: 'white', strokeWidth: 1, /*no stroke*/strokeStyle: '#118529',
                spikeLength: 30, spikeGirth: 30, padding: 0, cornerRadius: 10, positions: ['top'],
                cssStyles: { fontFamily: '"lucida grande",tahoma,verdana,arial,sans-serif',fontSize: '15px'}
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
                <div class="gf_toptittlel">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
            <div class="gf_dh">
                <div class="gf_dhl">
                    <table width="<%=ProtalUtil.isAutoLogin?"220":"420" %>" border="0" cellspacing="0" cellpadding="0">
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
                                <a target="_blank" href="/portal/report?plantId=&userid=<%=ViewData["uid"] %>">报表获取</a>
                            </td>
                            <td width="40" align="right">
                                <img src="/images/gf/gf_ico06.jpg" width="22" height="35" />
                            </td>
                            <td width="70">
                                <a target="_blank" href="/portal/logs">日志获取</a>
                            </td>
                            <td width="5" align="right">
                                <img src="/images/gf/gf_dh02.jpg" width="5" height="35" />
                            </td>
                            <%} %>
                            
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
            <div style="clear: both;">
            </div>
            <div class="plr">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
                    <tr>
                        <td width="290" valign="top">
                            <table width="280" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td ><img src="/images/gf/001.gif" width="281" height="24" /></td>
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
                                <div>
                                    <table width="100%" height="34" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="56%" align="left">
                                                <div class="plrtab">
                                                    <ul id="mhchange">
                                                        <li><a href="javascript:void(0);" class="onclick" id="maptab">分布图</a></li>
                                                        <li><a href="javascript:void(0);" id="treetab">结构图</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                            <td width="31%" align="right" class="xxtab03">
                                                点击地图可查看电站详细信息
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="plantmap">
                                    <div class="plantmapm" id="container_maptab" >             
                                        <div style="background: url(/images/map/n.jpg) no-repeat center;height:462px; margin: auto; position:relative;">
                                            <% 
                                            double lonrate = 580 /((135.0833-73.6666)*1.0d);
                                            double latrate = 400 / ((53.5583 - 18) * 1.0d);
                                            foreach (Plant plant in ViewData["plants"] as IList<Plant>)
                                            {
                                                //将坐标换算成地图坐标
                                                CountryCity cc = CountryCityService.GetInstance().GetCity(plant.city);
                                                if (cc == null || string.IsNullOrEmpty(cc.lon) || string.IsNullOrEmpty(cc.lat)) continue;
                                                int x = int.Parse(((StringUtil.stringtoFloat(cc.lon) - 73.6666) * lonrate).ToString("0")) + 37;
                                                int y = int.Parse(((53.5583 - StringUtil.stringtoFloat(cc.lat)) * latrate).ToString("0")) + 13;
                                            %>
                                            <div style="top:<%=y%>px; left:<%=x%>px;position:absolute;">
                                            <%if (plant.isVirtualPlant)
                                              { %>
                                            <div style=""><a href="/portal/virtual/<%=plant.id%>" target="_blank"><span><img src="/images/map/db.ico" border=0 style="cursor:pointer;" alt="<%=plant.name%>" onmouseover="tips('plant_tip_<%=plant.id%>');" id="plant_tip_<%=plant.id%>"/></span>
                                            <%--<span style="cursor:pointer;" onmouseover="tips('plant_tip_<%=plant.id%>-1');" id="plant_tip_<%=plant.id%>-1"> <%=plant.name%></span>--%>
                                            </a></div>
                                            <%}
                                              else
                                              {%>
                                            `<div style=""><a href="/portal/plant/<%=plant.id%>" target="_blank"><span><img src="/images/map/db.ico" border=0 style="cursor:pointer;" alt="<%=plant.name%>" onmouseover="tips('plant_tip_<%=plant.id%>');" id="plant_tip_<%=plant.id%>"/></span>
                                            <%-- <span style="cursor:pointer;" onmouseover="tips('plant_tip_<%=plant.id%>-1');" id="plant_tip_<%=plant.id%>-1"> <%=plant.name%></span>--%></a></div>  
                                            <%} %>
                                            </div>
                                            <div id="plant_tip_<%=plant.id%>-content" style="display:none; background-color:Red;">  
                                            <!--  
                                            <div style="FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#D7F4CB,endColorStr=#ffffff); height:0px; width:200px;">
                                            -->
                                            <div style=" line-height:20px; padding-left:10px;"><font size=3 ><strong><%=plant.name %></strong></font></div>
                                            <div style=" line-height:20px; padding-left:10px;">当前功率：<%=plant.DisplayTodayTotalPower%> <%=plant.TodayTotalPowerUnit%></div>
                                            <div style=" line-height:20px; padding-left:10px;">今日发电：<%=plant.DisplayTotalDayEnergy %> <%=plant.TotalDayEnergyUnit%></div>
                                            <div style=" line-height:20px; padding-left:10px;">累计发电：<%=plant.DisplayTotalEnergy %> <%=plant.TotalEnergyUnit%></div>

                                            
                                            <!--
                                            </div>
                                            <div style="background:-moz-linear-gradient(top,#D7F4CB,#ffffff); height:60px; width:200px;">
                                            
                                            </div>
                                            -->
                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="plantmapm" id="container_treetab" style="overflow: hidden;display:none;">
                                        <iframe id="mainFrame"  height="500" width="100%" src=""
                                            frameborder="0"></iframe>
                                    </div>
                                </div>
                            </div>
                            <%if (!ProtalUtil.isAutoLogin)
                              { %>
                            <div>
                                <div style="height: 20px;">
                                </div>
                                <div class="xxtab0">
                                    <span class="xxtab"><span class="sbu">
                                        <input name="Submit" type="submit" class="yellowbu" value="详细数据" onclick="window.open('/portal/fgpjData?id=0')" />
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
                                                <strong>发电量(GWh) </strong>
                                            </td>
                                            <td colspan="5" bgcolor="#F5F6F7">
                                                <strong>收入(亿元)</strong>
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
                                        <%double?[] daydatas = ViewData["daydatas"] as double?[]; %>
                                        <tr>
                                            <td bgcolor="#F5F6F7">
                                                <strong>当 日</strong>
                                            </td>
                                            <%foreach (double value in daydatas)
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
            <div style="height: 30px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
</body>
</html>
