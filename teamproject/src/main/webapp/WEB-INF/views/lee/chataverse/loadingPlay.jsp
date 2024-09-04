<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/chataverse/header.jsp" %>
<link rel="stylesheet" href="/resources/lee/css/chataverse/loading.css">
<div class="loadingContainer">
<script type="text/javascript" src="/resources/lee/js/chataverse/loadingPlay.js" defer></script>
	<input type="hidden" id="regionInput" value="${region}">
	<canvas class="loading_canvas" id="LOADING_CANVAS">
	</canvas>	
	<div class="loading_container">
		<div class="loading_bar" id="loadingBar"><span class="loading_text">Loading...  </span><span class="loading_text"id="loadingText">0%</span></div>
	</div>
</div>
<%@ include file="/WEB-INF/views/lee/chataverse/footer.jsp" %>