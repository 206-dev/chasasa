<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/chataverse/header.jsp" %>
<link rel="stylesheet" href="/resources/lee/css/chataverse/region.css">
<script type="text/javascript">
$(function(){
	$("#map-item > .region-outBox > .region-item").css("display", "none");
	$("#map-item").on("click", ".pin-item", function(){
		$("#map-item > .region-outBox > .region-item").fadeOut(1000);
		let that = $(this);
		console.log("클릭한것 : ", that);
		let next = that.next();
		console.log("next : ", next);
		next.fadeIn(1000);
	});
	
	$("title").text("Choice Region");
	$("#regionContainer").on("click", ".region-item", function(){
		console.log("지역 버튼 클릭");
		let that = $(this);
		let region = that.attr("data-region");
		console.log("region : " + region);
		
		let url = "/lee/chataverse/loadingPlay/" + region;
		window.location.href = url;
	});
});
</script>

<div class="regionContainer" id="regionContainer">

	<div class="map-item" id="map-item">
		<img alt="" src="/resources/lee/image/region/dot_map_green.png" class="map">
	<!-------------------- 맵 ---------------------->
	
		<!-- 부산 -->
		<div class="region-outBox busan">
				<img alt="pin" src="/resources/lee/image/region/pin.png" class="pin-item pin-top" data-region="busan">
			<div class="region-item" data-region="busan">
				<div class="region-box" data-region="busan">
					<div class="img-box">
						<img alt="" src="/resources/lee/image/region/test1.jpg" class="region-img">
						<img alt="" src="/resources/lee/image/region/test2.jpg" class="region-img">
					</div>
					<div class="explain-box">
						<p>부산</p>
						<div class="inline-flex">
							<span>4.3</span> 
							<img alt="star" src="/resources/lee/image/region/star.png" class="star ml-5"> 
							<span>(</span><span>31</span><span>)</span>
							<span class="ml-5">해변</span>
						</div>
						<p>2/10</p>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 동해 -->
		<div class="region-outBox donghae">
			<img alt="pin" src="/resources/lee/image/region/pin.png" class="pin-item pin-top" data-region="donghae">
			<div class="region-item">
				<div class="region-box">
					<div class="img-box" data-region="donghae">
						<img alt="" src="/resources/lee/image/region/test1.jpg" class="region-img">
						<img alt="" src="/resources/lee/image/region/test2.jpg" class="region-img">
					</div>
					<div class="explain-box">
						<p>동해</p>
						<div class="inline-flex">
							<span>4.4</span> 
							<img alt="star" src="/resources/lee/image/region/star.png" class="star ml-5"> 
							<span>(</span><span>42</span><span>)</span>
							<span class="ml-5">바다</span>
						</div>
						<p>6/10</p>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 제주 -->
		<div class="region-outBox jeju">
			<img alt="pin" src="/resources/lee/image/region/pin.png" class="pin-item pin-bottom" data-region="jeju">
			<div class="region-item">
				<div class="region-box" data-region="jeju">
					<div class="img-box">
						<img alt="" src="/resources/lee/image/region/test1.jpg" class="region-img">
						<img alt="" src="/resources/lee/image/region/test2.jpg" class="region-img">
					</div>
					<div class="explain-box">
						<p>제주 협재</p>
						<div class="inline-flex">
							<span>4.7</span> 
							<img alt="star" src="/resources/lee/image/region/star.png" class="star ml-5"> 
							<span>(</span><span>69</span><span>)</span>
							<span class="ml-5">해변</span>
						</div>
						<p>8/10</p>
					</div>
				</div>
			</div>
		</div>

	<!-------------------- 맵 -------------->
	</div>
</div>

<%@ include file="/WEB-INF/views/lee/chataverse/footer.jsp" %>