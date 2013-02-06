<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="DataLinq" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Common" %>

<div>
			<span class="sl">
			
			   <%if (!(ViewData["page"] as Pager).IsFirst)
                             { %>
                           
                           <a href="#" onclick="changePage('1');">首页</a>
                           <%} %>
                           <%if ((ViewData["page"] as Pager).IsPre)
                             { %>
                            <a href="#" onclick="changePage('<%=(ViewData["page"] as Pager).PreNo%>');">上一页 </a>
                            <%} %>
			            <%=(ViewData["page"] as Pager).PageIndex%> / <%=(ViewData["page"] as Pager).PageCount%> 页  
                            
                             <%if ((ViewData["page"] as Pager).IsNext)
                               { %>
                            <a href="#" onclick="changePage('<%=(ViewData["page"] as Pager).NextNo%>');">下一页</a> 
                            <%} %>
                            
                             <%if (!(ViewData["page"] as Pager).IsLast)
                               { %>
                            <a href="#" onclick="changePage('<%=(ViewData["page"] as Pager).PageCount%>');">尾页</a> 
                                <%} %>
			
			
			
			</span>
			<span class="fr">跳转   
			  <select name="page" onchange="changePage($(this).val())">
			  <%for (int i = 1; i <= (ViewData["page"] as Pager).PageCount; i++)
       {
           if ((ViewData["page"] as Pager).PageIndex.Equals(i))
           {
            %>
			    <option selected="selected" value="<%=i %>">第 <%=i%>页</option>
<%}
           else
           { %>            
			    <option value="<%=i %>">第 <%=i%>页</option>
			    <%}
       }%>
			    </select>
				</span>
			</div>
			