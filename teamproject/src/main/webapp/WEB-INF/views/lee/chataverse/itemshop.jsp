<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/lee/include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmf" %>
<link rel="stylesheet" href="/resources/lee/css/chataverse/itemshop.css">
<!-- <script src="/resources/lee/js/user/point.js" defer></script> -->
<script>
$(function(){
	
	//아이템 그리드 세팅
	const FIRST_TAB = $("#tab").children().eq(0);
	
	$(".tab").on("click", ".tab_links",function(){
		disActiveTab();
// 		console.log("탭클릭");
		let that = $(this);
		let typeno = that.attr("data-typeno");
// 		let setStr = '"[data-typeno=' + typeno + ']"';
// 		console.log(that);
// 		console.log("tab typeno : ", typeno);
// 		console.log("name : ", name);
// 		console.log("setStr : ", setStr);

		that.addClass("active_tab");
		let selectedContent = $("#itemShopContentConainer").children().filter(function(){
			return $(this).attr("data-typeno") == typeno;
		});
// 		console.log("selectedContent : ", selectedContent);
		selectedContent.css("display", "grid");
	});
	
	function tabInit(){
		disActiveTab();
		
		$(".tab_content").css("display", "none");

// 		console.log("FIRST_TAB : ", FIRST_TAB);
		FIRST_TAB.trigger("click");
	}
	
	function disActiveTab(){
		$(".tab_content").css("display", "none");
		$(".tab_links").removeClass("active_tab");
	}
	

	FIRST_TAB.css("border-radius", "7px 0 0 0");
	tabInit();
	
	//아이템구입버튼
	$(".tab_content").on("click", ".itemBox", function(){
		console.log("아이템 구입 버튼");
		//사용자 아이디
		let userid = `${loginSessionDto.userid}`;
		if(userid === "" || userid === null){
// 			console.log("아이디 없음")
			location.href = "/lee/user/login";
		}
		
		let that = $(this);
		
		//사용자 보유 포인트
		let point = parseInt($("#my_point").html());
		//아이템 번호
		let itemno = that.attr("data-itemno");
		//아이템 가격
		let price = parseInt(that.attr("data-price"));
		
		//로그인체크 리다이렉트
		
// 		console.log("USERID : ", USERID)
// 		console.log(that);
// 		console.log("userid : ", userid);
// 		console.log("itemno : ", itemno);
// 		console.log("point : ", point);
// 		console.log("price : ", price);
// 		console.log("point 타입 : ", typeof(point));
// 		console.log("price 타입 : ", typeof(price));
		if(point < price){
// 			console.log("아이템가격 : " + price + ", 내포인트 : " + point);
// 			console.log("너무 비싸!");
			alert("포인트 부족!!");
		}else if(point >= price){
// 			console.log("아이템가격 : " + price + ", 내포인트 : " + point);
// 			console.log("사볼까?!");
			let confirmResult = confirm("정말 구입하시겠습니까?");
// 			console.log("confirmResult : ", confirmResult);
			if(confirmResult){
				console.log("아이템 구입!")
				let sData = {
					"itemno" : itemno,
					"price" : price,
					"userid" : userid
				}
				$.ajax({
					type : "post",
					url : "/api/buyItem",
					data : JSON.stringify(sData),
					contentType : "application/json; charset=utf-8",
					success : function(rData){
						console.log(rData);
						if(rData){
							showLevelInfo(userid);
						}else{
							console.log("아이템 구입 실패");
						}
					}
				});
			}else{
				console.log("구입 취소!")
			}
		}
	});
});

</script>

<div class="leaderboard-div">
		<a href="#" class ="leaderboard-Container">
			<img alt="banner" src="/resources/common/banner/redearboard1.png" id="readerboard-img-1" class="readerboard-img" width="728" height="90">
			<img alt="banner" src="" id="readerboard-img-2" class="readerboard-img" width="728" height="90">
		</a>
<!-- 		<button class="btn ad_point_btn">광고보고 포인트 쌓기!</button> -->
	</div>
