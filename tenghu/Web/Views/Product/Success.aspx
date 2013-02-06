<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DataLinq.Product>" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>您的订单已提交成功，稍后我们将有人后台处理！</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/ny.css" rel="stylesheet" type="text/css" />
     <script src="/script/jquery.js" type="text/javascript"></script>
</head>
<body>
   <div class="main">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="/img/bg01.png" width="1004" height="14" /></td>
    </tr>
    <tr>
      <td background="/img/bg02.png">
	  <div class="mainbody">
	  <%Html.RenderAction("header","home"); %>
	  
	  <div class="ny_banner"><img src="/img/banner/banner_4.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top"><div class="left_dh">
              <div class="left_dh01">产品展示</div>
              <div class="left_dh02">
                <ul>
           	<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
        { %>
			<li><a href="/product.aspx/list/<%=cat.id %>">+ <%=cat.name %></a></li>
			<%} %>
                </ul>
              </div>
              <div class="left_dh04"><a href="/product.aspx" class="lyn">> 最新产品</a></div>
              <div class="left_dh04"><a href="/service.aspx/network" class="lyn">> 售后服务网点</a></div>
              <div class="left_dh03"></div>
            </div>
            <div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="#" class="lz">首页</a> &gt; <a href="#" class="lz">产品展示</a></div>
			<div class="rbox01">
			<div class="rbox01_ico">
			<div class="sl">订购成功</div>
			</div>
			<div class="succ">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="8%" height="40"><img src="/img/ny/icosuc.gif" width="25" height="25" /></td>
                  <td width="92%" class="succ_tt" height="25" valign="middle">
                 <div style="line-height:25px"> 您的订单已提交成功，稍后我们将有人后台处理！</div>
                  
                  </td>
                </tr>
                <tr>
                  <td height="35">&nbsp;</td>
                  <td><a href="/product.aspx">&gt;&gt; 再去浏览其他产品！</a></td>
                </tr>
              </table>
			</div>
			</div>
			</td>
          </tr>
          <tr>
            <td valign="bottom">
			<div class="ny_top"><a href="#"><img src="/img/ny/click_up.jpg" width="40" height="15" border="0" /></a></div>
			</td>
          </tr>
        </table>
	  </div>
	  <%Html.RenderPartial("footer"); %>
	
	  </div>
	  </td>
    </tr>
    <tr>
      <td><img src="/img/bg03.png" width="1004" height="12" /></td>
    </tr>
  </table>
</div>
</body>
</html>

  <script src="/script/jquery.validate.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $().ready(function() {
            $("#cancel").click(function() {
                $("input[type='text']").each(function() {
                    $(this).val('');
                });
                $("select").each(function() {
                    $(this).get(0).selectedIndex = 0;
                });
                $("#comment").val('');

            });

            $("#buy").validate({
                rules: {
                    uname: "required",
                    tel: "required",
                    email: "required",
                    address: "required",
                    company: "required"
                },
                messages: {
                    uname: {
                        required: "请输入您的姓名"
                    },
                    tel: {
                        required: "请输入电话 "
                    },
                    email: {
                        required: "请输入邮箱"
                    },
                    address: {
                        required: "请输入地址 "
                    },
                    company: {
                        required: "请输入所属公司 "
                    }
                }
            });
        });
    
</script>