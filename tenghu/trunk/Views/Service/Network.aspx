<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>售后网络</title>
    <link href="../../css/ny.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="/script/jquery.js" type="text/javascript"></script>
         <script type="text/javascript">
             function loaddata() {
                 $.ajax({
                     type: "GET",
                     url: "/service/load/" + $("#area").val() + "?issale=false&type=" + $("#type").val() + "&keyword=" + $("#txt").val(),
                     data: {},
                     success: function(result) {
                         $("#container").html(result);
                     },
                     beforeSend: function() {
                     }
                 });
             
             }
             $().ready(function() {
                 $("#area").change(loaddata);
                 $("#type").change(loaddata);
                 $("#go").click(loaddata);
             });
    
</script>


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
	  
	  <div class="ny_banner"><img src="/img/banner/banner_22.jpg" width="964" height="147" /></div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="210" valign="top">
			<div class="left_dh">
			<div class="left_dh01">服务</div>
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
			<div class="ny_wz"><span class="f11">Welcome to</span> <span class="bulez f11">PROUDTIGER</span> &gt; <a href="/" class="lz">首页</a> &gt; <a href="/service" class="lz">服务</a> &gt; 售后网络</div>
			<div class="rbox01">
			<div class="rbox01_ico">
			<div class="sl">售后网络</div>
			<div class="sr"></div> 
			</div>
			<div class="rbox01_m">秉承“一切为了客户，创造客户价值”的服务理念，以客户需求为中心，用一流的速度、一流的技能、一流的态度实现“超越客户期
			  望，超越行业标准”的服务目标。通过标准化、差异化、超值化的服务来降低客户的心理成本和使用成本，最终提高客户的过渡价值
			  赢利能力和购买能力，从而提升服务品牌竞争力，引领行业服务新潮流。
			  <div class="patent" id="map" class="map" >
			  
		<script type="text/javascript" src="http://www.google.com/jsapi?key=<%= ConfigurationManager.AppSettings["map.key"]%>"></script>
		<script language="javascript">
		    var latitude = 37.4419;
		    var longitude = -122.1419;
		    var address = "鼠标滚轮 :<br />滚动鼠标滚轮可放大或缩小地图。<br />双击 :<br />用鼠标双击地图，地图可变大一级。<br />拖动 :<br />按住鼠标左键拖动鼠标可移动地图。<br />查找 :<br />可在下方选择不同的查询条件进行网点检索。";
		    
		    function changePoint(lat, lon,adr) {
		        latitude = lat;
		        longitude = lon;
		        address = adr;
		        initialize();
		    }
		</script>
		<script type="text/javascript">
        function addListener(pointMarker, latlng, content) {
            GEvent.addListener(pointMarker, latlng, function() {
                pointMarker.openInfoWindowHtml(content,0,0);
            });
        }
        
        google.load('maps', '2', {language: "zh-cn"});
        var map;
        function initialize() {
            map = new GMap2(document.getElementById("map"));
            map.setCenter(new GLatLng(latitude, longitude), 6);
            map.addMapType(G_SATELLITE_3D_MAP);
            map.addControl(new GLargeMapControl());

            var content = '<div style=\"overflow:auto;\">'+address+'</div>';
            var marker = new GMarker(new GLatLng(latitude, longitude));
            addListener(marker, "click", content);
            map.addOverlay(marker);

        }
    </script>
    
		<script type="text/javascript">
            initialize();
        </script>
			  
			  </div>
			  <div class="cx01">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td><strong>全部销售点查询：</strong></td>
                    
                    <td>
                    <%=Html.DropDownList("area",Comm.Area) %>
                    </td>
                    <td>
                    <%=Html.DropDownList("type",Comm.NetworkType) %>
                    </td>
                    <td>
                      <input type="text" name="txt"  id="txt" /><a href="javascript:void(0);" id="go">  查找</a> 
                      
                    </td>
                  </tr>
                </table>
			  </div>
			  <div id="container">
			    
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