<div>
	
	<!-- <p>아이템 리스트</p> -->
	<!-- <span>${itemTypeList}</span> -->
	
	<div class="itemShopContainer">
		<h3 class="mt-10">아이템상점</h3>
		
<!-- 		<div> -->
<%-- 			<span>myitemList : ${myItemList}</span>	 --%>
<!-- 		</div> -->
<!-- 		<div> -->
<%-- 			<span>itemList : ${itemList}</span>	 --%>
<!-- 		</div> -->
		<div class="tab_container">
			<div class="tab" id="tab">
				<c:forEach var="dto" items="${itemTypeList}">
					<button class="tab_links" data-typeno="${dto.typeno}">${dto.typekr}</button>
				</c:forEach>
			</div>
			<div id="itemShopContentConainer" class="itemShopContentConainer">
				<c:forEach var="itemTypeDto" items="${itemTypeList}">
				<div class="tab_content" data-typeno="${itemTypeDto.typeno}">
					<c:forEach var="itemDto" items="${itemList}">
						<c:if test="${itemDto.typeno == itemTypeDto.typeno}">
							<c:choose>
								<c:when test="${myItemList == null || myItemList == ''}">
									<button class="itemBox"  data-itemno="${itemDto.itemno}" data-price="${itemDto.price}">
										<div class="imgBox">
											<c:choose>
												<c:when test="${itemDto.itempath != null && itemDto.itempath != ''}">
													<img alt="item" src="${itemDto.itempath}">
												</c:when>
												<c:otherwise>
													<img alt="noimage" src="/resources/lee/image/chabak/image/cancle.png">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="itemInfoBox">
											<span>${itemDto.itemnamekr} (${itemDto.capacity}인용)</span>
											<span>${itemDto.price} Point</span>
										</div>
									</button>
								</c:when>
								
								<c:otherwise>
<%-- 									${myItemList} --%>
									<c:set var="isOwnedItem" value="false"/>
									<c:forEach var="myItemDto" items="${myItemList}">
										<c:if test="${myItemDto.itemno == itemDto.itemno}">
											<c:set var="isOwnedItem" value="true"/>
										</c:if>
									</c:forEach>
									
									<c:if test="${isOwnedItem}">
										<button class="itemBox-myitem" data-itemno="${itemDto.itemno}" data-price="${itemDto.price}">
											<div class="owned-item-box">보유중</div>
			                                <div class="imgBox">
			                                    <c:choose>
			                                        <c:when test="${itemDto.itempath != null && itemDto.itempath != ''}">
			                                            <img alt="item" src="${itemDto.itempath}">
			                                        </c:when>
			                                        <c:otherwise>
			                                            <img alt="noimage" src="/resources/lee/image/chabak/image/cancle.png">
			                                        </c:otherwise>
			                                    </c:choose>
			                                </div>
			                                <div class="itemInfoBox">
			                                    <span>${itemDto.itemnamekr} (${itemDto.capacity}인용)</span>
			                                    <span>${itemDto.price} Point</span>
			                                </div>
			                            </button>
									</c:if>
									<c:if test="${!isOwnedItem}">
										<button class="itemBox" data-itemno="${itemDto.itemno}" data-price="${itemDto.price}">
			                                <div class="imgBox">
			                                    <c:choose>
			                                        <c:when test="${itemDto.itempath != null && itemDto.itempath != ''}">
			                                            <img alt="item" src="${itemDto.itempath}">
			                                        </c:when>
			                                        <c:otherwise>
			                                            <img alt="noimage" src="/resources/lee/image/chabak/image/cancle.png">
			                                        </c:otherwise>
			                                    </c:choose>
			                                </div>
			                                <div class="itemInfoBox">
			                                    <span>${itemDto.itemnamekr} (${itemDto.capacity}인용)</span>
			                                    <span>${itemDto.price} Point</span>
			                                </div>
			                            </button>
									</c:if>
									
								</c:otherwise>
							</c:choose>
							
							
							
							
						</c:if>
					</c:forEach>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/lee/include/actionForm.jsp" %>
<%@ include file="/WEB-INF/views/lee/include/footer.jsp"%>