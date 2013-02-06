<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="DataLinq" %>
<% Pager page = (ViewData["page"] as Pager); %>
            <span style="float: right; padding-right: 10px;">
            <%if(page.IsFirst==false)
              { %>
            <a onclick="changePage(0)" href="#" class="lblack">首页</a>   <span class="lbl">|</span> 
            <%} %>
          
            <%if(page.IsPre)
              { %>
            <a onclick="changePage('<%=page.PreNo %>')" href="#" class="lblack">上一页</a> <%--<span class="lbl">|</span>  --%>
            <%} %>
           
            <span class="lbl">共 <%=page.PageIndex %> / <%=page.PageCount %> 页</span> 
             <%if(page.IsNext)
              { %>
            <a onclick="changePage('<%=page.NextNo %>')" href="#" class="lblack">下一页</a> <span class="lbl">|</span> 
            <%} %>
           
            <%if(page.IsLast==false)
              { %>
             <a onclick="changePage('<%=page.PageCount %>')" href="#" class="lblack">尾页</a> 
            <%} %>
            </span>