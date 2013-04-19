<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/Index.Master" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%=Resources.SunResource.HOME_INDEX_INDEX%></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="../../script/cookie.js" type="text/javascript"></script>
    <script type="text/javascript">
        function remember() {
            var Days = 30;
            var exp = new Date();
            exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
            document.cookie = "sunInfoBankUser=" + $("#username").val() + ";expires=" + exp.toGMTString(); ;
        }

        function reloadcode(img) {
            img.src = img.src + "?" + new Date().getMilliseconds();
        }

        function getCookie(name) {
            var result = null;
            var myCookie = document.cookie + ";";
            var searchName = name + "=";
            var startOfCookie = myCookie.indexOf(searchName);
            var endOfCookie;
            if (startOfCookie != -1) {
                startOfCookie += searchName.length;
                endOfCookie = myCookie.indexOf(";", startOfCookie); //分隔符;
                if (endOfCookie == -1) {
                    endOfCookie = mycookie.indexOf("&", startOfCookie); //分隔符&
                }
                result = decodeURI(myCookie.substring(startOfCookie, endOfCookie)); //unescape decodeURI
            }
            if (result == null) result = "";
            return result;
        } 
   
   
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

    <style type="text/css">
        .container, .container img
        {
            width: 540px;
            height: 202px;
        }
        .container img
        {
            border: 0;
            vertical-align: top;
        }

        .container ul, .container li
        {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .num
        {
            position: absolute;
            right: 5px;
            bottom: 5px;
            font: 12px/1.5 tahoma, arial;
            height: 18px;
        }
        .num li
        {
            float: left;
            color: #d94b01;
            text-align: center;
            line-height: 16px;
            width: 16px;
            height: 16px;
            font-family: Arial;
            font-size: 11px;
            cursor: pointer;
            margin-left: 3px;
            border: 1px solid #f47500;
            background-color: #fcf2cf;
        }
        .num li.on
        {
            line-height: 18px;
            width: 18px;
            height: 18px;
            font-size: 14px;
            margin-top: -2px;
            background-color: #ff9415;
            font-weight: bold;
            color: #FFF;
        }
        .style1
        {
            width: 134px;
        }
    </style>
    <div class="mainbox">
        <div class="embox"></div>
        <div class="mainboxup">
            <div class="mainboxup_l">
                <form name="loginform" method="post" action="/home/index" id="loginform">
                <div class="indexicg"><%=Resources.SunResource.HOME_INDEX_LOGIN%></div>
                <input id="localZone" name="localZone" type="hidden" />
            <%--    <table width="390" border="0" align="left" cellpadding="0" cellspacing="0" style="margin-top: 15px; margin-left:30px;">
                    <%if(Request.QueryString.ToString().Equals("t")){ %>
                    <tr>
                        <td height="26" colspan="3" align="right" class="dgr">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="5%">
                                        <img src="/images/tx.jpg" width="12" height="11" />
                                    </td>
                                    <td width="95%" style="color: #EF8700; font-weight: bold;">
                                        <%=Resources.SunResource.HOME_INDEX_LOG_FAIL_TIME_OUT%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%}
                      else
                    {%>
                    <tr>
                        <td colspan="3" height="12">
                            <%= Html.ValidationMessage("Error", "", new { id = "errormessage", @class = "redzi" })%>&nbsp
                        </td>
                    </tr>
                    <%} %>
                    <tr>
                        <td width="78" height="32" align="left" class="dgr">
                            <%=Resources.SunResource.HOME_INDEX_USERNAME%>:
                        </td>
                        <td align="right" width="167" >
                            <%= Html.TextBoxFor(m => m.username, new { @class = "insy01", @style = "width:155px;", size = "25"})%>
                        </td>
                        <td width="165" align="left">
                            &nbsp;<span id="error_username"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="32" align="left" class="dgr">
                            <%= Resources.SunResource.HOME_INDEX_PASSWORD%>:
                        </td>
                        <td align="right">
                            <%= Html.PasswordFor(m => m.password, new { @class = "insy01", @style = "width:155px;", size = "25" })%>
                        </td>
                        <td align="left">
                            &nbsp;<span id="error_password"></span>
                        </td>
                    </tr>
                    <tr>
                    <td colspan="3">
                    <table>
                    <tr>
                      <td align="left"  width="167">
                               <input id="ssl" type="checkbox" value="checkbox" />
                                        SSL
                                        <%=Html.CheckBox("autologin",false) %>
                                        <%= Resources.SunResource.HOME_INDEX_REMAIN_REMEMBER_ME%>
                        </td>
                        
                        <td height="32" align="right"  width="78">
                            <input type="submit" class="loginbu" value="<%=Resources.SunResource.HOME_INDEX_LOGIN%>"
                                            onclick="remember(this)" />
                        </td>
                      
                        <td align="left" width="165">
                        </td>
                    </tr>
                    </table>
                    
                    </td>
                    </tr>
                    <tr>
                        <td height="35" colspan="2" align="center">
                            <span style="float: left;"><a href="/auth/reg" class="green">
                                <%= Resources.SunResource.HOME_INDEX_REGISTER%></a></span><span style="float: right;"><a href="/public/findpassword" class="green">
                                        <%= Resources.SunResource.HOME_INDEX_FORGETTEN_PASSWORD%>? </a></span>
                        </td>
                        <td height="35" align="center">
                            &nbsp;
                        </td>
                    </tr>
                </table>--%>
               
    <table width="400" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
    <tr>
      <td height="30" colspan="3" align="left" class="dgr"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
         
          <td width="100%" style="color:#EF8700; font-weight:bold;">
           <span id="error">
          <%if (Request.QueryString.ToString().Equals("t"))
            { %>
            <img src="images/tx.jpg" width="12" height="11" id="Img1" /> &nbsp; <%=Resources.SunResource.HOME_INDEX_LOG_FAIL_TIME_OUT%>       
            <%}
            else
            {%>
             <%= Html.ValidationMessage("Error", "", new { id = "errormessage"})%>&nbsp
            <%} %>
    
          </span></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td width="73" height="28" align="left" class="dgr"><span style="white-space:nowrap;"><%=Resources.SunResource.HOME_INDEX_USERNAME%>:</span> </td>
      <td width="174" align="right">
       <%= Html.TextBoxFor(m => m.username, new { @class = "insy01", tabindex ="1"})%>
      </td>
      <td width="153" rowspan="2">
      <input type="submit" class="loginbu" value="<%=Resources.SunResource.HOME_INDEX_LOGIN%>"
                                            onclick="remember(this)" id="btnLogin", tabindex ="3" />
      
      </td>
    </tr>
    <tr>

      <td height="28" align="left" class="dgr"> <%= Resources.SunResource.HOME_INDEX_PASSWORD%>:</td>
      <td align="right">
       <%= Html.PasswordFor(m => m.password, new { @class = "insy01", tabindex = "2" })%>
      </td>
      </tr>
    <tr>
      <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <%if (Cn.Loosoft.Zhisou.SunPower.Common.ValidateCodeUtil.isValid())
              { %>
              <td class="dgr" width="82"><span leftzone="0|15" rightzone="0|15" space="space"> <%= Resources.SunResource.HOME_INDEX_VALIDATECODE%>:</span>      </td>
              <td align="left" width="170"><input name="validatecode" type="text" style="border:1px solid #3A4E2B; width:95px; height:17px; vertical-align:middle;" />
                <img src="/content/ashx/validatecode.ashx" width="60" height="19"  style="vertical-align:middle; cursor:pointer; " title="<%= Resources.SunResource.HOME_INDEX_RELOAD_VALIDATECODE%>" onclick="reloadcode(this)" /> </td>
          <%}%>
          <td align="left">
          <%=Html.CheckBox("autologin",false) %>
                                        <%= Resources.SunResource.HOME_INDEX_REMAIN_REMEMBER_ME%>
          </td>
          <td align="right" style="display:none">
           <input id="Checkbox1" type="checkbox" value="checkbox" />
                                        SSL
          </td>
          </tr>
      </table></td>
      <td height="36">&nbsp;</td>
    </tr>
    <tr>
      <td height="28" colspan="2" align="center"><span style="float:left;"><a href="/newregister/register" class="green" target=_blank>
                                <%= Resources.SunResource.HOME_INDEX_REGISTER%></a></span>

	  <span style=" float:right; margin-left:20px;"><a href="/public/findpassword" class="green">
                                        <%= Resources.SunResource.HOME_INDEX_FORGETTEN_PASSWORD%>? </a></span>	  </td>
      <td height="28" align="center">&nbsp;</td>
    </tr>
  </table>  
  
                </form>
            </div>
            <div style="float: right; height: 100px; width: 510px; margin-top: 40px; color: #A2A2A2;
                font-size: 11px;">
                <div style="float: left; width: 90px; padding-top: 20px; height: 90px;">
                    <a onclick="gotoexampleplant(this);" href="javascript:void(0);">
                        <img src="/images/ico01.gif" border="0" /></a></div>
                <div style="float: left; height: 100px; width: 380px;">
                    <div class="mrb">
                        <a  onclick="gotoexampleplant(this);" href="javascript:void(0);">
                            <%=Resources.SunResource.HOME_INDEX_EXAMPLE_PLANT %></a></div>
                    <div style="clear: both;">
                    </div>
                    <div class="sl02">
                        <%=Resources.SunResource.HOME_INDEX_EXAMPLE_DES %></div>
                    <div style="clear: both;">
                    </div>
                    <div class="sl01">
                        <%=Resources.SunResource.HOME_INDEX_DESCR_TITLE%>
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div style="padding-top: 10px;">
                        <input value="<%=Resources.SunResource.HOME_INDEX_VIEW_CLICKVIEW %>" onclick="gotoexampleplant();"
                            style="border: none; background: url(/images/clibg.jpg) no-repeat; width: 140px;
                            height: 23px; color: #B55507; font-weight: bold; font-size: 13px; padding-left: 21px;
                            line-height: 20px; cursor: pointer;"></input>
                    </div>
                </div>
            </div>
        </div>
        <div class="embox">
        </div>
        <div class="mainboxmid">
            <div class="mainboxmid_l">
                <div class="indexicg2">
                    <%=Resources.SunResource.HOME_INDEX_BANK_OVERVIEW%></div>
                <div class="mml02">
                    <ul>
                        <li><span style="float: left;">
                            <%= Resources.SunResource.HOME_INDEX_PLANTS%>(<%=ViewData["dayenergyUnit"] %>):</span>
                            <strong class="ddgr" style="float: right; padding-right: 30px;">
                                <%=ViewData["AlldayTotalEnergy"]%></strong></li>
                        <li><span style="float: left;">
                            <%= Resources.SunResource.HOME_INDEX_TOTAL_ENERGY%>(<%= ViewData["energyUnit"]%>):</span>
                            <strong class="ddgr" style="float: right; padding-right: 30px;">
                                <%=ViewData["AllTotalEnergy"]%></strong></li>
                        <li><span style="float: left;">
                            <%= Resources.SunResource.HOME_INDEX_AVOIDED_CO2%>(<%= ViewData["co2Unit"]%>):</span>
                            <strong class="ddgr" style="float: right; padding-right: 30px;">
                                <%=ViewData["AllCO2"]%></strong></li>
                    </ul>
                </div>
            </div>
            <div class="mainboxmid_r">
                <div class="folio_block">
                    <div class="main_view">
                        <div class="window">
                            <div class="container" id="idContainer2">
                                <ul id="idSlider2">
                                    <%if (ViewData["piclist"] == null || (ViewData["piclist"] as IList<Adpic>).Count == 0)
                                      { %>
                                    <li>
                                        <img src="/images/nopico02.gif" width="540" height="206" /></li>
                                    <%}
                                      else
                                      {
                                          foreach (var item in ViewData["piclist"] as IList<Adpic>)
                                          {
                                    %>
                                    <li><a target="_blank" href="<%=item.picUrl %>">
                                        <img src="/DepartmentPic/<%=ViewData["language"] %>/<%=item.picName %>" alt="" />
                                    </a></li>
                                    <%}
                                      }%>
                                </ul>
                                <ul class="num" id="idNum">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="embox">
        </div>
        <div class="mainboxdown">
            <div class="mainboxdown_l">
                <div class="indexicg">
                    <span style="float: left;"><%= Resources.SunResource.HOME_INDEX_PLANT_DISTRIBUTION%></span>
                </div>
               
                <div class="mdl02">
                    <ul style="margin: 10px 0px 0px 0px; padding-left:120px;  overflow: hidden;">
                        <%
                            foreach (Cn.Loosoft.Zhisou.SunPower.Domain.Plant plant in ViewData["newPlants"] as List<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>)
                            {  
                        %>
                        <li style="margin-top:5px;"><%=plant.name.Length>20?plant.name.Substring(0,20):plant.name%></li>
                        <%} %>
                    </ul>
                </div>
            </div>
            <div class="mainboxdown_r">
                <div class="indexicg">
                    <span style="float: left;"><%= Resources.SunResource.HOMT_INDEX_MOBILE_TITLE%></span>
                    <a href="#" style="float: right; padding-right: 10px;"></a>
                </div>
                <div style="width: 528px; height: 144px; margin: 12px auto auto 8px; background: url(/images/gg01.jpg) no-repeat;
                    font-family: Arial, Helvetica, sans-serif;">
                    <div style="padding-top: 30px; width: 280px; padding-left: 15px;">
                        <span style="font-size: 18px; font-weight: bold;"><%= Resources.SunResource.HOMT_INDEX_MOBILE_SUB_TITLE%></span>
                        <div style="line-height: 16px; color: #666666; padding: 5px 0px 10px 0px;">
                            <%= Resources.SunResource.HOMT_INDEX_MOBILE_DESCR%>
                        </div>
                    </div>
                    <div style="padding-left: 15px;">
                        <label>
                        <input onclick="window.location.href='/app/index'" type="submit" name="Submit2" value="<%= Resources.SunResource.HOME_INDEX_MOBILE_BUTTON%> &gt;&gt;"  style="background:url(/images/dlown.jpg) no-repeat; width:85px; height:16px; color:#FFFFFF; text-align:center; border:none; font-family:Arial, Helvetica, sans-serif; padding-bottom:5px; cursor:pointer;"/>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="embox">
        </div>
    </div>

    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        var action = '<%= Request.Url %>';

        $().ready(function() {
            var d = new Date();
            var localZone = d.getTimezoneOffset() / 60;
            $("#localZone").val(localZone);

            $("#ssl").click(function() {
                if ($(this).attr('checked')) {
                    $('#loginform').attr('action', action.replace("http", "https"));
                }
                else {
                    $('#loginform').attr('action', action);
                }
            });


            $("#username").attr("value", getCookie("sunInfoBankUser"))

            $("#btnLogin").click(function() {
                if ($("#username").val() == "") {
                    $("#error").text("<%=Resources.SunResource.HOME_INDEX_USERNAME_REQUIRED %>");
                    $("#username").get(0).focus();
                    return false;
                }
                if ($("#password").val() == "") {
                    $("#error").text("<%=Resources.SunResource.HOME_INDEX_PASSWORD_REQUIRED %>");
                    $("#password").get(0).focus();
                    return false;
                }
            });


            //            $("#loginform").validate({
            //                errorElement: "em",
            //                rules: {
            //                    username: {
            //                        required: true
            //                    },
            //                    password: {
            //                        required: true
            //                    }
            //                },
            //                errorPlacement: function(error, element) {
            //                    if (element.attr("name") == "username") {
            //                        $("#error_username").text('');
            //                        error.appendTo("#error_username");
            //                    }
            //                    if (element.attr("name") == "password") {
            //                        $("#error_password").text('');
            //                        error.appendTo("#error_password");
            //                    }
            //                },

            //                messages: {
            //                    username: {
            //                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.HOME_INDEX_USERNAME_REQUIRED %></span>"
            //                    },
            //                    password: {
            //                        required: "<span class='error'>&nbsp;<%=Resources.SunResource.HOME_INDEX_PASSWORD_REQUIRED %></span>"
            //                    }
            //                },
            //                success: function(em) {
            //                }
            //            });

        });
    </script>

    <script language="javascript" type="text/javascript">

        function gotoexampleplant() {
            var zone=new Date();
            zone = zone.getTimezoneOffset() / 60;
            window.location.href = "/home/exampleplant?"+zone;
        }

        function gotoexampleplant(thisa) {
            var zone = new Date();
            zone = zone.getTimezoneOffset() / 60;
            window.location.href = "/home/exampleplant?" + zone;
            thisa.href = "/home/exampleplant?" + zone;
        }
        
        function clearerrormsg() {
            $("#errormessage").hide();
        }

        $(document).ready(function() {
            if ($("#username").val() == "") {
                $("#username")[0].focus();
            }
            else {
                $("#password")[0].focus();
            }
        });
          
    </script>

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

</asp:Content>
