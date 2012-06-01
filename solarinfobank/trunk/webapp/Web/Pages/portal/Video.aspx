<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>视频监控 <%=this.Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/slide.js" type="text/javascript"></script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
    <link href="../../style/lrtk.css" rel="stylesheet" type="text/css" />
<style>
#video_pic_container *{ border:none;}
</style>
    <script>
        function changeClick(obj) {
            $('#video').removeClass("onclick");
            $('#video_pic').removeClass("onclick");
            $('#' + obj).addClass("onclick");
        }
        $().ready(function() {
            $('#video').click(function() {
                changeClick($(this).attr("id"));
                $("#video_pic_container").hide();
                $("#video_container").show();
            })
            $("#video_pic").click(function() {
                changeClick($(this).attr("id"));
            })
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#monitor').change(function() {
                var url = this.value;
                if (url.indexOf("61.190.35.174") != -1) {
                    url += "?cnname=1&cnpwd=1";
                    var now = new Date();
                    now.setTime(now.getTime() + 1000 * 60 * 30);
                    var nameValue = escape("1" + "#N1" + "1" + "#N2" + "61.190.35.174" + "#N3" + "sz160sa120sb116sc0");
                    document.cookie = "ID=" + nameValue + ";expires=" + now.toGMTString();
                }

                $('#monitorwindow').attr('src', url);
            });
            $('#monitorwindow').attr('src', $("#monitor").val() == null ? "" : $("#monitor").val());
        })
    </script>

</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=this.Model.name %></div>
                <div class="gf_toptittlel">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div>
                <div>
                    <div class="subico01">
                        <ul id="change">
                            <li><a id="video_pic" href="/portal/video?id=<%=Request["id"] %>" class="onclick">视频监控图片</a></li>
                            <li><a id="video" href="javascript:void(0);">视频监控</a></li>
                            <li></li>
                        </ul>
                    </div>
                </div>
                <div style="padding-top: 20px;" id="video_pic_container">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="41%" valign="top">

                                <script type="text/javascript">
		<!--

                                    d = new dTree('d');
                                    <%=ViewData["str"] %>
                                    document.write(d);

		//-->
                                </script>

                            </td>
                            <td width="59%" align="right">
                                <% var array = ViewData["images"] as IList<FileInfo>;%>
                                <script>
                                    var totalIndex = '<%=array.Count %>';
                                        var target = [ <%for(int x=1;x<array.Count;x++)
                                        { Response.Write(string.Format("\"xixi-0{0}\",",x));} %><%=string.Format("\"xixi-0{0}\"",(array.Count)) %>];
                                </script>
                                <div style="height: 560px; padding-top: 20px; border: none;" class="wrap picshow">
                                    <!--大图轮换区-->
                                    <%if (array.Count > 0)
                                      { %>
                                    <div id="picarea">
                                        <div style="margin: 0px auto; width: 774px; height: 436px; overflow: hidden">
                                            <div style="margin: 0px auto; width: 774px; height: 436px; overflow: hidden" id="bigpicarea">
                                                <p class="bigbtnPrev">
                                                    <span id="big_play_prev"></span>
                                                </p>
                                                <% int i = 0;
                                                   foreach (FileInfo image in array)
                                                   {  %>
                                                <div id="image_xixi-0<%=++i %>" class="image">
                                                        <img alt="" src="/content/ashx/drawing.ashx?path=<%=image.FullName %>" width="772"
                                                            height="434">
                                                    <div class="word">
                                                        <h3>
                                                        </h3>
                                                    </div>
                                                </div>
                                                <%} %>
                                                <p class="bigbtnNext">
                                                    <span id="big_play_next"></span>
                                                </p>
                                            </div>
                                        </div>
                                        <div id="smallpicarea">
                                            <div id="thumbs">
                                                <ul>
                                                    <li class="first btnPrev">
                                                        <img id="play_prev" src="/images/left.png"></li>
                                                    <% i = 0;
                                                       foreach (FileInfo image in array)
                                                       {  %>
                                                    <li id="thumb_li-0<%=i %>" class="<%=i++.Equals(array.Count)?"last_img":"" %> slideshowItem">
                                                        <a id="thumb_xixi-0<%=i %>" href="#">
                                                            <img src="/content/ashx/drawing.ashx?path=<%=image.FullName %>" width="90" height="60"></a>
                                                    </li>
                                                    <%} %>
                                                    <li class="last btnNext">
                                                        <img id="play_next" src="/images/right.png"></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                              

                                    <%} %>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="padding-top: 20px; display: none;" id="video_container">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="40%">
                                <select id="monitor" name="monitor" class="subselect02" style="width: 280px; height: 20px;
                                    line-height: 20px;">
                                    <%foreach (var item in ViewData["data"] as IList<Cn.Loosoft.Zhisou.SunPower.Domain.VideoMonitor>)
                                      { %>
                                    <option value="<%=item.url %>" key="<%=item.id %>" <%=(Request.QueryString["id"]==item.id.ToString())?"selected='selected'":"" %>>
                                        <%=item.name %></option>
                                    <%} %>
                                </select>
                            </td>
                            <td width="60%" style="color: #459001;">
                            </td>
                        </tr>
                    </table>
                    <iframe id="monitorwindow" src="" width="98%" style="margin: 0 auto; border: none;
                        margin-top: 10px;" height="800"></iframe>
                </div>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
