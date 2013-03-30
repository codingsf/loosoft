<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<!--临时代码for foxconn-->
<script runat="server">
    string tmpCreateVideoFolderTree(IList<DirectoryInfo> topDirectoryInfo, int uplevel, int pid)
    {
        string video_uri = ConfigurationManager.AppSettings["history_video_server_uri"];
        string jsstr = "";
        if (uplevel == -1)
        {
            jsstr += string.Format(" d.add({0}, {1}, '{2}', 'javascript:void(0);', '', '', '/images/tree/folder.gif');", 0, uplevel, "历史视频监控");
            uplevel++;
        }
        //有下级那么就递归调用下级生成脚本。进行累计
        if (topDirectoryInfo != null && topDirectoryInfo.Count > 0)
        {
            DirectoryInfo tmpDir = null;
            int curLevel = 0;
            for (int i = 0; i < topDirectoryInfo.Count; i++)
            {
                tmpDir = topDirectoryInfo[i];
                if (tmpDir.GetDirectories().Length == 0 && tmpDir.GetFiles().Length == 0)//没有下级目录并且当前目录没有文件不显示
                    continue;
                curLevel = ((uplevel + 1) * 10 + i);
                jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '', '', '/images/tree/folder.gif');", curLevel, uplevel, tmpDir.Name, "javascript:void(0);");
                int subCurLevel = 1;
                foreach (FileInfo file in tmpDir.GetFiles())
                {
                    string fullName = file.FullName.Replace('\\', '/');
                    if (!file.Extension.ToLower().Equals(".mp4") && !file.Extension.ToLower().Equals(".flv") && !file.Extension.ToLower().Equals(".wmv")) continue;
                    if (file.Extension.Equals(".mp4"))
                    {
                        //VideoConvertFlv(fullName, "1280*720", fullName.Substring(0, fullName.LastIndexOf("."))+".flv");
                    }
                    fullName = string.Format("{0}{1}", video_uri, fullName.Substring(fullName.IndexOf('/')));
                    jsstr += string.Format(" d.add({0}, {1}, '{2}', '{3}', '{4}', '');", subCurLevel++, curLevel, file.Name, "javascript:void(0);", "\"rel=\"" + fullName);
                }
                if (tmpDir.GetDirectories() != null && tmpDir.GetDirectories().Length > 0)
                    jsstr += tmpCreateVideoFolderTree(tmpDir.GetDirectories(), curLevel, pid);
            }
        }
        return jsstr;
    }

    public static string VideoConvertFlv(string FromName, string WidthAndHeight, string ExportName)
    {
        string ffmpeg = HttpContext.Current.Server.MapPath("~/FLV/ffmpeg.exe");
        string Command = "d:\\ffmpeg\\\\bin\\ffmpeg.exe -i "+FromName+" -y -ab 56 -ar 22050 -b 500 -r 15 -s 320*240 " +ExportName;
        System.Diagnostics.Process p = new System.Diagnostics.Process();
        p.StartInfo.FileName = ffmpeg;
        p.StartInfo.Arguments = Command;
        p.StartInfo.WorkingDirectory = "d:\\ffmpeg";
        p.StartInfo.UseShellExecute = false;
        p.StartInfo.RedirectStandardInput = true;
        p.StartInfo.RedirectStandardOutput = true;
        p.StartInfo.RedirectStandardError = true;
        p.StartInfo.CreateNoWindow = false;
        //开始执行
        p.Start();
        p.BeginErrorReadLine();
        p.WaitForExit();
        p.Close();
        p.Dispose();
        //p.StandardInput.WriteLine(Command);
        //p.StandardInput.WriteLine("Exit ");
        return ExportName;
    }

</script>
<%
    User user = UserUtil.getCurUser();
    Protal protal = ProtalService.GetInstance().GetByUser(user.ParentUserId);
    Plant plant = Model;
    IList<VideoMonitor> monitors = VideoMonitorService.GetInstance().GetList(new VideoMonitor() { plantId = plant.id });
    ViewData["data"] = monitors;

    IList<DirectoryInfo> dirInfos = new List<DirectoryInfo>();
    foreach (VideoMonitor monitor in monitors)
    {
        if (string.IsNullOrEmpty(monitor.videofolder))
            continue;
        if (Directory.Exists(monitor.videofolder))
        {
            dirInfos.Add(new DirectoryInfo(monitor.videofolder));
        }
    }
    string str = string.Empty;
    str = tmpCreateVideoFolderTree(dirInfos, -1, plant.id);
    ViewData["str"] = str;
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>视频监控
        <%=this.Model.name %></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
    <link href="../../style/lrtk.css" rel="stylesheet" type="text/css" />

    <script src="../../script/pop_layer.js" type="text/javascript"></script>

    <script src="../../script/jwplayer.js" type="text/javascript"></script>

    <script src="../../script/player.js" type="text/javascript"></script>

    <script src="../../script/jquery.media.js" type="text/javascript"></script>

    <style>
        #video_pic_container *
        {
            border: none;
        }
    </style>

    <script >
        var tc = "solarinfobank/solarinfobank1.18/";
        var fileurl = '';
        function changeClick(obj) {
            $('#video').removeClass("onclick");
            $('#video_pic').removeClass("onclick");
            $('#video_history').removeClass("onclick");
            $('#' + obj).addClass("onclick");
        }
        $().ready(function() {
            $("a[rel !='']").click(function() {
                fileurl = $(this).attr("rel");
                fileurl = fileurl.replace(tc, "");
                initjwplayer();
            })

            $('#video').click(function() {
                changeClick($(this).attr("id"));
                $("#video_pic_container").hide();
                $("#video_container").show();
            })
            $("#video_pic").click(function() {
                changeClick($(this).attr("id"));
            })
            $("#video_history").click(function() {
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

    <script type="text/javascript">
        var player;
        var type;
        //var time = ${readTime} *60*1000;
        var height = 378;
        var width = 480;
        var quartz = null;
        function initjwplayer() {
            jwplayer('mediaspace').setup({
                'id': 'playerID',
                'width': width,
                'height': height,
                'file': fileurl,    // FLV视频地址
                'type': 'http',        // 数据类型，一定要配置正确，否则不能正常拖动，我就是这个参数没设置，郁闷了半天，无法拖动
                'image': '/flash/video_big.jpg', // 开始播放之前的预览图
                'autostart': 'true',    // 是否自动播放
                'streamer': "start",    // 参数为 “start”,这个参数用于传递给服务器从特定的关键帧开始播放，nginx编译了 flv 模块 所以是支持的。
                'flashplayer': "/flash/player.swf",
                'controlbar': 'bottom',
                //'controlbar.idlehide': true,
                'skin': '/flash/stormtrooper.zip',
                //'skin': 'http://s0-www.ltvimg.com/v3_6_4/assets/skins/glow/glow.zip',
                'icons': false,
                'events': {
                    onReady: function() { player = this; type = 'fl'; },
                    onPlay: function() {
                        if (init) {
                            init = false;
                        }
                    }
                }
            });
        }
        var init = true;
       
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
                            <li><a id="video_pic" href="/portal/video?id=<%=Request["id"] %>">视频监控图片</a></li>
                            <li><a id="video" href="javascript:void(0);">视频监控</a></li>
                            <li><a class="onclick" id="video_history" href="/portal/videohistory?id=<%=Request["id"] %>">
                                历史监控</a></li>
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
                                    d.closeAll();
		//-->
                                </script>

                            </td>
                            <td width="59%" align="right">
                                <div id='mediaspace'>
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
