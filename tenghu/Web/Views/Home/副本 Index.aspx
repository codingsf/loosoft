<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title><%=WebconfigService.GetInstance().Config.title %></title>
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<script src="../../script/jquery.js" type="text/javascript"></script>
<meta name="description" content=<%= "\"" + Html.Encode(WebconfigService.GetInstance().Config.descr) + "\"" %> />
<meta name="keywords" content=<%= "\"" + Html.Encode(WebconfigService.GetInstance().Config.keyword) + "\"" %> />
<script>
     /*!
     * SlideTrans
     * Copyright (c) 2010 cloudgamer
     * Blog: http://cloudgamer.cnblogs.com/
     * Date: 2008-7-6
     */



     var $$ = function(id) {
         return "string" == typeof id ? document.getElementById(id) : id;
     };

     var Extend = function(destination, source) {
         for (var property in source) {
             destination[property] = source[property];
         }
         return destination;
     }

     var CurrentStyle = function(element) {
         return element.currentStyle || document.defaultView.getComputedStyle(element, null);
     }

     var Bind = function(object, fun) {
         var args = Array.prototype.slice.call(arguments).slice(2);
         return function() {
             return fun.apply(object, args.concat(Array.prototype.slice.call(arguments)));
         }
     }

     var forEach = function(array, callback, thisObject) {
         if (array.forEach) {
             array.forEach(callback, thisObject);
         } else {
             for (var i = 0, len = array.length; i < len; i++) { callback.call(thisObject, array[i], i, array); }
         }
     }

     var Tween = {
         Quart: {
             easeOut: function(t, b, c, d) {
                 return -c * ((t = t / d - 1) * t * t * t - 1) + b;
             }
         },
         Back: {
             easeOut: function(t, b, c, d, s) {
                 if (s == undefined) s = 1.70158;
                 return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
             }
         },
         Bounce: {
             easeOut: function(t, b, c, d) {
                 if ((t /= d) < (1 / 2.75)) {
                     return c * (7.5625 * t * t) + b;
                 } else if (t < (2 / 2.75)) {
                     return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
                 } else if (t < (2.5 / 2.75)) {
                     return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
                 } else {
                     return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
                 }
             }
         }
     }


     //容器对象,滑动对象,切换数量
     var SlideTrans = function(container, slider, count, options) {
         this._slider = $$(slider);
         this._container = $$(container); //容器对象
         this._timer = null; //定时器
         this._count = Math.abs(count); //切换数量
         this._target = 0; //目标值
         this._t = this._b = this._c = 0; //tween参数

         this.Index = 0; //当前索引

         this.SetOptions(options);

         this.Auto = !!this.options.Auto;
         this.Duration = Math.abs(this.options.Duration);
         this.Time = Math.abs(this.options.Time);
         this.Pause = Math.abs(this.options.Pause);
         this.Tween = this.options.Tween;
         this.onStart = this.options.onStart;
         this.onFinish = this.options.onFinish;

         var bVertical = !!this.options.Vertical;
         this._css = bVertical ? "top" : "left"; //方向

         //样式设置
         var p = CurrentStyle(this._container).position;
         p == "relative" || p == "absolute" || (this._container.style.position = "relative");
         this._container.style.overflow = "hidden";
         this._slider.style.position = "absolute";

         this.Change = this.options.Change ? this.options.Change :
		this._slider[bVertical ? "offsetHeight" : "offsetWidth"] / this._count;
     };
     SlideTrans.prototype = {
         //设置默认属性
         SetOptions: function(options) {
             this.options = {//默认值
                 Vertical: true, //是否垂直方向（方向不能改）
                 Auto: true, //是否自动
                 Change: 0, //改变量
                 Duration: 30, //滑动持续时间
                 Time: 10, //滑动延时
                 Pause: 3000, //停顿时间(Auto为true时有效)
                 onStart: function() { }, //开始转换时执行
                 onFinish: function() { }, //完成转换时执行
                 Tween: Tween.Quart.easeOut//tween算子
             };
             Extend(this.options, options || {});
         },
         //开始切换
         Run: function(index) {
             //修正index
             index == undefined && (index = this.Index);
             index < 0 && (index = this._count - 1) || index >= this._count && (index = 0);
             //设置参数
             this._target = -Math.abs(this.Change) * (this.Index = index);
             this._t = 0;
             this._b = parseInt(CurrentStyle(this._slider)[this.options.Vertical ? "top" : "left"]);
             this._c = this._target - this._b;

             this.onStart();
             this.Move();
         },
         //移动
         Move: function() {
             clearTimeout(this._timer);
             //未到达目标继续移动否则进行下一次滑动
             if (this._c && this._t < this.Duration) {
                 this.MoveTo(Math.round(this.Tween(this._t++, this._b, this._c, this.Duration)));
                 this._timer = setTimeout(Bind(this, this.Move), this.Time);
             } else {
                 this.MoveTo(this._target);
                 this.Auto && (this._timer = setTimeout(Bind(this, this.Next), this.Pause));
             }
         },
         //移动到
         MoveTo: function(i) {
             this._slider.style[this._css] = i + "px";
         },
         //下一个
         Next: function() {
             this.Run(++this.Index);
         },
         //上一个
         Previous: function() {
             this.Run(--this.Index);
         },
         //停止
         Stop: function() {
             clearTimeout(this._timer); this.MoveTo(this._target);
         }
     };
 </script>
 
 <script>
     $(document).ready(function() {
         $('#head li:eq(0) a').addClass("hover");
     });
 </script>
