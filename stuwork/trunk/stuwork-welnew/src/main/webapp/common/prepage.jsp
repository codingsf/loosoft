<%--用于前台分页 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<s:if test="!page.result.empty">
<div id="page">
	<span>
		第 <c:out value="${page.pageNo }"/>页&nbsp;&nbsp;共 ${page.totalPages } 页
		&nbsp;&nbsp;<c:if test="${page.pageNo > 1}"><a href="${curUrl}${page.prePage}">&lt;上一页</a></c:if>
		<c:forEach begin="${page.startScope}" end="${page.endScope}" var="tmpPageNo" >
		<c:choose>
		<c:when test="${page.pageNo==tmpPageNo}">
				<a href="#" style="color: red;">${tmpPageNo}</a>
		</c:when>
		<c:otherwise>
				<a href="${curUrl}${tmpPageNo }">${tmpPageNo}</a>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${page.pageNo < page.totalPages }"><a href="${curUrl}${page.nextPage }">下一页&gt;</a></c:if>
	</span>
</div>
</s:if>