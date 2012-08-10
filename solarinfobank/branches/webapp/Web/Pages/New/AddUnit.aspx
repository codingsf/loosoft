﻿<%@ Page Language="C#"  Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

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
<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $("#change").click(function() {
            if ($("#unessential").is(":hidden")) {
                $("#unessential").slideDown(0);
            } else {
                $("#unessential").slideUp(0);
            }
        });
    });
    </script>
</head>
<body>

<div class="lcbox">

<div class="lctab">
<ul>
<li>1、用户信息 </li>
<li>2、电站信息</li>
<li  class="lc_yellowbg"> 3、设备信息</li>
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
	  <div class="mb30">
	  <span class="lcintt02">ShangHai LinGang BIPV </span>
	  <table width="723" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="9" height="9" background="/images/tc/tc01.gif"></td>
          <td background="/images/tc/tc02.gif"></td>
          <td width="9" height="9" background="/images/tc/tc03.gif"></td>
        </tr>
        <tr>
          <td background="/images/tc/tc04.gif">&nbsp;</td>
          <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="37%" class="tdstyle01">设备序列号 </td>
              <td width="36%" class="tdstyle01">设备名称</td>
              <td width="27%" class="tdstyle01">操作</td>
            </tr>
            <tr>
              <td class="tdstyle02">051147265</td>
              <td class="tdstyle02">kfdfgfdg</td>
              <td class="tdstyle02"><a href="#"><img src="/images/lc/pencil.gif" width="16" height="16" border="0" /></a> <a href="#"><img src="/images/lc/lc_del.gif" width="14" height="13" border="0" /></a></td>
            </tr>
            <tr>
              <td class="tdstyle02">051147265</td>
              <td class="tdstyle02">kfdfgfdg</td>
              <td class="tdstyle02"><a href="#"><img src="/images/lc/pencil.gif" width="16" height="16" border="0" /></a> <a href="#"><img src="/images/lc/lc_del.gif" width="14" height="13" border="0" /></a></td>
            </tr>
          </table>
          <div class="lcadd02"><a href="javascript:void(0)" id="change">添加设备</a></div>
              <table width="705" border="0" align="center" cellpadding="0" cellspacing="0" id="unessential">
                <tr>
                  <td height="45" valign="bottom" background="/images/lc/lcbg003.jpg"><div class="lcintt01"> <span class="f1 ml15 red">注：* 为必填项</span></div></td>
                </tr>
                <tr>
                  <td background="/images/lc/lcbg04.jpg"><div class="lcin01 mt10">
                      <ul>
                        <li> 设备序列号  <input name="textfield3223" type="text" class="lcinput02" />
                            <span class="redzi"> *</span> </li>
                        <li> 设备密码  <input name="textfield3233" type="text" class="lcinput01" />
                            <span class="redzi"> *</span></li>
                        <li> 设备名称  <input name="textfield32232" type="text" class="lcinput02" />
                          <span class="redzi"> *</span>
						  </li>
                      </ul>
                  </div></td>
                </tr>
                <tr>
                  <td background="/images/lc/lcbg04.jpg">
				  <span class="lcsub">
				  <input name="Submit31" type="submit" class="btua" value="保存" />
                    <input name="Submit32" type="submit" class="btub" value="取消" />
					</span>
					</td>
                </tr>
                <tr>
                  <td height="9" background="/images/lc/lcbg05.jpg"></td>
                </tr>
            </table></td>
          <td background="/images/tc/tc05.gif">&nbsp;</td>
        </tr>
        <tr>
          <td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td>
          <td background="/images/tc/tc07.gif"></td>
          <td><img src="/images/tc/tc08.gif" width="9" height="9" /></td>
        </tr>
      </table>
	  </div>
	  
	  <div class="ok_box0"> 
	    <input name="Submit2" type="submit" class="ok_greenbtu mr20" value="上一步" />
	    <input type="submit" name="Submit" class="ok_greenbtu" value="完成" />
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
