<%@ page language="java"  session="false" %>
<%
final String queryString = request.getQueryString();
final String url = request.getContextPath() + "/login?service=stuwork";
response.sendRedirect(response.encodeURL(url));%>
