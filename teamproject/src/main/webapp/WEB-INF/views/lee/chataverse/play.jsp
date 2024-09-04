<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/chataverse/header.jsp" %>
<link rel="stylesheet" href="/resources/lee/css/chataverse/play.css">
<div class="canvasContainer">
	<canvas class="canvas" id="canvas"></canvas>
	<script type="module" src="/resources/lee/js/chataverse/play/index.js?${now.time}"></script>
</div>
<%@ include file="/WEB-INF/views/lee/chataverse/footer.jsp" %>