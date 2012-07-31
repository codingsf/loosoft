<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Index</title>
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
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
	  
	  <div class="ny_banner"><img src="/img/ny/nybanner05.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top">
			<div class="left_dh">
			<div class="left_dh01">联系我们</div>
			<div class="left_dh02">
	<ul id="lmenu">
				<%foreach (Category cat in ViewData["childCat"] as IList<Category>)
      { %>
			<li><a href="<%=cat.url %>">+ <%=cat.name%></a></li>
			<%
                    if (cat.ChildCategory != null && cat.ChildCategory.Count > 0)
                    {%>
                    	<li id="llo">
			 <%foreach (var item in cat.ChildCategory)
      { %>
        <a href="<%=item.url %>">&gt;&gt; <%=item.name %> </a>
			  
       <%} %>      
			</li>
			
     <% }
      }   %>
		
            </ul>
</div>
			
			<div class="left_dh04"><a href="/product" class="lyn">> 最新产品</a></div>
			<div class="left_dh04"><a href="/service/network" class="lyn">> 售后服务网点</a></div>
			<div class="left_dh03"></div>
			  </div>
			<div class="nytel"><%=WebconfigService.GetInstance().Config.tel %></div>
			</td>
            <td width="753" rowspan="2" valign="top" class="tdp">
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="/service" class="lz">服务</a></div>
			<div class="rbox01">
			<div class="rbox01_ico">
			<div class="sl">技术简介</div>
			<div class="sr"><a href="#"><img src="/img/ny/more.jpg" width="39" height="7" border="0" /></a></div> 
			</div>
			<div class="rbox01_m">秉承“一切为了客户，创造客户价值”的服务理念，以客户需求为中心，用一流的速度、一流的技能、一流的态度实现“超越客户期
			  望，超越行业标准”的服务目标。通过标准化、差异化、超值化的服务来降低客户的心理成本和使用成本，最终提高客户的过渡价值
			  赢利能力和购买能力，从而提升服务品牌竞争力，引领行业服务新潮流。
			  <div class="patent"><img src="/img/ny/nyimg07.jpg" width="695" height="390" /></div>
			  <div class="cx01">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><strong>全部销售点查询：</strong></td>
                    <td><select name="select">
                      <option>--请选择产品类别--</option>
                    </select>
                    </td>
                    <td><select name="select2">
                      <option>--请选择区域--</option>
                                        </select></td>
                    <td><select name="select3">
                      <option>--请选择网点类别--</option>
                                        </select></td>
                    <td><label>
                      <input type="text" name="textfield2" />
                    </label></td>
                  </tr>
                </table>
			  </div>
			  <div>
			    <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#E8E8E8" style="border-collapse:collapse;">
                  <tr>
                    <td width="17%" height="30" class="txl01"><strong>国家</strong></td>
                    <td width="20%" class="txl01"><strong>地区</strong></td>
                    <td width="48%" class="txl01"><strong>名称</strong></td>
                    <td width="15%" class="txl01"><strong>查看详细</strong></td>
                    </tr>
                  <tr>
                    <td height="30" class="txl03">中国</td>
                    <td width="20%" class="txl03">合肥</td>
                    <td width="48%" class="txl03">合肥销售直营店12号</td>
                    <td width="15%" class="txl03"><a href="#"><img src="/img/ny/cx01.gif" width="16" height="16" border="0" /></a></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl03">&nbsp;</td>
                    <td width="20%" class="txl03">&nbsp;</td>
                    <td width="48%" class="txl03">&nbsp;</td>
                    <td width="15%" class="txl03"><a href="#"><img src="/img/ny/cx01.gif" width="16" height="16" border="0" /></a></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl03">&nbsp;</td>
                    <td width="20%" class="txl03">&nbsp;</td>
                    <td width="48%" class="txl03">&nbsp;</td>
                    <td width="15%" class="txl03"><a href="#"><img src="/img/ny/cx01.gif" width="16" height="16" border="0" /></a></td>
                  </tr>
                  <tr>
                    <td height="30" class="txl03">&nbsp;</td>
                    <td width="20%" class="txl03">&nbsp;</td>
                    <td width="48%" class="txl03">&nbsp;</td>
                    <td width="15%" class="txl03"><a href="#"><img src="/img/ny/cx01.gif" width="16" height="16" border="0" /></a></td>
                  </tr>
                </table>
			  </div>
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
