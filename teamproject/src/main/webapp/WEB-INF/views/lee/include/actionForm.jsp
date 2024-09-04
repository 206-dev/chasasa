<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form id="actionForm" action="" method="get">
<!-- 	<h2>actionFrom</h2> -->
	<input id="inputPageNum" type="hidden" name="pageNum" value="${criteria.pageNum}">
	<input id="inputAmount" type="hidden" name="amount" value="${criteria.amount}">
	<input type="hidden" name="type" value="${criteria.type}">
	<input type="hidden" name="keyword" value="${criteria.keyword}">
<!-- 	<span>boardtypeno : </span> -->
<%-- 	<input type="text" name="boardtypeno" value="${boardtype.boardtypeno}"> --%>
<!-- 	<span>boardtype : </span> -->
<%-- 	<input type="text" name="boardtype" value="${boardtype.boardtype}"> --%>
<%-- 	<span>boardtype : ${boardtype}</span> --%>
</form>