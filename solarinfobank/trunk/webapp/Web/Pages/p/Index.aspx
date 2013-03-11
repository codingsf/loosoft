<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=uft-8" />
    <title>光伏电站全球分布</title>
    <script type="text/javascript">
        function reloadcode(img) {
            alert("dfs")
            img.src = img.src + "?" + new Date().getMilliseconds();
        }
    </script>
</head>
<body bgcolor="#ffffff">
<%if (ViewData["errorMessage"] != null)
  { %>
<div style="text-align:center;">
<br/>
非法门户
<br />
</div>
<%}
  else
  { %>
<div style=" background-color:black;">
    <!-- 影片中使用的 URL-->
    <!-- 影片中使用的文本-->
    <!-- saved from url=(0013)about:internet -->
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
        width="1340" height="768" id="earth" align="middle">
        <param name="allowScriptAccess" value="sameDomain" />
        <param name="movie" value="/video/earth2.swf" />
        <param name="quality" value="high" />
        <param name="bgcolor" value="#ffffff" />
        <embed src="/video/earth2.swf" quality="high" bgcolor="#ffffff" width="1366" height="768"
            name="earth" align="middle" allowscriptaccess="sameDomain" type="application/x-shockwave-flash"
            pluginspage="http://www.macromedia.com/go/getflashplayer" />
    </object>
</div>
<div style="text-align:center;">
<br/>
<form action="/portal/login" method="post">
登录进入：
用户名<input name="username" class="insy01" value="<%=Request.Params["username"]%>" readonly="readonly"/>
&nbsp;&nbsp;密码<input name="password" class="insy01" value="" type="password"/>  
<input name="validatecode" type="text" style="border:1px solid #3A4E2B; width:95px; height:17px; vertical-align:middle;" />
<img src="/content/ashx/validatecode.ashx" width="60" height="19"  style="vertical-align:middle; cursor:pointer; " title="<%= Resources.SunResource.HOME_INDEX_RELOAD_VALIDATECODE%>" onclick="reloadcode(this)" />
<input type="submit" class="loginbu" value="登录" id="btnLogin", tabindex ="3" />
</form>
<br/>
</div>
<%} %>
</body>
</html>