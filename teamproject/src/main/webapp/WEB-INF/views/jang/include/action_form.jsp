<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="actionForm" action="/jang/board/notice/list" method="get">
	<input type="hidden" name="pageNum" 
		value="${pageMaker.cri.pageNum}" />
	<input type="hidden" name="amount" 
		value="${pageMaker.cri.amount}" />
	<input type="hidden" name="type"
		value="${pageMaker.cri.type}"/>
	<input type="hidden" name="keyword"
		value="${pageMaker.cri.keyword}"/>
	<input type="hidden" name="sort"
		value="${pageMaker.cri.sort != null ? pageMaker.cri.sort : ''}"/>
	<input type="hidden" name="order"
		value="${pageMaker.cri.order != null ? pageMaker.cri.order : ''}"/>
</form>