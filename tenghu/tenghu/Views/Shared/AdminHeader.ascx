<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<div class="top">
            <div class="top_logo">
                <img src="/images/logo.jpg" width="312" height="69" /></div>
            <div class="topdh">
                <div>
                    
                </div>
            </div>
        </div>
        
        <div class="wz">
            <div class="wz_l">
                <div class="wz_l02">
                    欢迎您，<a href="#" class="lblack"><%=Session["alogin"]!=null?(Session["alogin"] as Cn.Loosoft.Zhisou.Tenghu.Domain.Manager).username:string.Empty%>  </a></div>
                <div class="wz_l01">
                    <a href="/admin/my" class="lblack">修改资料</a> | <a onclick="return confirm('您确定要退出吗?');" href="/auth/logout" class="lblack">退出</a></div>
            </div>
            <div class="wz_r">
             <a href="/admin"> 后台首页</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a target="_blank" href="/home"> 网站首页</a> </div>
        </div>