<style type="text/css">
.container { width:964px; height:385px; margin:0px; padding:0px;}
.container img{width:964px; height:370px; overflow:hidden;}
.container img{border:0;vertical-align:top;}
</style>
<style type="text/css">
.container ul, .container li{list-style:none;margin:0;padding:0;}

.num{ position:absolute; top:370px; font:12px/1.5 tahoma, arial; height:15px; z-index:100; background-color:#898788; width:964px; padding-left:50px;}
.num li{
	float: left;
	color:#FFF;
	text-align: center;
	line-height: 16px;
	width: 18px;
	height: 15px;
	font-family: Arial;
	font-size: 11px;
	cursor: pointer;
	border-left: 1px solid #fff;
	background-color: #626669;
}
.num li.on{
	line-height: 15px;
	width: 18px;
	height: 15px;
	font-size: 11px;
	background-color: #EC1922;
	color:#FFF;
}
</style>
</head>
<body>
<% var images = ViewData["images"] as IList<Cn.Loosoft.Zhisou.Tenghu.Domain.Image>;
   var news = ViewData["news"] as IList<News>;
    %>
<div class="main">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="/img/bg01.png" width="1004" height="14" /></td>
    </tr>
    <tr>
      <td background="/img/bg02.png">
	  <div class="mainbody">
	  <%Html.RenderAction("header","home"); %>
	  <div class="banner_index">
	  
	    <div class="container" id="idContainer2">
	<ul id="idSlider2">
	
	<% foreach (Cn.Loosoft.Zhisou.Tenghu.Domain.Image img in images)
    { %>
		<li><a target="_blank" href="<%=img.url %>"> <img src="/upload/<%=img.pic %>"alt="" /> </a></li>
	<%} %>
	</ul>
	<ul class="num" id="idNum">
	<li style=" width:50px;"></li>
	</ul>
</div>
	  
	  </div>
	  <div class="midbox">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10"><img src="/img/body01.jpg" width="10" height="200" /></td>
            <td background="/img/body02.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="290" valign="top">
				<div class="ico01"><a href="/about/more/8"><img src="/img/ico01.jpg" width="259" height="18" border="0" /></a></div>
				<div class="nl01">
				<%=(ViewData["jianjie"] as Category).text.Length > 70 ? (ViewData["jianjie"] as Category).text.Substring(0, 70) : (ViewData["jianjie"] as Category).text%>...
				</div>
			    <div><a href="/service?"><img src="/img/bu01.jpg" width="135" height="35" border="0" /></a><a href="/contact/job"><img src="/img/bu02.jpg" width="135" height="35" border="0" /></a></div></td>
                <td width="13"><img src="/img/line01.jpg" width="13" height="186" /></td>
                <td valign="top">
				<div class="ico01"><a href="/news"><img src="/img/ico02.jpg" width="349" height="18" border="0" /></a></div>
				<%if (news != null && news.Count > 0)
                { %>
				
				<div class="nl02">
				<div class="nl02_img"><a href="/news/info/<%=news[0].id %>"><img src="<%=news[0].imgUrl %>" width="79" height="46" border="0" /></a></div>
				<div class="nl02_r">
				<div><a href="/news/info/<%=news[0].id %>"><strong><%=news[0].title %></strong></a></div>
				<div class="lbla"><%=news[0].text.Length > 40 ? news[0].text.Substring(0, 40) : news[0].text %>...</div>
				</div>
				</div>
				<%} %>
				<div class="nl02_d">
				<ul>
				<% int i = 0;
				    foreach (var item in news)
                 {
                     if (i++.Equals(1))
                         continue;
                         %>
				<li><a href="/news/info/<%=item.id %>">·<%=item.title %></a></li>
		        <%} %>
				</ul>
				</div>
				
				
				</td>
                <td width="13"><img src="/img/line01.jpg" width="13" height="186" /></td>
                <td width="250"><a href="/patent/info"><img src="/img/video.jpg" width="248" height="160" border="0" /></a></td>
              </tr>
            </table></td>
            <td width="8"><img src="/img/body03.jpg" width="8" height="200" /></td>
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
<script>

    var nums = [], timer, n = $$("idSlider2").getElementsByTagName("li").length,
	st = new SlideTrans("idContainer2", "idSlider2", n, {
	    onStart: function() {//设置按钮样式
	        forEach(nums, function(o, i) { o.className = st.Index == i ? "on" : ""; })
	    }
	});
    for (var i = 1; i <= n; AddNum(i++)) { };
    function AddNum(i) {
        var num = $$("idNum").appendChild(document.createElement("li"));
        num.innerHTML = i--;
        num.onmouseover = function() {
            timer = setTimeout(function() { num.className = "on"; st.Auto = false; st.Run(i); }, 200);
        }
        num.onmouseout = function() { clearTimeout(timer); num.className = ""; st.Auto = true; st.Run(); }
        nums[i] = num;
    }
    st.Run();
</script>
</html>
