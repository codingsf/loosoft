<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!-- turn page .jsp -->    
<div class="fenye">
  <h6>
    <span class="wz">第 <span class="shuzi">
    <c:choose>
    <c:when test="${((page.pageNo-1)*page.pageSize+1)<page.totalCount}">
    <c:out value="${(page.pageNo-1)*page.pageSize+1}"/>-
    </c:when>
    <c:otherwise>
    	<c:choose>
    	<c:when test="${page.totalCount==0}">
    	 0 -
    	</c:when>
    	<c:otherwise>
    	 1 -
    	</c:otherwise>
    	</c:choose>
    </c:otherwise>
    </c:choose>
    <c:choose>
    <c:when test="${(page.pageNo*page.pageSize)<page.totalCount}">
    <c:out value="${page.pageNo*page.pageSize}"/></c:when>
    <c:otherwise><c:out value="${page.totalCount}"/></c:otherwise>
    </c:choose>
    </span> 条，共 <span class="shuzi"><b>${page.totalCount}</b></span> 条</span>
	<a href="javascript:jumpPage(1)">首页</a>
	<s:if test="page.hasPre"><a href="javascript:jumpPage(${page.prePage})">上一页</a></s:if>
	<s:if test="page.hasNext"><a href="javascript:jumpPage(${page.nextPage})">下一页</a></s:if>
	<a href="javascript:jumpPage(${page.totalPages})">末页</a>
  </h6>
  <div class="clear"></div>
</div>