<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=uft-8" />
    <title>�����վȫ��ֲ�</title>

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
          //  window.setTimeout("goIndex()", 20000);
        });

        function goIndex() {
            window.location.href = "/portal/index";
        }
    </script>

</head>
<body bgcolor="#ffffff">
    <!-- ӰƬ��ʹ�õ� URL-->
    <!-- ӰƬ��ʹ�õ��ı�-->
    <!-- saved from url=(0013)about:internet -->
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
        width="1200" height="768" id="earth" align="middle">
        <param name="allowScriptAccess" value="sameDomain" />
        <param name="movie" value="/video/earth.swf" />
        <param name="quality" value="high" />
        <param name="bgcolor" value="#ffffff" />
        <embed src="/video/earth.swf" quality="high" bgcolor="#ffffff" width="1366" height="768"
            name="earth" align="middle" allowscriptaccess="sameDomain" type="application/x-shockwave-flash"
            pluginspage="http://www.macromedia.com/go/getflashplayer" />
    </object>
</body>
</html>
