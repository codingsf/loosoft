<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<div class="leftbox01">
                            <div class="leftbox01_u">
                                快捷菜单</div>
                            <div class="leftbox01_l">
                                <ul>
                                    <li><a href="/admin/webconfig">网站管理</a></li>
                                    <li><a href="/admin/banner">页面Banner</a></li>
                                    <li><a href="/admin/addnew">发布新闻</a></li>
                                    <li><a href="/admin/addproduct">发布产品</a></li>
                                    <li><a href="/admin/addjob">发布职位</a></li>
                                    <li><a href="/admin/my">我的资料</a></li>
                                    <li><%--<a href="/admin/links">友情链接</a>--%></li>
                                    <li><a href="/admin/zhuanli">发布专利</a></li>
                                    <li><a href="/admin/qiye">其他信息</a></li>
                                    
                                    
                                    
                                    <%if (Session["alogin"]!=null&&(Session["alogin"] as Manager).issuper)
                                      { %>
                                    <li><a href="/admin/adduser">添加用户</a></li>
                                    <%} %>
                                </ul>
                            </div>
                        </div>
                        <div class="leftbox02">
                            电话：<%=WebconfigService.GetInstance().Config.tel %></div>