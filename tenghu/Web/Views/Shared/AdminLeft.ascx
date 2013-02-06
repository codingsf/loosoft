<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>

<div class="leftbox01">
                            <div class="leftbox01_u">
                                快捷菜单</div>
                            <div class="leftbox01_l">
                                <ul>
                                    <li><a href="/admin.aspx/webconfig">网站管理</a></li>
                                    <li><a href="/admin.aspx/banner">页面Banner</a></li>
                                    <li><a href="/admin.aspx/addnew">发布新闻</a></li>
                                    <li><a href="/admin.aspx/addproduct">发布产品</a></li>
                                    <li><a href="/admin.aspx/addjob">发布职位</a></li>
                                    <li><a href="/admin.aspx/my">我的资料</a></li>
                                    <li><%--<a href="/admin.aspx/links">友情链接</a>--%></li>
                                    <li><a href="/admin.aspx/zhuanli">发布专利</a></li>
                                    <li><a href="/admin.aspx/qiye">其他信息</a></li>
                                    
                                    
                                    
                                    <%if (Session["alogin"]!=null&&(Session["alogin"] as Manager).issuper)
                                      { %>
                                    <li><a href="/admin.aspx/adduser">添加用户</a></li>
                                    <%} %>
                                </ul>
                            </div>
                        </div>
                        <div class="leftbox02">
                            电话：<%=WebconfigService.GetInstance().Config.tel %></div>