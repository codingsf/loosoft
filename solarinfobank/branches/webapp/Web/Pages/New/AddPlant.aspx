<%@ Page Language="C#"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注册</title>
    <link href="../../style/lc.css" rel="stylesheet" type="text/css" />
    <link href="../../style/css.css" rel="stylesheet" type="text/css" />
    <link href="../../style/sub.css" rel="stylesheet" type="text/css" />
    <link href="../../style/kj.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
<script>
    $().ready(function() {

        $("#addplant").click(function() {
            $('#plant_container').append('<iframe scrolling="no" frameborder="0" width="100%"  height="1100" src="/new/addplantcontrol"></iframe>');
        });
    });
</script>
</head>
<body>

<div class="lcbox">

<div class="lctab">
<ul>
<li>1、用户信息 </li>
<li class="lc_yellowbg">2、电站信息</li>
<li> 3、设备信息</li>
</ul>
</div>

<div class="lcabout">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="9" height="9" background="/images/tc/tc01.gif"></td>
      <td background="/images/tc/tc02.gif"></td>
      <td width="9" height="9" background="/images/tc/tc03.gif"></td>
    </tr>
    <tr>
      <td background="/images/tc/tc04.gif">&nbsp;</td>
      <td bgcolor="#FFFFFF">
        
        <div id="plant_container">
        <iframe scrolling="no" frameborder="0" width="100%"  height="1100" src="/new/addplantcontrol"></iframe>
        </div>
		<div class="lcadd01"><a href="javascript:void(0)" id="addplant">添加电站</a></div>
        <div class="ok_box0"> 
	    <input type="submit" name="Submit2" class="ok_greenbtu mr20" value="上一步" />
	    <input type="submit" name="Submit" class="ok_greenbtu" value="下一步" />
	  </div>	  </td>
      <td background="/images/tc/tc05.gif">&nbsp;</td>
    </tr>
    
    <tr>
      <td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td>
      <td background="/images/tc/tc07.gif"></td>
      <td><img src="/images/tc/tc08.gif" width="9" height="9" /></td>
    </tr>
  </table>
</div>
</div>

</body>
</html>
